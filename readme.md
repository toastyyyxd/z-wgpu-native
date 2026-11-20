# z-wgpu-native

Idiomatic Zig bindings for [wgpu-native](https://github.com/gfx-rs/wgpu-native),
auto-generated from the C headers.

- **Bindings:** wgpu-native **v29.0.1**
- **This branch:** Zig **0.18.0-dev** (master)
- Regenerated from `wgpu.h` on every wgpu-native bump; see
  [Refreshing the bindings](#refreshing-the-bindings)

On stable Zig? Use the [`zig-0.17.1`](https://git.toastyx.dev/toasty/z-wgpu-native/src/branch/zig-0.17.1)
branch instead — 0.18 renamed `packed struct` to `bitpack struct` and changed
`std.meta`, so the two are not source-compatible.

The generated code mirrors the C headers; the ergonomic layers sit on top:

| Module | Contents |
| --- | --- |
| `z.types` | C structs/enums with Zig names, `StringView`, chained-struct iterator, `bitpack struct` flag sets |
| `z.handles` | method-style per-handle wrappers (`device.createBuffer(..)`), `Optional{Handle}` wrappers |
| `z.callbacks` | typed callback/trampoline helpers for the async entry points |
| `z.c` | raw `translate-c` output, unchanged |

```zig
const z = @import("z_wgpu_native");

const instance = z.handles.createInstance(null) orelse return error.NoInstance;
```

## Examples

- [`tests/triangle.zig`](tests/triangle.zig) — adapter/device, surface, render pass, buffer readback (windowed).
- [`tests/compute.zig`](tests/compute.zig) — headless Vulkan compute.

## Requirements

- Zig **0.18.0-dev** (`minimum_zig_version` in `build.zig.zon`)
- **wgpu-native** (`libwgpu_native.a` / `.so` / `.dll` / `.dylib`). The bindings
  only declare `extern` functions; link it yourself. Build or download it:

```sh
# build wgpu-native from the vendored submodule into zig-out/lib
zig build -Dmode=full
# or download a release from https://github.com/gfx-rs/wgpu-native/releases
# or, on Nix: nix build .#default  ->  result/lib/libwgpu_native.a
```

## Install

Tagged archives pin a release:

```sh
# Zig master
zig fetch --save https://git.toastyx.dev/toasty/z-wgpu-native/archive/v1.0.1-zig0.18-dev.tar.gz

# Zig 0.17.1 (zig-0.17.1 branch)
zig fetch --save https://git.toastyx.dev/toasty/z-wgpu-native/archive/v1.0.1-zig0.17.1.tar.gz
```

Or use a path dependency:

```zig
.dependencies = .{
    .z_wgpu_native = .{ .path = "../z-wgpu-native" },
},
```

Then wire the module and the native library in `build.zig`:

```zig
const dep = b.dependency("z_wgpu_native", .{ .target = target, .optimize = optimize });

exe.root_module.addImport("z_wgpu_native", dep.module("z_wgpu_native"));
exe.root_module.link_libc = true;
exe.root_module.addObjectFile(b.path("lib/libwgpu_native.a"));
exe.root_module.linkSystemLibrary("vulkan", .{});
exe.root_module.linkSystemLibrary("X11", .{});
exe.root_module.linkSystemLibrary("wayland-client", .{});
exe.root_module.linkSystemLibrary("m", .{});
exe.root_module.linkSystemLibrary("dl", .{});
exe.root_module.linkSystemLibrary("pthread", .{});
exe.root_module.linkSystemLibrary("unwind", .{});
exe.root_module.linkSystemLibrary("gcc_s", .{});
```

Linux system libraries required by the static wgpu-native build. On Windows or
macOS, link the platform equivalents (`userenv`, `ws2_32`, `winpthread` on
Windows).

## Build modes

| `-Dmode` | Uses | Needs clang/cargo? |
| --- | --- | --- |
| `minimal` (default) | checked-in `src/` | no |
| `codegen` | regenerates `src/` from `vendor/wgpu-native` headers | clang + submodules (no cargo) |
| `full` | builds wgpu-native from vendored source, then creates `src/` | yes (cargo/rust) |

Other options:

| Option | Effect |
| --- | --- |
| `-Dtest=true` | build and run the test suites |
| `-Dheaded-tests=true` | also run the windowed tests (`triangle`, `rgbw`) |
| `-Dwgpu=<path>` | use a prebuilt wgpu-native library instead of building it (required for tests with `-Dmode=minimal`/`codegen`) |
| `-Dtarget=`, `-Dcpu=`, `-Doptimize=` | standard Zig target options; cross-compilation is supported |

## Supported targets

`x86_64-linux-gnu` (host), `aarch64-linux-gnu`, `x86_64-linux-musl`,
`aarch64-linux-musl`, `x86_64-windows-gnu`, `aarch64-windows-gnu`.

GPU tests run on `x86_64-linux-gnu` only.

## Testing

```sh
# fast: use a prebuilt wgpu-native, checked-in src/
zig build -Dtest=true -Dmode=minimal -Dwgpu=/path/to/libwgpu_native.a

# also run the windowed triangle/rgbw tests (needs a display)
zig build -Dtest=true -Dheaded-tests=true -Dmode=minimal -Dwgpu=/path/to/libwgpu_native.a
```

Suites: `abi` (extern-struct layout), `lib` (value-level), `compute` (headless
Vulkan), `triangle` and `rgbw` (windowed). Tested on `0.18.0-dev.1153`.

## Zig version support

Zig 0.18 renamed `packed struct` to `bitpack struct` and changed `std.meta`,
so stable and master are not source-compatible. Two branches:

| Branch | Zig | Notes |
| --- | --- | --- |
| `main` | 0.18.0-dev | tracks Zig master |
| `zig-0.17.1` | 0.17.1 | stable toolchain; flake pins `zig-0_17_1` |

## Quirks

A few things work differently from raw wgpu-native:

### Handle fields in descriptors use `Optional{Handle}`

The C headers use null pointers for optional handles. In Zig that is a
`?*anyopaque`, but extern structs cannot hold non-pointer optionals with a
guaranteed layout, so nullable handle fields use `handles.Optional{Foo}`:

```zig
// set a handle
.d = .{ .device = z.handles.OptionalDevice.wrap(device) },
// leave it empty
.d = .{ .device = z.handles.OptionalDevice.none() },
// read it back
const dev = surface_tex.texture.unwrap();  // panics if null
const dev = surface_tex.texture.get();     // returns ?Texture
```

### `WGPUBool` is `u32`, not `bool`

C `WGPUBool` is `u32` (`1` or `0`), and extern struct fields must keep that layout:

```zig
.alpha_to_coverage_enabled = 1, // true
.mapped_at_creation = 0,        // false
```

### Chained structs

Descriptors that take `next_in_chain` point at a chained struct whose `s_type`
you set explicitly. `z.types.chainedIterator` walks the chain:

```zig
var iter = z.types.chainedIterator(&first_chain);
while (iter.next()) |chain| { ... }
```

## Refreshing the bindings

```sh
git submodule update --init --recursive
zig build -Dmode=codegen   # rewrites src/c-wgpu.zig, types.zig, handles.zig, ...
git diff src/              # review, then commit
```

`-Dmode=codegen` re-runs `translate-c` on `vendor/wgpu-native/ffi/wgpu.h`, then
the generator in `build/` rewrites the ergonomic layers.

## Contributing

Development and issues: [git.toastyx.dev/toasty/z-wgpu-native](https://git.toastyx.dev/toasty/z-wgpu-native).

```sh
nix develop -c zig build -Dtest=true                     # headless suites
nix develop -c zig build -Dtest=true -Dheaded-tests=true # + windowed suites
```

## AI disclosure

This codebase uses LLM/AI for development. The generated bindings are covered by
the test suites; review anything you depend on.

## License

Dual-licensed, at your option:

- MIT License ([LICENSE-MIT](LICENSE-MIT))
- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE))
