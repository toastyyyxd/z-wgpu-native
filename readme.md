Run `clang -E -I vendor/wgpu-native/ffi/webgpu-headers vendor/wgpu-native/ffi/wgpu.h -o preprocessed.h`, then `zig translate-c preprocessed.h > bindings.zig` to get initial bindings manually.
WIP.