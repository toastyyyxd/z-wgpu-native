const std = @import("std");
const LazyPath = std.Build.LazyPath;
const triples = @import("./triples.zig");

pub fn build(b: *std.Build) !void {
    const host = b.graph.host;
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const zig_triple = try target.result.zigTriple(b.allocator);
    const rust_triple = try triples.rust(b.allocator, target.result);

    const c_includes = b.option([]const u8, "c-includes", "Path to any headers needed for translate-c and other steps.");
    var c_includes_it = std.mem.splitAny(u8, c_includes orelse &.{}, ",");

    // --- translate c ---
    const run_translate_c = b.addTranslateC(.{
        .root_source_file = b.path("vendor/wgpu-native/ffi/wgpu.h"),
        .optimize = optimize,
        .target = target,
        .link_libc = true,
    });
    while (c_includes_it.peek() != null) {
        const path = c_includes_it.next().?;
        if (std.mem.eql(u8, path, "")) break;
        run_translate_c.addIncludePath(.{ .cwd_relative = path });
        std.log.info("translate-c including path \"{s}\".", .{path});
    }
    c_includes_it.reset();
    run_translate_c.addIncludePath(b.path("vendor/wgpu-native/ffi/webgpu-headers"));
    const root_bindings_source = run_translate_c.getOutput();
    const root_bindings_step = b.step("translate", "Preprocess and translate .h into initial .zig root bindings.");
    root_bindings_step.dependOn(&run_translate_c.step);

    // --- codegen ---
    const generator_mod = b.addModule("z_wgpu_native_gen", .{
        .root_source_file = b.path("build/main.zig"),
        .optimize = optimize,
        .target = target,
    });
    const generator_exe = b.addExecutable(.{
        .root_module = generator_mod,
        .name = "z_wgpu_native_gen",
    });

    const gen_tests = b.addTest(.{
        .root_module = generator_mod,
    });
    const run_generator_tests = b.addRunArtifact(gen_tests);

    const run_generator = b.addRunArtifact(generator_exe);
    run_generator.addFileArg(root_bindings_source);
    run_generator.addDirectoryArg(b.path("src"));
    run_generator.step.dependOn(&generator_exe.step);
    run_generator.step.dependOn(&run_generator_tests.step);
    run_generator.step.dependOn(root_bindings_step);
    const generate_wrapper_step = b.step("codegen", "Generate wrapper code.");
    generate_wrapper_step.dependOn(&run_generator.step);

    // --- root module ---
    const mod = b.addModule("z_wgpu_native", .{
        .root_source_file = b.path("src/root.zig"),
        .optimize = optimize,
        .target = target,
    });
    mod.addAnonymousImport("c_wgpu_native", .{
        .root_source_file = root_bindings_source,
        .optimize = optimize,
        .target = target,
    });

    // build lib
    const lib = b.addLibrary(.{
        .name = "z_wgpu_native",
        .root_module = mod,
    });
    lib.step.dependOn(generate_wrapper_step);
    b.installArtifact(lib);

    // cargo build
    const cargo_profile: []const u8 = if (optimize == .Debug) "debug" else "release";
    const run_cargo_args: []const []const u8 = if (optimize == .Debug)
        &.{ "cargo", "build", "--target", rust_triple, "--manifest-path", "vendor/wgpu-native/Cargo.toml" }
    else
        &.{ "cargo", "build", "--target", rust_triple, "--release", "--manifest-path", "vendor/wgpu-native/Cargo.toml" };
    const run_cargo = b.addSystemCommand(run_cargo_args);

    // link wgpu-native and system lib deps
    // "This output type will create *.a files on Linux, macOS and Windows (MinGW), and *.lib files on Windows (MSVC)."
    // https://doc.rust-lang.org/reference/linkage.html
    const is_msvc = target.result.os.tag == .windows and target.result.abi == .msvc;
    const rust_lib_prefix = if (is_msvc) "" else "lib";
    const rust_lib_suffix = if (is_msvc) "" else ".a";
    const wgpu_lib = b.path(b.fmt("vendor/wgpu-native/target/{s}/{s}/{s}wgpu_native{s}", .{
        rust_triple,
        cargo_profile,
        rust_lib_prefix,
        rust_lib_suffix,
    }));
    mod.addObjectFile(wgpu_lib);
    switch (target.result.os.tag) {
        .linux => {
            mod.linkSystemLibrary("unwind", .{});
            mod.linkSystemLibrary("gcc_s", .{});
            mod.linkSystemLibrary("pthread", .{});
            mod.linkSystemLibrary("dl", .{});
            mod.linkSystemLibrary("m", .{});
        },
        .windows => {
            mod.linkSystemLibrary("winpthread", .{});
        },
        else => lib.step.fail("Unsupported target OS \"{any}\" of \"{s}\".", .{ target.result.os.tag, zig_triple }) catch unreachable,
    }
    lib.step.dependOn(&run_cargo.step);

    // --- tests ---
    const test_step = b.step("test", "Run library tests");

    // HEADLESS TESTS
    const lib_test_mod = b.addModule("z_wgpu_native_tests", .{
        .root_source_file = b.path("tests/lib.zig"),
        .target = target,
        .optimize = optimize,
    });
    lib_test_mod.addImport("z_wgpu_native", mod);

    const lib_tests = b.addTest(.{
        .root_module = lib_test_mod,
    });
    lib_tests.step.dependOn(&run_cargo.step);
    const run_lib_tests = b.addRunArtifact(lib_tests);

    const abi_mod = b.addModule("z_wgpu_native_abi_test", .{
        .root_source_file = b.path("tests/abi.zig"),
        .target = target,
        .optimize = optimize,
    });
    abi_mod.addImport("z_wgpu_native", mod);

    const abi_tests = b.addTest(.{
        .root_module = abi_mod,
    });
    abi_tests.step.dependOn(&run_cargo.step);
    const run_abi_tests = b.addRunArtifact(abi_tests);

    const compute_mod = b.addModule("z_wgpu_native_compute_test", .{
        .root_source_file = b.path("tests/compute.zig"),
        .target = target,
        .optimize = optimize,
    });
    compute_mod.addImport("z_wgpu_native", mod);

    const compute_tests = b.addTest(.{
        .root_module = compute_mod,
    });
    compute_tests.step.dependOn(&run_cargo.step);
    const run_compute_tests = b.addRunArtifact(compute_tests);
    const compute_test_step = b.step("compute-test", "Run compute integration test");
    compute_test_step.dependOn(&run_compute_tests.step);

    test_step.dependOn(&run_generator_tests.step);
    test_step.dependOn(&run_lib_tests.step);
    test_step.dependOn(&run_abi_tests.step);
    test_step.dependOn(&run_compute_tests.step);

    // HEADED TESTS
    // wayland only
    if (target.result.cpu.arch == host.result.cpu.arch and target.result.os.tag == host.result.os.tag and host.result.os.tag == .linux) {
        const triangle_mod = b.addModule("z_wgpu_native_triangle_test", .{
            .root_source_file = b.path("tests/triangle.zig"),
            .target = target,
            .optimize = optimize,
        });
        triangle_mod.addImport("z_wgpu_native", mod);
        triangle_mod.linkSystemLibrary("glfw3", .{});
        triangle_mod.linkSystemLibrary("wayland-client", .{});
        triangle_mod.linkSystemLibrary("wayland-egl", .{});

        const triangle_tests = b.addTest(.{
            .root_module = triangle_mod,
        });
        triangle_tests.step.dependOn(&run_cargo.step);
        const run_triangle_tests = b.addRunArtifact(triangle_tests);
        const triangle_test_step = b.step("triangle-test", "Run windowed triangle test");
        triangle_test_step.dependOn(&run_triangle_tests.step);

        const rgbw_mod = b.addModule("z_wgpu_native_rgbw_test", .{
            .root_source_file = b.path("tests/rgbw.zig"),
            .target = target,
            .optimize = optimize,
        });
        rgbw_mod.addImport("z_wgpu_native", mod);
        rgbw_mod.linkSystemLibrary("glfw3", .{});
        rgbw_mod.linkSystemLibrary("wayland-client", .{});
        rgbw_mod.linkSystemLibrary("wayland-egl", .{});

        const rgbw_tests = b.addTest(.{
            .root_module = rgbw_mod,
        });
        rgbw_tests.step.dependOn(&run_cargo.step);
        const run_rgbw_tests = b.addRunArtifact(rgbw_tests);
        const rgbw_test_step = b.step("rgbw-test", "Run windowed cube+pyramid test");
        rgbw_test_step.dependOn(&run_rgbw_tests.step);
        test_step.dependOn(&run_triangle_tests.step);
        test_step.dependOn(&run_rgbw_tests.step);
    }
}
