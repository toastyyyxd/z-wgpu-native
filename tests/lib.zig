const std = @import("std");
const z = @import("z_wgpu_native");

test "root re-exports module declarations" {
    comptime {
        std.debug.assert(z.Device == z.handles.Device);
        std.debug.assert(z.DeviceDescriptor == z.types.DeviceDescriptor);
        std.debug.assert(z.BufferUsage == z.types.BufferUsage);
        std.debug.assert(z.ShaderModuleDescriptorWithShaderSourceWGSL == z.builders.ShaderModuleDescriptorWithShaderSourceWGSL);
        std.debug.assert(@TypeOf(z.createInstance) == @TypeOf(z.handles.createInstance));
    }
}

test "stubbed entry points stay declared and root-aliased" {
    comptime {
        // Stubs are inline functions whose body is a compile error. The
        // declarations themselves must remain visible in both modules, so a
        // misspelled name is a normal Zig error and docs still show them.
        std.debug.assert(@hasDecl(z.handles.Buffer, "writeMappedRange"));
        std.debug.assert(@hasDecl(z.Device, "getAdapterInfo"));
        std.debug.assert(@hasDecl(z.handles, "getInstanceFeatures"));
        std.debug.assert(@hasDecl(z, "getInstanceFeatures"));
        std.debug.assert(@hasDecl(z, "getProcAddress"));
    }
}

test "flag helpers compose" {
    const usage = (z.BufferUsage{ .map_read = true }).bitOr(.{ .copy_dst = true });
    try std.testing.expect(usage.map_read);
    try std.testing.expect(usage.copy_dst);

    const masked = usage.bitAnd(.{ .map_read = true });
    try std.testing.expect(masked.map_read);
    try std.testing.expect(!masked.copy_dst);
}

test "extra builders" {
    const names = [_][]const u8{
        "InstanceDescriptorWithInstanceExtras",
        "DeviceDescriptorWithDeviceExtras",
        "LimitsWithNativeLimits",
        "ShaderModuleDescriptorWithShaderSourceGLSL",
        "BindGroupEntryWithBindGroupEntryExtras",
        "BindGroupLayoutEntryWithBindGroupLayoutEntryExtras",
        "QuerySetDescriptorWithQuerySetDescriptorExtras",
        "SurfaceConfigurationWithSurfaceConfigurationExtras",
        "SurfaceDescriptorWithSurfaceSourceSwapChainPanel",
        "PrimitiveStateWithPrimitiveStateExtras",
        "SamplerDescriptorWithSamplerDescriptorExtras",
        "SurfaceConfigurationWithSurfaceColorManagement",
    };
    inline for (names) |name| {
        const Builder = @field(z, name);
        var builder: Builder = .{};
        _ = builder.descriptor();
    }
}

test "builder slice setters" {
    var instance_builder: z.InstanceDescriptorWithInstanceExtras = .{};
    instance_builder.setRequiredFeatures(&[_]z.InstanceFeatureName{});
    _ = instance_builder.descriptor();

    var surface_builder: z.SurfaceConfigurationWithSurfaceConfigurationExtras = .{};
    surface_builder.setViewFormats(&[_]z.TextureFormat{});
    _ = surface_builder.descriptor();

    var bind_builder: z.BindGroupEntryWithBindGroupEntryExtras = .{};
    bind_builder.setBuffers(&[_]?*z.Buffer{});
    bind_builder.setSamplers(&[_]?*z.Sampler{});
    bind_builder.setTextureViews(&[_]?*z.TextureView{});
    _ = bind_builder.descriptor();

    var query_builder: z.QuerySetDescriptorWithQuerySetDescriptorExtras = .{};
    query_builder.setPipelineStatistics(&[_]z.PipelineStatisticName{});
    _ = query_builder.descriptor();
}

test "NativeDisplayHandle zero-init" {
    const dh: z.types.NativeDisplayHandle = .{};
    try std.testing.expectEqual(@as(u32, 0), @intFromEnum(dh.type));
}

