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

test "triangle" {
    std.log.info("initializing GLFW...", .{});
    if (glfwInit() == 0) return error.GlfwInitFailed;
    defer glfwTerminate();

    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    const window = glfwCreateWindow(640, 480, "z-wgpu-native triangle", null, null) orelse return error.GlfwWindowFailed;
    defer glfwDestroyWindow(window);

    const wl_dpy = glfwGetWaylandDisplay() orelse return error.NoWaylandDisplay;

    std.log.info("creating instance...", .{});

    var extras: z.types.InstanceExtras = std.mem.zeroes(z.types.InstanceExtras);
    extras.chain.s_type = .instance_extras;
    extras.display_handle.type = .wayland;
    extras.display_handle.data.wayland.display = @ptrCast(wl_dpy);
    const instance = z.handles.createInstance(&z.types.InstanceDescriptor{
        .next_in_chain = @ptrCast(&extras.chain),
    }) orelse unreachable;

    std.log.info("creating surface...", .{});
    const wl_sfc = glfwGetWaylandWindow(window) orelse return error.NoWaylandSurface;
    var surface_source = z.types.SurfaceSourceWaylandSurface{
        .chain = .{ .s_type = .surface_source_wayland_surface },
        .display = @ptrCast(wl_dpy),
        .surface = @ptrCast(wl_sfc),
    };
    const surface = instance.createSurface(&z.types.SurfaceDescriptor{
        .next_in_chain = @ptrCast(&surface_source.chain),
    }) orelse unreachable;
    defer surface.unconfigure();

    std.log.info("enumerating adapter...", .{});
    const adapter_count = instance.enumerateAdapters(null, null);
    if (adapter_count == 0) return error.NoAdapter;
    const adapters = try std.testing.allocator.alloc(z.handles.Adapter, adapter_count);
    defer std.testing.allocator.free(adapters);
    _ = instance.enumerateAdapters(null, adapters.ptr);
    const adapter = adapters[0];

    std.log.info("requesting device...", .{});

    var dev_ctx = DeviceCtx{};
    var dev_ctx2: u8 = 0;
    _ = adapter.requestDevice(null, z.callbacks.requestDeviceCallback(
        DeviceCtx, u8, &dev_ctx, &dev_ctx2,
        struct {
            fn cb(ctx: *DeviceCtx, _: *u8, s: z.types.RequestDeviceStatus, d: ?z.handles.Device, _: []const u8) void {
                ctx.status = s;
                ctx.device = d;
            }
        }.cb,
    ));
    const device = dev_ctx.device orelse return error.NoDevice;
    const queue = device.getQueue() orelse unreachable;

    std.log.info("querying surface capabilities...", .{});

    const caps = try surface.getCapabilities(adapter);
    defer z.handles.surfaceCapabilitiesFreeMembers(caps);
    std.log.info("surface: status=1 formats={d} presentModes={d}", .{ caps.format_count, caps.present_mode_count });

    if (caps.format_count == 0) return error.NoSurfaceFormats;
    if (caps.present_mode_count == 0) return error.NoPresentModes;

    surface.configure(&z.types.SurfaceConfiguration{
        .device = z.handles.OptionalDevice.wrap(device),
        .format = caps.formats[0],
        .usage = .{ .render_attachment = true },
        .view_formats = caps.formats,
        .alpha_mode = .auto,
        .width = 640,
        .height = 480,
        .present_mode = .fifo,
    });

    std.log.info("loading shader...", .{});

    const shader_wgsl = @embedFile("triangle.wgsl");
    var shader_source = z.types.ShaderSourceWGSL{
        .chain = .{ .s_type = .shader_source_wgsl },
        .code = z.types.StringView.fromSlice(shader_wgsl),
    };
    const shader_module = device.createShaderModule(&z.types.ShaderModuleDescriptor{
        .next_in_chain = &shader_source.chain,
    }) orelse unreachable;

    const pipeline_layout = device.createPipelineLayout(&z.types.PipelineLayoutDescriptor{}) orelse unreachable;

    const render_pipeline = device.createRenderPipeline(&z.types.RenderPipelineDescriptor{
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
            .targets = @ptrCast(&[1]z.types.ColorTargetState{.{ .format = caps.formats[0], .write_mask = z.types.ColorWriteMask_all }}),
        },
    }) orelse unreachable;

    std.log.info("rendering...", .{});

    var frame_count: u32 = 0;
    while (glfwWindowShouldClose(window) == 0) : (frame_count += 1) {
        glfwPollEvents();
        if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) break;
        if (frame_count > 300) break;

        var surface_tex: z.types.SurfaceTexture = undefined;
        surface.getCurrentTexture(&surface_tex);
        if (surface_tex.status != .success_optimal) continue;

        const tex_view = surface_tex.texture.unwrap().createView(null) orelse unreachable;

        const clear_color = z.types.Color{ .r = 0.0, .g = 0.0, .b = 0.0, .a = 1.0 };
        const command_encoder = device.createCommandEncoder(null) orelse unreachable;
        const render_pass = command_encoder.beginRenderPass(&z.types.RenderPassDescriptor{
            .color_attachment_count = 1,
            .color_attachments = @ptrCast(&[1]z.types.RenderPassColorAttachment{.{ .view = z.handles.OptionalTextureView.wrap(tex_view), .depth_slice = 0xFFFFFFFF, .load_op = .clear, .store_op = .store, .clear_value = clear_color }}),
        }) orelse unreachable;
        render_pass.setPipeline(render_pipeline);
        render_pass.draw(3, 1, 0, 0);
        render_pass.end();

        const command_buffer = command_encoder.finish(null) orelse unreachable;
        queue.submit(1, &command_buffer);
        _ = try surface.present();
    }

    std.log.info("rendered {d} frames", .{frame_count});
    if (frame_count > 0) {
        std.log.info("PASS", .{});
    } else {
        std.log.info("PASS (window was closed)", .{});
    }
}
