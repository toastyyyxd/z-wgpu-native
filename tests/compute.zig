const std = @import("std");
const z = @import("z_wgpu_native");

const DeviceCtx = struct {
    status: z.types.RequestDeviceStatus = undefined,
    device: z.c.WGPUDevice = null,
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

    const instance = z.handles.createInstance(null);
    var raw_adapter: z.c.WGPUAdapter = undefined;
    const adapter_count = instance.enumerateAdapters(null, &raw_adapter);
    if (adapter_count == 0) {
        try w.print("no adapters available, skipping\n", .{});
        return;
    }
    const adapter = z.handles.Adapter.fromPtr(raw_adapter.?);

    try w.print("requesting device...\n", .{});

    var dev_ctx = DeviceCtx{};
    var dev_ctx2: u8 = 0;
    const dev_future = adapter.requestDevice(null, z.callbacks.requestDeviceCallback(
        DeviceCtx,
        u8,
        &dev_ctx,
        &dev_ctx2,
        struct {
            fn cb(ctx: *DeviceCtx, _: *u8, s: z.types.RequestDeviceStatus, d: z.c.WGPUDevice, _: [:0]const u8) void {
                ctx.status = s;
                ctx.device = d;
            }
        }.cb,
    ));
    var dev_waits = [_]z.c.WGPUFutureWaitInfo{.{ .future = dev_future, .completed = 0 }};
    _ = try z.handles.waitAny(instance, &dev_waits, 5_000_000_000);

    const device = z.handles.Device.fromPtr(dev_ctx.device.?);
    const queue = device.getQueue();

    try w.print("loading shader...\n", .{});

    const shader_wgsl = @embedFile("shader.wgsl");
    var shader_source = z.c.WGPUShaderSourceWGSL{
        .chain = .{ .next = null, .sType = z.c.WGPUSType_ShaderSourceWGSL },
        .code = .{ .data = shader_wgsl, .length = shader_wgsl.len },
    };
    const shader_module = device.createShaderModule(&z.c.WGPUShaderModuleDescriptor{
        .nextInChain = &shader_source.chain,
        .label = .{ .data = "compute_shader", .length = 14 },
    });

    try w.print("creating buffers...\n", .{});

    const numbers = [_]u32{ 1, 2, 3, 4 };
    const numbers_size = @as(u64, @sizeOf(@TypeOf(numbers)));

    const staging_buffer = device.createBuffer(&z.c.WGPUBufferDescriptor{
        .nextInChain = null,
        .label = .{ .data = "staging_buffer", .length = 14 },
        .usage = z.c.WGPUBufferUsage_MapRead | z.c.WGPUBufferUsage_CopyDst,
        .size = numbers_size,
        .mappedAtCreation = 0,
    });

    const storage_buffer = device.createBuffer(&z.c.WGPUBufferDescriptor{
        .nextInChain = null,
        .label = .{ .data = "storage_buffer", .length = 14 },
        .usage = z.c.WGPUBufferUsage_Storage | z.c.WGPUBufferUsage_CopyDst | z.c.WGPUBufferUsage_CopySrc,
        .size = numbers_size,
        .mappedAtCreation = 0,
    });

    try w.print("creating compute pipeline...\n", .{});

    const compute_pipeline = device.createComputePipeline(&z.c.WGPUComputePipelineDescriptor{
        .nextInChain = null,
        .label = .{ .data = "compute_pipeline", .length = 16 },
        .layout = null,
        .compute = .{
            .nextInChain = null,
            .module = @as(z.c.WGPUShaderModule, @ptrCast(shader_module.ptr)),
            .entryPoint = .{ .data = "main", .length = 4 },
            .constantCount = 0,
            .constants = null,
        },
    });

    const bind_group_layout = compute_pipeline.getBindGroupLayout(0);
    const bind_group = device.createBindGroup(&z.c.WGPUBindGroupDescriptor{
        .nextInChain = null,
        .label = .{ .data = "bind_group", .length = 10 },
        .layout = @as(z.c.WGPUBindGroupLayout, @ptrCast(bind_group_layout.ptr)),
        .entryCount = 1,
        .entries = @ptrCast(&[_]z.c.WGPUBindGroupEntry{
            z.c.WGPUBindGroupEntry{
                .nextInChain = null,
                .binding = 0,
                .buffer = @as(z.c.WGPUBuffer, @ptrCast(storage_buffer.ptr)),
                .offset = 0,
                .size = numbers_size,
            },
        }),
    });

    try w.print("executing compute...\n", .{});

    queue.writeBuffer(
        @as(z.c.WGPUBuffer, @ptrCast(storage_buffer.ptr)),
        0,
        @ptrCast(&numbers),
        numbers_size,
    );

    const command_encoder = device.createCommandEncoder(null);
    const compute_pass = command_encoder.beginComputePass(null);
    compute_pass.setPipeline(@as(z.c.WGPUComputePipeline, @ptrCast(compute_pipeline.ptr)));
    compute_pass.setBindGroup(0, @as(z.c.WGPUBindGroup, @ptrCast(bind_group.ptr)), 0, null);
    compute_pass.dispatchWorkgroups(@as(u32, @intCast(numbers.len)), 1, 1);
    compute_pass.end();

    command_encoder.copyBufferToBuffer(
        @as(z.c.WGPUBuffer, @ptrCast(storage_buffer.ptr)), 0,
        @as(z.c.WGPUBuffer, @ptrCast(staging_buffer.ptr)), 0,
        numbers_size,
    );
    const command_buffer = command_encoder.finish(null);
    const raw_cb = @as(z.c.WGPUCommandBuffer, @ptrCast(command_buffer.ptr));
    queue.submit(1, @ptrCast(&raw_cb));

    try w.print("reading back results...\n", .{});

    var map_ctx = MapCtx{};
    var map_ctx2: u8 = 0;
    const map_future = staging_buffer.mapAsync(z.c.WGPUMapMode_Read, 0, numbers_size, z.callbacks.bufferMapCallback(
        MapCtx,
        u8,
        &map_ctx,
        &map_ctx2,
        struct {
            fn cb(ctx: *MapCtx, _: *u8, s: z.types.MapAsyncStatus, _: [:0]const u8) void {
                ctx.status = s;
                ctx.mapped = true;
            }
        }.cb,
    ));
    var map_waits = [_]z.c.WGPUFutureWaitInfo{.{ .future = map_future, .completed = 0 }};
    _ = try z.handles.waitAny(instance, &map_waits, 5_000_000_000);

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
}
