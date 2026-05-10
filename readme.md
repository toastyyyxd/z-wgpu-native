# z-wgpu-native

Idiomatic Zig bindings for [wgpu-native](https://github.com/gfx-rs/wgpu-native), auto-generated from the C headers.

# This codebase DOES use LLM/AI for development.

imo llms are good for repetitive work, search, and pattern recognition, not for creating anything novel. bindings should be an "okay" use-case, but if you mind, definitely avoid using this repo unless you review and test all code yourself.

## Build

Requires `clang` and `cargo` on `$PATH`.

```sh
zig build                # build the wrapper library
zig build codegen        # regenerate src/* from vendor headers
zig build test           # run all tests including headed tests that link glfw + etc
zig build compute-test   # run only the headless compute test
zig build translate      # run only the C-to-Zig translation step

```

## Structure

* `build/main.zig` handles top control flow mostly
* `build/Map*.zig` mapping strategies for kinds of things
* `build/Output*.zig` generates zig code from mapped information
* `src/types.zig` enums, flags (packed structs), data structs with converted fields
* `src/handles.zig` handle structs with method wrappers + standalone functions
* `src/callbacks.zig` comptime closure trampolines for C callback types
* `src/root.zig` re-exports everything
* `tests/lib.zig` unit tests
* `tests/compute.zig` compute shader test
* `tests/triangle.zig` headed basic rendering of a red triangle test
* `tests/rgbw.zig` headed spinning pyramid and colorful cube test

## Wrapper quirks

A few things work differently from raw wgpu-native as far as I know of...

### Handle fields in descriptors use `Optional{Handle}`

The C headers use null pointers for optional handles. In Zig that's a `?*anyopaque`, but extern structs can't hold non-pointer optionals with a guaranteed layout. So nullable handle fields use `handles.Optional{Foo}` instead:

```zig
// set a handle
.d = .{ .device = wgpu.handles.OptionalDevice.wrap(device) },
// leave it empty
.d = .{ .device = wgpu.handles.OptionalDevice.none() },
// read it back
const dev = surface_tex.texture.unwrap();       // panics if null
const dev = surface_tex.texture.get();           // returns ?Texture
```

### `WGPUBool` is `c_int`, not `bool`

C `WGPUBool` is `uint32_t`. Wrap it as Zig `bool` (1 byte) and padding bits get read as garbage by the C side. All `WGPUBool` fields are `c_int`, so write `0` / `1` instead of `false` / `true`:

```zig
.alpha_to_coverage_enabled = 0,
.mapped_at_creation = 0,
```

### Descriptor casts are automatic

The wrapper converts `types.*` descriptors to `c.*` in method bodies. You don't need `@ptrCast` for descriptor arguments — just pass the wrapper type directly. Same for handles in method args: pass the wrapper, not the raw `.ptr`.

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

## License

This project is dual-licensed under either:

- MIT License ([LICENSE-MIT](LICENSE-MIT))
- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE))

at your option.
