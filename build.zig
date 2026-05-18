const std = @import("std");
const LazyPath = std.Build.LazyPath;
const Step = std.Build.Step;
const triples = @import("./triples.zig");

const Mode = enum {
    minimal,
    codegen,
    full,
};
const State = struct {
    build: *std.Build,
    host: std.Build.ResolvedTarget,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    zig_triple: []const u8,
    rust_triple: []const u8,
    do_tests: bool,
    is_cross: bool,
    test_cross: bool,
    test_headed: bool,
    mode: Mode,

    c_includes: ?std.mem.SplitIterator(u8, std.mem.DelimiterType.any),
    wgpu_native_path: ?LazyPath,

    cargo_step: ?*Step,
    translate_step: ?*Step,
    codegen_step: ?*Step,
    library_step: ?*Step,
};

pub fn build(b: *std.Build) !void {
    var state = try b.allocator.create(State);

    state.build = b;
    state.host = b.graph.host;
    state.target = b.standardTargetOptions(.{});
    state.optimize = b.standardOptimizeOption(.{});
    state.do_tests = b.option(bool, "test", "Run tests.") orelse false;
    state.test_cross = b.option(bool, "force-cross-tests", "Force run tests when crosscompiling regardless of emulation flags.") orelse false or
        (b.enable_qemu and state.target.result.cpu.arch == state.host.result.cpu.arch) and
        (b.enable_darling or !(state.target.result.os.tag == .macos and state.target.result.cpu.arch == .aarch64)) and
        (b.enable_rosetta or !(state.target.result.os.tag == .macos and state.target.result.cpu.arch == .x86_64)) and
        (b.enable_wasmtime or (state.target.result.cpu.arch != .wasm32 and state.target.result.cpu.arch != .wasm64)) and
        (b.enable_wine or state.target.result.os.tag != .windows);
    state.test_headed = b.option(bool, "headed-tests", "Run headed tests on top of default headless tests") orelse false;

    state.zig_triple = try state.target.result.zigTriple(b.allocator);

    const host_zig_triple = try state.host.result.zigTriple(b.allocator);
    state.is_cross = !std.mem.eql(u8, host_zig_triple, state.zig_triple);
    std.log.info("Compiling on host {s} for target {s}.", .{ host_zig_triple, state.zig_triple });

    const cargo_target_opt = b.option([]const u8, "cargo-target", "Override a more reliable Cargo target triple if `triples.zig` does not translate it correctly.");
    state.rust_triple = cargo_target_opt orelse try triples.rust(b.allocator, state.target.result);

    const c_includes_opt = b.option([]const u8, "c-includes", "Path to any headers needed for translate-c and other steps.");
    state.c_includes = if (c_includes_opt) |s| std.mem.splitAny(u8, s, ",") else null;

    state.wgpu_native_path = b.option(LazyPath, "wgpu", "Provide a prebuilt wgpu-native library to skip the cargo and rust dependencies.");

    state.cargo_step = null;
    state.translate_step = null;
    state.codegen_step = null;
    state.library_step = null;

    state.mode = b.option(Mode, "mode",
        \\
        \\`minimal` : Consumers can usually build from the existing src/, though it could be out-of-sync with vendor/ or codegen.
        \\`codegen` : Generates src/ and builds; requires git submodules to run translate-c.
        \\`full`    : Suitable for hermetic builds and building tests; requires cargo and rust dependencies.
        \\ Note: You can provide a prebuilt wgpu_native library with `-Dwgpu=<path-to-file>` for tests.
        \\        For hermetic or deterministic builds, flake.nix provides coverage for crosscompilation as well.
    ) orelse
        if (state.do_tests and state.wgpu_native_path != null) .codegen
        else if (state.do_tests) .full
        else .minimal;
    std.log.info("Running a {any} build, change this with -Dmode=<minimal|codegen|full>.", .{ state.mode });

    if (state.mode == .full and state.do_tests) {
        std.log.info(\\
                     \\If you would like to more efficently run tests or are having issues with the required rust toolchain,
                     \\consider providing a prebuilt wgpu-native library with -Dwgpu=<path-to-file> to skip the cargo step.
        , .{});
    }
    if (state.mode == .minimal and state.do_tests) {
        std.log.info("You are running tests for the generated src/ code only, which may be stale and do not reflect the state of the codegen module.", .{});
    }
    if ((state.mode == .codegen or state.mode == .minimal) and state.do_tests and state.wgpu_native_path == null) {
        std.log.err("You must provide a prebuilt wgpu_native binary for tests without the cargo build step.", .{});
        return error.InvalidBuildConfiguration;
    }
    if (state.wgpu_native_path != null and state.mode == .full) {
        std.log.err("-Dwgpu and -Dmode=full are mutually exclusive, -Dwgpu defines a prebuilt wgpu-native to use while -Dmode=full builds it from source.", .{});
        return error.InvalidBuildConfiguration;
    }

    if (state.mode == .full) {
        state.cargo_step = try cargoBuild(state);
    }

    if (state.mode == .full or state.mode == .codegen) {
        state.translate_step = try translateC(state);
        state.codegen_step = try codegen(state);
        state.codegen_step.?.dependOn(state.translate_step.?); 
    }

    if (state.mode == .full or state.mode == .codegen or state.mode == .minimal) {
        state.library_step = try library(state);
        if (state.cargo_step) |cargo| {
            state.library_step.?.dependOn(cargo);
        }
        if (state.codegen_step) |codegen_s| {
            state.library_step.?.dependOn(codegen_s);
        }
        b.default_step.dependOn(state.library_step.?);
    }
}

