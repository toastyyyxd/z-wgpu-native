const std = @import("std");
const z = @import("z_wgpu_native");

const DeviceCtx = struct {
    status: z.types.RequestDeviceStatus = undefined,
    device: ?*z.handles.Device = null,
};

const MapCtx = struct {
    status: z.types.MapAsyncStatus = undefined,
    mapped: bool = false,
};

test "compute" {
    std.log.info("creating instance...", .{});

    const instance = z.handles.createInstance(null);
    const adapter_count = instance.enumerateAdapters(null, null);
    if (adapter_count == 0) {
        std.log.info("no adapters available, skipping", .{});
        return;
    }
    const adapters = try std.testing.allocator.alloc(?*z.handles.Adapter, adapter_count);
    defer std.testing.allocator.free(adapters);
    _ = instance.enumerateAdapters(null, adapters.ptr);
    const adapter = adapters[0] orelse return error.NoAdapter;

    std.log.info("requesting device...", .{});

    var dev_ctx = DeviceCtx{};
    var dev_ctx2: u8 = 0;
    
    _ = adapter.requestDevice(null, z.callbacks.requestDeviceCallback(
        DeviceCtx,
        u8,
        &dev_ctx,
        &dev_ctx2,
        struct {
            fn cb(ctx: *DeviceCtx, _: *u8, s: z.types.RequestDeviceStatus, d: ?*z.handles.Device, _: []const u8) void {
                ctx.status = s;
                ctx.device = d;
            }
        }.cb,
    ));

    const device = dev_ctx.device orelse return error.NoDevice;
    const queue = device.getQueue();

    std.log.info("loading shader...", .{});

    const shader_wgsl = @embedFile("compute.wgsl");
    var shader = z.builders.ShaderModuleDescriptorWithShaderSourceWGSL{
        .code = z.types.StringView.fromSlice(shader_wgsl),
    };
    const shader_module = device.createShaderModule(shader.descriptor());

    std.log.info("creating buffers...", .{});

    const numbers = [_]u32{ 1, 2, 3, 4 };
    const numbers_size = @as(u64, @sizeOf(@TypeOf(numbers)));

    const staging_buffer = device.createBuffer(&z.types.BufferDescriptor{
        .usage = .{ .map_read = true, .copy_dst = true },
        .size = numbers_size,
        .mapped_at_creation = 0,
    }) orelse unreachable;

    const storage_buffer = device.createBuffer(&z.types.BufferDescriptor{
        .usage = .{ .storage = true, .copy_dst = true, .copy_src = true },
        .size = numbers_size,
        .mapped_at_creation = 0,
    }) orelse unreachable;

    std.log.info("creating compute pipeline...", .{});

    const compute_pipeline = device.createComputePipeline(&z.types.ComputePipelineDescriptor{
        .compute = .{
            .module = shader_module,
            .entry_point = z.types.StringView.fromSlice("main"),
        },
    });

    const bind_group_layout = compute_pipeline.getBindGroupLayout(0);
    var bind_group_desc: z.types.BindGroupDescriptor = .{ .layout = bind_group_layout };
    bind_group_desc.setEntries(&.{.{
        .binding = 0,
        .buffer = storage_buffer,
        .offset = 0,
        .size = numbers_size,
    }});
    const bind_group = device.createBindGroup(&bind_group_desc);

    std.log.info("executing compute...", .{});

    queue.writeBuffer(storage_buffer, 0, @ptrCast(&numbers), numbers_size);

    const command_encoder = device.createCommandEncoder(null);
    const compute_pass = command_encoder.beginComputePass(null);
    compute_pass.setPipeline(compute_pipeline);
    compute_pass.setBindGroup(0, bind_group, &.{});
    compute_pass.dispatchWorkgroups(@as(u32, @intCast(numbers.len)), 1, 1);
    compute_pass.end();

    command_encoder.copyBufferToBuffer(storage_buffer, 0, staging_buffer, 0, numbers_size);
    const command_buffer = command_encoder.finish(null);
    queue.submit(&.{command_buffer});

    std.log.info("reading back results...", .{});

    var map_ctx = MapCtx{};
    var map_ctx2: u8 = 0;
    _ = staging_buffer.mapAsync(z.types.MapMode{ .read = true }, 0, numbers_size, z.callbacks.bufferMapCallback(
        MapCtx,
        u8,
        &map_ctx,
        &map_ctx2,
        struct {
            fn cb(ctx: *MapCtx, _: *u8, s: z.types.MapAsyncStatus, _: []const u8) void {
                ctx.status = s;
                ctx.mapped = true;
            }
        }.cb,
    ));

    while (!map_ctx.mapped) {
        _ = device.poll(true, null); 
    }

    if (map_ctx.status != .success) return error.MapFailed;

    const mapped = staging_buffer.getMappedRange(0, numbers_size) orelse return error.MapFailed;
    const result: []const u32 = @as([*]const u32, @alignCast(@ptrCast(mapped)))[0..numbers.len];

    std.log.info("results: {any}", .{result});

    const expected = [_]u32{ 0, 1, 7, 2 };
    for (result, expected) |r, e| {
        if (r != e) {
            std.log.info("FAIL: expected {d}, got {d}", .{ e, r });
            return error.TestFailed;
        }
    }

    staging_buffer.unmap();
    std.log.info("PASS", .{});
}

test "sync wrappers" {
    const instance = z.handles.createInstance(null);
    defer instance.release();

    const adapter_response = try instance.requestAdapterSync(std.testing.io, null);
    try std.testing.expectEqual(z.types.RequestAdapterStatus.success, adapter_response.status);
    const adapter = adapter_response.adapter orelse return error.NoAdapter;
    defer adapter.release();

    const device_response = try adapter.requestDeviceSync(std.testing.io, instance, null);
    try std.testing.expectEqual(z.types.RequestDeviceStatus.success, device_response.status);
    const device = device_response.device orelse return error.NoDevice;
    defer device.release();

    const queue = device.getQueue();
    defer queue.release();

    const done = try queue.onSubmittedWorkDoneSync(std.testing.io, device);
    try std.testing.expectEqual(z.types.QueueWorkDoneStatus.success, done.status);
}
