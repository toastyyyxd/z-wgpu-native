# z-wgpu-native

Idiomatic Zig bindings for [wgpu-native](https://github.com/gfx-rs/wgpu-native),
auto-generated from the C headers.

- **Bindings:** wgpu-native **[v29.0.1.1](https://github.com/gfx-rs/wgpu-native/releases/tag/v29.0.1.1)**
  (`6aed509`, webgpu-headers `673658bc`, pinned in `wgpu-native-version`)
- **This branch:** Zig **0.18.0-dev** (master)
- Regenerated from `wgpu.h` on every wgpu-native bump. See
  [Refreshing the bindings](#refreshing-the-bindings)

On stable Zig? Use the [`zig-0.17.1`](https://git.toastyx.dev/toasty/z-wgpu-native/src/branch/zig-0.17.1)
branch instead — 0.18 renamed `packed struct` to `bitpack struct` and changed
`std.meta`, so the two are not source-compatible.

The generated code mirrors the C headers. The ergonomic layers sit on top:

| Module | Contents |
| --- | --- |
| `wgpu.types` | C structs/enums with Zig names, `StringView`, chained-struct iterator, `bitpack struct` flag sets |
| `wgpu.handles` | opaque handle pointers with methods (`device.createBuffer(..)`), `release`/`addRef` |
| `wgpu.callbacks` | typed callback/trampoline helpers for the async entry points |
| `wgpu.builders` | lifetime-safe builders for chained structs, including wgpu-native extras |
| `wgpu.c` | raw `translate-c` output, unchanged |

Every public declaration is also re-exported at the root, so `wgpu.Device`,
`wgpu.DeviceDescriptor`, `wgpu.BufferUsage` and `wgpu.createInstance` work
without a module prefix.

```zig
const wgpu = @import("z_wgpu_native");

const instance = wgpu.Instance.create(null);
```

## Examples

- [`tests/triangle.zig`](tests/triangle.zig) — adapter/device, surface, render pass, buffer readback (windowed).
- [`tests/compute.zig`](tests/compute.zig) — headless Vulkan compute.

## Sync wrappers

Future-returning calls have blocking forms that take an `std.Io`:

```zig
const adapter = (try instance.requestAdapterSync(io, null)).adapter orelse return error.NoAdapter;
defer adapter.release();

const device = (try adapter.requestDeviceSync(io, instance, null)).device orelse return error.NoDevice;
defer device.release();

_ = try buffer.mapSync(io, device, .{ .read = true }, 0, size);
_ = try queue.onSubmittedWorkDoneSync(io, device);
```

`requestAdapter` and `requestDevice` complete inside the call. `mapSync` and
`onSubmittedWorkDoneSync` block on `wgpuDevicePoll(true)`. Sync wrappers are not
generated for entry points wgpu-native stubs as `unimplemented!()` (see
[Entry points that currently abort](#entry-points-that-currently-abort)). Their
raw wrappers still exist and abort if called.

## Entry points that currently abort

wgpu-native stubs some C entry points with `unimplemented!()`. Calling one
panics inside the Rust library and aborts the process. The bindings still expose
them because they mirror the C headers.

`wgpu.unimplemented_entry_points` lists the affected C names. Sync
wrappers are not generated for these for the same reason.

```zig
for (wgpu.unimplemented_entry_points) |name| {
    std.log.info("unimplemented: {s}", .{name});
}
```

The raw `wgpu.c` module exposes the same C functions.

## Builders

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

Keep the builder alive until the create call returns. `descriptor()` returns a
pointer into the builder's own storage. Fields with a count and pointer pair get
the same `set*` slice helpers as the underlying descriptor.

## Slice setters

Descriptors with a count and pointer field pair get a setter that fills both from
a slice:

```zig
var rp: wgpu.RenderPassDescriptor = .{};
rp.setColorAttachments(&.{.{ .view = view, .load_op = .clear, .store_op = .store }});

var bg: wgpu.BindGroupDescriptor = .{ .layout = layout };
bg.setEntries(&.{.{ .binding = 0, .buffer = buffer, .size = size }});
```

The slice has to stay valid for the call. wgpu copies the descriptor contents.

Function parameters with a count and pointer pair take slices the same way:

```zig
queue.submit(&.{command_buffer});
render_pass.setBindGroup(0, bind_group, &.{});
```

The C-shaped form remains available as `submitRaw`/`setBindGroupRaw`/… when you
need to pass an explicit count or pointer.

## Requirements

- Zig **0.18.0-dev.1151+8dfb7a7cc** (`minimum_zig_version` in `build.zig.zon`)
- **wgpu-native** (`libwgpu_native.a` / `.so` / `.dll` / `.dylib`). The bindings
  only declare `extern` functions. Link it yourself. Build or download it:

```sh
# build wgpu-native from the vendored submodule into zig-out/lib
zig build -Dmode=full
# or download a release from https://github.com/gfx-rs/wgpu-native/releases
# or, on Nix: nix build .#default  ->  result/lib/libwgpu_native.a
```

Package archives do not include `vendor/`, so `-Dmode=codegen` and
`-Dmode=full` need a repo checkout with submodules.

## Install

Tagged archives pin a release:

```sh
# Zig master
zig fetch --save https://git.toastyx.dev/toasty/z-wgpu-native/archive/v1.1.0-zig0.18-dev.tar.gz

# Zig 0.17.1 (plain v1.1.0 tag)
zig fetch --save https://git.toastyx.dev/toasty/z-wgpu-native/archive/v1.1.0.tar.gz
```

Or use a path or submodule dependency:

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

Linux system libraries required by the static wgpu-native build. On Windows,
link the platform equivalents (`userenv`, `ws2_32`, `winpthread`).

## Build modes

| `-Dmode` | Uses | Needs clang/cargo? |
| --- | --- | --- |
| `minimal` (default) | checked-in `src/` | no |
| `codegen` | regenerates `src/` from `vendor/wgpu-native` headers | submodules only (no cargo) |
| `full` | builds wgpu-native from vendored source, then creates `src/` | yes (cargo/rust) |

Other options:

| Option | Effect |
| --- | --- |
| `-Dtest=true` | build/install the test suites (run them with the `test` step) |
| `-Dheaded-tests=true` | also run the windowed tests (`triangle`, `rgbw`) |
| `-Dwgpu=<path>` | use a prebuilt wgpu-native library instead of building it (required for tests with `-Dmode=minimal`/`codegen`) |
| `-Dtarget=`, `-Dcpu=`, `-Doptimize=` | standard Zig target options |

## Supported targets

`x86_64-linux-gnu`, `aarch64-linux-gnu`, `x86_64-linux-musl`,
`aarch64-linux-musl`, `x86_64-windows-gnu`, `aarch64-windows-gnu`.

GPU tests have only been run on `x86_64-linux-gnu` (my machine).

## Testing

```sh
# fast: use a prebuilt wgpu-native, checked-in src/
zig build test -Dtest=true -Dmode=minimal -Dwgpu=/path/to/libwgpu_native.a

# also run the windowed triangle/rgbw tests (needs a display)
zig build test -Dtest=true -Dheaded-tests=true -Dmode=minimal -Dwgpu=/path/to/libwgpu_native.a
```

The `test` step is required: `-Dtest=true` alone only builds and installs the test
binaries (as `zig-out/bin/{abi,lib,compute,triangle,rgbw}`) without running them.

Suites: `abi` (extern-struct layout), `lib` (value-level), `compute` (headless
Vulkan), `triangle` and `rgbw` (windowed). Tested on `0.18.0-dev.1153`.

## Zig version support

Zig 0.18 renamed `packed struct` to `bitpack struct` and changed `std.meta`,
so stable and master are not source-compatible. Two branches:

| Branch | Zig | Notes |
| --- | --- | --- |
| `main` | 0.18.0-dev | tracks Zig master |
| `zig-0.17.1` | 0.17.1 | stable toolchain, flake pins `zig-0_17_1` |

## Quirks

Differences from raw wgpu-native:

### Handles are opaque pointers

Handles are `*T` pointers with methods and refcounting. Nullable fields are
`?*T`, so descriptors take handles directly:

```zig
const instance = wgpu.Instance.create(null);
defer instance.release();

// nullable handle fields are plain options
var config: wgpu.SurfaceConfiguration = .{ .device = device, /* ... */ };
const view = surface_tex.texture.?.createView(null);
```

Parameters and returns follow `WGPU_NULLABLE` from the C headers, so only
genuinely nullable pointers are options.

### Flags are packed structs

Compose typed flag sets with the generated `bitOr`, `bitAnd` and `bitXor`
methods:

```zig
const usage = wgpu.BufferUsage{ .map_read = true }
    .bitOr(.{ .copy_dst = true });
```

`@bitCast` through the backing `u64` still works when you need raw bits.

### `WGPUBool` is `bool` in signatures, `u32` in struct fields

Function parameters and returns use `bool` (`device.poll(true, null)`,
`adapter.hasFeature(...)`). C struct layout still requires `u32` for extern
struct fields:

```zig
.alpha_to_coverage_enabled = 1, // true
.mapped_at_creation = 0,        // false
```

### Descriptors are zero-initialized

C's `INIT` macros zero every field, and the generated descriptors do the same.
`{}` construction is deterministic because every field has a default. Where a C
enum has no zero-valued enumerator, the generator adds a Zig-only
`@"undefined" = 0` tag for that default. It never corresponds to a C value.

### Chained structs

Descriptors that take `next_in_chain` point at a chained struct whose `s_type`
you set explicitly. `wgpu.chainedIterator` walks the chain:

```zig
var iter = wgpu.chainedIterator(&first_chain);
while (iter.next()) |chain| { ... }
```

## Refreshing the bindings

Generated code is tied to one wgpu-native release. `wgpu-native-version` records
the tag, the wgpu-native commit and the nested `webgpu-headers` commit. Bump all
three together, then regenerate once:

```sh
git submodule update --init --recursive
nix develop -c zig build -Dmode=codegen   # rewrites src/ in a single pass
git diff src/                             # review, then commit
tools/check-wgpu-pin.sh                   # tag/commit/readme agree
```

`-Dmode=codegen` reruns `translate-c` on `vendor/wgpu-native/ffi/wgpu.h` and
rewrites the ergonomic layers. The generator reads translate-c output directly,
so one pass is enough after a header bump. A second pass must leave `src/`
unchanged. Codegen fails on leaks and runs the generator tests.

Run codegen inside `nix develop`. translate-c records absolute include paths in
`src/c-wgpu.zig`, so regenerating outside the pinned dev shell rewrites those
comments even when nothing else changed.

## Contributing

The canonical repo is
[git.toastyx.dev/toasty/z-wgpu-native](https://git.toastyx.dev/toasty/z-wgpu-native).
It syncs to
[github.com/toastyyyxd/z-wgpu-native](https://github.com/toastyyyxd/z-wgpu-native)
automatically. Use the GitHub mirror for issues and pull requests.

```sh
nix develop -c zig build test -Dtest=true                     # headless suites
nix develop -c zig build test -Dtest=true -Dheaded-tests=true # + windowed suites
```

## AI disclosure

This codebase uses LLM/AI for development. The generated bindings are covered by
the test suites. Review anything you depend on.

## License

Dual-licensed, at your option:

- MIT License ([LICENSE-MIT](LICENSE-MIT))
- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE))
