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

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    var buf: [8192]u8 = undefined;
    var file_writer = std.Io.File.stdout().writer(io, &buf);
    const w = &file_writer.interface;

    try w.print("creating instance...\n", .{});

    const instance = try z.handles.createInstance(null);
    var adapter: z.handles.Adapter = undefined;
    const adapter_count = instance.enumerateAdapters(null, &adapter);
    if (adapter_count == 0) {
        try w.print("no adapters available, skipping\n", .{});
        return;
    }

    try w.print("requesting device...\n", .{});

    var dev_ctx = DeviceCtx{};
    var dev_ctx2: u8 = 0;
    const dev_future = adapter.requestDevice(null, z.callbacks.requestDeviceCallback(
        DeviceCtx,
        u8,
        &dev_ctx,
        &dev_ctx2,
        struct {
            fn cb(ctx: *DeviceCtx, _: *u8, s: z.types.RequestDeviceStatus, d: z.handles.Device, _: []const u8) void {
                ctx.status = s;
                ctx.device = d;
            }
        }.cb,
    ));
    var dev_waits = [_]z.types.FutureWaitInfo{.{ .future = dev_future, .completed = 0 }};
    _ = try z.handles.waitAny(instance, @ptrCast(&dev_waits), 5_000_000_000);

    const device = dev_ctx.device.?;
    const queue = try device.getQueue();

    try w.print("loading shader...\n", .{});

    const shader_wgsl = @embedFile("compute.wgsl");
    var shader_source = z.types.ShaderSourceWGSL{
        .chain = .{ .s_type = .shader_source_wgsl },
        .code = z.types.StringView.fromSlice(shader_wgsl),
    };
    const shader_module = try device.createShaderModule(&z.types.ShaderModuleDescriptor{
        .next_in_chain = &shader_source.chain,
    });

    try w.print("creating buffers...\n", .{});

    const numbers = [_]u32{ 1, 2, 3, 4 };
    const numbers_size = @as(u64, @sizeOf(@TypeOf(numbers)));

    const staging_buffer = try device.createBuffer(&z.types.BufferDescriptor{
        .usage = .{ .map_read = true, .copy_dst = true },
        .size = numbers_size,
        .mapped_at_creation = 0,
    });

    const storage_buffer = try device.createBuffer(&z.types.BufferDescriptor{
        .usage = .{ .storage = true, .copy_dst = true, .copy_src = true },
        .size = numbers_size,
        .mapped_at_creation = 0,
    });

    try w.print("creating compute pipeline...\n", .{});

    const compute_pipeline = try device.createComputePipeline(&z.types.ComputePipelineDescriptor{
        .compute = .{
            .module = z.handles.OptionalShaderModule.wrap(shader_module),
            .entry_point = z.types.StringView.fromSlice("main"),
        },
    });

    const bind_group_layout = try compute_pipeline.getBindGroupLayout(0);
    const bind_group = try device.createBindGroup(&z.types.BindGroupDescriptor{
        .layout = z.handles.OptionalBindGroupLayout.wrap(bind_group_layout),
        .entry_count = 1,
        .entries = @ptrCast(&z.types.BindGroupEntry{
            .binding = 0,
            .buffer = z.handles.OptionalBuffer.wrap(storage_buffer),
            .offset = 0,
            .size = numbers_size,
        }),
    });

    try w.print("executing compute...\n", .{});

    queue.writeBuffer(storage_buffer, 0, @ptrCast(&numbers), numbers_size);

    const command_encoder = try device.createCommandEncoder(null);
    const compute_pass = try command_encoder.beginComputePass(null);
    compute_pass.setPipeline(compute_pipeline);
    compute_pass.setBindGroup(0, bind_group, 0, null);
    compute_pass.dispatchWorkgroups(@as(u32, @intCast(numbers.len)), 1, 1);
    compute_pass.end();

    command_encoder.copyBufferToBuffer(storage_buffer, 0, staging_buffer, 0, numbers_size);
    const command_buffer = try command_encoder.finish(null);
    queue.submit(1, &command_buffer);

    try w.print("reading back results...\n", .{});

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
    _ = try z.handles.waitAny(instance, @ptrCast(&map_waits), 5_000_000_000);

    const mapped = staging_buffer.getMappedRange(0, numbers_size) orelse return error.MapFailed;
    const result: []const u32 = @as([*]const u32, @alignCast(@ptrCast(mapped)))[0..numbers.len];

    try w.print("results: {any}\n", .{result});

    const expected = [_]u32{ 0, 1, 7, 2 };
    for (result, expected) |r, e| {
        if (r != e) {
            try w.print("FAIL: expected {d}, got {d}\n", .{ e, r });
            std.process.exit(1);
        }
    }

    try w.print("PASS\n", .{});
    try file_writer.flush();
}
