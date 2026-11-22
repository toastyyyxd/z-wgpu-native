const std = @import("std");
const c = @import("c_wgpu_native");
const types = @import("types.zig");

// Zig 0.17 removed @bitCast for extern structs, so layouts are copied bytewise.
// tests/abi.zig checks the layout.
inline fn asC(comptime C: type, value: anytype) C {
    var out: C = undefined;
    var v = value;
    @memcpy(@import("std").mem.asBytes(&out), @import("std").mem.asBytes(&v));
    return out;
}

/// Stubbed by wgpu-native. Sorted by C name.
pub const unimplemented_entry_points: []const []const u8 = &.{
    "wgpuBindGroupLayoutSetLabel",
    "wgpuBindGroupSetLabel",
    "wgpuBufferGetMapState",
    "wgpuBufferReadMappedRange",
    "wgpuBufferSetLabel",
    "wgpuBufferWriteMappedRange",
    "wgpuCommandBufferSetLabel",
    "wgpuCommandEncoderSetLabel",
    "wgpuComputePassEncoderSetLabel",
    "wgpuComputePipelineSetLabel",
    "wgpuDeviceCreateComputePipelineAsync",
    "wgpuDeviceCreateRenderPipelineAsync",
    "wgpuDeviceGetAdapterInfo",
    "wgpuDeviceGetLostFuture",
    "wgpuDeviceSetLabel",
    "wgpuExternalTextureAddRef",
    "wgpuExternalTextureRelease",
    "wgpuExternalTextureSetLabel",
    "wgpuGetInstanceFeatures",
    "wgpuGetProcAddress",
    "wgpuHasInstanceFeature",
    "wgpuInstanceGetWGSLLanguageFeatures",
    "wgpuInstanceHasWGSLLanguageFeature",
    "wgpuInstanceWaitAny",
    "wgpuPipelineLayoutSetLabel",
    "wgpuQuerySetSetLabel",
    "wgpuQueueSetLabel",
    "wgpuRenderBundleEncoderSetLabel",
    "wgpuRenderBundleSetLabel",
    "wgpuRenderPassEncoderSetLabel",
    "wgpuRenderPipelineSetLabel",
    "wgpuSamplerSetLabel",
    "wgpuShaderModuleGetCompilationInfo",
    "wgpuShaderModuleSetLabel",
    "wgpuSupportedInstanceFeaturesFreeMembers",
    "wgpuSupportedWGSLLanguageFeaturesFreeMembers",
    "wgpuSurfaceSetLabel",
    "wgpuTextureGetTextureBindingViewDimension",
    "wgpuTextureSetLabel",
    "wgpuTextureViewSetLabel",
};

pub const OnSubmittedWorkDoneResult = struct {
    status: types.QueueWorkDoneStatus = undefined,
    message_buf: [512]u8 = undefined,
    message_len: usize = 0,

    pub fn message(self: *const @This()) []const u8 {
        return self.message_buf[0..self.message_len];
    }
};

const OnSubmittedWorkDoneSyncCtx = struct { response: OnSubmittedWorkDoneResult = .{}, done: bool = false };

fn onSubmittedWorkDoneSyncTrampoline(status: c.WGPUQueueWorkDoneStatus, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
    _ = userdata2;
    const ctx: *OnSubmittedWorkDoneSyncCtx = @ptrCast(@alignCast(userdata1));
    ctx.response.status = @enumFromInt(status);
    if (message.data) |d| {
        const n = @min(message.length, ctx.response.message_buf.len);
        @memcpy(ctx.response.message_buf[0..n], d[0..n]);
        ctx.response.message_len = n;
    }
    ctx.done = true;
}

pub const MapResult = struct {
    status: types.MapAsyncStatus = undefined,
    message_buf: [512]u8 = undefined,
    message_len: usize = 0,

    pub fn message(self: *const @This()) []const u8 {
        return self.message_buf[0..self.message_len];
    }
};

const MapSyncCtx = struct { response: MapResult = .{}, done: bool = false };

fn mapSyncTrampoline(status: c.WGPUMapAsyncStatus, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
    _ = userdata2;
    const ctx: *MapSyncCtx = @ptrCast(@alignCast(userdata1));
    ctx.response.status = @enumFromInt(status);
    if (message.data) |d| {
        const n = @min(message.length, ctx.response.message_buf.len);
        @memcpy(ctx.response.message_buf[0..n], d[0..n]);
        ctx.response.message_len = n;
    }
    ctx.done = true;
}

pub const RequestAdapterResult = struct {
    status: types.RequestAdapterStatus = undefined,
    adapter: ?*Adapter = null,
    message_buf: [512]u8 = undefined,
    message_len: usize = 0,

    pub fn message(self: *const @This()) []const u8 {
        return self.message_buf[0..self.message_len];
    }
};

const RequestAdapterSyncCtx = struct { response: RequestAdapterResult = .{}, done: bool = false };

fn requestAdapterSyncTrampoline(status: c.WGPURequestAdapterStatus, adapter: c.WGPUAdapter, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
    _ = userdata2;
    const ctx: *RequestAdapterSyncCtx = @ptrCast(@alignCast(userdata1));
    ctx.response.status = @enumFromInt(status);
    ctx.response.adapter = if (adapter) |h| Adapter.fromPtr(@ptrCast(h)) else null;
    if (message.data) |d| {
        const n = @min(message.length, ctx.response.message_buf.len);
        @memcpy(ctx.response.message_buf[0..n], d[0..n]);
        ctx.response.message_len = n;
    }
    ctx.done = true;
}

pub const RequestDeviceResult = struct {
    status: types.RequestDeviceStatus = undefined,
    device: ?*Device = null,
    message_buf: [512]u8 = undefined,
    message_len: usize = 0,

    pub fn message(self: *const @This()) []const u8 {
        return self.message_buf[0..self.message_len];
    }
};

const RequestDeviceSyncCtx = struct { response: RequestDeviceResult = .{}, done: bool = false };

fn requestDeviceSyncTrampoline(status: c.WGPURequestDeviceStatus, device: c.WGPUDevice, message: c.WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
    _ = userdata2;
    const ctx: *RequestDeviceSyncCtx = @ptrCast(@alignCast(userdata1));
    ctx.response.status = @enumFromInt(status);
    ctx.response.device = if (device) |h| Device.fromPtr(@ptrCast(h)) else null;
    if (message.data) |d| {
        const n = @min(message.length, ctx.response.message_buf.len);
        @memcpy(ctx.response.message_buf[0..n], d[0..n]);
        ctx.response.message_len = n;
    }
    ctx.done = true;
}

pub const Adapter = opaque {
    pub fn fromPtr(ptr: *anyopaque) *Adapter {
        return @ptrCast(ptr);
    }

    pub fn release(self: *Adapter) void {
        c.wgpuAdapterRelease(@ptrCast(self));
    }

    pub fn getInfo(self: *Adapter) types.StatusError!types.AdapterInfo {
        var result: types.AdapterInfo = undefined;
        const status = c.wgpuAdapterGetInfo(@ptrCast(self), @ptrCast(&result));
        try @as(types.Status, @enumFromInt(status)).toError();
        return result;
    }

    pub fn addRef(self: *Adapter) void {
        c.wgpuAdapterAddRef(@ptrCast(self));
    }

    pub fn getLimits(self: *Adapter) types.StatusError!types.Limits {
        var result: types.Limits = undefined;
        const status = c.wgpuAdapterGetLimits(@ptrCast(self), @ptrCast(&result));
        try @as(types.Status, @enumFromInt(status)).toError();
        return result;
    }

    pub fn hasFeature(self: *Adapter, feature: types.FeatureName) bool {
        return c.wgpuAdapterHasFeature(@ptrCast(self), @intFromEnum(feature)) != 0;
    }

    pub fn getFeatures(self: *Adapter, features: *types.SupportedFeatures) void {
        c.wgpuAdapterGetFeatures(@ptrCast(self), @ptrCast(features));
    }

    pub fn requestDevice(self: *Adapter, descriptor: ?*const types.DeviceDescriptor, callbackInfo: types.RequestDeviceCallbackInfo) types.Future {
        const result = c.wgpuAdapterRequestDevice(@ptrCast(self), @ptrCast(descriptor), asC(c.WGPURequestDeviceCallbackInfo, callbackInfo));
        return asC(types.Future, result);
    }

    pub fn requestDeviceSync(self: *Adapter, io: std.Io, instance: *Instance, descriptor: ?*const types.DeviceDescriptor) types.WaitStatusError!RequestDeviceResult {
        var ctx: RequestDeviceSyncCtx = .{};
        const future = self.requestDevice(descriptor, types.RequestDeviceCallbackInfo{ .mode = .allow_process_events, .callback = &requestDeviceSyncTrampoline, .userdata1 = @ptrCast(&ctx) });
        _ = future;
        var spins: u32 = 0;
        while (!ctx.done) {
            instance.processEvents();
            if (ctx.done) break;
            if (spins < 16) {
                spins += 1;
                continue;
            }
            std.Io.sleep(io, std.Io.Duration.fromMilliseconds(1), .awake) catch {};
        }
        return ctx.response;
    }

};

