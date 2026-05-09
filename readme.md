# z-wgpu-native

Idiomatic Zig bindings for [wgpu-native](https://github.com/gfx-rs/wgpu-native), auto-generated from the C headers.

## How it works

`build/main.zig` is a code generator that parses `bindings.zig` (raw `zig translate-c` output) and produces Zig wrapper code under `src/`. Run `zig build codegen` to regenerate.

## What it produces

- `src/types.zig` — enums, flags (packed structs), data structs with converted fields
- `src/handles.zig` — handle structs with method wrappers + standalone functions
- `src/callbacks.zig` — comptime closure trampolines for C callback types
- `src/root.zig` — re-exports everything

## Usage

```zig
const wgpu = @import("z_wgpu_native");

const instance = wgpu.handles.Instance.fromPtr(
    @ptrCast(wgpu.c.wgpuCreateInstance(&descriptor))
);
instance.processEvents();
```
