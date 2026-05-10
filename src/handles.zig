const c = @import("c_wgpu_native");
const types = @import("types.zig");

pub const Adapter = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Adapter {
        return .{ .ptr = ptr };
    }

    pub fn getInfo(self: Adapter) !c.WGPUAdapterInfo {
        var result: c.WGPUAdapterInfo = undefined;
        const status = c.wgpuAdapterGetInfo(@ptrCast(self.ptr), @ptrCast(&result));
        if (status != 1) return error.Unexpected;
        return result;
    }

    pub fn getLimits(self: Adapter) !c.WGPULimits {
        var result: c.WGPULimits = undefined;
        const status = c.wgpuAdapterGetLimits(@ptrCast(self.ptr), @ptrCast(&result));
        if (status != 1) return error.Unexpected;
        return result;
    }

    pub fn hasFeature(self: Adapter, feature: types.FeatureName) c_int {
        return c.wgpuAdapterHasFeature(@ptrCast(self.ptr), @intFromEnum(feature));
    }

    pub fn getFeatures(self: Adapter, features: ?*types.SupportedFeatures) void {
        c.wgpuAdapterGetFeatures(@ptrCast(self.ptr), @ptrCast(features));
    }

    pub fn requestDevice(self: Adapter, descriptor: ?*const types.DeviceDescriptor, callbackInfo: c.WGPURequestDeviceCallbackInfo) types.Future {
        const result = c.wgpuAdapterRequestDevice(@ptrCast(self.ptr), @ptrCast(descriptor), callbackInfo);
        return @bitCast(result);
    }

};

pub const OptionalAdapter = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: Adapter) OptionalAdapter {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalAdapter {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalAdapter) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalAdapter) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalAdapter) ?Adapter {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalAdapter) Adapter {
        return .{ .ptr = self.ptr.? };
    }
};

pub const BindGroup = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) BindGroup {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: BindGroup, label: c.WGPUStringView) void {
        c.wgpuBindGroupSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const OptionalBindGroup = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: BindGroup) OptionalBindGroup {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalBindGroup {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalBindGroup) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalBindGroup) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalBindGroup) ?BindGroup {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalBindGroup) BindGroup {
        return .{ .ptr = self.ptr.? };
    }
};

pub const BindGroupLayout = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) BindGroupLayout {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: BindGroupLayout, label: c.WGPUStringView) void {
        c.wgpuBindGroupLayoutSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const OptionalBindGroupLayout = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: BindGroupLayout) OptionalBindGroupLayout {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalBindGroupLayout {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalBindGroupLayout) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalBindGroupLayout) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalBindGroupLayout) ?BindGroupLayout {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalBindGroupLayout) BindGroupLayout {
        return .{ .ptr = self.ptr.? };
    }
};

pub const Buffer = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Buffer {
        return .{ .ptr = ptr };
    }

    pub fn getMapState(self: Buffer) types.BufferMapState {
        return c.wgpuBufferGetMapState(@ptrCast(self.ptr));
    }

    pub fn destroy(self: Buffer) void {
        c.wgpuBufferDestroy(@ptrCast(self.ptr));
    }

    pub fn writeMappedRange(self: Buffer, offset: usize, data: ?*const anyopaque, size: usize) !void {
        const status = c.wgpuBufferWriteMappedRange(@ptrCast(self.ptr), offset, data, size);
        if (status != 1) return error.Unexpected;
    }

    pub fn mapAsync(self: Buffer, mode: types.MapMode, offset: usize, size: usize, callbackInfo: c.WGPUBufferMapCallbackInfo) types.Future {
        const result = c.wgpuBufferMapAsync(@ptrCast(self.ptr), @bitCast(mode), offset, size, callbackInfo);
        return @bitCast(result);
    }

    pub fn getSize(self: Buffer) u64 {
        return c.wgpuBufferGetSize(@ptrCast(self.ptr));
    }

    pub fn getConstMappedRange(self: Buffer, offset: usize, size: usize) ?*const anyopaque {
        return c.wgpuBufferGetConstMappedRange(@ptrCast(self.ptr), offset, size);
    }

    pub fn readMappedRange(self: Buffer, offset: usize, data: ?*anyopaque, size: usize) !void {
        const status = c.wgpuBufferReadMappedRange(@ptrCast(self.ptr), offset, data, size);
        if (status != 1) return error.Unexpected;
    }

    pub fn getUsage(self: Buffer) types.BufferUsage {
        return c.wgpuBufferGetUsage(@ptrCast(self.ptr));
    }

    pub fn unmap(self: Buffer) void {
        c.wgpuBufferUnmap(@ptrCast(self.ptr));
    }

    pub fn setLabel(self: Buffer, label: c.WGPUStringView) void {
        c.wgpuBufferSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn getMappedRange(self: Buffer, offset: usize, size: usize) ?*anyopaque {
        return c.wgpuBufferGetMappedRange(@ptrCast(self.ptr), offset, size);
    }

};

pub const OptionalBuffer = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: Buffer) OptionalBuffer {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalBuffer {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalBuffer) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalBuffer) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalBuffer) ?Buffer {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalBuffer) Buffer {
        return .{ .ptr = self.ptr.? };
    }
};

pub const CommandBuffer = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) CommandBuffer {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: CommandBuffer, label: c.WGPUStringView) void {
        c.wgpuCommandBufferSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const OptionalCommandBuffer = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: CommandBuffer) OptionalCommandBuffer {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalCommandBuffer {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalCommandBuffer) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalCommandBuffer) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalCommandBuffer) ?CommandBuffer {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalCommandBuffer) CommandBuffer {
        return .{ .ptr = self.ptr.? };
    }
};

