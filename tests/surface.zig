const std = @import("std");
const builtin = @import("builtin");
//const z = @import("../src/root.zig");
const z = @import("z_wgpu_native");

pub fn createSurfaceFromGlfw(instance: z.handles.Instance, window: ?*anyopaque) !z.handles.Surface {
    return switch (comptime builtin.os.tag) {
        .windows => {
            const win32 = struct {
                const HINSTANCE = *anyopaque;
                const HWND = *anyopaque;
                const LPCWSTR = ?[*:0]const u16;

                extern "c" fn glfwGetWin32Window(window: ?*anyopaque) ?HWND;
                
                extern "kernel32" fn GetModuleHandleW(lpModuleName: LPCWSTR) callconv(.c) ?HINSTANCE;
            };

            const hwnd = win32.glfwGetWin32Window(window) orelse return error.NoWin32Window;
            
            const hinstance = win32.GetModuleHandleW(null) orelse return error.NoModuleHandle;

            var surface_source = z.types.SurfaceSourceWindowsHWND{
                .chain = .{ .s_type = .surface_source_windows_hwnd },
                .hinstance = @ptrCast(hinstance),
                .hwnd = @ptrCast(hwnd),
            };
            
            return instance.createSurface(&z.types.SurfaceDescriptor{
                .next_in_chain = @ptrCast(&surface_source.chain),
            }) orelse error.SurfaceCreationFailed;
        },

        .linux => {
            const linux_glfw = struct {
                extern "c" fn glfwGetWaylandDisplay() ?*anyopaque;
                extern "c" fn glfwGetWaylandWindow(window: ?*anyopaque) ?*anyopaque;
                extern "c" fn glfwGetX11Display() ?*anyopaque;
                extern "c" fn glfwGetX11Window(window: ?*anyopaque) ?*anyopaque; 
                extern "c" fn glfwGetPlatform() c_int; // GLFW 3.4+ feature to verify target
            };

            const wl_dpy = linux_glfw.glfwGetWaylandDisplay();
            
            if (wl_dpy != null) {
                const wl_sfc = linux_glfw.glfwGetWaylandWindow(window);
                if (wl_sfc) |sfc| {
                    std.log.info("[surface.zig] Attempting Wayland surface initialization.", .{});
                    var surface_source = z.types.SurfaceSourceWaylandSurface{
                        .chain = .{ .s_type = .surface_source_wayland_surface },
                        .display = wl_dpy.?,
                        .surface = sfc,
                    };
                    if (instance.createSurface(&z.types.SurfaceDescriptor{
                        .next_in_chain = @ptrCast(&surface_source.chain),
                    })) |surf| return surf else {
                        std.log.warn("[surface.zig] Wayland surface creation failed in wgpu, falling back to X11...", .{});
                    }
                }
            }

            if (linux_glfw.glfwGetX11Display()) |x11_dpy| {
                const x11_win = linux_glfw.glfwGetX11Window(window) orelse return error.NoX11Window;
                std.log.info("[surface.zig] Initializing via X11/Xlib window.", .{});

                var surface_source = z.types.SurfaceSourceXlibWindow{
                    .chain = .{ .s_type = .surface_source_xlib_window },
                    .display = x11_dpy,
                    .window = @intCast(@intFromPtr(x11_win)),
                };
                return instance.createSurface(&z.types.SurfaceDescriptor{
                    .next_in_chain = @ptrCast(&surface_source.chain),
                }) orelse error.SurfaceCreationFailed;
            }

            return error.NoValidDisplayBackendFound;
        },
        else => @compileError("Unsupported target OS for WebGPU surface creation"),
    };
}
