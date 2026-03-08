const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const run_clang_preprocess = b.addSystemCommand(&[_][]const u8{"clang"});
    run_clang_preprocess.addArg("-E");
    run_clang_preprocess.addArg("-I");
    run_clang_preprocess.addDirectoryArg(b.path("vendor/wgpu-native/ffi/webgpu-headers"));
    run_clang_preprocess.addFileArg(b.path("vendor/wgpu-native/ffi/wgpu.h"));
    run_clang_preprocess.addArg("-o");
    const preprocessed_h = run_clang_preprocess.addOutputFileArg("preprocessed.h");
    
    const run_translate_c = b.addTranslateC(.{
        .root_source_file = preprocessed_h,
        .optimize = optimize,
        .target = target,
    });
    run_translate_c.step.dependOn(&run_clang_preprocess.step);
    const root_bindings_source = run_translate_c.getOutput();

    const root_bindings_step = b.step("root_bindings", "Preprocess and translate .h into initial .zig root bindings.");
    root_bindings_step.dependOn(&run_clang_preprocess.step);
    root_bindings_step.dependOn(&run_translate_c.step);

    const generator_mod = b.addModule("z_wgpu_native_gen", .{
        .root_source_file = b.path("build/main.zig"),
        .optimize = optimize,
        .target = target,
    });
    const generator_exe = b.addExecutable(.{
        .root_module = generator_mod,
        .name = "z_wgpu_native_generator",
    });
    const run_generator = b.addRunArtifact(generator_exe);
    run_generator.addFileArg(root_bindings_source);
    run_generator.addDirectoryArg(b.path("src"));
    run_generator.step.dependOn(&generator_exe.step);
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

    const lib_tests = b.addTest(.{
        .root_module = generator_mod,
    });
    const run_lib_tests = b.addRunArtifact(lib_tests);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_lib_tests.step);
}
