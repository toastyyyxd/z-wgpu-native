# z-wgpu-native

[![CI](https://img.shields.io/github/actions/workflow/status/toastyyyxd/z-wgpu-native/ci.yml?branch=main&label=ci&style=flat-square)](https://github.com/toastyyyxd/z-wgpu-native/actions/workflows/ci.yml)
[![license](https://img.shields.io/badge/license-MIT%20OR%20Apache--2.0-blue?style=flat-square)](#license)
[![Zig](https://img.shields.io/badge/Zig-0.18.0--dev%20%7C%200.17.1-f7a41d?logo=zig&style=flat-square)](https://git.toastyx.dev/toasty/z-wgpu-native)
[![wgpu-native](https://img.shields.io/badge/wgpu--native-v29.0.1.1-7c4dff?style=flat-square)](https://github.com/gfx-rs/wgpu-native/releases/tag/v29.0.1.1)

Idiomatic Zig bindings for [wgpu-native](https://github.com/gfx-rs/wgpu-native),
auto-generated from the C headers.

- **Bindings:** wgpu-native **[v29.0.1.1](https://github.com/gfx-rs/wgpu-native/releases/tag/v29.0.1.1)**
  (pinned in `wgpu-native-version`)
- **This branch:** Zig **0.18.0-dev** (master)
- Regenerated from `wgpu.h` on every wgpu-native bump. See
  [Refreshing the bindings](CONTRIBUTING.md#refreshing-the-bindings).

On stable Zig? Use the [`zig-0.17.1`](https://git.toastyx.dev/toasty/z-wgpu-native/src/branch/zig-0.17.1)
branch instead.

The public surface is generated rather than hand-maintained. A generator turns
`wgpu.h` into the raw `translate-c` bindings and the ergonomic layer together:
handle methods, chained-struct builders that own their storage, slice setters,
callback trampolines, `std.Io` sync wrappers, and Zig error unions for the entry
points that return C status codes. A wgpu-native bump is one regeneration command, and the `abi` suite
checks the result field by field against the C headers.

Hand-written bindings go stale when either upstream moves. One generator
produces both branches, so a wgpu-native or Zig bump is a rebuild instead of a
port.

The API is re-exported at the root, so `wgpu.Device`, `wgpu.BufferUsage` and
`wgpu.createInstance` work without reaching into submodules:

```zig
const wgpu = @import("z_wgpu_native");
const instance = wgpu.createInstance(null);
```

**Contents:** [Install](#install) | [Linking the runtime](#linking-the-runtime) |
[Quickstart](#quickstart) | [Ergonomics](#ergonomics) |
[Entry points that currently abort](#entry-points-that-currently-abort) |
[Mapping C to Zig](#mapping-c-to-zig) | [Quirks](#quirks) |
[Examples](#examples) | [Contributing](#contributing)

## Install

Zig **master** on `main`, or Zig **0.17.1** on the `zig-0.17.1` branch.

Tagged archives pin a release:

```sh
# Zig master
zig fetch --save https://git.toastyx.dev/toasty/z-wgpu-native/archive/v1.3.0-zig0.18-dev.tar.gz

# Zig 0.17.1 (stable)
zig fetch --save https://git.toastyx.dev/toasty/z-wgpu-native/archive/v1.3.0-zig0.17.1.tar.gz
```

The plain `v1.3.0` tag is an alias for the stable line, kept so registries
resolve a default. Use an explicit `-zig<version>` tag (above) to pin what you
support.

Or use a path or submodule dependency:

```zig
.dependencies = .{
    .z_wgpu_native = .{ .path = "../z-wgpu-native" },
},
```

Then wire the module in `build.zig`:

```zig
const dep = b.dependency("z_wgpu_native", .{ .target = target, .optimize = optimize });

exe.root_module.addImport("z_wgpu_native", dep.module("z_wgpu_native"));
exe.root_module.link_libc = true;
```

By default the bindings do not link wgpu-native. The next section has the link commands.

If you already have the library, pass it to the dependency and the module links
it for you:

```zig
const dep = b.dependency("z_wgpu_native", .{
    .target = target,
    .optimize = optimize,
    .wgpu = b.path("lib/libwgpu_native.a"),
    .@"system-libs" = "unwind",
});

exe.root_module.addImport("z_wgpu_native", dep.module("z_wgpu_native"));
```

`-Dwgpu` is the path to a wgpu-native library. It also makes the test suites use
that library instead of building wgpu-native with Cargo. `-Dsystem-libs` is a
comma-separated list of system libraries, empty by default. Add the libraries
for your target from the tables in the next section.

Package archives do not include `vendor/`, so `-Dmode=codegen` and `-Dmode=full`
need a repo checkout with submodules (see [CONTRIBUTING.md](CONTRIBUTING.md)).

## Linking the runtime

wgpu-native is the C library (`libwgpu_native.a`, `.so`, `.dll`, `.dylib`).
The bindings only declare the functions. The application links the library.
Build or download it:

```sh
# build wgpu-native from the vendored submodule into zig-out/lib
zig build -Dmode=full
# or download a release from https://github.com/gfx-rs/wgpu-native/releases
# or, on Nix: nix build .#default   (result/lib/libwgpu_native.a)
```

Per-target prebuilt libraries including z-wgpu-native and wgpu-native are in the release assets.

| Target | Link these | Built | Tested |
| --- | --- | --- | --- |
| `x86_64-linux-gnu` | `unwind` | ✅ | ✅ |
| `aarch64-linux-gnu` | `unwind` | ✅ | ❌ |
| `x86_64-linux-musl` | `unwind` | ✅ | ❌ |
| `aarch64-linux-musl` | `unwind` | ✅ | ❌ |
| `x86_64-windows-gnu` | `userenv` `ws2_32` `winpthread` `unwind` | ✅ | 🔘 |
| `aarch64-windows-gnu` | `userenv` `ws2_32` `winpthread` `unwind` | ✅ | ❌ |
| `aarch64-linux-android` | `android` `m` | ✅ | ❌ |
| `arm-linux-android` | `android` `m` | ✅ | ❌ |
| `x86_64-linux-android` | `android` `m` | ✅ | ❌ |
| macOS | `(Metal frameworks)` | 🔘 | 🔘 |

`✅` full build and suites, `🔘` partial (bindings only, or `abi` and `lib` only), `❌` not built or not run.

These are the libraries the wgpu-native archive needs. On glibc older than 2.34
add `m`, `dl` and `pthread`. `gcc_s` can be used in place of `unwind`.

<details>
<summary>Platform libraries</summary>

The application adds its own platform libraries:

| When the application uses | It links |
| --- | --- |
| a window from GLFW | `glfw3` |
| a window from SDL | `SDL2` or `SDL3` |
| an X11 surface | `X11` |
| an XCB surface | `xcb` |
| a Wayland surface | `wayland-client` |
| the Vulkan backend | nothing at link time, needs loader at runtime |
| WinUI `SwapChainPanel` | COM and the Windows App SDK |
| an Android native window | the NDK |
| a Metal layer | the Metal frameworks |

</details>

<details>
<summary>Linking by hand</summary>

```zig
exe.root_module.addObjectFile(b.path("lib/libwgpu_native.a")); // wgpu_native.lib on MSVC

const runtime_libs: []const []const u8 = switch (target.result.os.tag) {
    .linux => &.{ "unwind" },
    .windows => &.{ "userenv", "ws2_32", "winpthread", "unwind" },
    else => @panic("untested target; see the table above"),
};
for (runtime_libs) |name| exe.root_module.linkSystemLibrary(name, .{});
```

</details>

<details>
<summary>Library naming, dynamic linking and platform notes</summary>

- Windows archives also ship `lib/wgpu_native.dll.lib` and `lib/wgpu_native.dll`
  for dynamic linking.
- A vendored `-Dmode=full` build installs to `zig-out/lib` using Zig's naming
  (`libwgpu_native.a`, or `wgpu_native.lib` on MSVC).
- Only the windowed tests need GLFW/`glfw3`, since window creation is your app's
  job.
- Android links need `-landroid` and `-lm`, while the NDK clang driver supplies
  libc and libdl. The Android targets build through the flake's `android` dev
  shell (see [CONTRIBUTING.md](CONTRIBUTING.md#android)).

</details>

<details>
<summary>Windowed tests</summary>

The windowed test suites link `glfw3`, `X11`, `wayland-client` and `vulkan`.
They run only with `-Dheaded-tests`.

</details>

## Quickstart

Setup, from `Instance` to `Queue`:

```zig
const std = @import("std");
const wgpu = @import("z_wgpu_native");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var threaded: std.Io.Threaded = .init(allocator, .{});
    defer threaded.deinit();
    const io = threaded.io();

    const instance = wgpu.createInstance(null);
    defer instance.release();

    var adapter_result = try instance.requestAdapterSync(io, allocator, null);
    defer adapter_result.deinit(allocator);
    const adapter = try adapter_result.tryAdapter();
    defer adapter.release();

    var device_result = try instance.requestDeviceSync(io, allocator, adapter, null);
    defer device_result.deinit(allocator);
    const device = try device_result.tryDevice();
    defer device.release();

    const queue = device.getQueue();
    defer queue.release();

    // From here it is ordinary WebGPU: create shaders, pipelines and buffers with
    // `device`, submit with `queue`, and read results back with
    // `buffer.mapSync(io, allocator, device, .{ .read = true }, 0, size, .none)`.
}
```

Full example in [`tests/compute.zig`](tests/compute.zig).

## Ergonomics

### Error unions

Entry points that return a status become Zig error unions, generated from the
status enum:

```zig
const limits = try device.getLimits();  // StatusError!Limits
const info = try adapter.getInfo();     // StatusError!AdapterInfo
defer info.deinit();                    // frees the C-allocated payload
```

Only entry points wgpu-native actually implements are used here. Calling a
stubbed one is a compile error rather than a process abort; see
[Entry points that currently abort](#entry-points-that-currently-abort).

Each status enum also has `toError`/`fromError`. Async callbacks and request
results keep their status field, so the raw status is never lost, and handles
that can be null stay optionals (`?*Buffer`), matching `WGPU_NULLABLE`.

### Builders

Chained extensions get a builder, including wgpu-native extras such as
`InstanceExtras`, `DeviceExtras` and `SurfaceConfigurationExtras`. The builder
owns the chained struct, so the `next_in_chain` pointer stays valid for the
create call:

```zig
var shader = wgpu.ShaderModuleDescriptorWithShaderSourceWGSL{
    .code = wgpu.StringView.fromSlice(wgsl),
};
const module = device.createShaderModule(shader.descriptor());

var surface = wgpu.SurfaceDescriptorWithSurfaceSourceWaylandSurface{
    .display = display,
    .surface = wl_surface,
};
const s = instance.createSurface(surface.descriptor());
```

Keep the builder alive until the create call returns, because `descriptor()`
returns a pointer into the builder's own storage.

### Slice setters

Descriptors with a count and pointer field pair get a setter that fills both from
a slice. The slice has to stay valid for the call. wgpu copies the descriptor
contents.

```zig
var rp: wgpu.RenderPassDescriptor = .{};
rp.setColorAttachments(&.{.{ .view = view, .load_op = .clear, .store_op = .store }});

var bg: wgpu.BindGroupDescriptor = .{ .layout = layout };
bg.setEntries(&.{.{ .binding = 0, .buffer = buffer, .size = size }});
```

Function parameters with a count and pointer pair take slices the same way:

```zig
queue.submit(&.{command_buffer});
render_pass.setBindGroup(0, bind_group, &.{});
```

The C-shaped form remains available as `submitRaw`/`setBindGroupRaw`/… when you
need an explicit count or pointer.

### Sync wrappers

Future-returning calls have blocking forms that take an `std.Io` and an
allocator:

```zig
var adapter_result = try instance.requestAdapterSync(io, allocator, null);
defer adapter_result.deinit(allocator);
const adapter = try adapter_result.tryAdapter();
defer adapter.release();

var device_result = try instance.requestDeviceSync(io, allocator, adapter, null);
defer device_result.deinit(allocator);
const device = try device_result.tryDevice();
defer device.release();

var mapped = try buffer.mapSync(io, allocator, device, .{ .read = true }, 0, size, .none);
defer mapped.deinit(allocator);
try mapped.tryMap();

var done = try queue.onSubmittedWorkDoneSync(io, allocator, device, .none);
defer done.deinit(allocator);
try done.tryOnSubmittedWorkDone();
```

Each wrapper returns a result value. `try` covers only the allocation of the
callback message. The operation status is checked with `tryAdapter`,
`tryDevice`, `tryMap`, or `tryOnSubmittedWorkDone`, which return the error set
of the matching status enum, so a failed request does not look like an empty
result. `text()` returns the message delivered by the callback, empty when
there is none, and `deinit(allocator)` frees it.

`requestAdapter` and `requestDevice` complete inside the call, so they take no
timeout. `mapSync` and `onSubmittedWorkDoneSync` take a `std.Io.Timeout`.
`.none` blocks until the operation completes. A duration or deadline returns
`error.Timeout` when it expires, leaving the operation pending; its callback
frees the allocated state when it runs later. `instance.requestDeviceSync` is a
shortcut that forwards to the adapter form. Sync wrappers are not generated for
entry points wgpu-native stubs out (see
[Entry points that currently abort](#entry-points-that-currently-abort)).

## Entry points that currently abort

wgpu-native stubs some entry points, and the generated methods for them are
compile errors. The names are in `wgpu.unimplemented_entry_points`, and the raw
extern stays available as `wgpu.c.<name>`.

## Mapping C to Zig

| wgpu-native C | Zig |
| --- | --- |
| `WGPUDevice`, `WGPUBuffer`, `WGPUCommandEncoder` | `wgpu.Device`, `wgpu.Buffer`, `wgpu.CommandEncoder` |
| `wgpuCreateInstance(..)` | `wgpu.createInstance(..)` or `wgpu.Instance.create(..)` |
| `wgpuDeviceCreateBuffer(device, &desc)` | `device.createBuffer(&desc)` |
| `wgpuBufferGetSize(buffer)` | `buffer.getSize()` |
| `WGPUBufferUsage_MapRead` | `wgpu.BufferUsage{ .map_read = true }` (combine with `.bitOr(..)`) |
| `WGPUColorWriteMask_All` | `wgpu.ColorWriteMask_all` |
| `WGPUFeatureName_DepthClipControl` | `wgpu.FeatureName.depth_clip_control` |
| `WGPUSType_ShaderSourceWGSL` | `wgpu.SType.shader_source_wgsl` |
| `WGPUStringView` | `wgpu.StringView` (`.fromSlice`, `.toSlice`, `.fromZStr`) |
| `WGPUBool` | `bool` in signatures, `u32` in extern struct fields |
| `WGPU_NULLABLE T*` | `?*T` |
| `WGPUDeviceDescriptor` | `wgpu.DeviceDescriptor` (same snake_case field names) |

The `WGPU`/`wgpu` prefixes are dropped throughout. Three rules cover the rest:

- Entry points whose receiver is a handle become methods on it, e.g.
  `wgpuQueueSubmit(queue, ..)` becomes `queue.submit(..)`.
- Functions with no receiver stay at the root, e.g. `wgpu.getInstanceFeatures`.
- Callback infos map 1:1, e.g. `wgpu.RequestAdapterCallbackInfo`, with typed
  trampolines in `wgpu.callbacks`.

## Quirks

Differences from raw wgpu-native:

- **Nullable handles are options.** `WGPU_NULLABLE` follows the C headers, so
  descriptor fields are `?*T` and reads need `.?`/`if` (e.g.
  `surface_tex.texture.?.createView(null)`).
- **Flags are `bitpack struct` flag sets.** Compose with `bitOr`/`bitAnd`/`bitXor`.
  `@bitCast` through the backing `u64` still works when you need raw bits, e.g.
  `wgpu.BufferUsage{ .map_read = true }.bitOr(.{ .copy_dst = true })`.
- **Descriptors are zero-initialized.** C's `INIT` macros zero every field and
  the generated descriptors match, so `{}` construction is deterministic. Where
  a C enum has no zero-valued enumerator, the generator adds a Zig-only
  `@"undefined" = 0` tag for that default, and it never maps to a C value.
- **Out payloads expose `deinit()`.** Results with a C `…FreeMembers`
  (`getInfo`, `getCapabilities`, `getFeatures`) own C-side memory; free them with
  `.deinit()`. The raw `wgpu.c.wgpu…FreeMembers` functions remain available.
- **Chained structs set `s_type` explicitly.** Descriptors that take
  `next_in_chain` point at a chained struct, and `wgpu.chainedIterator(&first_chain)`
  walks the chain.

## Examples

- [`tests/triangle.zig`](tests/triangle.zig) covers adapter/device, surface,
  render pass and buffer readback (windowed).
- [`tests/compute.zig`](tests/compute.zig) covers headless Vulkan compute, with
  and without the sync wrappers.
- [`tests/lib.zig`](tests/lib.zig) covers the value-level API.
- [`tests/abi.zig`](tests/abi.zig) checks extern-struct layout against the C
  headers.

Build modes, test commands and the codegen workflow are in
[CONTRIBUTING.md](CONTRIBUTING.md).

## Contributing

The canonical repo is
[git.toastyx.dev/toasty/z-wgpu-native](https://git.toastyx.dev/toasty/z-wgpu-native).
It syncs to
[github.com/toastyyyxd/z-wgpu-native](https://github.com/toastyyyxd/z-wgpu-native)
automatically. Use the GitHub mirror for issues and pull requests. See
[CONTRIBUTING.md](CONTRIBUTING.md) for the pinned dev shell, the test suites, the
target matrix and how to regenerate the bindings.

## AI disclosure

This codebase uses LLM/AI for development. The generated bindings are covered by
the test suites. Review anything you depend on.

## License

Dual-licensed, at your option:

- MIT License ([LICENSE-MIT](LICENSE-MIT))
- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE))