fn cargoBuild(state: *State) !*Step {
    const cargo_profile: []const u8 = if (state.optimize == .Debug) "debug" else "release";

    const run_cargo_args: []const []const u8 = if (state.optimize == .Debug)
        &.{ "cargo", "build", "--target", state.rust_triple, "--manifest-path", "vendor/wgpu-native/Cargo.toml" }
    else
        &.{ "cargo", "build", "--target", state.rust_triple, "--release", "--manifest-path", "vendor/wgpu-native/Cargo.toml" };
    const run_cargo = state.build.addSystemCommand(run_cargo_args);

    const is_msvc = state.target.result.os.tag == .windows and state.target.result.abi == .msvc;
    const rust_lib_prefix = if (is_msvc) "" else "lib";
    const rust_lib_suffix = if (is_msvc) ".lib" else ".a";
    state.wgpu_native_path = state.build.path(state.build.fmt("vendor/wgpu-native/target/{s}/{s}/{s}wgpu_native{s}", .{
        state.rust_triple,
        cargo_profile,
        rust_lib_prefix,
        rust_lib_suffix,
    }));

    const install_lib = state.build.addInstallLibFile(state.wgpu_native_path.?, state.build.fmt("{s}wgpu_native{s}", .{
        state.target.result.libPrefix(),
        state.target.result.staticLibSuffix(),
    }));
    install_lib.step.dependOn(&run_cargo.step);

    const step = state.build.step("build-wgpu", "Builds wgpu-native from vendored source.");
    step.dependOn(&install_lib.step);
    return step;
}

fn translateC(state: *State) !*Step {
    const run_translate_c = state.build.addTranslateC(.{
        .root_source_file = state.build.path("vendor/wgpu-native/ffi/wgpu.h"),
        .optimize = state.optimize,
        .target = state.target,
        .link_libc = true,
    });
    if (state.c_includes) |_| {
        const c_includes = &state.c_includes.?;
        while (c_includes.peek() != null) {
            const path = c_includes.next().?;
            run_translate_c.addIncludePath(.{ .cwd_relative = path });
            std.log.info("translate-c including path \"{s}\".", .{path});
        }
        c_includes.reset();
    }
    run_translate_c.addIncludePath(state.build.path("vendor/wgpu-native/ffi/webgpu-headers"));
    const c_bindings_source = run_translate_c.getOutput();

    const update_source = state.build.addUpdateSourceFiles();
    update_source.addCopyFileToSource(c_bindings_source, "src/c-wgpu.zig");
    update_source.step.dependOn(&run_translate_c.step);

    const step = state.build.step("translate-c", "Translate wgpu.h into initial .zig root bindings.");
    step.dependOn(&update_source.step);
    return step;
}

fn codegen(state: *State) !*Step {
    const mod = state.build.addModule("z_wgpu_native_gen", .{
        .root_source_file = state.build.path("build/main.zig"),
        .optimize = state.optimize,
        .target = state.host,
    });
    const exe = state.build.addExecutable(.{
        .root_module = mod,
        .name = "z_wgpu_native_gen",
    });
    const tests = state.build.addTest(.{
        .root_module = mod,
    });

    const run_tests = state.build.addRunArtifact(tests);

    const run = state.build.addRunArtifact(exe);
    run.addFileArg(state.build.path("src/c-wgpu.zig"));
    run.step.dependOn(&run_tests.step); 
    const out = state.build.tmpPath();
    run.addDirectoryArg(out);
    
    const update_source = state.build.addUpdateSourceFiles();
    update_source.addCopyFileToSource(out.path(state.build, "callbacks.zig"), "src/callbacks.zig");
    update_source.addCopyFileToSource(out.path(state.build, "handles.zig"), "src/handles.zig");
    update_source.addCopyFileToSource(out.path(state.build, "root.zig"), "src/root.zig");
    update_source.addCopyFileToSource(out.path(state.build, "types.zig"), "src/types.zig");
    update_source.step.dependOn(&run.step);

    const step = state.build.step("codegen", "Runs codegen based on src/c-wgpu.zig translated headers and copies them into src/.");
    step.dependOn(&update_source.step);
    return step;
}

