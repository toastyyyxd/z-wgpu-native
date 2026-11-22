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

    var adapter_response = try instance.requestAdapterSync(std.testing.io, std.testing.allocator, null);
    defer adapter_response.deinit(std.testing.allocator);
    const adapter = adapter_response.tryAdapter() catch |err| {
        std.log.info("no adapter available ({s}), skipping sync wrapper test", .{@errorName(err)});
        return;
    };
    defer adapter.release();

    var device_response = try instance.requestDeviceSync(std.testing.io, std.testing.allocator, adapter, null);
    defer device_response.deinit(std.testing.allocator);
    const device = try device_response.tryDevice();
    defer device.release();

    const queue = device.getQueue();
    defer queue.release();

    const timeout = std.Io.Timeout{ .duration = .{ .raw = std.Io.Duration.fromMilliseconds(5000), .clock = .awake } };
    var done = try queue.onSubmittedWorkDoneSync(std.testing.io, std.testing.allocator, device, timeout);
    defer done.deinit(std.testing.allocator);
    try std.testing.expectEqual(z.types.QueueWorkDoneStatus.success, done.status);
}

test "sync request failure carries status and message" {
    const instance = z.handles.createInstance(null);
    defer instance.release();

    var options = z.types.RequestAdapterOptions{ .backend_type = .@"null" };
    var response = try instance.requestAdapterSync(std.testing.io, std.testing.allocator, &options);
    defer response.deinit(std.testing.allocator);

    try std.testing.expectEqual(z.types.RequestAdapterStatus.unavailable, response.status);
    try std.testing.expect(response.adapter == null);
    try std.testing.expect(response.text().len > 0);
    try std.testing.expectError(error.Unavailable, response.tryAdapter());
}

test "limits and adapter info are populated with null chained pointers" {
    const instance = z.handles.createInstance(null);
    defer instance.release();

    var adapter_response = try instance.requestAdapterSync(std.testing.io, std.testing.allocator, null);
    defer adapter_response.deinit(std.testing.allocator);
    const adapter = adapter_response.tryAdapter() catch |err| {
        std.log.info("no adapter available ({s}), skipping limits test", .{@errorName(err)});
        return;
    };
    defer adapter.release();

    const adapter_limits = try adapter.getLimits();
    try std.testing.expect(adapter_limits.max_buffer_size > 0);
    try std.testing.expect(adapter_limits.next_in_chain == null);

    const info = try adapter.getInfo();
    defer info.deinit();
    try std.testing.expect(info.next_in_chain == null);
    try std.testing.expect(info.device.toSlice() != null);

    var device_response = try adapter.requestDeviceSync(std.testing.io, std.testing.allocator, instance, null);
    defer device_response.deinit(std.testing.allocator);
    const device = try device_response.tryDevice();
    defer device.release();

    var features: z.types.SupportedFeatures = .{};
    device.getFeatures(&features);
    defer features.deinit();

    const device_limits = try device.getLimits();
    try std.testing.expect(device_limits.max_buffer_size > 0);
    try std.testing.expect(device_limits.next_in_chain == null);

    const instance_limits = try z.getInstanceLimits();
    try std.testing.expect(instance_limits.next_in_chain == null);
}

test "mapSync readback" {
    const instance = z.handles.createInstance(null);
    defer instance.release();

    var adapter_response = try instance.requestAdapterSync(std.testing.io, std.testing.allocator, null);
    defer adapter_response.deinit(std.testing.allocator);
    const adapter = adapter_response.tryAdapter() catch |err| {
        std.log.info("no adapter available ({s}), skipping mapSync test", .{@errorName(err)});
        return;
    };
    defer adapter.release();

    var device_response = try adapter.requestDeviceSync(std.testing.io, std.testing.allocator, instance, null);
    defer device_response.deinit(std.testing.allocator);
    const device = try device_response.tryDevice();
    defer device.release();

    const queue = device.getQueue();
    defer queue.release();

    const input = [_]u32{ 11, 22, 33, 44 };
    const size = @as(usize, @sizeOf(@TypeOf(input)));

    const source = device.createBuffer(&z.types.BufferDescriptor{
        .usage = .{ .copy_src = true, .copy_dst = true },
        .size = size,
    }) orelse return error.NoBuffer;
    defer source.release();

    const staging = device.createBuffer(&z.types.BufferDescriptor{
        .usage = .{ .map_read = true, .copy_dst = true },
        .size = size,
    }) orelse return error.NoBuffer;
    defer staging.release();

    queue.writeBuffer(source, 0, @ptrCast(&input), size);

    const encoder = device.createCommandEncoder(null);
    encoder.copyBufferToBuffer(source, 0, staging, 0, size);
    const command_buffer = encoder.finish(null);
    queue.submit(&.{command_buffer});

    var mapped = try staging.mapSync(std.testing.io, std.testing.allocator, device, .{ .read = true }, 0, size, .none);
    defer mapped.deinit(std.testing.allocator);
    if (mapped.status != .success) {
        std.log.info("mapSync failed: {s}", .{mapped.text()});
        return error.MapFailed;
    }
    try std.testing.expectEqual(z.types.MapAsyncStatus.success, mapped.status);

    const mapped_ptr = staging.getMappedRange(0, size) orelse return error.MapFailed;
    const result: []const u32 = @as([*]const u32, @alignCast(@ptrCast(mapped_ptr)))[0..input.len];
    try std.testing.expectEqualSlices(u32, &input, result);
    staging.unmap();
}
