const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const run_clang_preprocess = b.addSystemCommand(&[_][]const u8{
        "bash", "-c", "mkdir -p .zig-cache/tmp && clang -E -I vendor/wgpu-native/ffi/webgpu-headers vendor/wgpu-native/ffi/wgpu.h | sed '/typedef.*_Float/d' > .zig-cache/tmp/preprocessed.h",
    });
    const preprocessed_h = b.path(".zig-cache/tmp/preprocessed.h");
    
    const run_translate_c = b.addTranslateC(.{
        .root_source_file = preprocessed_h,
        .optimize = optimize,
        .target = target,
        .link_libc = false,
    });
    run_translate_c.step.dependOn(&run_clang_preprocess.step);
    const root_bindings_source = run_translate_c.getOutput();

    const root_bindings_step = b.step("translate", "Preprocess and translate .h into initial .zig root bindings.");
    root_bindings_step.dependOn(&run_clang_preprocess.step);
    root_bindings_step.dependOn(&run_translate_c.step);

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

    const lib = b.addLibrary(.{
        .name = "z_wgpu_native",
        .root_module = mod,
    });
    lib.step.dependOn(generate_wrapper_step);
    b.installArtifact(lib);

    const run_cargo = b.addSystemCommand(&[_][]const u8{
        "cargo", "build",
        "--manifest-path", "vendor/wgpu-native/Cargo.toml",
    });

    const wgpu_lib = b.path("vendor/wgpu-native/target/debug/libwgpu_native.a");
    mod.addObjectFile(wgpu_lib);
    mod.linkSystemLibrary("unwind", .{});
    mod.linkSystemLibrary("gcc_s", .{});
    mod.linkSystemLibrary("pthread", .{});
    mod.linkSystemLibrary("dl", .{});
    mod.linkSystemLibrary("m", .{});
    lib.step.dependOn(generate_wrapper_step);
    lib.step.dependOn(&run_cargo.step);
    b.installArtifact(lib);

    const lib_test_mod = b.addModule("z_wgpu_native_tests", .{
        .root_source_file = b.path("tests/lib.zig"),
        .target = target,
        .optimize = optimize,
    });
    lib_test_mod.addImport("z_wgpu_native", mod);

    const lib_tests = b.addTest(.{
        .root_module = lib_test_mod,
    });
    const run_lib_tests = b.addRunArtifact(lib_tests);

    const compute_mod = b.addModule("z_wgpu_native_compute_test", .{
        .root_source_file = b.path("tests/compute.zig"),
        .target = target,
        .optimize = optimize,
    });
    compute_mod.addImport("z_wgpu_native", mod);

    const compute_exe = b.addExecutable(.{
        .name = "compute-test",
        .root_module = compute_mod,
    });
    compute_exe.step.dependOn(&run_cargo.step);
    const run_compute_test = b.addRunArtifact(compute_exe);
    const compute_test_step = b.step("compute-test", "Run compute integration test");
    compute_test_step.dependOn(&run_compute_test.step);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_generator_tests.step);
    test_step.dependOn(&run_lib_tests.step);
    test_step.dependOn(&run_compute_test.step);
}