pub const CommandEncoder = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) CommandEncoder {
        return .{ .ptr = ptr };
    }

    pub fn copyTextureToTexture(self: CommandEncoder, source: ?*const types.TexelCopyTextureInfo, destination: ?*const types.TexelCopyTextureInfo, copySize: ?*const types.Extent3D) void {
        c.wgpuCommandEncoderCopyTextureToTexture(@ptrCast(self.ptr), @ptrCast(source), @ptrCast(destination), @ptrCast(copySize));
    }

    pub fn copyBufferToTexture(self: CommandEncoder, source: ?*const types.TexelCopyBufferInfo, destination: ?*const types.TexelCopyTextureInfo, copySize: ?*const types.Extent3D) void {
        c.wgpuCommandEncoderCopyBufferToTexture(@ptrCast(self.ptr), @ptrCast(source), @ptrCast(destination), @ptrCast(copySize));
    }

    pub fn beginComputePass(self: CommandEncoder, descriptor: ?*const types.ComputePassDescriptor) !ComputePassEncoder {
        const result = c.wgpuCommandEncoderBeginComputePass(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn copyTextureToBuffer(self: CommandEncoder, source: ?*const types.TexelCopyTextureInfo, destination: ?*const types.TexelCopyBufferInfo, copySize: ?*const types.Extent3D) void {
        c.wgpuCommandEncoderCopyTextureToBuffer(@ptrCast(self.ptr), @ptrCast(source), @ptrCast(destination), @ptrCast(copySize));
    }

    pub fn pushDebugGroup(self: CommandEncoder, groupLabel: c.WGPUStringView) void {
        c.wgpuCommandEncoderPushDebugGroup(@ptrCast(self.ptr), groupLabel);
    }

    pub fn copyBufferToBuffer(self: CommandEncoder, source: Buffer, sourceOffset: u64, destination: Buffer, destinationOffset: u64, size: u64) void {
        c.wgpuCommandEncoderCopyBufferToBuffer(@ptrCast(self.ptr), @ptrCast(source.ptr), sourceOffset, @ptrCast(destination.ptr), destinationOffset, size);
    }

    pub fn clearTexture(self: CommandEncoder, texture: Texture, range: ?*const types.ImageSubresourceRange) void {
        c.wgpuCommandEncoderClearTexture(@ptrCast(self.ptr), @ptrCast(texture.ptr), @ptrCast(range));
    }

    pub fn resolveQuerySet(self: CommandEncoder, querySet: QuerySet, firstQuery: u32, queryCount: u32, destination: Buffer, destinationOffset: u64) void {
        c.wgpuCommandEncoderResolveQuerySet(@ptrCast(self.ptr), @ptrCast(querySet.ptr), firstQuery, queryCount, @ptrCast(destination.ptr), destinationOffset);
    }

    pub fn popDebugGroup(self: CommandEncoder) void {
        c.wgpuCommandEncoderPopDebugGroup(@ptrCast(self.ptr));
    }

    pub fn beginRenderPass(self: CommandEncoder, descriptor: ?*const types.RenderPassDescriptor) !RenderPassEncoder {
        const result = c.wgpuCommandEncoderBeginRenderPass(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn finish(self: CommandEncoder, descriptor: ?*const types.CommandBufferDescriptor) !CommandBuffer {
        const result = c.wgpuCommandEncoderFinish(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn setLabel(self: CommandEncoder, label: c.WGPUStringView) void {
        c.wgpuCommandEncoderSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn insertDebugMarker(self: CommandEncoder, markerLabel: c.WGPUStringView) void {
        c.wgpuCommandEncoderInsertDebugMarker(@ptrCast(self.ptr), markerLabel);
    }

    pub fn writeTimestamp(self: CommandEncoder, querySet: QuerySet, queryIndex: u32) void {
        c.wgpuCommandEncoderWriteTimestamp(@ptrCast(self.ptr), @ptrCast(querySet.ptr), queryIndex);
    }

    pub fn clearBuffer(self: CommandEncoder, buffer: Buffer, offset: u64, size: u64) void {
        c.wgpuCommandEncoderClearBuffer(@ptrCast(self.ptr), @ptrCast(buffer.ptr), offset, size);
    }

};

pub const OptionalCommandEncoder = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: CommandEncoder) OptionalCommandEncoder {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalCommandEncoder {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalCommandEncoder) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalCommandEncoder) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalCommandEncoder) ?CommandEncoder {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalCommandEncoder) CommandEncoder {
        return .{ .ptr = self.ptr.? };
    }
};

pub const ComputePassEncoder = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) ComputePassEncoder {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: ComputePassEncoder, label: c.WGPUStringView) void {
        c.wgpuComputePassEncoderSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn setPipeline(self: ComputePassEncoder, pipeline: ComputePipeline) void {
        c.wgpuComputePassEncoderSetPipeline(@ptrCast(self.ptr), @ptrCast(pipeline.ptr));
    }

    pub fn setImmediates(self: ComputePassEncoder, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void {
        c.wgpuComputePassEncoderSetImmediates(@ptrCast(self.ptr), offset, sizeBytes, data);
    }

    pub fn setBindGroup(self: ComputePassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: usize, dynamicOffsets: ?*const u32) void {
        c.wgpuComputePassEncoderSetBindGroup(@ptrCast(self.ptr), groupIndex, @ptrCast(group.ptr), dynamicOffsetCount, dynamicOffsets);
    }

    pub fn popDebugGroup(self: ComputePassEncoder) void {
        c.wgpuComputePassEncoderPopDebugGroup(@ptrCast(self.ptr));
    }

    pub fn endPipelineStatisticsQuery(self: ComputePassEncoder) void {
        c.wgpuComputePassEncoderEndPipelineStatisticsQuery(@ptrCast(self.ptr));
    }

    pub fn writeTimestamp(self: ComputePassEncoder, querySet: QuerySet, queryIndex: u32) void {
        c.wgpuComputePassEncoderWriteTimestamp(@ptrCast(self.ptr), @ptrCast(querySet.ptr), queryIndex);
    }

    pub fn insertDebugMarker(self: ComputePassEncoder, markerLabel: c.WGPUStringView) void {
        c.wgpuComputePassEncoderInsertDebugMarker(@ptrCast(self.ptr), markerLabel);
    }

    pub fn dispatchWorkgroupsIndirect(self: ComputePassEncoder, indirectBuffer: Buffer, indirectOffset: u64) void {
        c.wgpuComputePassEncoderDispatchWorkgroupsIndirect(@ptrCast(self.ptr), @ptrCast(indirectBuffer.ptr), indirectOffset);
    }

    pub fn pushDebugGroup(self: ComputePassEncoder, groupLabel: c.WGPUStringView) void {
        c.wgpuComputePassEncoderPushDebugGroup(@ptrCast(self.ptr), groupLabel);
    }

    pub fn dispatchWorkgroups(self: ComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) void {
        c.wgpuComputePassEncoderDispatchWorkgroups(@ptrCast(self.ptr), workgroupCountX, workgroupCountY, workgroupCountZ);
    }

    pub fn end(self: ComputePassEncoder) void {
        c.wgpuComputePassEncoderEnd(@ptrCast(self.ptr));
    }

    pub fn beginPipelineStatisticsQuery(self: ComputePassEncoder, querySet: QuerySet, queryIndex: u32) void {
        c.wgpuComputePassEncoderBeginPipelineStatisticsQuery(@ptrCast(self.ptr), @ptrCast(querySet.ptr), queryIndex);
    }

};

pub const OptionalComputePassEncoder = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: ComputePassEncoder) OptionalComputePassEncoder {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalComputePassEncoder {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalComputePassEncoder) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalComputePassEncoder) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalComputePassEncoder) ?ComputePassEncoder {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalComputePassEncoder) ComputePassEncoder {
        return .{ .ptr = self.ptr.? };
    }
};