pub const BindGroup = opaque {
    pub fn fromPtr(ptr: *anyopaque) *BindGroup {
        return @ptrCast(ptr);
    }

    pub fn release(self: *BindGroup) void {
        c.wgpuBindGroupRelease(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuBindGroupSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *BindGroup, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuBindGroupSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuBindGroupSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn addRef(self: *BindGroup) void {
        c.wgpuBindGroupAddRef(@ptrCast(self));
    }

};

pub const BindGroupLayout = opaque {
    pub fn fromPtr(ptr: *anyopaque) *BindGroupLayout {
        return @ptrCast(ptr);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuBindGroupLayoutSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *BindGroupLayout, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuBindGroupLayoutSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuBindGroupLayoutSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn addRef(self: *BindGroupLayout) void {
        c.wgpuBindGroupLayoutAddRef(@ptrCast(self));
    }

    pub fn release(self: *BindGroupLayout) void {
        c.wgpuBindGroupLayoutRelease(@ptrCast(self));
    }

};

pub const Buffer = opaque {
    pub fn fromPtr(ptr: *anyopaque) *Buffer {
        return @ptrCast(ptr);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuBufferGetMapState` for the raw extern, which aborts at runtime.
    pub inline fn getMapState(self: *Buffer) types.BufferMapState {
        _ = self;
        @compileError("wgpuBufferGetMapState is stubbed by wgpu-native; use wgpu.c.wgpuBufferGetMapState for the raw extern (aborts at runtime)");
    }

    pub fn release(self: *Buffer) void {
        c.wgpuBufferRelease(@ptrCast(self));
    }

    pub fn destroy(self: *Buffer) void {
        c.wgpuBufferDestroy(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuBufferWriteMappedRange` for the raw extern, which aborts at runtime.
    pub inline fn writeMappedRange(self: *Buffer, offset: usize, data: ?*const anyopaque, size: usize) types.StatusError!void {
        _ = self;
        _ = offset;
        _ = data;
        _ = size;
        @compileError("wgpuBufferWriteMappedRange is stubbed by wgpu-native; use wgpu.c.wgpuBufferWriteMappedRange for the raw extern (aborts at runtime)");
    }

    pub fn mapAsync(self: *Buffer, mode: types.MapMode, offset: usize, size: usize, callbackInfo: types.BufferMapCallbackInfo) types.Future {
        const result = c.wgpuBufferMapAsync(@ptrCast(self), asC(c.WGPUMapMode, mode), offset, size, asC(c.WGPUBufferMapCallbackInfo, callbackInfo));
        return asC(types.Future, result);
    }

    pub fn getSize(self: *Buffer) u64 {
        return c.wgpuBufferGetSize(@ptrCast(self));
    }

    pub fn getConstMappedRange(self: *Buffer, offset: usize, size: usize) ?*const anyopaque {
        return c.wgpuBufferGetConstMappedRange(@ptrCast(self), offset, size);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuBufferReadMappedRange` for the raw extern, which aborts at runtime.
    pub inline fn readMappedRange(self: *Buffer, offset: usize, data: ?*anyopaque, size: usize) types.StatusError!void {
        _ = self;
        _ = offset;
        _ = data;
        _ = size;
        @compileError("wgpuBufferReadMappedRange is stubbed by wgpu-native; use wgpu.c.wgpuBufferReadMappedRange for the raw extern (aborts at runtime)");
    }

    pub fn getUsage(self: *Buffer) types.BufferUsage {
        const result = c.wgpuBufferGetUsage(@ptrCast(self));
        return asC(types.BufferUsage, result);
    }

    pub fn unmap(self: *Buffer) void {
        c.wgpuBufferUnmap(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuBufferSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *Buffer, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuBufferSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuBufferSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn getMappedRange(self: *Buffer, offset: usize, size: usize) ?*anyopaque {
        return c.wgpuBufferGetMappedRange(@ptrCast(self), offset, size);
    }

    pub fn addRef(self: *Buffer) void {
        c.wgpuBufferAddRef(@ptrCast(self));
    }

    pub fn mapSync(self: *Buffer, io: std.Io, device: *Device, mode: types.MapMode, offset: usize, size: usize) types.WaitStatusError!MapResult {
        var ctx: MapSyncCtx = .{};
        const future = self.mapAsync(mode, offset, size, types.BufferMapCallbackInfo{ .mode = .allow_process_events, .callback = &mapSyncTrampoline, .userdata1 = @ptrCast(&ctx) });
        _ = future;
        while (!ctx.done) {
            _ = device.poll(true, null);
            if (ctx.done) break;
            std.Io.sleep(io, std.Io.Duration.fromMilliseconds(1), .awake) catch {};
        }
        return ctx.response;
    }

};

pub const CommandBuffer = opaque {
    pub fn fromPtr(ptr: *anyopaque) *CommandBuffer {
        return @ptrCast(ptr);
    }

    pub fn addRef(self: *CommandBuffer) void {
        c.wgpuCommandBufferAddRef(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuCommandBufferSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *CommandBuffer, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuCommandBufferSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuCommandBufferSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn release(self: *CommandBuffer) void {
        c.wgpuCommandBufferRelease(@ptrCast(self));
    }

};

pub const CommandEncoder = opaque {
    pub fn fromPtr(ptr: *anyopaque) *CommandEncoder {
        return @ptrCast(ptr);
    }

    pub fn addRef(self: *CommandEncoder) void {
        c.wgpuCommandEncoderAddRef(@ptrCast(self));
    }

    pub fn release(self: *CommandEncoder) void {
        c.wgpuCommandEncoderRelease(@ptrCast(self));
    }

    pub fn copyTextureToTexture(self: *CommandEncoder, source: *const types.TexelCopyTextureInfo, destination: *const types.TexelCopyTextureInfo, copySize: *const types.Extent3D) void {
        c.wgpuCommandEncoderCopyTextureToTexture(@ptrCast(self), @ptrCast(source), @ptrCast(destination), @ptrCast(copySize));
    }

    pub fn copyBufferToTexture(self: *CommandEncoder, source: *const types.TexelCopyBufferInfo, destination: *const types.TexelCopyTextureInfo, copySize: *const types.Extent3D) void {
        c.wgpuCommandEncoderCopyBufferToTexture(@ptrCast(self), @ptrCast(source), @ptrCast(destination), @ptrCast(copySize));
    }

    pub fn beginComputePass(self: *CommandEncoder, descriptor: ?*const types.ComputePassDescriptor) *ComputePassEncoder {
        const result = c.wgpuCommandEncoderBeginComputePass(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn copyTextureToBuffer(self: *CommandEncoder, source: *const types.TexelCopyTextureInfo, destination: *const types.TexelCopyBufferInfo, copySize: *const types.Extent3D) void {
        c.wgpuCommandEncoderCopyTextureToBuffer(@ptrCast(self), @ptrCast(source), @ptrCast(destination), @ptrCast(copySize));
    }

    pub fn pushDebugGroup(self: *CommandEncoder, groupLabel: types.StringView) void {
        c.wgpuCommandEncoderPushDebugGroup(@ptrCast(self), asC(c.WGPUStringView, groupLabel));
    }

    pub fn copyBufferToBuffer(self: *CommandEncoder, source: *Buffer, sourceOffset: u64, destination: *Buffer, destinationOffset: u64, size: u64) void {
        c.wgpuCommandEncoderCopyBufferToBuffer(@ptrCast(self), @ptrCast(source), sourceOffset, @ptrCast(destination), destinationOffset, size);
    }

    pub fn clearTexture(self: *CommandEncoder, texture: *Texture, range: *const types.ImageSubresourceRange) void {
        c.wgpuCommandEncoderClearTexture(@ptrCast(self), @ptrCast(texture), @ptrCast(range));
    }

    pub fn resolveQuerySet(self: *CommandEncoder, querySet: *QuerySet, firstQuery: u32, queryCount: u32, destination: *Buffer, destinationOffset: u64) void {
        c.wgpuCommandEncoderResolveQuerySet(@ptrCast(self), @ptrCast(querySet), firstQuery, queryCount, @ptrCast(destination), destinationOffset);
    }

    pub fn popDebugGroup(self: *CommandEncoder) void {
        c.wgpuCommandEncoderPopDebugGroup(@ptrCast(self));
    }

    pub fn beginRenderPass(self: *CommandEncoder, descriptor: *const types.RenderPassDescriptor) *RenderPassEncoder {
        const result = c.wgpuCommandEncoderBeginRenderPass(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn finish(self: *CommandEncoder, descriptor: ?*const types.CommandBufferDescriptor) *CommandBuffer {
        const result = c.wgpuCommandEncoderFinish(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuCommandEncoderSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *CommandEncoder, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuCommandEncoderSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuCommandEncoderSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn insertDebugMarker(self: *CommandEncoder, markerLabel: types.StringView) void {
        c.wgpuCommandEncoderInsertDebugMarker(@ptrCast(self), asC(c.WGPUStringView, markerLabel));
    }

    pub fn writeTimestamp(self: *CommandEncoder, querySet: *QuerySet, queryIndex: u32) void {
        c.wgpuCommandEncoderWriteTimestamp(@ptrCast(self), @ptrCast(querySet), queryIndex);
    }

    pub fn clearBuffer(self: *CommandEncoder, buffer: *Buffer, offset: u64, size: u64) void {
        c.wgpuCommandEncoderClearBuffer(@ptrCast(self), @ptrCast(buffer), offset, size);
    }

};

pub const ComputePassEncoder = opaque {
    pub fn fromPtr(ptr: *anyopaque) *ComputePassEncoder {
        return @ptrCast(ptr);
    }

    pub fn addRef(self: *ComputePassEncoder) void {
        c.wgpuComputePassEncoderAddRef(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuComputePassEncoderSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *ComputePassEncoder, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuComputePassEncoderSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuComputePassEncoderSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn setPipeline(self: *ComputePassEncoder, pipeline: *ComputePipeline) void {
        c.wgpuComputePassEncoderSetPipeline(@ptrCast(self), @ptrCast(pipeline));
    }

    pub fn setImmediates(self: *ComputePassEncoder, offset: u32, data: ?*const anyopaque, size: usize) void {
        c.wgpuComputePassEncoderSetImmediates(@ptrCast(self), offset, data, size);
    }

    pub fn setBindGroup(self: *ComputePassEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsets: []const u32) void {
        self.setBindGroupRaw(groupIndex, group, @intCast(dynamicOffsets.len), @ptrCast(dynamicOffsets.ptr));
    }

    pub fn setBindGroupRaw(self: *ComputePassEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) void {
        c.wgpuComputePassEncoderSetBindGroup(@ptrCast(self), groupIndex, @ptrCast(group), dynamicOffsetCount, dynamicOffsets);
    }

    pub fn popDebugGroup(self: *ComputePassEncoder) void {
        c.wgpuComputePassEncoderPopDebugGroup(@ptrCast(self));
    }

    pub fn release(self: *ComputePassEncoder) void {
        c.wgpuComputePassEncoderRelease(@ptrCast(self));
    }

    pub fn endPipelineStatisticsQuery(self: *ComputePassEncoder) void {
        c.wgpuComputePassEncoderEndPipelineStatisticsQuery(@ptrCast(self));
    }

    pub fn writeTimestamp(self: *ComputePassEncoder, querySet: *QuerySet, queryIndex: u32) void {
        c.wgpuComputePassEncoderWriteTimestamp(@ptrCast(self), @ptrCast(querySet), queryIndex);
    }

    pub fn insertDebugMarker(self: *ComputePassEncoder, markerLabel: types.StringView) void {
        c.wgpuComputePassEncoderInsertDebugMarker(@ptrCast(self), asC(c.WGPUStringView, markerLabel));
    }

    pub fn dispatchWorkgroupsIndirect(self: *ComputePassEncoder, indirectBuffer: *Buffer, indirectOffset: u64) void {
        c.wgpuComputePassEncoderDispatchWorkgroupsIndirect(@ptrCast(self), @ptrCast(indirectBuffer), indirectOffset);
    }

    pub fn pushDebugGroup(self: *ComputePassEncoder, groupLabel: types.StringView) void {
        c.wgpuComputePassEncoderPushDebugGroup(@ptrCast(self), asC(c.WGPUStringView, groupLabel));
    }

    pub fn dispatchWorkgroups(self: *ComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) void {
        c.wgpuComputePassEncoderDispatchWorkgroups(@ptrCast(self), workgroupCountX, workgroupCountY, workgroupCountZ);
    }

    pub fn end(self: *ComputePassEncoder) void {
        c.wgpuComputePassEncoderEnd(@ptrCast(self));
    }

    pub fn beginPipelineStatisticsQuery(self: *ComputePassEncoder, querySet: *QuerySet, queryIndex: u32) void {
        c.wgpuComputePassEncoderBeginPipelineStatisticsQuery(@ptrCast(self), @ptrCast(querySet), queryIndex);
    }

};

pub const ComputePipeline = opaque {
    pub fn fromPtr(ptr: *anyopaque) *ComputePipeline {
        return @ptrCast(ptr);
    }

    pub fn addRef(self: *ComputePipeline) void {
        c.wgpuComputePipelineAddRef(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuComputePipelineSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *ComputePipeline, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuComputePipelineSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuComputePipelineSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn release(self: *ComputePipeline) void {
        c.wgpuComputePipelineRelease(@ptrCast(self));
    }

    pub fn getBindGroupLayout(self: *ComputePipeline, groupIndex: u32) *BindGroupLayout {
        const result = c.wgpuComputePipelineGetBindGroupLayout(@ptrCast(self), groupIndex);
        return @ptrCast(result.?);
    }

};

pub const Device = opaque {
    pub fn fromPtr(ptr: *anyopaque) *Device {
        return @ptrCast(ptr);
    }

    pub fn release(self: *Device) void {
        c.wgpuDeviceRelease(@ptrCast(self));
    }

    pub fn createTexture(self: *Device, descriptor: *const types.TextureDescriptor) *Texture {
        const result = c.wgpuDeviceCreateTexture(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn hasFeature(self: *Device, feature: types.FeatureName) bool {
        return c.wgpuDeviceHasFeature(@ptrCast(self), @intFromEnum(feature)) != 0;
    }

    pub fn createBindGroup(self: *Device, descriptor: *const types.BindGroupDescriptor) *BindGroup {
        const result = c.wgpuDeviceCreateBindGroup(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn createBuffer(self: *Device, descriptor: *const types.BufferDescriptor) ?*Buffer {
        const result = c.wgpuDeviceCreateBuffer(@ptrCast(self), @ptrCast(descriptor));
        if (result) |r| return @ptrCast(r) else return null;
    }

    pub fn createShaderModuleSpirV(self: *Device, descriptor: *const types.ShaderModuleDescriptorSpirV) *ShaderModule {
        const result = c.wgpuDeviceCreateShaderModuleSpirV(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn startGraphicsDebuggerCapture(self: *Device) bool {
        return c.wgpuDeviceStartGraphicsDebuggerCapture(@ptrCast(self)) != 0;
    }

    pub fn createRenderPipeline(self: *Device, descriptor: *const types.RenderPipelineDescriptor) *RenderPipeline {
        const result = c.wgpuDeviceCreateRenderPipeline(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn createShaderModule(self: *Device, descriptor: *const types.ShaderModuleDescriptor) *ShaderModule {
        const result = c.wgpuDeviceCreateShaderModule(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn getNativeMetalDevice(self: *Device) ?*anyopaque {
        return c.wgpuDeviceGetNativeMetalDevice(@ptrCast(self));
    }

    pub fn poll(self: *Device, wait: bool, submissionIndex: [*c]const c.WGPUSubmissionIndex) bool {
        return c.wgpuDevicePoll(@ptrCast(self), @intFromBool(wait), submissionIndex) != 0;
    }

    pub fn destroy(self: *Device) void {
        c.wgpuDeviceDestroy(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuDeviceCreateComputePipelineAsync` for the raw extern, which aborts at runtime.
    pub inline fn createComputePipelineAsync(self: *Device, descriptor: *const types.ComputePipelineDescriptor, callbackInfo: types.CreateComputePipelineAsyncCallbackInfo) types.Future {
        _ = self;
        _ = descriptor;
        _ = callbackInfo;
        @compileError("wgpuDeviceCreateComputePipelineAsync is stubbed by wgpu-native; use wgpu.c.wgpuDeviceCreateComputePipelineAsync for the raw extern (aborts at runtime)");
    }

    pub fn createPipelineLayout(self: *Device, descriptor: *const types.PipelineLayoutDescriptor) *PipelineLayout {
        const result = c.wgpuDeviceCreatePipelineLayout(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn createRenderBundleEncoder(self: *Device, descriptor: *const types.RenderBundleEncoderDescriptor) *RenderBundleEncoder {
        const result = c.wgpuDeviceCreateRenderBundleEncoder(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn createSampler(self: *Device, descriptor: ?*const types.SamplerDescriptor) *Sampler {
        const result = c.wgpuDeviceCreateSampler(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuDeviceGetAdapterInfo` for the raw extern, which aborts at runtime.
    pub inline fn getAdapterInfo(self: *Device) types.StatusError!types.AdapterInfo {
        _ = self;
        @compileError("wgpuDeviceGetAdapterInfo is stubbed by wgpu-native; use wgpu.c.wgpuDeviceGetAdapterInfo for the raw extern (aborts at runtime)");
    }

    pub fn addRef(self: *Device) void {
        c.wgpuDeviceAddRef(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuDeviceCreateRenderPipelineAsync` for the raw extern, which aborts at runtime.
    pub inline fn createRenderPipelineAsync(self: *Device, descriptor: *const types.RenderPipelineDescriptor, callbackInfo: types.CreateRenderPipelineAsyncCallbackInfo) types.Future {
        _ = self;
        _ = descriptor;
        _ = callbackInfo;
        @compileError("wgpuDeviceCreateRenderPipelineAsync is stubbed by wgpu-native; use wgpu.c.wgpuDeviceCreateRenderPipelineAsync for the raw extern (aborts at runtime)");
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuDeviceSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *Device, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuDeviceSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuDeviceSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn popErrorScope(self: *Device, callbackInfo: types.PopErrorScopeCallbackInfo) types.Future {
        const result = c.wgpuDevicePopErrorScope(@ptrCast(self), asC(c.WGPUPopErrorScopeCallbackInfo, callbackInfo));
        return asC(types.Future, result);
    }

    pub fn getQueue(self: *Device) *Queue {
        const result = c.wgpuDeviceGetQueue(@ptrCast(self));
        return @ptrCast(result.?);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuDeviceGetLostFuture` for the raw extern, which aborts at runtime.
    pub inline fn getLostFuture(self: *Device) types.Future {
        _ = self;
        @compileError("wgpuDeviceGetLostFuture is stubbed by wgpu-native; use wgpu.c.wgpuDeviceGetLostFuture for the raw extern (aborts at runtime)");
    }

    pub fn createCommandEncoder(self: *Device, descriptor: ?*const types.CommandEncoderDescriptor) *CommandEncoder {
        const result = c.wgpuDeviceCreateCommandEncoder(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn createBindGroupLayout(self: *Device, descriptor: *const types.BindGroupLayoutDescriptor) *BindGroupLayout {
        const result = c.wgpuDeviceCreateBindGroupLayout(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn getLimits(self: *Device) types.StatusError!types.Limits {
        var result: types.Limits = undefined;
        const status = c.wgpuDeviceGetLimits(@ptrCast(self), @ptrCast(&result));
        try @as(types.Status, @enumFromInt(status)).toError();
        return result;
    }

    pub fn stopGraphicsDebuggerCapture(self: *Device) void {
        c.wgpuDeviceStopGraphicsDebuggerCapture(@ptrCast(self));
    }

    pub fn getFeatures(self: *Device, features: *types.SupportedFeatures) void {
        c.wgpuDeviceGetFeatures(@ptrCast(self), @ptrCast(features));
    }

    pub fn createShaderModuleTrusted(self: *Device, descriptor: *const types.ShaderModuleDescriptor, runtimeChecks: types.ShaderRuntimeChecks) *ShaderModule {
        const result = c.wgpuDeviceCreateShaderModuleTrusted(@ptrCast(self), @ptrCast(descriptor), asC(c.WGPUShaderRuntimeChecks, runtimeChecks));
        return @ptrCast(result.?);
    }

    pub fn pushErrorScope(self: *Device, filter: types.ErrorFilter) void {
        c.wgpuDevicePushErrorScope(@ptrCast(self), @intFromEnum(filter));
    }

    pub fn createComputePipeline(self: *Device, descriptor: *const types.ComputePipelineDescriptor) *ComputePipeline {
        const result = c.wgpuDeviceCreateComputePipeline(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn createQuerySet(self: *Device, descriptor: *const types.QuerySetDescriptor) *QuerySet {
        const result = c.wgpuDeviceCreateQuerySet(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

};

pub const ExternalTexture = opaque {
    pub fn fromPtr(ptr: *anyopaque) *ExternalTexture {
        return @ptrCast(ptr);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuExternalTextureSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *ExternalTexture, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuExternalTextureSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuExternalTextureSetLabel for the raw extern (aborts at runtime)");
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuExternalTextureAddRef` for the raw extern, which aborts at runtime.
    pub inline fn addRef(self: *ExternalTexture) void {
        _ = self;
        @compileError("wgpuExternalTextureAddRef is stubbed by wgpu-native; use wgpu.c.wgpuExternalTextureAddRef for the raw extern (aborts at runtime)");
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuExternalTextureRelease` for the raw extern, which aborts at runtime.
    pub inline fn release(self: *ExternalTexture) void {
        _ = self;
        @compileError("wgpuExternalTextureRelease is stubbed by wgpu-native; use wgpu.c.wgpuExternalTextureRelease for the raw extern (aborts at runtime)");
    }

};

pub const Instance = opaque {
    pub fn fromPtr(ptr: *anyopaque) *Instance {
        return @ptrCast(ptr);
    }

    pub fn enumerateAdapters(self: *Instance, options: ?*const types.InstanceEnumerateAdapterOptions, adapters: [*c]?*Adapter) usize {
        return c.wgpuInstanceEnumerateAdapters(@ptrCast(self), @ptrCast(options), @ptrCast(adapters));
    }

    pub fn release(self: *Instance) void {
        c.wgpuInstanceRelease(@ptrCast(self));
    }

    pub fn createSurface(self: *Instance, descriptor: *const types.SurfaceDescriptor) *Surface {
        const result = c.wgpuInstanceCreateSurface(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn requestAdapter(self: *Instance, options: ?*const types.RequestAdapterOptions, callbackInfo: types.RequestAdapterCallbackInfo) types.Future {
        const result = c.wgpuInstanceRequestAdapter(@ptrCast(self), @ptrCast(options), asC(c.WGPURequestAdapterCallbackInfo, callbackInfo));
        return asC(types.Future, result);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuInstanceGetWGSLLanguageFeatures` for the raw extern, which aborts at runtime.
    pub inline fn getWGSLLanguageFeatures(self: *Instance, features: *types.SupportedWGSLLanguageFeatures) void {
        _ = self;
        _ = features;
        @compileError("wgpuInstanceGetWGSLLanguageFeatures is stubbed by wgpu-native; use wgpu.c.wgpuInstanceGetWGSLLanguageFeatures for the raw extern (aborts at runtime)");
    }

    pub fn generateReport(self: *Instance, report: *types.GlobalReport) void {
        c.wgpuGenerateReport(@ptrCast(self), @ptrCast(report));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuInstanceHasWGSLLanguageFeature` for the raw extern, which aborts at runtime.
    pub inline fn hasWGSLLanguageFeature(self: *Instance, feature: types.WGSLLanguageFeatureName) bool {
        _ = self;
        _ = feature;
        @compileError("wgpuInstanceHasWGSLLanguageFeature is stubbed by wgpu-native; use wgpu.c.wgpuInstanceHasWGSLLanguageFeature for the raw extern (aborts at runtime)");
    }

    pub fn processEvents(self: *Instance) void {
        c.wgpuInstanceProcessEvents(@ptrCast(self));
    }

    pub fn addRef(self: *Instance) void {
        c.wgpuInstanceAddRef(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuInstanceWaitAny` for the raw extern, which aborts at runtime.
    pub inline fn waitAny(self: *Instance, futureCount: usize, futures: ?*types.FutureWaitInfo, timeoutNS: u64) types.WaitStatusError!void {
        _ = self;
        _ = futureCount;
        _ = futures;
        _ = timeoutNS;
        @compileError("wgpuInstanceWaitAny is stubbed by wgpu-native; use wgpu.c.wgpuInstanceWaitAny for the raw extern (aborts at runtime)");
    }

    pub fn requestAdapterSync(self: *Instance, io: std.Io, options: ?*const types.RequestAdapterOptions) types.WaitStatusError!RequestAdapterResult {
        var ctx: RequestAdapterSyncCtx = .{};
        const future = self.requestAdapter(options, types.RequestAdapterCallbackInfo{ .mode = .allow_process_events, .callback = &requestAdapterSyncTrampoline, .userdata1 = @ptrCast(&ctx) });
        _ = future;
        var spins: u32 = 0;
        while (!ctx.done) {
            self.processEvents();
            if (ctx.done) break;
            if (spins < 16) {
                spins += 1;
                continue;
            }
            std.Io.sleep(io, std.Io.Duration.fromMilliseconds(1), .awake) catch {};
        }
        return ctx.response;
    }

    pub fn create(descriptor: ?*const types.InstanceDescriptor) *Instance {
        const result = c.wgpuCreateInstance(@ptrCast(descriptor));
        return @ptrCast(result.?);
    }

};

pub const PipelineLayout = opaque {
    pub fn fromPtr(ptr: *anyopaque) *PipelineLayout {
        return @ptrCast(ptr);
    }

    pub fn addRef(self: *PipelineLayout) void {
        c.wgpuPipelineLayoutAddRef(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuPipelineLayoutSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *PipelineLayout, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuPipelineLayoutSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuPipelineLayoutSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn release(self: *PipelineLayout) void {
        c.wgpuPipelineLayoutRelease(@ptrCast(self));
    }

};

pub const QuerySet = opaque {
    pub fn fromPtr(ptr: *anyopaque) *QuerySet {
        return @ptrCast(ptr);
    }

    pub fn getCount(self: *QuerySet) u32 {
        return c.wgpuQuerySetGetCount(@ptrCast(self));
    }

    pub fn getType(self: *QuerySet) types.QueryType {
        const result = c.wgpuQuerySetGetType(@ptrCast(self));
        return @enumFromInt(result);
    }

    pub fn destroy(self: *QuerySet) void {
        c.wgpuQuerySetDestroy(@ptrCast(self));
    }

    pub fn release(self: *QuerySet) void {
        c.wgpuQuerySetRelease(@ptrCast(self));
    }

    pub fn addRef(self: *QuerySet) void {
        c.wgpuQuerySetAddRef(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuQuerySetSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *QuerySet, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuQuerySetSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuQuerySetSetLabel for the raw extern (aborts at runtime)");
    }

};

pub const Queue = opaque {
    pub fn fromPtr(ptr: *anyopaque) *Queue {
        return @ptrCast(ptr);
    }

    pub fn writeTexture(self: *Queue, destination: *const types.TexelCopyTextureInfo, data: ?*const anyopaque, dataSize: usize, dataLayout: *const types.TexelCopyBufferLayout, writeSize: *const types.Extent3D) void {
        c.wgpuQueueWriteTexture(@ptrCast(self), @ptrCast(destination), data, dataSize, @ptrCast(dataLayout), @ptrCast(writeSize));
    }

    pub fn release(self: *Queue) void {
        c.wgpuQueueRelease(@ptrCast(self));
    }

    pub fn onSubmittedWorkDone(self: *Queue, callbackInfo: types.QueueWorkDoneCallbackInfo) types.Future {
        const result = c.wgpuQueueOnSubmittedWorkDone(@ptrCast(self), asC(c.WGPUQueueWorkDoneCallbackInfo, callbackInfo));
        return asC(types.Future, result);
    }

    pub fn getNativeMetalCommandQueue(self: *Queue) ?*anyopaque {
        return c.wgpuQueueGetNativeMetalCommandQueue(@ptrCast(self));
    }

    pub fn addRef(self: *Queue) void {
        c.wgpuQueueAddRef(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuQueueSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *Queue, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuQueueSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuQueueSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn writeBuffer(self: *Queue, buffer: *Buffer, bufferOffset: u64, data: ?*const anyopaque, size: usize) void {
        c.wgpuQueueWriteBuffer(@ptrCast(self), @ptrCast(buffer), bufferOffset, data, size);
    }

    pub fn getTimestampPeriod(self: *Queue) f32 {
        return c.wgpuQueueGetTimestampPeriod(@ptrCast(self));
    }

    pub fn submit(self: *Queue, commands: []const *CommandBuffer) void {
        self.submitRaw(@intCast(commands.len), @ptrCast(commands.ptr));
    }

    pub fn submitRaw(self: *Queue, commandCount: usize, commands: [*c]const ?*CommandBuffer) void {
        c.wgpuQueueSubmit(@ptrCast(self), commandCount, @ptrCast(commands));
    }

    pub fn submitForIndex(self: *Queue, commands: []const *CommandBuffer) types.SubmissionIndex {
        return self.submitForIndexRaw(@intCast(commands.len), @ptrCast(commands.ptr));
    }

    pub fn submitForIndexRaw(self: *Queue, commandCount: usize, commands: [*c]const ?*CommandBuffer) types.SubmissionIndex {
        const result = c.wgpuQueueSubmitForIndex(@ptrCast(self), commandCount, @ptrCast(commands));
        return asC(types.SubmissionIndex, result);
    }

    pub fn onSubmittedWorkDoneSync(self: *Queue, io: std.Io, device: *Device) types.WaitStatusError!OnSubmittedWorkDoneResult {
        var ctx: OnSubmittedWorkDoneSyncCtx = .{};
        const future = self.onSubmittedWorkDone(types.QueueWorkDoneCallbackInfo{ .mode = .allow_process_events, .callback = &onSubmittedWorkDoneSyncTrampoline, .userdata1 = @ptrCast(&ctx) });
        _ = future;
        while (!ctx.done) {
            _ = device.poll(true, null);
            if (ctx.done) break;
            std.Io.sleep(io, std.Io.Duration.fromMilliseconds(1), .awake) catch {};
        }
        return ctx.response;
    }

};

pub const RenderBundle = opaque {
    pub fn fromPtr(ptr: *anyopaque) *RenderBundle {
        return @ptrCast(ptr);
    }

    pub fn release(self: *RenderBundle) void {
        c.wgpuRenderBundleRelease(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuRenderBundleSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *RenderBundle, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuRenderBundleSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuRenderBundleSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn addRef(self: *RenderBundle) void {
        c.wgpuRenderBundleAddRef(@ptrCast(self));
    }

};

pub const RenderBundleEncoder = opaque {
    pub fn fromPtr(ptr: *anyopaque) *RenderBundleEncoder {
        return @ptrCast(ptr);
    }

    pub fn draw(self: *RenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) void {
        c.wgpuRenderBundleEncoderDraw(@ptrCast(self), vertexCount, instanceCount, firstVertex, firstInstance);
    }

    pub fn insertDebugMarker(self: *RenderBundleEncoder, markerLabel: types.StringView) void {
        c.wgpuRenderBundleEncoderInsertDebugMarker(@ptrCast(self), asC(c.WGPUStringView, markerLabel));
    }

    pub fn pushDebugGroup(self: *RenderBundleEncoder, groupLabel: types.StringView) void {
        c.wgpuRenderBundleEncoderPushDebugGroup(@ptrCast(self), asC(c.WGPUStringView, groupLabel));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuRenderBundleEncoderSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *RenderBundleEncoder, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuRenderBundleEncoderSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuRenderBundleEncoderSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn finish(self: *RenderBundleEncoder, descriptor: ?*const types.RenderBundleDescriptor) *RenderBundle {
        const result = c.wgpuRenderBundleEncoderFinish(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn drawIndirect(self: *RenderBundleEncoder, indirectBuffer: *Buffer, indirectOffset: u64) void {
        c.wgpuRenderBundleEncoderDrawIndirect(@ptrCast(self), @ptrCast(indirectBuffer), indirectOffset);
    }

    pub fn setPipeline(self: *RenderBundleEncoder, pipeline: *RenderPipeline) void {
        c.wgpuRenderBundleEncoderSetPipeline(@ptrCast(self), @ptrCast(pipeline));
    }

    pub fn addRef(self: *RenderBundleEncoder) void {
        c.wgpuRenderBundleEncoderAddRef(@ptrCast(self));
    }

    pub fn setIndexBuffer(self: *RenderBundleEncoder, buffer: *Buffer, format: types.IndexFormat, offset: u64, size: u64) void {
        c.wgpuRenderBundleEncoderSetIndexBuffer(@ptrCast(self), @ptrCast(buffer), @intFromEnum(format), offset, size);
    }

    pub fn drawIndexed(self: *RenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void {
        c.wgpuRenderBundleEncoderDrawIndexed(@ptrCast(self), indexCount, instanceCount, firstIndex, baseVertex, firstInstance);
    }

    pub fn release(self: *RenderBundleEncoder) void {
        c.wgpuRenderBundleEncoderRelease(@ptrCast(self));
    }

    pub fn setVertexBuffer(self: *RenderBundleEncoder, slot: u32, buffer: ?*Buffer, offset: u64, size: u64) void {
        c.wgpuRenderBundleEncoderSetVertexBuffer(@ptrCast(self), slot, @ptrCast(buffer), offset, size);
    }

    pub fn popDebugGroup(self: *RenderBundleEncoder) void {
        c.wgpuRenderBundleEncoderPopDebugGroup(@ptrCast(self));
    }

    pub fn drawIndexedIndirect(self: *RenderBundleEncoder, indirectBuffer: *Buffer, indirectOffset: u64) void {
        c.wgpuRenderBundleEncoderDrawIndexedIndirect(@ptrCast(self), @ptrCast(indirectBuffer), indirectOffset);
    }

    pub fn setImmediates(self: *RenderBundleEncoder, offset: u32, data: ?*const anyopaque, size: usize) void {
        c.wgpuRenderBundleEncoderSetImmediates(@ptrCast(self), offset, data, size);
    }

    pub fn setBindGroup(self: *RenderBundleEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsets: []const u32) void {
        self.setBindGroupRaw(groupIndex, group, @intCast(dynamicOffsets.len), @ptrCast(dynamicOffsets.ptr));
    }

    pub fn setBindGroupRaw(self: *RenderBundleEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) void {
        c.wgpuRenderBundleEncoderSetBindGroup(@ptrCast(self), groupIndex, @ptrCast(group), dynamicOffsetCount, dynamicOffsets);
    }

};

pub const RenderPassEncoder = opaque {
    pub fn fromPtr(ptr: *anyopaque) *RenderPassEncoder {
        return @ptrCast(ptr);
    }

    pub fn multiDrawIndexedIndirectCount(self: *RenderPassEncoder, buffer: *Buffer, offset: u64, count_buffer: *Buffer, count_buffer_offset: u64, max_count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndexedIndirectCount(@ptrCast(self), @ptrCast(buffer), offset, @ptrCast(count_buffer), count_buffer_offset, max_count);
    }

    pub fn setBindGroup(self: *RenderPassEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsets: []const u32) void {
        self.setBindGroupRaw(groupIndex, group, @intCast(dynamicOffsets.len), @ptrCast(dynamicOffsets.ptr));
    }

    pub fn setBindGroupRaw(self: *RenderPassEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) void {
        c.wgpuRenderPassEncoderSetBindGroup(@ptrCast(self), groupIndex, @ptrCast(group), dynamicOffsetCount, dynamicOffsets);
    }

    pub fn popDebugGroup(self: *RenderPassEncoder) void {
        c.wgpuRenderPassEncoderPopDebugGroup(@ptrCast(self));
    }

    pub fn setVertexBuffer(self: *RenderPassEncoder, slot: u32, buffer: ?*Buffer, offset: u64, size: u64) void {
        c.wgpuRenderPassEncoderSetVertexBuffer(@ptrCast(self), slot, @ptrCast(buffer), offset, size);
    }

    pub fn multiDrawIndirect(self: *RenderPassEncoder, buffer: *Buffer, offset: u64, count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndirect(@ptrCast(self), @ptrCast(buffer), offset, count);
    }

    pub fn insertDebugMarker(self: *RenderPassEncoder, markerLabel: types.StringView) void {
        c.wgpuRenderPassEncoderInsertDebugMarker(@ptrCast(self), asC(c.WGPUStringView, markerLabel));
    }

    pub fn multiDrawIndexedIndirect(self: *RenderPassEncoder, buffer: *Buffer, offset: u64, count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndexedIndirect(@ptrCast(self), @ptrCast(buffer), offset, count);
    }

    pub fn setImmediates(self: *RenderPassEncoder, offset: u32, data: ?*const anyopaque, size: usize) void {
        c.wgpuRenderPassEncoderSetImmediates(@ptrCast(self), offset, data, size);
    }

    pub fn setStencilReference(self: *RenderPassEncoder, reference: u32) void {
        c.wgpuRenderPassEncoderSetStencilReference(@ptrCast(self), reference);
    }

    pub fn beginPipelineStatisticsQuery(self: *RenderPassEncoder, querySet: *QuerySet, queryIndex: u32) void {
        c.wgpuRenderPassEncoderBeginPipelineStatisticsQuery(@ptrCast(self), @ptrCast(querySet), queryIndex);
    }

    pub fn setViewport(self: *RenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) void {
        c.wgpuRenderPassEncoderSetViewport(@ptrCast(self), x, y, width, height, minDepth, maxDepth);
    }

    pub fn setBlendConstant(self: *RenderPassEncoder, color: *const types.Color) void {
        c.wgpuRenderPassEncoderSetBlendConstant(@ptrCast(self), @ptrCast(color));
    }

    pub fn drawIndexedIndirect(self: *RenderPassEncoder, indirectBuffer: *Buffer, indirectOffset: u64) void {
        c.wgpuRenderPassEncoderDrawIndexedIndirect(@ptrCast(self), @ptrCast(indirectBuffer), indirectOffset);
    }

    pub fn multiDrawIndirectCount(self: *RenderPassEncoder, buffer: *Buffer, offset: u64, count_buffer: *Buffer, count_buffer_offset: u64, max_count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndirectCount(@ptrCast(self), @ptrCast(buffer), offset, @ptrCast(count_buffer), count_buffer_offset, max_count);
    }

    pub fn executeBundles(self: *RenderPassEncoder, bundles: []const *RenderBundle) void {
        self.executeBundlesRaw(@intCast(bundles.len), @ptrCast(bundles.ptr));
    }

    pub fn executeBundlesRaw(self: *RenderPassEncoder, bundleCount: usize, bundles: [*c]const ?*RenderBundle) void {
        c.wgpuRenderPassEncoderExecuteBundles(@ptrCast(self), bundleCount, @ptrCast(bundles));
    }

    pub fn beginOcclusionQuery(self: *RenderPassEncoder, queryIndex: u32) void {
        c.wgpuRenderPassEncoderBeginOcclusionQuery(@ptrCast(self), queryIndex);
    }

    pub fn addRef(self: *RenderPassEncoder) void {
        c.wgpuRenderPassEncoderAddRef(@ptrCast(self));
    }

    pub fn release(self: *RenderPassEncoder) void {
        c.wgpuRenderPassEncoderRelease(@ptrCast(self));
    }

    pub fn endOcclusionQuery(self: *RenderPassEncoder) void {
        c.wgpuRenderPassEncoderEndOcclusionQuery(@ptrCast(self));
    }

    pub fn writeTimestamp(self: *RenderPassEncoder, querySet: *QuerySet, queryIndex: u32) void {
        c.wgpuRenderPassEncoderWriteTimestamp(@ptrCast(self), @ptrCast(querySet), queryIndex);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuRenderPassEncoderSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *RenderPassEncoder, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuRenderPassEncoderSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuRenderPassEncoderSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn drawIndexed(self: *RenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void {
        c.wgpuRenderPassEncoderDrawIndexed(@ptrCast(self), indexCount, instanceCount, firstIndex, baseVertex, firstInstance);
    }

    pub fn endPipelineStatisticsQuery(self: *RenderPassEncoder) void {
        c.wgpuRenderPassEncoderEndPipelineStatisticsQuery(@ptrCast(self));
    }

    pub fn drawIndirect(self: *RenderPassEncoder, indirectBuffer: *Buffer, indirectOffset: u64) void {
        c.wgpuRenderPassEncoderDrawIndirect(@ptrCast(self), @ptrCast(indirectBuffer), indirectOffset);
    }

    pub fn setIndexBuffer(self: *RenderPassEncoder, buffer: *Buffer, format: types.IndexFormat, offset: u64, size: u64) void {
        c.wgpuRenderPassEncoderSetIndexBuffer(@ptrCast(self), @ptrCast(buffer), @intFromEnum(format), offset, size);
    }

    pub fn draw(self: *RenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) void {
        c.wgpuRenderPassEncoderDraw(@ptrCast(self), vertexCount, instanceCount, firstVertex, firstInstance);
    }

    pub fn pushDebugGroup(self: *RenderPassEncoder, groupLabel: types.StringView) void {
        c.wgpuRenderPassEncoderPushDebugGroup(@ptrCast(self), asC(c.WGPUStringView, groupLabel));
    }

    pub fn setScissorRect(self: *RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) void {
        c.wgpuRenderPassEncoderSetScissorRect(@ptrCast(self), x, y, width, height);
    }

    pub fn end(self: *RenderPassEncoder) void {
        c.wgpuRenderPassEncoderEnd(@ptrCast(self));
    }

    pub fn setPipeline(self: *RenderPassEncoder, pipeline: *RenderPipeline) void {
        c.wgpuRenderPassEncoderSetPipeline(@ptrCast(self), @ptrCast(pipeline));
    }

};

pub const RenderPipeline = opaque {
    pub fn fromPtr(ptr: *anyopaque) *RenderPipeline {
        return @ptrCast(ptr);
    }

    pub fn addRef(self: *RenderPipeline) void {
        c.wgpuRenderPipelineAddRef(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuRenderPipelineSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *RenderPipeline, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuRenderPipelineSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuRenderPipelineSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn release(self: *RenderPipeline) void {
        c.wgpuRenderPipelineRelease(@ptrCast(self));
    }

    pub fn getBindGroupLayout(self: *RenderPipeline, groupIndex: u32) *BindGroupLayout {
        const result = c.wgpuRenderPipelineGetBindGroupLayout(@ptrCast(self), groupIndex);
        return @ptrCast(result.?);
    }

};

pub const Sampler = opaque {
    pub fn fromPtr(ptr: *anyopaque) *Sampler {
        return @ptrCast(ptr);
    }

    pub fn release(self: *Sampler) void {
        c.wgpuSamplerRelease(@ptrCast(self));
    }

    pub fn addRef(self: *Sampler) void {
        c.wgpuSamplerAddRef(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuSamplerSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *Sampler, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuSamplerSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuSamplerSetLabel for the raw extern (aborts at runtime)");
    }

};

pub const ShaderModule = opaque {
    pub fn fromPtr(ptr: *anyopaque) *ShaderModule {
        return @ptrCast(ptr);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuShaderModuleSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *ShaderModule, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuShaderModuleSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuShaderModuleSetLabel for the raw extern (aborts at runtime)");
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuShaderModuleGetCompilationInfo` for the raw extern, which aborts at runtime.
    pub inline fn getCompilationInfo(self: *ShaderModule, callbackInfo: types.CompilationInfoCallbackInfo) types.Future {
        _ = self;
        _ = callbackInfo;
        @compileError("wgpuShaderModuleGetCompilationInfo is stubbed by wgpu-native; use wgpu.c.wgpuShaderModuleGetCompilationInfo for the raw extern (aborts at runtime)");
    }

    pub fn addRef(self: *ShaderModule) void {
        c.wgpuShaderModuleAddRef(@ptrCast(self));
    }

    pub fn release(self: *ShaderModule) void {
        c.wgpuShaderModuleRelease(@ptrCast(self));
    }

};

pub const Surface = opaque {
    pub fn fromPtr(ptr: *anyopaque) *Surface {
        return @ptrCast(ptr);
    }

    pub fn configure(self: *Surface, config: *const types.SurfaceConfiguration) void {
        c.wgpuSurfaceConfigure(@ptrCast(self), @ptrCast(config));
    }

    pub fn present(self: *Surface) types.StatusError!void {
        const status = c.wgpuSurfacePresent(@ptrCast(self));
        try @as(types.Status, @enumFromInt(status)).toError();
    }

    pub fn unconfigure(self: *Surface) void {
        c.wgpuSurfaceUnconfigure(@ptrCast(self));
    }

    pub fn getCapabilities(self: *Surface, adapter: *Adapter) types.StatusError!types.SurfaceCapabilities {
        var result: types.SurfaceCapabilities = undefined;
        const status = c.wgpuSurfaceGetCapabilities(@ptrCast(self), @ptrCast(adapter), @ptrCast(&result));
        try @as(types.Status, @enumFromInt(status)).toError();
        return result;
    }

    pub fn getCurrentTexture(self: *Surface, surfaceTexture: *types.SurfaceTexture) void {
        c.wgpuSurfaceGetCurrentTexture(@ptrCast(self), @ptrCast(surfaceTexture));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuSurfaceSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *Surface, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuSurfaceSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuSurfaceSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn addRef(self: *Surface) void {
        c.wgpuSurfaceAddRef(@ptrCast(self));
    }

    pub fn release(self: *Surface) void {
        c.wgpuSurfaceRelease(@ptrCast(self));
    }

};

pub const Texture = opaque {
    pub fn fromPtr(ptr: *anyopaque) *Texture {
        return @ptrCast(ptr);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuTextureGetTextureBindingViewDimension` for the raw extern, which aborts at runtime.
    pub inline fn getTextureBindingViewDimension(self: *Texture) types.TextureViewDimension {
        _ = self;
        @compileError("wgpuTextureGetTextureBindingViewDimension is stubbed by wgpu-native; use wgpu.c.wgpuTextureGetTextureBindingViewDimension for the raw extern (aborts at runtime)");
    }

    pub fn getSampleCount(self: *Texture) u32 {
        return c.wgpuTextureGetSampleCount(@ptrCast(self));
    }

    pub fn getFormat(self: *Texture) types.TextureFormat {
        const result = c.wgpuTextureGetFormat(@ptrCast(self));
        return @enumFromInt(result);
    }

    pub fn createView(self: *Texture, descriptor: ?*const types.TextureViewDescriptor) *TextureView {
        const result = c.wgpuTextureCreateView(@ptrCast(self), @ptrCast(descriptor));
        return @ptrCast(result.?);
    }

    pub fn getDimension(self: *Texture) types.TextureDimension {
        const result = c.wgpuTextureGetDimension(@ptrCast(self));
        return @enumFromInt(result);
    }

    pub fn getMipLevelCount(self: *Texture) u32 {
        return c.wgpuTextureGetMipLevelCount(@ptrCast(self));
    }

    pub fn addRef(self: *Texture) void {
        c.wgpuTextureAddRef(@ptrCast(self));
    }

    pub fn destroy(self: *Texture) void {
        c.wgpuTextureDestroy(@ptrCast(self));
    }

    pub fn getDepthOrArrayLayers(self: *Texture) u32 {
        return c.wgpuTextureGetDepthOrArrayLayers(@ptrCast(self));
    }

    pub fn getWidth(self: *Texture) u32 {
        return c.wgpuTextureGetWidth(@ptrCast(self));
    }

    pub fn release(self: *Texture) void {
        c.wgpuTextureRelease(@ptrCast(self));
    }

    pub fn getUsage(self: *Texture) types.TextureUsage {
        const result = c.wgpuTextureGetUsage(@ptrCast(self));
        return asC(types.TextureUsage, result);
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuTextureSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *Texture, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuTextureSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuTextureSetLabel for the raw extern (aborts at runtime)");
    }

    pub fn getNativeMetalTexture(self: *Texture) ?*anyopaque {
        return c.wgpuTextureGetNativeMetalTexture(@ptrCast(self));
    }

    pub fn getHeight(self: *Texture) u32 {
        return c.wgpuTextureGetHeight(@ptrCast(self));
    }

};

pub const TextureView = opaque {
    pub fn fromPtr(ptr: *anyopaque) *TextureView {
        return @ptrCast(ptr);
    }

    pub fn addRef(self: *TextureView) void {
        c.wgpuTextureViewAddRef(@ptrCast(self));
    }

    pub fn release(self: *TextureView) void {
        c.wgpuTextureViewRelease(@ptrCast(self));
    }

    /// Stubbed by wgpu-native: calling this is a compile error.
    /// Use `wgpu.c.wgpuTextureViewSetLabel` for the raw extern, which aborts at runtime.
    pub inline fn setLabel(self: *TextureView, label: types.StringView) void {
        _ = self;
        _ = label;
        @compileError("wgpuTextureViewSetLabel is stubbed by wgpu-native; use wgpu.c.wgpuTextureViewSetLabel for the raw extern (aborts at runtime)");
    }

};

/// Stubbed by wgpu-native: calling this is a compile error.
/// Use `wgpu.c.wgpuGetInstanceFeatures` for the raw extern, which aborts at runtime.
pub inline fn getInstanceFeatures(features: *types.SupportedInstanceFeatures) void {
    _ = features;
    @compileError("wgpuGetInstanceFeatures is stubbed by wgpu-native; use wgpu.c.wgpuGetInstanceFeatures for the raw extern (aborts at runtime)");
}

pub fn supportedFeaturesFreeMembers(supportedFeatures: types.SupportedFeatures) void {
    c.wgpuSupportedFeaturesFreeMembers(asC(c.WGPUSupportedFeatures, supportedFeatures));
}

pub fn surfaceCapabilitiesFreeMembers(surfaceCapabilities: types.SurfaceCapabilities) void {
    c.wgpuSurfaceCapabilitiesFreeMembers(asC(c.WGPUSurfaceCapabilities, surfaceCapabilities));
}

/// Stubbed by wgpu-native: calling this is a compile error.
/// Use `wgpu.c.wgpuGetProcAddress` for the raw extern, which aborts at runtime.
pub inline fn getProcAddress(procName: types.StringView) c.WGPUProc {
    _ = procName;
    @compileError("wgpuGetProcAddress is stubbed by wgpu-native; use wgpu.c.wgpuGetProcAddress for the raw extern (aborts at runtime)");
}

pub fn setLogCallback(callback: c.WGPULogCallback, userdata: ?*anyopaque) void {
    c.wgpuSetLogCallback(callback, userdata);
}

pub fn adapterInfoFreeMembers(adapterInfo: types.AdapterInfo) void {
    c.wgpuAdapterInfoFreeMembers(asC(c.WGPUAdapterInfo, adapterInfo));
}

pub fn createInstance(descriptor: ?*const types.InstanceDescriptor) *Instance {
    return Instance.create(descriptor);
}

/// Stubbed by wgpu-native: calling this is a compile error.
/// Use `wgpu.c.wgpuSupportedInstanceFeaturesFreeMembers` for the raw extern, which aborts at runtime.
pub inline fn supportedInstanceFeaturesFreeMembers(supportedInstanceFeatures: types.SupportedInstanceFeatures) void {
    _ = supportedInstanceFeatures;
    @compileError("wgpuSupportedInstanceFeaturesFreeMembers is stubbed by wgpu-native; use wgpu.c.wgpuSupportedInstanceFeaturesFreeMembers for the raw extern (aborts at runtime)");
}

/// Stubbed by wgpu-native: calling this is a compile error.
/// Use `wgpu.c.wgpuSupportedWGSLLanguageFeaturesFreeMembers` for the raw extern, which aborts at runtime.
pub inline fn supportedWGSLLanguageFeaturesFreeMembers(supportedWGSLLanguageFeatures: types.SupportedWGSLLanguageFeatures) void {
    _ = supportedWGSLLanguageFeatures;
    @compileError("wgpuSupportedWGSLLanguageFeaturesFreeMembers is stubbed by wgpu-native; use wgpu.c.wgpuSupportedWGSLLanguageFeaturesFreeMembers for the raw extern (aborts at runtime)");
}

pub fn getInstanceLimits() types.StatusError!types.InstanceLimits {
    var result: types.InstanceLimits = undefined;
    const status = c.wgpuGetInstanceLimits(@ptrCast(&result));
    try @as(types.Status, @enumFromInt(status)).toError();
    return result;
}

pub fn getVersion() u32 {
    return c.wgpuGetVersion();
}

pub fn setLogLevel(level: types.LogLevel) void {
    c.wgpuSetLogLevel(@intFromEnum(level));
}

/// Stubbed by wgpu-native: calling this is a compile error.
/// Use `wgpu.c.wgpuHasInstanceFeature` for the raw extern, which aborts at runtime.
pub inline fn hasInstanceFeature(feature: types.InstanceFeatureName) bool {
    _ = feature;
    @compileError("wgpuHasInstanceFeature is stubbed by wgpu-native; use wgpu.c.wgpuHasInstanceFeature for the raw extern (aborts at runtime)");
}

