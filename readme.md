# z-wgpu-native

Idiomatic Zig bindings for [wgpu-native](https://github.com/gfx-rs/wgpu-native), auto-generated from the C headers.

# This codebase DOES use LLM/AI for development.
imo llms are good for repetitive work, search, and pattern recognition, not for creating anything novel. bindings should be an "okay" use-case, but if you mind, definitely avoid using this repo unless you review and test all code yourself.

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
