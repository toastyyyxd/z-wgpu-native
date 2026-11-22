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
    optimize: std.lang.Optimize,
    zig_triple: []const u8,
    rust_triple: []const u8,
    do_tests: bool,
    core_tests: bool,
    skip_codegen: bool,
    is_cross: bool,
    test_cross: bool,
    test_headed: bool,
    mode: Mode,

    c_includes: ?std.mem.SplitIterator(u8, std.mem.DelimiterType.any),
    wgpu_native_path: ?LazyPath,
    system_libs: []const u8,

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
    state.do_tests = b.option(bool, "test", "Build the test suites (run them with `zig build test`).") orelse false;
    state.core_tests = b.option(bool, "core-tests", "Only build and run the abi/lib suites; no GPU, window or runtime library needed.") orelse false;
    state.skip_codegen = b.option(bool, "skip-codegen", "Use the checked-in src/ instead of regenerating it (cross builds).") orelse false;
    // The 0.18 build API has no emulation flags, so the run step adds -fqemu/-fwine itself.
    state.test_cross = b.option(bool, "force-cross-tests", "Force run tests when crosscompiling regardless of emulation flags.") orelse false;
    state.test_headed = b.option(bool, "headed-tests", "Run headed tests on top of default headless tests") orelse false;

    state.zig_triple = try state.target.result.zigTriple(b.allocator);

    const host_zig_triple = try state.host.result.zigTriple(b.allocator);
    state.is_cross = !std.mem.eql(u8, host_zig_triple, state.zig_triple);
    std.log.info("Compiling on host {s} for target {s}.", .{ host_zig_triple, state.zig_triple });

    const cargo_target_opt = b.option([]const u8, "cargo-target", "Override a more reliable Cargo target triple if `triples.zig` does not translate it correctly.");
    state.rust_triple = cargo_target_opt orelse try triples.rust(b.allocator, state.target.result);

    // 0.18 moved Android from an OS tag to a Linux ABI.
    const is_android = if (@hasField(std.Target.Os.Tag, "android"))
        state.target.result.os.tag == .android
    else
        state.target.result.abi == .android;

    const c_includes_opt = b.option([]const u8, "c-includes", "Path to any headers needed for translate-c and other steps.");
    state.c_includes = if (c_includes_opt) |s| std.mem.splitAny(u8, s, ",") else null;

    state.wgpu_native_path = b.option(LazyPath, "wgpu", "Provide a prebuilt wgpu-native library to skip the cargo and rust dependencies. When the package is used as a dependency this also links that library into the exported `z_wgpu_native` module.");
    state.system_libs = b.option([]const u8, "system-libs", "Comma-separated system libraries to link into the exported `z_wgpu_native` module when -Dwgpu is provided (e.g. `X11,wayland-client`). Defaults to none; the consumer decides which window-system and platform libraries to bring.") orelse "";

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

    if (is_android and state.mode == .codegen) {
        std.log.err("translate-c cannot target Android; use -Dmode=full to build the runtime.", .{});
        return error.InvalidBuildConfiguration;
    }
    if (is_android and state.do_tests) {
        std.log.err("Tests are not supported on Android; build the runtime with -Dmode=full instead.", .{});
        return error.InvalidBuildConfiguration;
    }
    if (is_android and state.mode == .full) {
        std.log.info("Android target: skipping codegen, using checked-in src/.", .{});
    }
    if (state.skip_codegen and state.mode == .codegen) {
        std.log.err("-Dskip-codegen and -Dmode=codegen are mutually exclusive.", .{});
        return error.InvalidBuildConfiguration;
    }
    if (state.skip_codegen and state.mode == .full) {
        std.log.info("Skipping codegen, using checked-in src/.", .{});
    }

    if (state.mode == .full and state.do_tests) {
        std.log.info(\\
                     \\If you would like to more efficently run tests or are having issues with the required rust toolchain,
                     \\consider providing a prebuilt wgpu-native library with -Dwgpu=<path-to-file> to skip the cargo step.
        , .{});
    }
    if (state.mode == .minimal and state.do_tests) {
        std.log.info("You are running tests for the generated src/ code only, which may be stale and do not reflect the state of the codegen module.", .{});
    }
    if ((state.mode == .codegen or state.mode == .minimal) and state.do_tests and state.wgpu_native_path == null and !state.core_tests) {
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

    if ((state.mode == .full or state.mode == .codegen) and !is_android and !state.skip_codegen) {
        const translated = try translateC(state);
        state.translate_step = translated.step;
        state.codegen_step = try codegen(state, translated.source);
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
    const cargo_profile: []const u8 = if (state.optimize == .debug) "debug" else "release";

    const run_cargo_args: []const []const u8 = if (state.optimize == .debug)
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

/// The translate-c output. Pass it to codegen so one build pass regenerates everything.
const TranslatedHeaders = struct {
    step: *Step,
    source: LazyPath,
};

fn translateC(state: *State) !TranslatedHeaders {
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
    return .{ .step = step, .source = c_bindings_source };
}

fn codegen(state: *State, translated_source: LazyPath) !*Step {
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
        .name = "codegen",
        .root_module = mod,
    });

    const run_tests = state.build.addRunArtifact(tests);

    const run = state.build.addRunArtifact(exe);
    run.addFileArg(translated_source);
    run.step.dependOn(&run_tests.step); 
    const out = state.build.tmpPath();
    run.addDirectoryArg(out);
    
    const update_source = state.build.addUpdateSourceFiles();
    update_source.addCopyFileToSource(out.path(state.build, "callbacks.zig"), "src/callbacks.zig");
    update_source.addCopyFileToSource(out.path(state.build, "handles.zig"), "src/handles.zig");
    update_source.addCopyFileToSource(out.path(state.build, "root.zig"), "src/root.zig");
    update_source.addCopyFileToSource(out.path(state.build, "builders.zig"), "src/builders.zig");
    update_source.addCopyFileToSource(out.path(state.build, "types.zig"), "src/types.zig");
    update_source.step.dependOn(&run.step);

    const step = state.build.step("codegen", "Runs codegen based on the translate-c output and copies it into src/.");
    step.dependOn(&update_source.step);
    return step;
}

