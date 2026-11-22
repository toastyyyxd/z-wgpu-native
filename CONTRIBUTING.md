# Contributing

The canonical repo is
[git.toastyx.dev/toasty/z-wgpu-native](https://git.toastyx.dev/toasty/z-wgpu-native).
It syncs to [github.com/toastyyyxd/z-wgpu-native](https://github.com/toastyyyxd/z-wgpu-native)
automatically. Use the GitHub mirror for issues and pull requests.

The workflow needs the pinned dev shell:

```sh
nix develop          # Zig from zig2nix (master), zls, Rust toolchain for -Dmode=full
```

## Branches and tags

| Branch | Zig | Tag convention |
| --- | --- | --- |
| `main` | 0.18.0-dev | `vX.Y.Z-zig0.18-dev` |
| `zig-0.17.1` | 0.17.1 | `vX.Y.Z-zig0.17.1` |

Releases are published only for tags with a `-zig` suffix (for example
`vX.Y.Z-zig<version>`). The plain `vX.Y.Z` tag is an alias for the stable line so
registries resolve a stable default.

The branches differ only in Zig 0.18's renames (`packed struct` became
`bitpack struct`, plus `std.meta` changes) and the pin/readme updates, so
changes are cherry-picked between them.

## Build modes

| `-Dmode` | Uses | Needs clang/cargo? |
| --- | --- | --- |
| `minimal` (default) | checked-in `src/` | no |
| `codegen` | regenerates `src/` from `vendor/wgpu-native` headers | submodules only (no cargo) |
| `full` | builds wgpu-native from vendored source, then creates `src/` | yes (cargo/rust) |

Package archives do not include `vendor/`, so `-Dmode=codegen` and `-Dmode=full`
need a repo checkout with submodules.

Other options:

| Option | Effect |
| --- | --- |
| `-Dtest=true` | build/install the test suites (run them with the `test` step) |
| `-Dheaded-tests=true` | also run the windowed tests (`triangle`, `rgbw`) |
| `-Dwgpu=<path>` | use a prebuilt wgpu-native library instead of building it (required for tests with `-Dmode=minimal`/`codegen`) |
| `-Dforce-cross-tests` | run the tests when cross-compiling even without emulation flags |
| `-Dcargo-target=<triple>` | override the Rust target triple if `triples.zig` guesses wrong |
| `-Dc-includes=<path>` | extra include path for translate-c |
| `-Dtarget=`, `-Dcpu=`, `-Doptimize=` | standard Zig target options |

## Supported targets

`x86_64-linux-gnu`, `aarch64-linux-gnu`, `x86_64-linux-musl`,
`aarch64-linux-musl`, `x86_64-windows-gnu`, `aarch64-windows-gnu`,
`aarch64-linux-android`, `arm-linux-android`, `x86_64-linux-android`.

GPU tests have only been run on `x86_64-linux-gnu`. `zig build` cross-compiles
the declared targets, and the Android targets build through the `android` dev
shell (see [Android](#android)). The linking table is in the
[readme](readme.md#linking-the-runtime).

## Android

`nix develop .#android` adds NDK r30 and the Rust targets for
`aarch64-linux-android`, `armv7-linux-androideabi` and `x86_64-linux-android`.
The NDK clang wrappers target API 26, and the shell exports the linker, archiver
and bindgen variables cargo needs. `x86_64` is the emulator ABI.

```sh
nix develop .#android -c zig build -Dmode=full -Dtarget=aarch64-linux-android
nix develop .#android -c zig build -Dmode=full -Dtarget=arm-linux-android
nix develop .#android -c zig build -Dmode=full -Dtarget=x86_64-linux-android
```

The dev-shell builds write `zig-out/lib/libwgpu_native.a`, so copy the archive out
between builds if you need more than one. `-Dmode=full` skips codegen on Android, because Zig's translate-c cannot target
Android without a libc sysroot, so the build reuses the checked-in `src/` and
only rebuilds the runtime.

For hermetic builds, use the flake packages:

```sh
nix build .#android              # aarch64-linux-android
nix build .#arm-linux-android
nix build .#x86_64-linux-android
nix build .#all                  # every declared target
```

Each package installs the runtime and the generated bindings to `$out/lib/`
(`libwgpu_native.a` and `libz_wgpu_native.a`).

## Testing

```sh
# fast: prebuilt wgpu-native + checked-in src/
zig build test -Dtest=true -Dmode=minimal -Dwgpu=/path/to/libwgpu_native.a

# also run the windowed triangle/rgbw tests (needs a display)
zig build test -Dtest=true -Dheaded-tests=true -Dmode=minimal -Dwgpu=/path/to/libwgpu_native.a

# from the pinned dev shell
nix develop -c zig build test -Dtest=true                     # headless suites
nix develop -c zig build test -Dtest=true -Dheaded-tests=true # + windowed suites
```

The `test` step is required, because `-Dtest=true` alone only builds and installs
the test binaries (`zig-out/bin/{abi,lib,compute,triangle,rgbw}`) without running
them.

Suites: `abi` (extern-struct layout), `lib` (value-level), `compute` (headless
Vulkan), `triangle` and `rgbw` (windowed). Tested on `0.18.0-dev.1153`.

`-Dcore-tests=true` builds and runs only the `abi` and `lib` suites, so it
needs neither the GPU nor the wgpu-native runtime. That is what CI uses for the
non-Linux targets:

```sh
# Windows ABI/value suites under Wine
nix develop .#windows-tests -c zig build test -Dtest=true -Dmode=minimal \
  -Dcore-tests=true -Dforce-cross-tests=true -Dtarget=x86_64-windows-gnu -fwine

# native macOS ABI/value suites (run on the macOS CI runner)
nix develop -c zig build test -Dtest=true -Dmode=minimal -Dcore-tests=true
```

CI runs the headless suites on a GitHub-hosted ubuntu runner, the Windows
`abi`/`lib` suites under Wine, and the `abi`/`lib` suites natively on a macOS
runner (best effort). Windowed suites are not run in CI, because the Nix-linked
test binaries need the dev shell's glibc, which a non-NixOS runner doesn't have.
The build-matrix jobs attach the per-target libraries as run artifacts, and a
`v*-zig*` tag publishes a GitHub release with per-target archives (and a
combined tarball).

## Code layout

`src/` is generated: `types.zig` (structs, enums, flag sets), `handles.zig`
(handle methods), `callbacks.zig` (trampolines), `builders.zig` (chained-struct
builders), `root.zig` (the root re-exports), and `c-wgpu.zig` (raw translate-c
output). The split is internal to the generator, so users only see the root re-exports
and, for raw names, `wgpu.c`.

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
so one pass is enough after a header bump, but a second pass must leave `src/`
unchanged. Codegen fails on leaks and runs the generator tests.

Run codegen inside `nix develop`. translate-c records absolute include paths in
`src/c-wgpu.zig`, so regenerating outside the pinned dev shell rewrites those
comments even when nothing else changed.

## AI disclosure

This codebase uses LLM/AI for development. The generated bindings are covered by
the test suites, so review anything you depend on.
