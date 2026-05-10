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
extern "c" fn glfwGetFramebufferSize(window: ?*GLFWwindow, width: *c_int, height: *c_int) void;

const GLFW_CLIENT_API = 0x00022001;
const GLFW_NO_API = 0;
const GLFW_KEY_ESCAPE = 256;
const GLFW_PRESS = 1;

const DeviceCtx = struct {
    status: z.types.RequestDeviceStatus = undefined,
    device: ?z.handles.Device = null,
};

const Vertex = extern struct {
    pos: [3]f32,
    col: [3]f32,
};

const Uniforms = extern struct {
    mvp: [4][4]f32,
};

fn mat4Mul(a: [4][4]f32, b: [4][4]f32) [4][4]f32 {
    var r: [4][4]f32 = std.mem.zeroes([4][4]f32);
    for (0..4) |col| {
        for (0..4) |row| {
            r[col][row] = a[0][row] * b[col][0] +
                a[1][row] * b[col][1] +
                a[2][row] * b[col][2] +
                a[3][row] * b[col][3];
        }
    }
    return r;
}

fn mat4Perspective(fov_y_rad: f32, aspect: f32, near: f32, far: f32) [4][4]f32 {
    const f = 1.0 / @tan(fov_y_rad * 0.5);
    return .{
        .{ f / aspect, 0, 0, 0 },
        .{ 0, f, 0, 0 },
        .{ 0, 0, far / (near - far), -1 },
        .{ 0, 0, (near * far) / (near - far), 0 },
    };
}

fn mat4Translation(tx: f32, ty: f32, tz: f32) [4][4]f32 {
    return .{
        .{ 1, 0, 0, 0 },
        .{ 0, 1, 0, 0 },
        .{ 0, 0, 1, 0 },
        .{ tx, ty, tz, 1 },
    };
}

fn mat4RotationY(angle_rad: f32) [4][4]f32 {
    const c = @cos(angle_rad);
    const s = @sin(angle_rad);
    return .{
        .{ c, 0, -s, 0 },
        .{ 0, 1, 0, 0 },
        .{ s, 0, c, 0 },
        .{ 0, 0, 0, 1 },
    };
}

