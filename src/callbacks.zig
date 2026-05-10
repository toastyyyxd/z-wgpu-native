const std = @import("std");
const c = @import("c_wgpu_native");
const types = @import("types.zig");
const handles = @import("handles.zig");

pub fn uncapturedErrorCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, ?*const handles.Device, c.WGPUErrorType, []const u8) void,
) c.WGPUUncapturedErrorCallbackInfo {
    const Trampoline = struct {
        fn call(device: ?*const c.WGPUDevice, @"type": c.WGPUErrorType, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, device, @"type", if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn requestDeviceCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.RequestDeviceStatus, handles.Device, []const u8) void,
) c.WGPURequestDeviceCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPURequestDeviceStatus, device: c.WGPUDevice, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), handles.Device.fromPtr(@ptrCast(device)), if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn queueWorkDoneCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.QueueWorkDoneStatus, []const u8) void,
) c.WGPUQueueWorkDoneCallbackInfo {
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

pub fn logCallback(comptime C1: type, ctx1: *C1, comptime cb: fn (*C1, c.WGPULogLevel, []const u8) void,
) c.WGPULogCallbackInfo {
    const Trampoline = struct {
        fn call(level: c.WGPULogLevel, message: c.WGPUStringView, userdata: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata));
            cb(c1, level, if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata = @ptrCast(ctx1),
    };
}

pub fn deviceLostCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, ?*const handles.Device, c.WGPUDeviceLostReason, []const u8) void,
) c.WGPUDeviceLostCallbackInfo {
    const Trampoline = struct {
        fn call(device: ?*const c.WGPUDevice, reason: c.WGPUDeviceLostReason, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, device, reason, if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn compilationInfoCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.CompilationInfoRequestStatus, ?*const c.struct_WGPUCompilationInfo) void,
) c.WGPUCompilationInfoCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPUCompilationInfoRequestStatus, compilationInfo: ?*const c.struct_WGPUCompilationInfo, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
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

pub fn createRenderPipelineAsyncCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.CreatePipelineAsyncStatus, handles.RenderPipeline, []const u8) void,
) c.WGPUCreateRenderPipelineAsyncCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPUCreatePipelineAsyncStatus, pipeline: c.WGPURenderPipeline, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), handles.RenderPipeline.fromPtr(@ptrCast(pipeline)), if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn requestAdapterCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.RequestAdapterStatus, handles.Adapter, []const u8) void,
) c.WGPURequestAdapterCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPURequestAdapterStatus, adapter: c.WGPUAdapter, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), handles.Adapter.fromPtr(@ptrCast(adapter)), if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn bufferMapCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.MapAsyncStatus, []const u8) void,
) c.WGPUBufferMapCallbackInfo {
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

pub fn createComputePipelineAsyncCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.CreatePipelineAsyncStatus, handles.ComputePipeline, []const u8) void,
) c.WGPUCreateComputePipelineAsyncCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPUCreatePipelineAsyncStatus, pipeline: c.WGPUComputePipeline, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), handles.ComputePipeline.fromPtr(@ptrCast(pipeline)), if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

pub fn popErrorScopeCallback(comptime C1: type, comptime C2: type, ctx1: *C1, ctx2: *C2, comptime cb: fn (*C1, *C2, types.PopErrorScopeStatus, c.WGPUErrorType, []const u8) void,
) c.WGPUPopErrorScopeCallbackInfo {
    const Trampoline = struct {
        fn call(status: c.WGPUPopErrorScopeStatus, @"type": c.WGPUErrorType, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
            const c1: *C1 = @ptrCast(@alignCast(userdata1));
            const c2: *C2 = @ptrCast(@alignCast(userdata2));
            cb(c1, c2, @enumFromInt(status), @"type", if (message.data) |d| d[0..message.length] else "");
        }
    };

    return .{
        .callback = &Trampoline.call,
        .userdata1 = @ptrCast(ctx1),
        .userdata2 = @ptrCast(ctx2),
    };
}