pub const ComputePipeline = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) ComputePipeline {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: ComputePipeline, label: c.WGPUStringView) void {
        c.wgpuComputePipelineSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn getBindGroupLayout(self: ComputePipeline, groupIndex: u32) !BindGroupLayout {
        const result = c.wgpuComputePipelineGetBindGroupLayout(@ptrCast(self.ptr), groupIndex);
        return .{ .ptr = @ptrCast(result.?) };
    }

};

pub const OptionalComputePipeline = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: ComputePipeline) OptionalComputePipeline {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalComputePipeline {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalComputePipeline) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalComputePipeline) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalComputePipeline) ?ComputePipeline {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalComputePipeline) ComputePipeline {
        return .{ .ptr = self.ptr.? };
    }
};

pub const Device = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Device {
        return .{ .ptr = ptr };
    }

    pub fn createTexture(self: Device, descriptor: ?*const types.TextureDescriptor) !Texture {
        const result = c.wgpuDeviceCreateTexture(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn hasFeature(self: Device, feature: types.FeatureName) c_int {
        return c.wgpuDeviceHasFeature(@ptrCast(self.ptr), @intFromEnum(feature));
    }

    pub fn createBindGroup(self: Device, descriptor: ?*const types.BindGroupDescriptor) !BindGroup {
        const result = c.wgpuDeviceCreateBindGroup(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn createBuffer(self: Device, descriptor: ?*const types.BufferDescriptor) !Buffer {
        const result = c.wgpuDeviceCreateBuffer(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn createShaderModuleSpirV(self: Device, descriptor: ?*const types.ShaderModuleDescriptorSpirV) !ShaderModule {
        const result = c.wgpuDeviceCreateShaderModuleSpirV(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn startGraphicsDebuggerCapture(self: Device) c_int {
        return c.wgpuDeviceStartGraphicsDebuggerCapture(@ptrCast(self.ptr));
    }

    pub fn createRenderPipeline(self: Device, descriptor: ?*const types.RenderPipelineDescriptor) !RenderPipeline {
        const result = c.wgpuDeviceCreateRenderPipeline(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn createShaderModule(self: Device, descriptor: ?*const types.ShaderModuleDescriptor) !ShaderModule {
        const result = c.wgpuDeviceCreateShaderModule(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn getNativeMetalDevice(self: Device) ?*anyopaque {
        return c.wgpuDeviceGetNativeMetalDevice(@ptrCast(self.ptr));
    }

    pub fn poll(self: Device, wait: c_int, submissionIndex: ?*const c.WGPUSubmissionIndex) c_int {
        return c.wgpuDevicePoll(@ptrCast(self.ptr), wait, submissionIndex);
    }

    pub fn destroy(self: Device) void {
        c.wgpuDeviceDestroy(@ptrCast(self.ptr));
    }

    pub fn createComputePipelineAsync(self: Device, descriptor: ?*const types.ComputePipelineDescriptor, callbackInfo: c.WGPUCreateComputePipelineAsyncCallbackInfo) types.Future {
        const result = c.wgpuDeviceCreateComputePipelineAsync(@ptrCast(self.ptr), @ptrCast(descriptor), callbackInfo);
        return @bitCast(result);
    }

    pub fn createPipelineLayout(self: Device, descriptor: ?*const types.PipelineLayoutDescriptor) !PipelineLayout {
        const result = c.wgpuDeviceCreatePipelineLayout(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn createRenderBundleEncoder(self: Device, descriptor: ?*const types.RenderBundleEncoderDescriptor) !RenderBundleEncoder {
        const result = c.wgpuDeviceCreateRenderBundleEncoder(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn createSampler(self: Device, descriptor: ?*const types.SamplerDescriptor) !Sampler {
        const result = c.wgpuDeviceCreateSampler(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn getAdapterInfo(self: Device) !c.WGPUAdapterInfo {
        var result: c.WGPUAdapterInfo = undefined;
        const status = c.wgpuDeviceGetAdapterInfo(@ptrCast(self.ptr), @ptrCast(&result));
        if (status != 1) return error.Unexpected;
        return result;
    }

    pub fn createRenderPipelineAsync(self: Device, descriptor: ?*const types.RenderPipelineDescriptor, callbackInfo: c.WGPUCreateRenderPipelineAsyncCallbackInfo) types.Future {
        const result = c.wgpuDeviceCreateRenderPipelineAsync(@ptrCast(self.ptr), @ptrCast(descriptor), callbackInfo);
        return @bitCast(result);
    }

    pub fn setLabel(self: Device, label: c.WGPUStringView) void {
        c.wgpuDeviceSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn popErrorScope(self: Device, callbackInfo: c.WGPUPopErrorScopeCallbackInfo) types.Future {
        const result = c.wgpuDevicePopErrorScope(@ptrCast(self.ptr), callbackInfo);
        return @bitCast(result);
    }

    pub fn getQueue(self: Device) !Queue {
        const result = c.wgpuDeviceGetQueue(@ptrCast(self.ptr));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn getLostFuture(self: Device) types.Future {
        const result = c.wgpuDeviceGetLostFuture(@ptrCast(self.ptr));
        return @bitCast(result);
    }

    pub fn createCommandEncoder(self: Device, descriptor: ?*const types.CommandEncoderDescriptor) !CommandEncoder {
        const result = c.wgpuDeviceCreateCommandEncoder(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn createBindGroupLayout(self: Device, descriptor: ?*const types.BindGroupLayoutDescriptor) !BindGroupLayout {
        const result = c.wgpuDeviceCreateBindGroupLayout(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn getLimits(self: Device) !c.WGPULimits {
        var result: c.WGPULimits = undefined;
        const status = c.wgpuDeviceGetLimits(@ptrCast(self.ptr), @ptrCast(&result));
        if (status != 1) return error.Unexpected;
        return result;
    }

    pub fn stopGraphicsDebuggerCapture(self: Device) void {
        c.wgpuDeviceStopGraphicsDebuggerCapture(@ptrCast(self.ptr));
    }

    pub fn getFeatures(self: Device, features: ?*types.SupportedFeatures) void {
        c.wgpuDeviceGetFeatures(@ptrCast(self.ptr), @ptrCast(features));
    }

    pub fn pushErrorScope(self: Device, filter: types.ErrorFilter) void {
        c.wgpuDevicePushErrorScope(@ptrCast(self.ptr), @intFromEnum(filter));
    }

    pub fn createComputePipeline(self: Device, descriptor: ?*const types.ComputePipelineDescriptor) !ComputePipeline {
        const result = c.wgpuDeviceCreateComputePipeline(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn createQuerySet(self: Device, descriptor: ?*const types.QuerySetDescriptor) !QuerySet {
        const result = c.wgpuDeviceCreateQuerySet(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

};

pub const OptionalDevice = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: Device) OptionalDevice {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalDevice {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalDevice) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalDevice) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalDevice) ?Device {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalDevice) Device {
        return .{ .ptr = self.ptr.? };
    }
};

pub const ExternalTexture = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) ExternalTexture {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: ExternalTexture, label: c.WGPUStringView) void {
        c.wgpuExternalTextureSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const OptionalExternalTexture = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: ExternalTexture) OptionalExternalTexture {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalExternalTexture {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalExternalTexture) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalExternalTexture) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalExternalTexture) ?ExternalTexture {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalExternalTexture) ExternalTexture {
        return .{ .ptr = self.ptr.? };
    }
};

pub const Instance = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Instance {
        return .{ .ptr = ptr };
    }

    pub fn enumerateAdapters(self: Instance, options: ?*const types.InstanceEnumerateAdapterOptions, adapters: ?*Adapter) usize {
        return c.wgpuInstanceEnumerateAdapters(@ptrCast(self.ptr), @ptrCast(options), @ptrCast(adapters));
    }

    pub fn createSurface(self: Instance, descriptor: ?*const types.SurfaceDescriptor) !Surface {
        const result = c.wgpuInstanceCreateSurface(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn requestAdapter(self: Instance, options: ?*const types.RequestAdapterOptions, callbackInfo: c.WGPURequestAdapterCallbackInfo) types.Future {
        const result = c.wgpuInstanceRequestAdapter(@ptrCast(self.ptr), @ptrCast(options), callbackInfo);
        return @bitCast(result);
    }

    pub fn getWGSLLanguageFeatures(self: Instance, features: ?*types.SupportedWGSLLanguageFeatures) void {
        c.wgpuInstanceGetWGSLLanguageFeatures(@ptrCast(self.ptr), @ptrCast(features));
    }

    pub fn generateReport(self: Instance, report: ?*types.GlobalReport) void {
        c.wgpuGenerateReport(@ptrCast(self.ptr), @ptrCast(report));
    }

    pub fn hasWGSLLanguageFeature(self: Instance, feature: types.WGSLLanguageFeatureName) c_int {
        return c.wgpuInstanceHasWGSLLanguageFeature(@ptrCast(self.ptr), @intFromEnum(feature));
    }

    pub fn processEvents(self: Instance) void {
        c.wgpuInstanceProcessEvents(@ptrCast(self.ptr));
    }

    pub fn waitAny(self: Instance, futureCount: usize, futures: ?*types.FutureWaitInfo, timeoutNS: u64) types.WaitStatus {
        return c.wgpuInstanceWaitAny(@ptrCast(self.ptr), futureCount, @ptrCast(futures), timeoutNS);
    }

};

pub const OptionalInstance = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: Instance) OptionalInstance {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalInstance {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalInstance) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalInstance) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalInstance) ?Instance {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalInstance) Instance {
        return .{ .ptr = self.ptr.? };
    }
};

pub const PipelineLayout = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) PipelineLayout {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: PipelineLayout, label: c.WGPUStringView) void {
        c.wgpuPipelineLayoutSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const OptionalPipelineLayout = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: PipelineLayout) OptionalPipelineLayout {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalPipelineLayout {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalPipelineLayout) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalPipelineLayout) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalPipelineLayout) ?PipelineLayout {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalPipelineLayout) PipelineLayout {
        return .{ .ptr = self.ptr.? };
    }
};

pub const QuerySet = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) QuerySet {
        return .{ .ptr = ptr };
    }

    pub fn getCount(self: QuerySet) u32 {
        return c.wgpuQuerySetGetCount(@ptrCast(self.ptr));
    }

    pub fn getType(self: QuerySet) types.QueryType {
        return c.wgpuQuerySetGetType(@ptrCast(self.ptr));
    }

    pub fn destroy(self: QuerySet) void {
        c.wgpuQuerySetDestroy(@ptrCast(self.ptr));
    }

    pub fn setLabel(self: QuerySet, label: c.WGPUStringView) void {
        c.wgpuQuerySetSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const OptionalQuerySet = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: QuerySet) OptionalQuerySet {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalQuerySet {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalQuerySet) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalQuerySet) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalQuerySet) ?QuerySet {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalQuerySet) QuerySet {
        return .{ .ptr = self.ptr.? };
    }
};

pub const Queue = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Queue {
        return .{ .ptr = ptr };
    }

    pub fn writeTexture(self: Queue, destination: ?*const types.TexelCopyTextureInfo, data: ?*const anyopaque, dataSize: usize, dataLayout: ?*const types.TexelCopyBufferLayout, writeSize: ?*const types.Extent3D) void {
        c.wgpuQueueWriteTexture(@ptrCast(self.ptr), @ptrCast(destination), data, dataSize, @ptrCast(dataLayout), @ptrCast(writeSize));
    }

    pub fn onSubmittedWorkDone(self: Queue, callbackInfo: c.WGPUQueueWorkDoneCallbackInfo) types.Future {
        const result = c.wgpuQueueOnSubmittedWorkDone(@ptrCast(self.ptr), callbackInfo);
        return @bitCast(result);
    }

    pub fn getNativeMetalCommandQueue(self: Queue) ?*anyopaque {
        return c.wgpuQueueGetNativeMetalCommandQueue(@ptrCast(self.ptr));
    }

    pub fn setLabel(self: Queue, label: c.WGPUStringView) void {
        c.wgpuQueueSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn writeBuffer(self: Queue, buffer: Buffer, bufferOffset: u64, data: ?*const anyopaque, size: usize) void {
        c.wgpuQueueWriteBuffer(@ptrCast(self.ptr), @ptrCast(buffer.ptr), bufferOffset, data, size);
    }

    pub fn getTimestampPeriod(self: Queue) f32 {
        return c.wgpuQueueGetTimestampPeriod(@ptrCast(self.ptr));
    }

    pub fn submit(self: Queue, commandCount: usize, commands: ?*const CommandBuffer) void {
        c.wgpuQueueSubmit(@ptrCast(self.ptr), commandCount, @ptrCast(commands));
    }

    pub fn submitForIndex(self: Queue, commandCount: usize, commands: ?*const CommandBuffer) types.SubmissionIndex {
        const result = c.wgpuQueueSubmitForIndex(@ptrCast(self.ptr), commandCount, @ptrCast(commands));
        return @bitCast(result);
    }

};

pub const OptionalQueue = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: Queue) OptionalQueue {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalQueue {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalQueue) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalQueue) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalQueue) ?Queue {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalQueue) Queue {
        return .{ .ptr = self.ptr.? };
    }
};

pub const RenderBundle = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) RenderBundle {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: RenderBundle, label: c.WGPUStringView) void {
        c.wgpuRenderBundleSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const OptionalRenderBundle = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: RenderBundle) OptionalRenderBundle {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalRenderBundle {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalRenderBundle) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalRenderBundle) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalRenderBundle) ?RenderBundle {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalRenderBundle) RenderBundle {
        return .{ .ptr = self.ptr.? };
    }
};

pub const RenderBundleEncoder = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) RenderBundleEncoder {
        return .{ .ptr = ptr };
    }

    pub fn draw(self: RenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) void {
        c.wgpuRenderBundleEncoderDraw(@ptrCast(self.ptr), vertexCount, instanceCount, firstVertex, firstInstance);
    }

    pub fn insertDebugMarker(self: RenderBundleEncoder, markerLabel: c.WGPUStringView) void {
        c.wgpuRenderBundleEncoderInsertDebugMarker(@ptrCast(self.ptr), markerLabel);
    }

    pub fn pushDebugGroup(self: RenderBundleEncoder, groupLabel: c.WGPUStringView) void {
        c.wgpuRenderBundleEncoderPushDebugGroup(@ptrCast(self.ptr), groupLabel);
    }

    pub fn setLabel(self: RenderBundleEncoder, label: c.WGPUStringView) void {
        c.wgpuRenderBundleEncoderSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn finish(self: RenderBundleEncoder, descriptor: ?*const types.RenderBundleDescriptor) !RenderBundle {
        const result = c.wgpuRenderBundleEncoderFinish(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn drawIndirect(self: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) void {
        c.wgpuRenderBundleEncoderDrawIndirect(@ptrCast(self.ptr), @ptrCast(indirectBuffer.ptr), indirectOffset);
    }

    pub fn setPipeline(self: RenderBundleEncoder, pipeline: RenderPipeline) void {
        c.wgpuRenderBundleEncoderSetPipeline(@ptrCast(self.ptr), @ptrCast(pipeline.ptr));
    }

    pub fn setIndexBuffer(self: RenderBundleEncoder, buffer: Buffer, format: types.IndexFormat, offset: u64, size: u64) void {
        c.wgpuRenderBundleEncoderSetIndexBuffer(@ptrCast(self.ptr), @ptrCast(buffer.ptr), @intFromEnum(format), offset, size);
    }

    pub fn drawIndexed(self: RenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void {
        c.wgpuRenderBundleEncoderDrawIndexed(@ptrCast(self.ptr), indexCount, instanceCount, firstIndex, baseVertex, firstInstance);
    }

    pub fn setVertexBuffer(self: RenderBundleEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) void {
        c.wgpuRenderBundleEncoderSetVertexBuffer(@ptrCast(self.ptr), slot, @ptrCast(buffer.ptr), offset, size);
    }

    pub fn popDebugGroup(self: RenderBundleEncoder) void {
        c.wgpuRenderBundleEncoderPopDebugGroup(@ptrCast(self.ptr));
    }

    pub fn drawIndexedIndirect(self: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) void {
        c.wgpuRenderBundleEncoderDrawIndexedIndirect(@ptrCast(self.ptr), @ptrCast(indirectBuffer.ptr), indirectOffset);
    }

    pub fn setImmediates(self: RenderBundleEncoder, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void {
        c.wgpuRenderBundleEncoderSetImmediates(@ptrCast(self.ptr), offset, sizeBytes, data);
    }

    pub fn setBindGroup(self: RenderBundleEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: usize, dynamicOffsets: ?*const u32) void {
        c.wgpuRenderBundleEncoderSetBindGroup(@ptrCast(self.ptr), groupIndex, @ptrCast(group.ptr), dynamicOffsetCount, dynamicOffsets);
    }

};

pub const OptionalRenderBundleEncoder = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: RenderBundleEncoder) OptionalRenderBundleEncoder {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalRenderBundleEncoder {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalRenderBundleEncoder) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalRenderBundleEncoder) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalRenderBundleEncoder) ?RenderBundleEncoder {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalRenderBundleEncoder) RenderBundleEncoder {
        return .{ .ptr = self.ptr.? };
    }
};

pub const RenderPassEncoder = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) RenderPassEncoder {
        return .{ .ptr = ptr };
    }

    pub fn multiDrawIndexedIndirectCount(self: RenderPassEncoder, buffer: Buffer, offset: u64, count_buffer: Buffer, count_buffer_offset: u64, max_count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndexedIndirectCount(@ptrCast(self.ptr), @ptrCast(buffer.ptr), offset, @ptrCast(count_buffer.ptr), count_buffer_offset, max_count);
    }

    pub fn setBindGroup(self: RenderPassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: usize, dynamicOffsets: ?*const u32) void {
        c.wgpuRenderPassEncoderSetBindGroup(@ptrCast(self.ptr), groupIndex, @ptrCast(group.ptr), dynamicOffsetCount, dynamicOffsets);
    }

    pub fn popDebugGroup(self: RenderPassEncoder) void {
        c.wgpuRenderPassEncoderPopDebugGroup(@ptrCast(self.ptr));
    }

    pub fn setVertexBuffer(self: RenderPassEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) void {
        c.wgpuRenderPassEncoderSetVertexBuffer(@ptrCast(self.ptr), slot, @ptrCast(buffer.ptr), offset, size);
    }

    pub fn multiDrawIndirect(self: RenderPassEncoder, buffer: Buffer, offset: u64, count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndirect(@ptrCast(self.ptr), @ptrCast(buffer.ptr), offset, count);
    }

    pub fn insertDebugMarker(self: RenderPassEncoder, markerLabel: c.WGPUStringView) void {
        c.wgpuRenderPassEncoderInsertDebugMarker(@ptrCast(self.ptr), markerLabel);
    }

    pub fn multiDrawIndexedIndirect(self: RenderPassEncoder, buffer: Buffer, offset: u64, count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndexedIndirect(@ptrCast(self.ptr), @ptrCast(buffer.ptr), offset, count);
    }

    pub fn setImmediates(self: RenderPassEncoder, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void {
        c.wgpuRenderPassEncoderSetImmediates(@ptrCast(self.ptr), offset, sizeBytes, data);
    }

    pub fn setStencilReference(self: RenderPassEncoder, reference: u32) void {
        c.wgpuRenderPassEncoderSetStencilReference(@ptrCast(self.ptr), reference);
    }

    pub fn beginPipelineStatisticsQuery(self: RenderPassEncoder, querySet: QuerySet, queryIndex: u32) void {
        c.wgpuRenderPassEncoderBeginPipelineStatisticsQuery(@ptrCast(self.ptr), @ptrCast(querySet.ptr), queryIndex);
    }

    pub fn setViewport(self: RenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) void {
        c.wgpuRenderPassEncoderSetViewport(@ptrCast(self.ptr), x, y, width, height, minDepth, maxDepth);
    }

    pub fn setBlendConstant(self: RenderPassEncoder, color: ?*const types.Color) void {
        c.wgpuRenderPassEncoderSetBlendConstant(@ptrCast(self.ptr), @ptrCast(color));
    }

    pub fn drawIndexedIndirect(self: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) void {
        c.wgpuRenderPassEncoderDrawIndexedIndirect(@ptrCast(self.ptr), @ptrCast(indirectBuffer.ptr), indirectOffset);
    }

    pub fn multiDrawIndirectCount(self: RenderPassEncoder, buffer: Buffer, offset: u64, count_buffer: Buffer, count_buffer_offset: u64, max_count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndirectCount(@ptrCast(self.ptr), @ptrCast(buffer.ptr), offset, @ptrCast(count_buffer.ptr), count_buffer_offset, max_count);
    }

    pub fn executeBundles(self: RenderPassEncoder, bundleCount: usize, bundles: ?*const RenderBundle) void {
        c.wgpuRenderPassEncoderExecuteBundles(@ptrCast(self.ptr), bundleCount, @ptrCast(bundles));
    }

    pub fn beginOcclusionQuery(self: RenderPassEncoder, queryIndex: u32) void {
        c.wgpuRenderPassEncoderBeginOcclusionQuery(@ptrCast(self.ptr), queryIndex);
    }

    pub fn endOcclusionQuery(self: RenderPassEncoder) void {
        c.wgpuRenderPassEncoderEndOcclusionQuery(@ptrCast(self.ptr));
    }

    pub fn writeTimestamp(self: RenderPassEncoder, querySet: QuerySet, queryIndex: u32) void {
        c.wgpuRenderPassEncoderWriteTimestamp(@ptrCast(self.ptr), @ptrCast(querySet.ptr), queryIndex);
    }

    pub fn setLabel(self: RenderPassEncoder, label: c.WGPUStringView) void {
        c.wgpuRenderPassEncoderSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn drawIndexed(self: RenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void {
        c.wgpuRenderPassEncoderDrawIndexed(@ptrCast(self.ptr), indexCount, instanceCount, firstIndex, baseVertex, firstInstance);
    }

    pub fn endPipelineStatisticsQuery(self: RenderPassEncoder) void {
        c.wgpuRenderPassEncoderEndPipelineStatisticsQuery(@ptrCast(self.ptr));
    }

    pub fn drawIndirect(self: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) void {
        c.wgpuRenderPassEncoderDrawIndirect(@ptrCast(self.ptr), @ptrCast(indirectBuffer.ptr), indirectOffset);
    }

    pub fn setIndexBuffer(self: RenderPassEncoder, buffer: Buffer, format: types.IndexFormat, offset: u64, size: u64) void {
        c.wgpuRenderPassEncoderSetIndexBuffer(@ptrCast(self.ptr), @ptrCast(buffer.ptr), @intFromEnum(format), offset, size);
    }

    pub fn draw(self: RenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) void {
        c.wgpuRenderPassEncoderDraw(@ptrCast(self.ptr), vertexCount, instanceCount, firstVertex, firstInstance);
    }

    pub fn pushDebugGroup(self: RenderPassEncoder, groupLabel: c.WGPUStringView) void {
        c.wgpuRenderPassEncoderPushDebugGroup(@ptrCast(self.ptr), groupLabel);
    }

    pub fn setScissorRect(self: RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) void {
        c.wgpuRenderPassEncoderSetScissorRect(@ptrCast(self.ptr), x, y, width, height);
    }

    pub fn end(self: RenderPassEncoder) void {
        c.wgpuRenderPassEncoderEnd(@ptrCast(self.ptr));
    }

    pub fn setPipeline(self: RenderPassEncoder, pipeline: RenderPipeline) void {
        c.wgpuRenderPassEncoderSetPipeline(@ptrCast(self.ptr), @ptrCast(pipeline.ptr));
    }

};

pub const OptionalRenderPassEncoder = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: RenderPassEncoder) OptionalRenderPassEncoder {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalRenderPassEncoder {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalRenderPassEncoder) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalRenderPassEncoder) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalRenderPassEncoder) ?RenderPassEncoder {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalRenderPassEncoder) RenderPassEncoder {
        return .{ .ptr = self.ptr.? };
    }
};

pub const RenderPipeline = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) RenderPipeline {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: RenderPipeline, label: c.WGPUStringView) void {
        c.wgpuRenderPipelineSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn getBindGroupLayout(self: RenderPipeline, groupIndex: u32) !BindGroupLayout {
        const result = c.wgpuRenderPipelineGetBindGroupLayout(@ptrCast(self.ptr), groupIndex);
        return .{ .ptr = @ptrCast(result.?) };
    }

};

pub const OptionalRenderPipeline = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: RenderPipeline) OptionalRenderPipeline {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalRenderPipeline {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalRenderPipeline) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalRenderPipeline) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalRenderPipeline) ?RenderPipeline {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalRenderPipeline) RenderPipeline {
        return .{ .ptr = self.ptr.? };
    }
};

pub const Sampler = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Sampler {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: Sampler, label: c.WGPUStringView) void {
        c.wgpuSamplerSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const OptionalSampler = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: Sampler) OptionalSampler {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalSampler {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalSampler) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalSampler) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalSampler) ?Sampler {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalSampler) Sampler {
        return .{ .ptr = self.ptr.? };
    }
};

