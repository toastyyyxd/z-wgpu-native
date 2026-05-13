const std = @import("std");
const z = @import("z_wgpu_native");

const DeviceCtx = struct {
    status: z.types.RequestDeviceStatus = undefined,
    device: ?z.handles.Device = null,
};

const MapCtx = struct {
    status: z.types.MapAsyncStatus = undefined,
    mapped: bool = false,
};

test "compute" {
    std.log.info("creating instance...", .{});

    const instance = z.handles.createInstance(null) orelse unreachable;
    var adapter: z.handles.Adapter = undefined;
    const adapter_count = instance.enumerateAdapters(null, &adapter);
    if (adapter_count == 0) {
        std.log.info("no adapters available, skipping", .{});
        return;
    }

    std.log.info("requesting device...", .{});

    var dev_ctx = DeviceCtx{};
    var dev_ctx2: u8 = 0;
    const dev_future = adapter.requestDevice(null, z.callbacks.requestDeviceCallback(
        DeviceCtx,
        u8,
        &dev_ctx,
        &dev_ctx2,
        struct {
            fn cb(ctx: *DeviceCtx, _: *u8, s: z.types.RequestDeviceStatus, d: ?z.handles.Device, _: []const u8) void {
                ctx.status = s;
                ctx.device = d;
            }
        }.cb,
    ));
    var dev_waits = [_]z.types.FutureWaitInfo{.{ .future = dev_future, .completed = 0 }};
    _ = try instance.waitAny(dev_waits.len, @ptrCast(&dev_waits), 5_000_000_000);

    const device = dev_ctx.device.?;
    const queue = device.getQueue() orelse unreachable;

    std.log.info("loading shader...", .{});

    const shader_wgsl = @embedFile("compute.wgsl");
    var shader_source = z.types.ShaderSourceWGSL{
        .chain = .{ .s_type = .shader_source_wgsl },
        .code = z.types.StringView.fromSlice(shader_wgsl),
    };
    const shader_module = device.createShaderModule(&z.types.ShaderModuleDescriptor{
        .next_in_chain = &shader_source.chain,
    }) orelse unreachable;

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
            .module = z.handles.OptionalShaderModule.wrap(shader_module),
            .entry_point = z.types.StringView.fromSlice("main"),
        },
    }) orelse unreachable;

    const bind_group_layout = compute_pipeline.getBindGroupLayout(0) orelse unreachable;
    const bind_group = device.createBindGroup(&z.types.BindGroupDescriptor{
        .layout = z.handles.OptionalBindGroupLayout.wrap(bind_group_layout),
        .entry_count = 1,
        .entries = @ptrCast(&z.types.BindGroupEntry{
            .binding = 0,
            .buffer = z.handles.OptionalBuffer.wrap(storage_buffer),
            .offset = 0,
            .size = numbers_size,
        }),
    }) orelse unreachable;

    std.log.info("executing compute...", .{});

    queue.writeBuffer(storage_buffer, 0, @ptrCast(&numbers), numbers_size);

    const command_encoder = device.createCommandEncoder(null) orelse unreachable;
    const compute_pass = command_encoder.beginComputePass(null) orelse unreachable;
    compute_pass.setPipeline(compute_pipeline);
    compute_pass.setBindGroup(0, bind_group, 0, null);
    compute_pass.dispatchWorkgroups(@as(u32, @intCast(numbers.len)), 1, 1);
    compute_pass.end();

    command_encoder.copyBufferToBuffer(storage_buffer, 0, staging_buffer, 0, numbers_size);
    const command_buffer = command_encoder.finish(null) orelse unreachable;
    queue.submit(1, &command_buffer);

    std.log.info("reading back results...", .{});

    var map_ctx = MapCtx{};
    var map_ctx2: u8 = 0;
    const map_future = staging_buffer.mapAsync(z.types.MapMode{ .read = true }, 0, numbers_size, z.callbacks.bufferMapCallback(
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
    var map_waits = [_]z.types.FutureWaitInfo{.{ .future = map_future, .completed = 0 }};
    _ = try instance.waitAny(map_waits.len, @ptrCast(&map_waits), 5_000_000_000);

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

    std.log.info("PASS", .{});
}