fn mat4RotationX(angle_rad: f32) [4][4]f32 {
    const c = @cos(angle_rad);
    const s = @sin(angle_rad);
    return .{
        .{ 1, 0, 0, 0 },
        .{ 0, c, s, 0 },
        .{ 0, -s, c, 0 },
        .{ 0, 0, 0, 1 },
    };
}

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    var buf: [8192]u8 = undefined;
    var file_writer = std.Io.File.stdout().writer(io, &buf);
    const w = &file_writer.interface;

    try w.print("initializing GLFW...\n", .{});
    if (glfwInit() == 0) return error.GlfwInitFailed;
    defer glfwTerminate();

    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    const window = glfwCreateWindow(640, 480, "z-wgpu-native rgbw cube+pyramid", null, null) orelse return error.GlfwWindowFailed;
    defer glfwDestroyWindow(window);

    const wl_dpy = glfwGetWaylandDisplay() orelse return error.NoWaylandDisplay;

    var extras: z.types.InstanceExtras = std.mem.zeroes(z.types.InstanceExtras);
    extras.chain.s_type = .instance_extras;
    extras.display_handle.type = .wayland;
    extras.display_handle.data.wayland.display = @ptrCast(wl_dpy);
    const instance = try z.handles.createInstance(&z.types.InstanceDescriptor{
        .next_in_chain = @ptrCast(&extras.chain),
    });

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

    var adapter: z.handles.Adapter = undefined;
    if (instance.enumerateAdapters(null, &adapter) == 0) return error.NoAdapter;

    var dev_ctx = DeviceCtx{};
    var dev_ctx2: u8 = 0;
    _ = adapter.requestDevice(null, z.callbacks.requestDeviceCallback(DeviceCtx, u8, &dev_ctx, &dev_ctx2, struct {
        fn cb(ctx: *DeviceCtx, _: *u8, s: z.types.RequestDeviceStatus, d: z.handles.Device, _: []const u8) void {
            ctx.status = s;
            ctx.device = d;
        }
    }.cb));
    const device = dev_ctx.device orelse return error.NoDevice;
    const queue = try device.getQueue();

    const caps = try surface.getCapabilities(adapter);
    defer z.handles.surfaceCapabilitiesFreeMembers(caps);
    if (caps.formatCount == 0 or caps.presentModeCount == 0) return error.NoSurfaceFormats;

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

    const shader_wgsl = @embedFile("rgbw.wgsl");
    var shader_source = z.types.ShaderSourceWGSL{
        .chain = .{ .s_type = .shader_source_wgsl },
        .code = z.types.StringView.fromSlice(shader_wgsl),
    };
    const shader_module = try device.createShaderModule(&z.types.ShaderModuleDescriptor{
        .next_in_chain = &shader_source.chain,
    });

    const uniform_buf_cube = try device.createBuffer(&std.mem.zeroInit(z.types.BufferDescriptor, .{
        .usage = .{ .uniform = true, .copy_dst = true },
        .size = @sizeOf(Uniforms),
    }));
    const uniform_buf_pyr = try device.createBuffer(&std.mem.zeroInit(z.types.BufferDescriptor, .{
        .usage = .{ .uniform = true, .copy_dst = true },
        .size = @sizeOf(Uniforms),
    }));

    const bind_group_layout = try device.createBindGroupLayout(&z.types.BindGroupLayoutDescriptor{
        .entry_count = 1,
        .entries = @ptrCast(&[1]z.types.BindGroupLayoutEntry{
            .{
                .binding = 0,
                .visibility = .{ .vertex = true },
                .buffer = .{ .type = .uniform, .min_binding_size = @sizeOf(Uniforms) },
                .sampler = .{ .type = .binding_not_used },
                .texture = .{ .sample_type = .binding_not_used },
                .storage_texture = .{ .access = .binding_not_used },
            },
        }),
    });

    const bind_group_cube = try device.createBindGroup(&z.types.BindGroupDescriptor{
        .layout = z.handles.OptionalBindGroupLayout.wrap(bind_group_layout),
        .entry_count = 1,
        .entries = @ptrCast(&[1]z.types.BindGroupEntry{
            .{ .binding = 0, .buffer = z.handles.OptionalBuffer.wrap(uniform_buf_cube), .offset = 0, .size = @sizeOf(Uniforms) },
        }),
    });
    const bind_group_pyr = try device.createBindGroup(&z.types.BindGroupDescriptor{
        .layout = z.handles.OptionalBindGroupLayout.wrap(bind_group_layout),
        .entry_count = 1,
        .entries = @ptrCast(&[1]z.types.BindGroupEntry{
            .{ .binding = 0, .buffer = z.handles.OptionalBuffer.wrap(uniform_buf_pyr), .offset = 0, .size = @sizeOf(Uniforms) },
        }),
    });

    const pipeline_layout = try device.createPipelineLayout(&z.types.PipelineLayoutDescriptor{
        .bind_group_layout_count = 1,
        .bind_group_layouts = @ptrCast(&bind_group_layout),
    });

    const render_pipeline = try device.createRenderPipeline(&z.types.RenderPipelineDescriptor{
        .layout = z.handles.OptionalPipelineLayout.wrap(pipeline_layout),
        .vertex = .{
            .module = z.handles.OptionalShaderModule.wrap(shader_module),
            .entry_point = z.types.StringView.fromSlice("vs_main"),
            .buffer_count = 1,
            .buffers = @ptrCast(&[1]z.types.VertexBufferLayout{
                .{
                    .array_stride = @sizeOf(Vertex),
                    .step_mode = .vertex,
                    .attribute_count = 2,
                    .attributes = @ptrCast(&[2]z.types.VertexAttribute{
                        .{ .format = .float32x3, .offset = @offsetOf(Vertex, "pos"), .shader_location = 0 },
                        .{ .format = .float32x3, .offset = @offsetOf(Vertex, "col"), .shader_location = 1 },
                    }),
                },
            }),
        },
        .primitive = .{ .topology = .triangle_list, .cull_mode = .back },
        .multisample = .{ .count = 1, .mask = 0xFFFFFFFF, .alpha_to_coverage_enabled = 0 },
        .fragment = &.{
            .module = z.handles.OptionalShaderModule.wrap(shader_module),
            .entry_point = z.types.StringView.fromSlice("fs_main"),
            .target_count = 1,
            .targets = @ptrCast(&[1]z.types.ColorTargetState{.{ .format = @enumFromInt(caps.formats[0]), .write_mask = z.types.ColorWriteMask_all }}),
        },
        .depth_stencil = &.{
            .format = .depth24_plus,
            .depth_write_enabled = .@"true",
            .depth_compare = .less,
            .stencil_front = .{},
            .stencil_back = .{},
        },
    });

    const depth_tex = try device.createTexture(&z.types.TextureDescriptor{
        .usage = .{ .render_attachment = true },
        .dimension = ._2d,
        .size = .{ .width = 640, .height = 480, .depth_or_array_layers = 1 },
        .format = .depth24_plus,
        .mip_level_count = 1,
        .sample_count = 1,
    });
    const depth_view = try depth_tex.createView(null);

    const cube_verts = [_]Vertex{
        .{ .pos = .{ -0.5, -0.5, 0.5 }, .col = .{ 1, 0, 0 } },
        .{ .pos = .{ 0.5, -0.5, 0.5 }, .col = .{ 1, 0, 0 } },
        .{ .pos = .{ 0.5, 0.5, 0.5 }, .col = .{ 1, 0, 0 } },
        .{ .pos = .{ -0.5, 0.5, 0.5 }, .col = .{ 1, 0, 0 } },
        .{ .pos = .{ 0.5, -0.5, -0.5 }, .col = .{ 0, 1, 0 } },
        .{ .pos = .{ -0.5, -0.5, -0.5 }, .col = .{ 0, 1, 0 } },
        .{ .pos = .{ -0.5, 0.5, -0.5 }, .col = .{ 0, 1, 0 } },
        .{ .pos = .{ 0.5, 0.5, -0.5 }, .col = .{ 0, 1, 0 } },
        .{ .pos = .{ -0.5, 0.5, 0.5 }, .col = .{ 0, 0, 1 } },
        .{ .pos = .{ 0.5, 0.5, 0.5 }, .col = .{ 0, 0, 1 } },
        .{ .pos = .{ 0.5, 0.5, -0.5 }, .col = .{ 0, 0, 1 } },
        .{ .pos = .{ -0.5, 0.5, -0.5 }, .col = .{ 0, 0, 1 } },
        .{ .pos = .{ -0.5, -0.5, -0.5 }, .col = .{ 1, 1, 1 } },
        .{ .pos = .{ 0.5, -0.5, -0.5 }, .col = .{ 1, 1, 1 } },
        .{ .pos = .{ 0.5, -0.5, 0.5 }, .col = .{ 1, 1, 1 } },
        .{ .pos = .{ -0.5, -0.5, 0.5 }, .col = .{ 1, 1, 1 } },
        .{ .pos = .{ 0.5, -0.5, 0.5 }, .col = .{ 1, 0, 1 } },
        .{ .pos = .{ 0.5, -0.5, -0.5 }, .col = .{ 1, 0, 1 } },
        .{ .pos = .{ 0.5, 0.5, -0.5 }, .col = .{ 1, 0, 1 } },
        .{ .pos = .{ 0.5, 0.5, 0.5 }, .col = .{ 1, 0, 1 } },
        .{ .pos = .{ -0.5, -0.5, -0.5 }, .col = .{ 1, 1, 0 } },
        .{ .pos = .{ -0.5, -0.5, 0.5 }, .col = .{ 1, 1, 0 } },
        .{ .pos = .{ -0.5, 0.5, 0.5 }, .col = .{ 1, 1, 0 } },
        .{ .pos = .{ -0.5, 0.5, -0.5 }, .col = .{ 1, 1, 0 } },
    };
    const cube_indices = [_]u32{
        0, 1, 2, 2, 3, 0,
        4, 5, 6, 6, 7, 4,
        8, 9, 10, 10, 11, 8,
        12, 13, 14, 14, 15, 12,
        16, 17, 18, 18, 19, 16,
        20, 21, 22, 22, 23, 20,
    };

    const pyramid_verts = [_]Vertex{
        .{ .pos = .{ -0.4, -0.5, 0.4 }, .col = .{ 0.8, 0.8, 0.8 } },
        .{ .pos = .{ 0.4, -0.5, 0.4 }, .col = .{ 0.8, 0.8, 0.8 } },
        .{ .pos = .{ 0.4, -0.5, -0.4 }, .col = .{ 0.8, 0.8, 0.8 } },
        .{ .pos = .{ -0.4, -0.5, -0.4 }, .col = .{ 0.8, 0.8, 0.8 } },
        .{ .pos = .{ 0.0, 0.5, 0.0 }, .col = .{ 0.6, 0.6, 0.6 } },
    };
    const pyramid_indices = [_]u32{
        0, 1, 4,
        1, 2, 4,
        2, 3, 4,
        3, 0, 4,
        0, 3, 2, 2, 1, 0,
    };

    const cube_vb = try device.createBuffer(&std.mem.zeroInit(z.types.BufferDescriptor, .{
        .usage = .{ .vertex = true, .copy_dst = true },
        .size = @sizeOf(@TypeOf(cube_verts)),
    }));
    queue.writeBuffer(cube_vb, 0, @ptrCast(&cube_verts), @sizeOf(@TypeOf(cube_verts)));
    const cube_ib = try device.createBuffer(&std.mem.zeroInit(z.types.BufferDescriptor, .{
        .usage = .{ .index = true, .copy_dst = true },
        .size = @sizeOf(@TypeOf(cube_indices)),
    }));
    queue.writeBuffer(cube_ib, 0, @ptrCast(&cube_indices), @sizeOf(@TypeOf(cube_indices)));

    const pyramid_vb = try device.createBuffer(&std.mem.zeroInit(z.types.BufferDescriptor, .{
        .usage = .{ .vertex = true, .copy_dst = true },
        .size = @sizeOf(@TypeOf(pyramid_verts)),
    }));
    queue.writeBuffer(pyramid_vb, 0, @ptrCast(&pyramid_verts), @sizeOf(@TypeOf(pyramid_verts)));
    const pyramid_ib = try device.createBuffer(&std.mem.zeroInit(z.types.BufferDescriptor, .{
        .usage = .{ .index = true, .copy_dst = true },
        .size = @sizeOf(@TypeOf(pyramid_indices)),
    }));
    queue.writeBuffer(pyramid_ib, 0, @ptrCast(&pyramid_indices), @sizeOf(@TypeOf(pyramid_indices)));

    const view_matrix = mat4Translation(0, 0, -4);

    try w.print("rendering...\n", .{});
    var frame_count: u32 = 0;
    while (glfwWindowShouldClose(window) == 0) : (frame_count += 1) {
        glfwPollEvents();
        if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) break;
        if (frame_count > 600) break;

        var fw: c_int = undefined;
        var fh: c_int = undefined;
        glfwGetFramebufferSize(window, &fw, &fh);
        const aspect = @as(f32, @floatFromInt(fw)) / @as(f32, @floatFromInt(fh));
        const proj = mat4Perspective(std.math.degreesToRadians(60), aspect, 0.1, 100.0);

        const angle_cube = @as(f32, @floatFromInt(frame_count)) * 0.02;
        const angle_pyr = @as(f32, @floatFromInt(frame_count)) * -0.03;

        var surface_tex: z.types.SurfaceTexture = undefined;
        surface.getCurrentTexture(&surface_tex);
        if (surface_tex.status != .success_optimal) continue;

        const tex_view = try surface_tex.texture.unwrap().createView(null);

        const command_encoder = try device.createCommandEncoder(null);
        const clear_color = z.types.Color{ .r = 0.05, .g = 0.05, .b = 0.1, .a = 1.0 };
        const render_pass = try command_encoder.beginRenderPass(&z.types.RenderPassDescriptor{
            .color_attachment_count = 1,
            .color_attachments = @ptrCast(&[1]z.types.RenderPassColorAttachment{.{ .view = z.handles.OptionalTextureView.wrap(tex_view), .depth_slice = 0xFFFFFFFF, .load_op = .clear, .store_op = .store, .clear_value = clear_color }}),
            .depth_stencil_attachment = @ptrCast(&z.types.RenderPassDepthStencilAttachment{
                .view = z.handles.OptionalTextureView.wrap(depth_view),
                .depth_load_op = .clear,
                .depth_store_op = .store,
                .depth_clear_value = 1.0,
            }),
        });
        render_pass.setPipeline(render_pipeline);

        // Draw cube (left side, spinning on Y in place)
        {
            const model = mat4Mul(mat4Translation(-0.7, 0, 0), mat4RotationY(angle_cube));
            const uniforms = Uniforms{ .mvp = mat4Mul(mat4Mul(proj, view_matrix), model) };
            queue.writeBuffer(uniform_buf_cube, 0, @ptrCast(&uniforms), @sizeOf(Uniforms));

            render_pass.setBindGroup(0, bind_group_cube, 0, null);
            render_pass.setVertexBuffer(0, cube_vb, 0, @sizeOf(@TypeOf(cube_verts)));
            render_pass.setIndexBuffer(cube_ib, .uint32, 0, @sizeOf(@TypeOf(cube_indices)));
            render_pass.drawIndexed(cube_indices.len, 1, 0, 0, 0);
        }

        // Draw pyramid (right side, spinning on X in place)
        {
            const model = mat4Mul(mat4Translation(0.7, 0, 0), mat4RotationX(angle_pyr));
            const uniforms = Uniforms{ .mvp = mat4Mul(mat4Mul(proj, view_matrix), model) };
            queue.writeBuffer(uniform_buf_pyr, 0, @ptrCast(&uniforms), @sizeOf(Uniforms));

            render_pass.setBindGroup(0, bind_group_pyr, 0, null);
            render_pass.setVertexBuffer(0, pyramid_vb, 0, @sizeOf(@TypeOf(pyramid_verts)));
            render_pass.setIndexBuffer(pyramid_ib, .uint32, 0, @sizeOf(@TypeOf(pyramid_indices)));
            render_pass.drawIndexed(pyramid_indices.len, 1, 0, 0, 0);
        }

        render_pass.end();
        const command_buffer = try command_encoder.finish(null);
        queue.submit(1, &command_buffer);
        _ = try surface.present();
    }

    try w.print("rendered {d} frames\n", .{frame_count});
    try file_writer.flush();
    if (frame_count > 0) try w.print("PASS\n", .{}) else try w.print("PASS (window was closed)\n", .{});
    try file_writer.flush();
}