pub const ShaderModule = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) ShaderModule {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: ShaderModule, label: c.WGPUStringView) void {
        c.wgpuShaderModuleSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn getCompilationInfo(self: ShaderModule, callbackInfo: c.WGPUCompilationInfoCallbackInfo) types.Future {
        const result = c.wgpuShaderModuleGetCompilationInfo(@ptrCast(self.ptr), callbackInfo);
        return @bitCast(result);
    }

};

pub const OptionalShaderModule = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: ShaderModule) OptionalShaderModule {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalShaderModule {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalShaderModule) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalShaderModule) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalShaderModule) ?ShaderModule {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalShaderModule) ShaderModule {
        return .{ .ptr = self.ptr.? };
    }
};

pub const Surface = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Surface {
        return .{ .ptr = ptr };
    }

    pub fn configure(self: Surface, config: ?*const types.SurfaceConfiguration) void {
        c.wgpuSurfaceConfigure(@ptrCast(self.ptr), @ptrCast(config));
    }

    pub fn present(self: Surface) !void {
        const status = c.wgpuSurfacePresent(@ptrCast(self.ptr));
        if (status != 1) return error.Unexpected;
    }

    pub fn unconfigure(self: Surface) void {
        c.wgpuSurfaceUnconfigure(@ptrCast(self.ptr));
    }

    pub fn getCapabilities(self: Surface, adapter: Adapter) !c.WGPUSurfaceCapabilities {
        var result: c.WGPUSurfaceCapabilities = undefined;
        const status = c.wgpuSurfaceGetCapabilities(@ptrCast(self.ptr), @ptrCast(adapter.ptr), @ptrCast(&result));
        if (status != 1) return error.Unexpected;
        return result;
    }

    pub fn getCurrentTexture(self: Surface, surfaceTexture: ?*types.SurfaceTexture) void {
        c.wgpuSurfaceGetCurrentTexture(@ptrCast(self.ptr), @ptrCast(surfaceTexture));
    }

    pub fn setLabel(self: Surface, label: c.WGPUStringView) void {
        c.wgpuSurfaceSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const OptionalSurface = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: Surface) OptionalSurface {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalSurface {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalSurface) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalSurface) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalSurface) ?Surface {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalSurface) Surface {
        return .{ .ptr = self.ptr.? };
    }
};