fn library(state: *State) !*Step {
    const mod = state.build.addModule("z_wgpu_native", .{
        .root_source_file = state.build.path("src/root.zig"),
        .optimize = state.optimize,
        .target = state.target,
    });
    const c_mod = state.build.addModule("c_wgpu_native", .{
        .root_source_file = state.build.path("src/c-wgpu.zig"),
        .optimize = state.optimize,
        .target = state.target,
    });
    mod.addImport("c_wgpu_native", c_mod);

    const lib = state.build.addLibrary(.{
        .name = "z_wgpu_native",
        .root_module = mod,
    });
    state.build.installArtifact(lib);

    const step = &lib.step;

    std.log.info("{s} consider tests.", .{ if (state.do_tests) "Will" else "Will not "});
    if (state.do_tests) {
        const lib_test_mod = state.build.addModule("z_wgpu_native_test_lib", .{
            .root_source_file = state.build.path("tests/lib.zig"),
            .target = state.target,
            .optimize = state.optimize,
            .link_libc = true,
        });
        const abi_test_mod = state.build.addModule("z_wgpu_native_test_abi", .{
            .root_source_file = state.build.path("tests/abi.zig"),
            .target = state.target,
            .optimize = state.optimize,
            .link_libc = true,
        });
        const compute_test_mod = state.build.addModule("z_wgpu_native_test_compute", .{
            .root_source_file = state.build.path("tests/compute.zig"),
            .target = state.target,
            .optimize = state.optimize,
            .link_libc = true,
        });
        const triangle_test_mod = state.build.addModule("z_wgpu_native_test_triangle", .{
            .root_source_file = state.build.path("tests/triangle.zig"),
            .target = state.target,
            .optimize = state.optimize,
            .link_libc = true,
        });
        const rgbw_test_mod = state.build.addModule("z_wgpu_native_test_rgbw", .{
            .root_source_file = state.build.path("tests/rgbw.zig"),
            .target = state.target,
            .optimize = state.optimize,
            .link_libc = true,
        });

        lib_test_mod.addImport("z_wgpu_native", mod);
        abi_test_mod.addImport("z_wgpu_native", mod);
        compute_test_mod.addImport("z_wgpu_native", mod);
        triangle_test_mod.addImport("z_wgpu_native", mod);
        rgbw_test_mod.addImport("z_wgpu_native", mod);

        const need_linked = [_]*std.Build.Module{ compute_test_mod, triangle_test_mod, rgbw_test_mod };
        for (need_linked) |module| {
            module.addObjectFile(state.wgpu_native_path.?);
            switch (state.target.result.os.tag) {
                .linux => {
                    module.linkSystemLibrary("unwind", .{});
                    module.linkSystemLibrary("gcc_s", .{});
                    module.linkSystemLibrary("pthread", .{});
                    module.linkSystemLibrary("dl", .{});
                    module.linkSystemLibrary("m", .{});
                    module.linkSystemLibrary("glfw3", .{});
                    module.linkSystemLibrary("wayland-client", .{});
                    module.linkSystemLibrary("vulkan", .{});
                    module.linkSystemLibrary("X11", .{});
                },
                .windows => {
                    module.linkSystemLibrary("winpthread", .{});
                    module.linkSystemLibrary("ws2_32", .{});
                    module.linkSystemLibrary("userenv", .{});
                    module.linkSystemLibrary("unwind", .{});
                    module.linkSystemLibrary("glfw3", .{});
                },
                else => {
                    std.log.err("Unsupported target OS \"{any}\" of \"{s}\" for tests.", .{ state.target.result.os.tag, state.zig_triple });
                    return error.UnsupportedTarget;
                },
            }
        }
        
        const lib_test = state.build.addTest(.{ 
            .root_module = lib_test_mod,
        });
        const abi_test = state.build.addTest(.{ 
            .root_module = abi_test_mod,
        });
        const compute_test = state.build.addTest(.{ 
            .root_module = compute_test_mod,
        });
        const triangle_test = state.build.addTest(.{ 
            .root_module = triangle_test_mod,
        });
        const rgbw_test = state.build.addTest(.{ 
            .root_module = rgbw_test_mod,
        });

        if (state.cargo_step) |cargo| {
            compute_test.step.dependOn(cargo);
            triangle_test.step.dependOn(cargo);
            rgbw_test.step.dependOn(cargo);
        }

        state.build.installArtifact(lib_test);
        state.build.installArtifact(abi_test);
        state.build.installArtifact(compute_test);
        state.build.installArtifact(triangle_test);
        state.build.installArtifact(rgbw_test);

        const test_step = state.build.step("test", "Build and run suitable library tests.");
        
        if (state.is_cross and !state.test_cross) return step;
        std.log.info("Will run headless tests.", .{});
        const lib_test_run = state.build.addRunArtifact(lib_test);
        const abi_test_run = state.build.addRunArtifact(abi_test);
        const compute_test_run = state.build.addRunArtifact(compute_test);
        test_step.dependOn(&lib_test_run.step);
        test_step.dependOn(&abi_test_run.step);
        test_step.dependOn(&compute_test_run.step);

        if (!state.test_headed) return step;
        std.log.info("Will run headed tests.", .{});
        const triangle_test_run = state.build.addRunArtifact(triangle_test);
        const rgbw_test_run = state.build.addRunArtifact(rgbw_test);
        test_step.dependOn(&triangle_test_run.step);
        test_step.dependOn(&rgbw_test_run.step);
        return test_step;
    }
    
    return step;
}