fn library(state: *State) !*Step {
    // The installed archive stays free of runtime link inputs: it is the
    // checked-in bindings, unrelated to any particular wgpu-native binary.
    const lib_mod = state.build.addModule("z_wgpu_native_impl", .{
        .root_source_file = state.build.path("src/root.zig"),
        .optimize = state.optimize,
        .target = state.target,
    });
    // The module consumers import. When -Dwgpu supplies a prebuilt runtime it
    // carries the object file and the consumer-declared system libraries.
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
    lib_mod.addImport("c_wgpu_native", c_mod);
    mod.addImport("c_wgpu_native", c_mod);
    linkRuntime(state, mod);

    const lib = state.build.addLibrary(.{
        .name = "z_wgpu_native",
        .root_module = lib_mod,
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

        // The abi/lib suites only inspect the bindings; they do not need the runtime.
        lib_test_mod.addImport("z_wgpu_native", lib_mod);
        abi_test_mod.addImport("z_wgpu_native", lib_mod);
        // The compute/headed suites exercise the runtime, which rides on `mod`.
        compute_test_mod.addImport("z_wgpu_native", mod);
        triangle_test_mod.addImport("z_wgpu_native", mod);
        rgbw_test_mod.addImport("z_wgpu_native", mod);

        if (!state.core_tests) {
            const linked = [_]*std.Build.Module{ compute_test_mod, triangle_test_mod, rgbw_test_mod };
            for (linked) |module| linkRuntimeLibs(state, module);
            if (state.test_headed) {
                try linkWindowLibs(state, triangle_test_mod);
                try linkWindowLibs(state, rgbw_test_mod);
            }
        }

        const lib_test = state.build.addTest(.{
            .name = "lib",
            .root_module = lib_test_mod,
        });
        const abi_test = state.build.addTest(.{
            .name = "abi",
            .root_module = abi_test_mod,
        });
        state.build.installArtifact(lib_test);
        state.build.installArtifact(abi_test);

        const test_step = state.build.step("test", "Build and run suitable library tests.");

        if (state.is_cross and !state.test_cross) return step;
        std.log.info("Will run headless tests.", .{});
        test_step.dependOn(&state.build.addRunArtifact(lib_test).step);
        test_step.dependOn(&state.build.addRunArtifact(abi_test).step);
        if (state.core_tests) return test_step;

        const compute_test = state.build.addTest(.{
            .name = "compute",
            .root_module = compute_test_mod,
        });
        if (state.cargo_step) |cargo| compute_test.step.dependOn(cargo);
        state.build.installArtifact(compute_test);
        test_step.dependOn(&state.build.addRunArtifact(compute_test).step);

        if (!state.test_headed) return test_step;
        std.log.info("Will run headed tests.", .{});
        const triangle_test = state.build.addTest(.{
            .name = "triangle",
            .root_module = triangle_test_mod,
        });
        const rgbw_test = state.build.addTest(.{
            .name = "rgbw",
            .root_module = rgbw_test_mod,
        });
        if (state.cargo_step) |cargo| {
            triangle_test.step.dependOn(cargo);
            rgbw_test.step.dependOn(cargo);
        }
        state.build.installArtifact(triangle_test);
        state.build.installArtifact(rgbw_test);
        test_step.dependOn(&state.build.addRunArtifact(triangle_test).step);
        test_step.dependOn(&state.build.addRunArtifact(rgbw_test).step);
        return test_step;
    }
    
    return step;
}

/// Attach a prebuilt wgpu-native runtime to the module consumers import.
/// This stays opt-in: without `-Dwgpu` the module is the pure bindings, exactly
/// as before, and the consumer links the runtime however they prefer.
fn linkRuntime(state: *State, module: *std.Build.Module) void {
    const path = state.wgpu_native_path orelse return;
    module.addObjectFile(path);
    module.link_libc = true;
    var names = std.mem.splitScalar(u8, state.system_libs, ',');
    while (names.next()) |raw| {
        const name = std.mem.trim(u8, raw, " \t");
        if (name.len == 0) continue;
        module.linkSystemLibrary(name, .{});
    }
}

/// Libraries the wgpu-native archive itself needs at link time on this OS.
/// Everything else - the window system, Vulkan loader, platform SDKs - is the
/// consumer's choice, because wgpu-native's surface and instance extensions
/// differ per application.
fn linkRuntimeLibs(state: *State, module: *std.Build.Module) void {
    switch (state.target.result.os.tag) {
        .linux => {
            // unwind/gcc_s: Rust unwinder. pthread/dl/m were separate libraries
            // before glibc 2.34 and are kept for older hosts.
            module.linkSystemLibrary("unwind", .{});
            module.linkSystemLibrary("gcc_s", .{});
            module.linkSystemLibrary("pthread", .{});
            module.linkSystemLibrary("dl", .{});
            module.linkSystemLibrary("m", .{});
        },
        .windows => {
            module.linkSystemLibrary("winpthread", .{});
            module.linkSystemLibrary("ws2_32", .{});
            module.linkSystemLibrary("userenv", .{});
            module.linkSystemLibrary("unwind", .{});
        },
        else => {},
    }
}

/// Window-system libraries only the headed (windowed) suites need.
fn linkWindowLibs(state: *State, module: *std.Build.Module) !void {
    switch (state.target.result.os.tag) {
        .linux => {
            module.linkSystemLibrary("glfw3", .{});
            module.linkSystemLibrary("X11", .{});
            module.linkSystemLibrary("wayland-client", .{});
            module.linkSystemLibrary("vulkan", .{});
        },
        .windows => module.linkSystemLibrary("glfw3", .{}),
        else => {
            std.log.err("Headed tests are not supported on target OS \"{any}\" of \"{s}\".", .{ state.target.result.os.tag, state.zig_triple });
            return error.UnsupportedTarget;
        },
    }
}
