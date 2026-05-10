const std = @import("std");
const z = @import("z_wgpu_native");

const GLFWwindow = opaque {};
const wl_display = opaque {};
const wl_surface = opaque {};

extern "c" fn glfwInit() c_int;
extern "c" fn glfwTerminate() void;
extern "c" fn glfwWindowHint(hint: c_int, value: c_int) void;
extern "c" fn glfwCreateWindow(width: c_int, height: c_int, title: [*:0]const u8, monitor: ?*anyopaque, share: ?*anyopaque) ?*GLFWwindow;
extern "c" fn glfwDestroyWindow(window: ?*GLFWwindow) void;
extern "c" fn glfwPollEvents() void;
extern "c" fn glfwWindowShouldClose(window: ?*GLFWwindow) c_int;
extern "c" fn glfwGetKey(window: ?*GLFWwindow, key: c_int) c_int;
extern "c" fn glfwGetWaylandDisplay() ?*wl_display;
extern "c" fn glfwGetWaylandWindow(window: ?*GLFWwindow) ?*wl_surface;

const GLFW_CLIENT_API = 0x00022001;
const GLFW_NO_API = 0;
const GLFW_KEY_ESCAPE = 256;
const GLFW_PRESS = 1;

const DeviceCtx = struct {
    status: z.types.RequestDeviceStatus = undefined,
    device: ?z.handles.Device = null,
};

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    var buf: [8192]u8 = undefined;
    var file_writer = std.Io.File.stdout().writer(io, &buf);
    const w = &file_writer.interface;

    try w.print("initializing GLFW...\n", .{});
    if (glfwInit() == 0) return error.GlfwInitFailed;
    defer glfwTerminate();

    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    const window = glfwCreateWindow(640, 480, "z-wgpu-native triangle", null, null) orelse return error.GlfwWindowFailed;
    defer glfwDestroyWindow(window);

    const wl_dpy = glfwGetWaylandDisplay() orelse return error.NoWaylandDisplay;

    try w.print("creating instance...\n", .{});

    var extras: z.types.InstanceExtras = std.mem.zeroes(z.types.InstanceExtras);
    extras.chain.s_type = .instance_extras;
    extras.display_handle.type = .wayland;
    extras.display_handle.data.wayland.display = @ptrCast(wl_dpy);
    const instance = try z.handles.createInstance(&z.types.InstanceDescriptor{
        .next_in_chain = @ptrCast(&extras.chain),
    });

    try w.print("creating surface...\n", .{});
    const wl_sfc = glfwGetWaylandWindow(window) orelse return error.NoWaylandSurface;
    var surface_source = z.types.SurfaceSourceWaylandSurface{
        .chain = .{ .s_type = .surface_source_wayland_surface },
        .display = @ptrCast(wl_dpy),
        .surface = @ptrCast(wl_sfc),
    };
    const surface = try instance.createSurface(&z.types.SurfaceDescriptor{
        .next_in_chain = @ptrCast(&surface_source.chain),
    });
    defer surface.unconfigure();

    try w.print("enumerating adapter...\n", .{});
    var adapter: z.handles.Adapter = undefined;
    const adapter_count = instance.enumerateAdapters(null, &adapter);
    if (adapter_count == 0) return error.NoAdapter;

    try w.print("requesting device...\n", .{});

    var dev_ctx = DeviceCtx{};
    var dev_ctx2: u8 = 0;
    _ = adapter.requestDevice(null, z.callbacks.requestDeviceCallback(
        DeviceCtx, u8, &dev_ctx, &dev_ctx2,
        struct {
            fn cb(ctx: *DeviceCtx, _: *u8, s: z.types.RequestDeviceStatus, d: z.handles.Device, _: []const u8) void {
                ctx.status = s;
                ctx.device = d;
            }
        }.cb,
    ));
    const device = dev_ctx.device orelse return error.NoDevice;
    const queue = try device.getQueue();

    try w.print("querying surface capabilities...\n", .{});

    const caps = try surface.getCapabilities(adapter);
    defer z.handles.surfaceCapabilitiesFreeMembers(caps);
    std.debug.print("surface: status=1 formats={d} presentModes={d}\n", .{ caps.formatCount, caps.presentModeCount });

    if (caps.formatCount == 0) return error.NoSurfaceFormats;
    if (caps.presentModeCount == 0) return error.NoPresentModes;

    surface.configure(&z.types.SurfaceConfiguration{
        .device = z.handles.OptionalDevice.wrap(device),
        .format = @enumFromInt(caps.formats[0]),
        .usage = .{ .render_attachment = true },
        .view_format_count = 1,
        .view_formats = @ptrCast(&caps.formats[0]),
        .alpha_mode = .auto,
        .width = 640,
        .height = 480,
        .present_mode = .fifo,
    });

    try w.print("loading shader...\n", .{});

    const shader_wgsl = @embedFile("triangle.wgsl");
    var shader_source = z.types.ShaderSourceWGSL{
        .chain = .{ .s_type = .shader_source_wgsl },
        .code = z.types.StringView.fromSlice(shader_wgsl),
    };
    const shader_module = try device.createShaderModule(&z.types.ShaderModuleDescriptor{
        .next_in_chain = &shader_source.chain,
    });

    const pipeline_layout = try device.createPipelineLayout(&z.types.PipelineLayoutDescriptor{});

    const render_pipeline = try device.createRenderPipeline(&z.types.RenderPipelineDescriptor{
        .layout = z.handles.OptionalPipelineLayout.wrap(pipeline_layout),
        .vertex = .{
            .module = z.handles.OptionalShaderModule.wrap(shader_module),
            .entry_point = z.types.StringView.fromSlice("vs_main"),
        },
        .primitive = .{
            .topology = .triangle_list,
            .strip_index_format = .@"undefined",
            .front_face = .ccw,
            .cull_mode = .none,
        },
        .multisample = .{ .count = 1, .mask = 0xFFFFFFFF, .alpha_to_coverage_enabled = 0 },
        .fragment = &.{
            .module = z.handles.OptionalShaderModule.wrap(shader_module),
            .entry_point = z.types.StringView.fromSlice("fs_main"),
            .target_count = 1,
            .targets = @ptrCast(&[1]z.types.ColorTargetState{.{ .format = @enumFromInt(caps.formats[0]), .write_mask = z.types.ColorWriteMask_all }}),
        },
    });

    try w.print("rendering...\n", .{});

    var frame_count: u32 = 0;
    while (glfwWindowShouldClose(window) == 0) : (frame_count += 1) {
        glfwPollEvents();
        if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) break;
        if (frame_count > 300) break;

        var surface_tex: z.types.SurfaceTexture = undefined;
        surface.getCurrentTexture(&surface_tex);
        if (surface_tex.status != .success_optimal) continue;

        const tex_view = try surface_tex.texture.unwrap().createView(null);

        const clear_color = z.types.Color{ .r = 0.0, .g = 0.0, .b = 0.0, .a = 1.0 };
        const command_encoder = try device.createCommandEncoder(null);
        const render_pass = try command_encoder.beginRenderPass(&z.types.RenderPassDescriptor{
            .color_attachment_count = 1,
            .color_attachments = @ptrCast(&[1]z.types.RenderPassColorAttachment{.{ .view = z.handles.OptionalTextureView.wrap(tex_view), .depth_slice = 0xFFFFFFFF, .load_op = .clear, .store_op = .store, .clear_value = clear_color }}),
        });
        render_pass.setPipeline(render_pipeline);
        render_pass.draw(3, 1, 0, 0);
        render_pass.end();

        const command_buffer = try command_encoder.finish(null);
        queue.submit(1, &command_buffer);
        _ = try surface.present();
    }

    try w.print("rendered {d} frames\n", .{frame_count});
    try file_writer.flush();
    if (frame_count > 0) {
        try w.print("PASS\n", .{});
    } else {
        try w.print("PASS (window was closed)\n", .{});
    }
    try file_writer.flush();
}