test "StringView roundtrip" {
    const original = "hello wgpu";
    const sv = z.types.StringView.fromSlice(original);
    const back = sv.toSlice().?;
    try std.testing.expect(std.mem.eql(u8, original, back));
}

test "bitpack struct bitCast roundtrip" {
    const mode: z.types.MapMode = .{ .read = true, .write = false };
    const u: u64 = @bitCast(mode);
    const mode2: z.types.MapMode = @bitCast(u);
    try std.testing.expect(mode2.read);
    try std.testing.expect(!mode2.write);
}

test "ChainedIterator empty chain" {
    const head: z.types.ChainedStruct = .{ .next = null };
    var iter = z.types.chainedIterator(&head);
    const first = iter.next();
    try std.testing.expect(first != null);
    try std.testing.expect(iter.next() == null);
}

test "DeviceDescriptor accepts typed callback infos" {
    const Ctx = struct {};
    const Helpers = struct {
        fn deviceLost(_: *Ctx, _: *Ctx, _: ?*z.handles.Device, _: z.types.DeviceLostReason, _: []const u8) void {}
        fn uncapturedError(_: *Ctx, _: *Ctx, _: ?*z.handles.Device, _: z.types.ErrorType, _: []const u8) void {}
    };
    var a: Ctx = .{};
    var b: Ctx = .{};
    const desc: z.types.DeviceDescriptor = .{
        .device_lost_callback_info = z.callbacks.deviceLostCallback(Ctx, Ctx, &a, &b, Helpers.deviceLost),
        .uncaptured_error_callback_info = z.callbacks.uncapturedErrorCallback(Ctx, Ctx, &a, &b, Helpers.uncapturedError),
    };
    comptime std.debug.assert(@TypeOf(desc.device_lost_callback_info) == z.types.DeviceLostCallbackInfo);
    comptime std.debug.assert(@TypeOf(desc.uncaptured_error_callback_info) == z.types.UncapturedErrorCallbackInfo);
}

test "enums without a C zero get a Zig-side zero tag" {
    // AdapterType has no C _Undefined, so the generator adds @"undefined" = 0.
    try std.testing.expect(!@hasDecl(z.c, "WGPUAdapterType_Undefined"));
    try std.testing.expectEqual(@as(u32, 0), @intFromEnum(z.types.AdapterType.@"undefined"));
}

test "descriptor zero-init defaults are deterministic" {
    const chain: z.types.ChainedStruct = .{};
    try std.testing.expect(chain.next == null);
    try std.testing.expectEqual(@as(u32, 0), @intFromEnum(chain.s_type));

    const info: z.types.AdapterInfo = .{};
    try std.testing.expectEqual(@as(u32, 0), @intFromEnum(info.adapter_type));
    try std.testing.expectEqual(@as(u32, 0), info.vendor_id);

    const buffer: z.types.BufferDescriptor = .{};
    try std.testing.expectEqual(@as(u64, 0), buffer.size);
    try std.testing.expectEqual(@as(u64, 0), @as(u64, @bitCast(buffer.usage)));

    const descriptor: z.types.DeviceDescriptor = .{};
    try std.testing.expectEqual(@as(u32, 0), @intFromEnum(descriptor.device_lost_callback_info.mode));
    try std.testing.expect(descriptor.required_limits == null);
}

test "all generated structs are default-constructible" {
    @setEvalBranchQuota(200_000);
    inline for (comptime std.meta.declarations(z.types)) |decl_name| {
        const raw = @field(z.types, decl_name);
        if (@TypeOf(raw) != type) continue;
        const T: type = raw;
        if (@typeInfo(T) != .@"struct") continue;
        if (comptime std.meta.containerLayout(T) == .auto) continue;
        const value: T = .{};
        try std.testing.expectEqual(@as(usize, @sizeOf(T)), @sizeOf(@TypeOf(value)));
    }
}
