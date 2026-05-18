# z-wgpu-native

Idiomatic Zig bindings for [wgpu-native](https://github.com/gfx-rs/wgpu-native), auto-generated from the C headers.

# This codebase DOES use LLM/AI for development.

imo llms are good for repetitive work, search, and pattern recognition, not for creating anything novel. bindings should be an "okay" use-case, but if you mind, definitely avoid using this repo unless you review and test all code yourself.

## Build

Requires `clang` and `cargo` on `$PATH` along with linking dependencies.

```sh
zig build --help
  -Dtarget=[string]            The CPU architecture, OS, and ABI to build for
  -Dcpu=[string]               Target CPU features to add or subtract
  -Dofmt=[string]              Target object format
  -Ddynamic-linker=[string]    Path to interpreter on the target system
  -Doptimize=[enum]            Prioritize performance, safety, or binary size
  -Dtest=[bool]                Run tests.
  -Dforce-cross-tests=[bool]   Force run tests when crosscompiling regardless of emulation flags.
  -Dheaded-tests=[bool]        Run headed tests on top of default headless tests
  -Dcargo-target=[string]      Override a more reliable Cargo target triple if `triples.zig` does not translate it correctly.
  -Dc-includes=[string]        Path to any headers needed for translate-c and other steps.
  -Dwgpu=[lazy_path]           Provide a prebuilt wgpu-native library to skip the cargo and rust dependencies.
  -Dmode=[enum]
    `minimal` : Consumers can usually build from the existing src/, though it could be out-of-sync with vendor/ or codegen.
    `codegen` : Generates src/ and builds; requires git submodules to run translate-c.
    `full`    : Suitable for hermetic builds and building tests; requires cargo and rust dependencies.
     Note: You can provide a prebuilt wgpu_native library with `-Dwgpu=<path-to-file>` for tests.
           For hermetic or deterministic builds, flake.nix provides coverage for crosscompilation as well.
    Supported Values:
        minimal
        codegen
        full
```

## Quirks

A few things work differently from raw wgpu-native:

### Handle fields in descriptors use `Optional{Handle}`

The C headers use null pointers for optional handles. In Zig that's a `?*anyopaque`, but extern structs can't hold non-pointer optionals with a guaranteed layout. So nullable handle fields use `handles.Optional{Foo}` instead:

```zig
// set a handle
.d = .{ .device = wgpu.handles.OptionalDevice.wrap(device) },
// leave it empty
.d = .{ .device = wgpu.handles.OptionalDevice.none() },
// read it back
const dev = surface_tex.texture.unwrap();       // panics if null
const dev = surface_tex.texture.get();          // returns ?Texture
```

### `WGPUBool` is `u32`, not `bool`

C `WGPUBool` is `u32`, `1` or `0`.
```zig
.alpha_to_coverage_enabled = 1, // true
.mapped_at_creation = 0,        // false
```

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