pub const Texture = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Texture {
        return .{ .ptr = ptr };
    }

    pub fn getTextureBindingViewDimension(self: Texture) types.TextureViewDimension {
        return c.wgpuTextureGetTextureBindingViewDimension(@ptrCast(self.ptr));
    }

    pub fn getSampleCount(self: Texture) u32 {
        return c.wgpuTextureGetSampleCount(@ptrCast(self.ptr));
    }

    pub fn getFormat(self: Texture) types.TextureFormat {
        return c.wgpuTextureGetFormat(@ptrCast(self.ptr));
    }

    pub fn createView(self: Texture, descriptor: ?*const types.TextureViewDescriptor) !TextureView {
        const result = c.wgpuTextureCreateView(@ptrCast(self.ptr), @ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
    }

    pub fn getDimension(self: Texture) types.TextureDimension {
        return c.wgpuTextureGetDimension(@ptrCast(self.ptr));
    }

    pub fn getMipLevelCount(self: Texture) u32 {
        return c.wgpuTextureGetMipLevelCount(@ptrCast(self.ptr));
    }

    pub fn destroy(self: Texture) void {
        c.wgpuTextureDestroy(@ptrCast(self.ptr));
    }

    pub fn getDepthOrArrayLayers(self: Texture) u32 {
        return c.wgpuTextureGetDepthOrArrayLayers(@ptrCast(self.ptr));
    }

    pub fn getWidth(self: Texture) u32 {
        return c.wgpuTextureGetWidth(@ptrCast(self.ptr));
    }

    pub fn getUsage(self: Texture) types.TextureUsage {
        return c.wgpuTextureGetUsage(@ptrCast(self.ptr));
    }

    pub fn setLabel(self: Texture, label: c.WGPUStringView) void {
        c.wgpuTextureSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn getNativeMetalTexture(self: Texture) ?*anyopaque {
        return c.wgpuTextureGetNativeMetalTexture(@ptrCast(self.ptr));
    }

    pub fn getHeight(self: Texture) u32 {
        return c.wgpuTextureGetHeight(@ptrCast(self.ptr));
    }

};

pub const OptionalTexture = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: Texture) OptionalTexture {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalTexture {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalTexture) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalTexture) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalTexture) ?Texture {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalTexture) Texture {
        return .{ .ptr = self.ptr.? };
    }
};

