const std = @import("std");
const c = @import("c_wgpu_native");
const types = @import("types.zig");
const handles = @import("handles.zig");

pub fn uncapturedErrorCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, ?handles.Device, types.ErrorType, []const u8) void,
) types.UncapturedErrorCallbackInfo {
    const Trampoline = struct {
        fn call(device: [*c]const c.WGPUDevice, @"type": c.WGPUErrorType, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, if (device) |p| if (p.*) |h| handles.Device.fromPtr(@ptrCast(h)) else null else null, @enumFromInt(@"type"), if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn requestDeviceCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.RequestDeviceStatus, ?handles.Device, []const u8) void,
) types.RequestDeviceCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPURequestDeviceStatus, device: c.WGPUDevice, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), if (device) |h| handles.Device.fromPtr(@ptrCast(h)) else null, if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn queueWorkDoneCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.QueueWorkDoneStatus, []const u8) void,
) types.QueueWorkDoneCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPUQueueWorkDoneStatus, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn deviceLostCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, ?handles.Device, types.DeviceLostReason, []const u8) void,
) types.DeviceLostCallbackInfo {
    const Trampoline = struct {
        fn call(device: [*c]const c.WGPUDevice, reason: c.WGPUDeviceLostReason, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, if (device) |p| if (p.*) |h| handles.Device.fromPtr(@ptrCast(h)) else null else null, @enumFromInt(reason), if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn compilationInfoCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.CompilationInfoRequestStatus, ?*const c.struct_WGPUCompilationInfo) void,
) types.CompilationInfoCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPUCompilationInfoRequestStatus, compilationInfo: [*c]const c.struct_WGPUCompilationInfo, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), compilationInfo);
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn createRenderPipelineAsyncCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.CreatePipelineAsyncStatus, ?handles.RenderPipeline, []const u8) void,
) types.CreateRenderPipelineAsyncCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPUCreatePipelineAsyncStatus, pipeline: c.WGPURenderPipeline, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), if (pipeline) |h| handles.RenderPipeline.fromPtr(@ptrCast(h)) else null, if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn requestAdapterCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.RequestAdapterStatus, ?handles.Adapter, []const u8) void,
) types.RequestAdapterCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPURequestAdapterStatus, adapter: c.WGPUAdapter, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), if (adapter) |h| handles.Adapter.fromPtr(@ptrCast(h)) else null, if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn bufferMapCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.MapAsyncStatus, []const u8) void,
) types.BufferMapCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPUMapAsyncStatus, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn createComputePipelineAsyncCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.CreatePipelineAsyncStatus, ?handles.ComputePipeline, []const u8) void,
) types.CreateComputePipelineAsyncCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPUCreatePipelineAsyncStatus, pipeline: c.WGPUComputePipeline, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), if (pipeline) |h| handles.ComputePipeline.fromPtr(@ptrCast(h)) else null, if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn popErrorScopeCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.PopErrorScopeStatus, types.ErrorType, []const u8) void,
) types.PopErrorScopeCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPUPopErrorScopeStatus, @"type": c.WGPUErrorType, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), @enumFromInt(@"type"), if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

