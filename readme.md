# z-wgpu-native

Idiomatic Zig bindings for [wgpu-native](https://github.com/gfx-rs/wgpu-native), auto-generated from the C headers.

# This codebase DOES use LLM/AI for development.

imo llms are good for repetitive work, search, and pattern recognition, not for creating anything novel. bindings should be an "okay" use-case, but if you mind, definitely avoid using this repo unless you review and test all code yourself.

## Build

Requires `clang` and `cargo` on `$PATH`.

```sh
zig build                # build the wrapper library
zig build codegen        # regenerate src/* from vendor headers
zig build test           # run all tests (unit + compute integration)
zig build compute-test   # run only the GPU compute integration test
zig build translate      # run only the C-to-Zig translation step

```

The `zig build test` step covers:

* Codegen unit tests
* Library unit tests (`tests/lib.zig`) 
* Compute test (`tests/compute.zig`)

## Structure

* `build/main.zig` code generator, parses `@cImport` output into an AST
* `build/*.zig` mapping strategies (enums, flags, structs, handles, callbacks)
* `src/types.zig` enums, flags (packed structs), data structs with converted fields
* `src/handles.zig` handle structs with method wrappers + standalone functions
* `src/callbacks.zig` comptime closure trampolines for C callback types
* `src/root.zig` re-exports everything
* `tests/lib.zig` unit tests
* `tests/compute.zig` compute shader test

## Usage

```zig
const wgpu = @import("z_wgpu_native");

// Types are under wgpu.types
const desc: wgpu.types.ShaderModuleDescriptor = .{
    .label = wgpu.types.StringView.fromSlice("my shader"),
};

// Handles are under wgpu.handles
const instance = wgpu.handles.createInstance(null);

// Callbacks are under wgpu.callbacks
const callback_info = wgpu.callbacks.requestAdapterCallback(
    Ctx, u8, &ctx, &ctx2,
    struct { fn cb(c: *Ctx, _: *u8, status: wgpu.types.RequestAdapterStatus, ...) void { ... } }.cb,
);

// Raw C bindings available under wgpu.c
const raw_device = wgpu.c.wgpuAdapterRequestDevice(@ptrCast(adapter.ptr), null, callback_info);

// Chained struct iterator
var iter = wgpu.types.chainedIterator(&first_chain);
while (iter.next()) |chain| { ... }
```