pub const TextureView = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) TextureView {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: TextureView, label: c.WGPUStringView) void {
        c.wgpuTextureViewSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const OptionalTextureView = extern struct {
    ptr: ?*anyopaque,

    pub fn wrap(handle: TextureView) OptionalTextureView {
        return .{ .ptr = handle.ptr };
    }

    pub fn none() OptionalTextureView {
        return .{ .ptr = null };
    }

    pub fn isSome(self: OptionalTextureView) bool {
        return self.ptr != null;
    }

    pub fn isNull(self: OptionalTextureView) bool {
        return self.ptr == null;
    }

    pub fn get(self: OptionalTextureView) ?TextureView {
        if (self.ptr) |p| return .{ .ptr = p };
        return null;
    }

    pub fn unwrap(self: OptionalTextureView) TextureView {
        return .{ .ptr = self.ptr.? };
    }
};

pub fn getInstanceFeatures(features: ?*types.SupportedInstanceFeatures) void {
        c.wgpuGetInstanceFeatures(@ptrCast(features));
}

pub fn supportedFeaturesFreeMembers(supportedFeatures: c.WGPUSupportedFeatures) void {
        c.wgpuSupportedFeaturesFreeMembers(supportedFeatures);
}

pub fn surfaceCapabilitiesFreeMembers(surfaceCapabilities: c.WGPUSurfaceCapabilities) void {
        c.wgpuSurfaceCapabilitiesFreeMembers(surfaceCapabilities);
}

pub fn getProcAddress(procName: c.WGPUStringView) c.WGPUProc {
        return c.wgpuGetProcAddress(procName);
}

pub fn setLogCallback(callback: c.WGPULogCallback, userdata: ?*anyopaque) void {
        c.wgpuSetLogCallback(callback, userdata);
}

pub fn adapterInfoFreeMembers(adapterInfo: c.WGPUAdapterInfo) void {
        c.wgpuAdapterInfoFreeMembers(adapterInfo);
}

pub fn createInstance(descriptor: ?*const types.InstanceDescriptor) !Instance {
        const result = c.wgpuCreateInstance(@ptrCast(descriptor));
        return .{ .ptr = @ptrCast(result.?) };
}

pub fn supportedInstanceFeaturesFreeMembers(supportedInstanceFeatures: c.WGPUSupportedInstanceFeatures) void {
        c.wgpuSupportedInstanceFeaturesFreeMembers(supportedInstanceFeatures);
}

pub fn supportedWGSLLanguageFeaturesFreeMembers(supportedWGSLLanguageFeatures: c.WGPUSupportedWGSLLanguageFeatures) void {
        c.wgpuSupportedWGSLLanguageFeaturesFreeMembers(supportedWGSLLanguageFeatures);
}

pub fn getInstanceLimits() !c.WGPUInstanceLimits {
        var result: types.InstanceLimits = undefined;
        const status = c.wgpuGetInstanceLimits(&result);
        if (status != 1) return error.Unexpected;
        return result;
}

pub fn getVersion() u32 {
        return c.wgpuGetVersion();
}

pub fn setLogLevel(level: types.LogLevel) void {
        c.wgpuSetLogLevel(@intFromEnum(level));
}

pub fn hasInstanceFeature(feature: types.InstanceFeatureName) c_int {
        return c.wgpuHasInstanceFeature(@intFromEnum(feature));
}

/// Wait for one or more futures to complete.
/// Returns the number of completed futures, or an error on timeout.
pub fn waitAny(instance: Instance, futures: []c.WGPUFutureWaitInfo, timeout_ns: u64) !usize {
    const status = c.wgpuInstanceWaitAny(@ptrCast(instance.ptr), futures.len, futures.ptr, timeout_ns);
    if (status == c.WGPUWaitStatus_Success) return futures.len;
    if (status == c.WGPUWaitStatus_TimedOut) return error.Timeout;
    return error.Unexpected;
}
