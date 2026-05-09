const c = @import("c_wgpu_native");
const types = @import("types.zig");

pub const Adapter = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Adapter {
        return .{ .ptr = ptr };
    }

    pub fn getInfo(self: Adapter) !c.WGPUAdapterInfo {
        var result: c.WGPUAdapterInfo = undefined;
        const status = c.wgpuAdapterGetInfo(@ptrCast(self.ptr), &result);
        if (status != 1) return error.Unexpected;
        return result;
    }

    pub fn getLimits(self: Adapter) !c.WGPULimits {
        var result: c.WGPULimits = undefined;
        const status = c.wgpuAdapterGetLimits(@ptrCast(self.ptr), &result);
        if (status != 1) return error.Unexpected;
        return result;
    }

    pub fn hasFeature(self: Adapter, feature: c.WGPUFeatureName) bool {
        return c.wgpuAdapterHasFeature(@ptrCast(self.ptr), feature);
    }

    pub fn getFeatures(self: Adapter, features: ?*c.WGPUSupportedFeatures) void {
        c.wgpuAdapterGetFeatures(@ptrCast(self.ptr), features);
    }

    pub fn requestDevice(self: Adapter, descriptor: ?*const c.WGPUDeviceDescriptor, callbackInfo: c.WGPURequestDeviceCallbackInfo) c.WGPUFuture {
        return c.wgpuAdapterRequestDevice(@ptrCast(self.ptr), descriptor, callbackInfo);
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

pub const BindGroupLayout = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) BindGroupLayout {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: BindGroupLayout, label: c.WGPUStringView) void {
        c.wgpuBindGroupLayoutSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const Buffer = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Buffer {
        return .{ .ptr = ptr };
    }

    pub fn getMapState(self: Buffer) c.WGPUBufferMapState {
        return c.wgpuBufferGetMapState(@ptrCast(self.ptr));
    }

    pub fn destroy(self: Buffer) void {
        c.wgpuBufferDestroy(@ptrCast(self.ptr));
    }

    pub fn mapAsync(self: Buffer, mode: c.WGPUMapMode, offset: usize, size: usize, callbackInfo: c.WGPUBufferMapCallbackInfo) c.WGPUFuture {
        return c.wgpuBufferMapAsync(@ptrCast(self.ptr), mode, offset, size, callbackInfo);
    }

    pub fn getSize(self: Buffer) u64 {
        return c.wgpuBufferGetSize(@ptrCast(self.ptr));
    }

    pub fn getConstMappedRange(self: Buffer, offset: usize, size: usize) ?*const anyopaque {
        return c.wgpuBufferGetConstMappedRange(@ptrCast(self.ptr), offset, size);
    }

    pub fn getUsage(self: Buffer) c.WGPUBufferUsage {
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

pub const CommandBuffer = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) CommandBuffer {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: CommandBuffer, label: c.WGPUStringView) void {
        c.wgpuCommandBufferSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const CommandEncoder = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) CommandEncoder {
        return .{ .ptr = ptr };
    }

    pub fn copyTextureToTexture(self: CommandEncoder, source: ?*const c.WGPUTexelCopyTextureInfo, destination: ?*const c.WGPUTexelCopyTextureInfo, copySize: ?*const c.WGPUExtent3D) void {
        c.wgpuCommandEncoderCopyTextureToTexture(@ptrCast(self.ptr), source, destination, copySize);
    }

    pub fn copyBufferToTexture(self: CommandEncoder, source: ?*const c.WGPUTexelCopyBufferInfo, destination: ?*const c.WGPUTexelCopyTextureInfo, copySize: ?*const c.WGPUExtent3D) void {
        c.wgpuCommandEncoderCopyBufferToTexture(@ptrCast(self.ptr), source, destination, copySize);
    }

    pub fn beginComputePass(self: CommandEncoder, descriptor: ?*const c.WGPUComputePassDescriptor) c.WGPUComputePassEncoder {
        const result = c.wgpuCommandEncoderBeginComputePass(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn copyTextureToBuffer(self: CommandEncoder, source: ?*const c.WGPUTexelCopyTextureInfo, destination: ?*const c.WGPUTexelCopyBufferInfo, copySize: ?*const c.WGPUExtent3D) void {
        c.wgpuCommandEncoderCopyTextureToBuffer(@ptrCast(self.ptr), source, destination, copySize);
    }

    pub fn pushDebugGroup(self: CommandEncoder, groupLabel: c.WGPUStringView) void {
        c.wgpuCommandEncoderPushDebugGroup(@ptrCast(self.ptr), groupLabel);
    }

    pub fn copyBufferToBuffer(self: CommandEncoder, source: c.WGPUBuffer, sourceOffset: u64, destination: c.WGPUBuffer, destinationOffset: u64, size: u64) void {
        c.wgpuCommandEncoderCopyBufferToBuffer(@ptrCast(self.ptr), source, sourceOffset, destination, destinationOffset, size);
    }

    pub fn resolveQuerySet(self: CommandEncoder, querySet: c.WGPUQuerySet, firstQuery: u32, queryCount: u32, destination: c.WGPUBuffer, destinationOffset: u64) void {
        c.wgpuCommandEncoderResolveQuerySet(@ptrCast(self.ptr), querySet, firstQuery, queryCount, destination, destinationOffset);
    }

    pub fn popDebugGroup(self: CommandEncoder) void {
        c.wgpuCommandEncoderPopDebugGroup(@ptrCast(self.ptr));
    }

    pub fn beginRenderPass(self: CommandEncoder, descriptor: ?*const c.WGPURenderPassDescriptor) c.WGPURenderPassEncoder {
        const result = c.wgpuCommandEncoderBeginRenderPass(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn finish(self: CommandEncoder, descriptor: ?*const c.WGPUCommandBufferDescriptor) c.WGPUCommandBuffer {
        const result = c.wgpuCommandEncoderFinish(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn setLabel(self: CommandEncoder, label: c.WGPUStringView) void {
        c.wgpuCommandEncoderSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn insertDebugMarker(self: CommandEncoder, markerLabel: c.WGPUStringView) void {
        c.wgpuCommandEncoderInsertDebugMarker(@ptrCast(self.ptr), markerLabel);
    }

    pub fn writeTimestamp(self: CommandEncoder, querySet: c.WGPUQuerySet, queryIndex: u32) void {
        c.wgpuCommandEncoderWriteTimestamp(@ptrCast(self.ptr), querySet, queryIndex);
    }

    pub fn clearBuffer(self: CommandEncoder, buffer: c.WGPUBuffer, offset: u64, size: u64) void {
        c.wgpuCommandEncoderClearBuffer(@ptrCast(self.ptr), buffer, offset, size);
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

    pub fn setPipeline(self: ComputePassEncoder, pipeline: c.WGPUComputePipeline) void {
        c.wgpuComputePassEncoderSetPipeline(@ptrCast(self.ptr), pipeline);
    }

    pub fn setBindGroup(self: ComputePassEncoder, groupIndex: u32, group: c.WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: ?*const u32) void {
        c.wgpuComputePassEncoderSetBindGroup(@ptrCast(self.ptr), groupIndex, group, dynamicOffsetCount, dynamicOffsets);
    }

    pub fn popDebugGroup(self: ComputePassEncoder) void {
        c.wgpuComputePassEncoderPopDebugGroup(@ptrCast(self.ptr));
    }

    pub fn endPipelineStatisticsQuery(self: ComputePassEncoder) void {
        c.wgpuComputePassEncoderEndPipelineStatisticsQuery(@ptrCast(self.ptr));
    }

    pub fn writeTimestamp(self: ComputePassEncoder, querySet: c.WGPUQuerySet, queryIndex: u32) void {
        c.wgpuComputePassEncoderWriteTimestamp(@ptrCast(self.ptr), querySet, queryIndex);
    }

    pub fn insertDebugMarker(self: ComputePassEncoder, markerLabel: c.WGPUStringView) void {
        c.wgpuComputePassEncoderInsertDebugMarker(@ptrCast(self.ptr), markerLabel);
    }

    pub fn dispatchWorkgroupsIndirect(self: ComputePassEncoder, indirectBuffer: c.WGPUBuffer, indirectOffset: u64) void {
        c.wgpuComputePassEncoderDispatchWorkgroupsIndirect(@ptrCast(self.ptr), indirectBuffer, indirectOffset);
    }

    pub fn setPushConstants(self: ComputePassEncoder, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void {
        c.wgpuComputePassEncoderSetPushConstants(@ptrCast(self.ptr), offset, sizeBytes, data);
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

    pub fn beginPipelineStatisticsQuery(self: ComputePassEncoder, querySet: c.WGPUQuerySet, queryIndex: u32) void {
        c.wgpuComputePassEncoderBeginPipelineStatisticsQuery(@ptrCast(self.ptr), querySet, queryIndex);
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

    pub fn getBindGroupLayout(self: ComputePipeline, groupIndex: u32) c.WGPUBindGroupLayout {
        const result = c.wgpuComputePipelineGetBindGroupLayout(@ptrCast(self.ptr), groupIndex);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

};

pub const Device = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Device {
        return .{ .ptr = ptr };
    }

    pub fn createTexture(self: Device, descriptor: ?*const c.WGPUTextureDescriptor) c.WGPUTexture {
        const result = c.wgpuDeviceCreateTexture(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn hasFeature(self: Device, feature: c.WGPUFeatureName) bool {
        return c.wgpuDeviceHasFeature(@ptrCast(self.ptr), feature);
    }

    pub fn createBindGroup(self: Device, descriptor: ?*const c.WGPUBindGroupDescriptor) c.WGPUBindGroup {
        const result = c.wgpuDeviceCreateBindGroup(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn createBuffer(self: Device, descriptor: ?*const c.WGPUBufferDescriptor) c.WGPUBuffer {
        const result = c.wgpuDeviceCreateBuffer(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn createShaderModuleSpirV(self: Device, descriptor: ?*const c.WGPUShaderModuleDescriptorSpirV) c.WGPUShaderModule {
        const result = c.wgpuDeviceCreateShaderModuleSpirV(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn createRenderPipeline(self: Device, descriptor: ?*const c.WGPURenderPipelineDescriptor) c.WGPURenderPipeline {
        const result = c.wgpuDeviceCreateRenderPipeline(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn createShaderModule(self: Device, descriptor: ?*const c.WGPUShaderModuleDescriptor) c.WGPUShaderModule {
        const result = c.wgpuDeviceCreateShaderModule(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn poll(self: Device, wait: bool, submissionIndex: ?*const c.WGPUSubmissionIndex) bool {
        return c.wgpuDevicePoll(@ptrCast(self.ptr), wait, submissionIndex);
    }

    pub fn destroy(self: Device) void {
        c.wgpuDeviceDestroy(@ptrCast(self.ptr));
    }

    pub fn createComputePipelineAsync(self: Device, descriptor: ?*const c.WGPUComputePipelineDescriptor, callbackInfo: c.WGPUCreateComputePipelineAsyncCallbackInfo) c.WGPUFuture {
        return c.wgpuDeviceCreateComputePipelineAsync(@ptrCast(self.ptr), descriptor, callbackInfo);
    }

    pub fn createPipelineLayout(self: Device, descriptor: ?*const c.WGPUPipelineLayoutDescriptor) c.WGPUPipelineLayout {
        const result = c.wgpuDeviceCreatePipelineLayout(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn createRenderBundleEncoder(self: Device, descriptor: ?*const c.WGPURenderBundleEncoderDescriptor) c.WGPURenderBundleEncoder {
        const result = c.wgpuDeviceCreateRenderBundleEncoder(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn createSampler(self: Device, descriptor: ?*const c.WGPUSamplerDescriptor) c.WGPUSampler {
        const result = c.wgpuDeviceCreateSampler(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn getAdapterInfo(self: Device) c.WGPUAdapterInfo {
        return c.wgpuDeviceGetAdapterInfo(@ptrCast(self.ptr));
    }

    pub fn createRenderPipelineAsync(self: Device, descriptor: ?*const c.WGPURenderPipelineDescriptor, callbackInfo: c.WGPUCreateRenderPipelineAsyncCallbackInfo) c.WGPUFuture {
        return c.wgpuDeviceCreateRenderPipelineAsync(@ptrCast(self.ptr), descriptor, callbackInfo);
    }

    pub fn setLabel(self: Device, label: c.WGPUStringView) void {
        c.wgpuDeviceSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn popErrorScope(self: Device, callbackInfo: c.WGPUPopErrorScopeCallbackInfo) c.WGPUFuture {
        return c.wgpuDevicePopErrorScope(@ptrCast(self.ptr), callbackInfo);
    }

    pub fn getQueue(self: Device) c.WGPUQueue {
        const result = c.wgpuDeviceGetQueue(@ptrCast(self.ptr));
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn getLostFuture(self: Device) c.WGPUFuture {
        return c.wgpuDeviceGetLostFuture(@ptrCast(self.ptr));
    }

    pub fn createCommandEncoder(self: Device, descriptor: ?*const c.WGPUCommandEncoderDescriptor) c.WGPUCommandEncoder {
        const result = c.wgpuDeviceCreateCommandEncoder(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn createBindGroupLayout(self: Device, descriptor: ?*const c.WGPUBindGroupLayoutDescriptor) c.WGPUBindGroupLayout {
        const result = c.wgpuDeviceCreateBindGroupLayout(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn getLimits(self: Device) !c.WGPULimits {
        var result: c.WGPULimits = undefined;
        const status = c.wgpuDeviceGetLimits(@ptrCast(self.ptr), &result);
        if (status != 1) return error.Unexpected;
        return result;
    }

    pub fn getFeatures(self: Device, features: ?*c.WGPUSupportedFeatures) void {
        c.wgpuDeviceGetFeatures(@ptrCast(self.ptr), features);
    }

    pub fn pushErrorScope(self: Device, filter: c.WGPUErrorFilter) void {
        c.wgpuDevicePushErrorScope(@ptrCast(self.ptr), filter);
    }

    pub fn createComputePipeline(self: Device, descriptor: ?*const c.WGPUComputePipelineDescriptor) c.WGPUComputePipeline {
        const result = c.wgpuDeviceCreateComputePipeline(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn createQuerySet(self: Device, descriptor: ?*const c.WGPUQuerySetDescriptor) c.WGPUQuerySet {
        const result = c.wgpuDeviceCreateQuerySet(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

};

pub const Instance = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Instance {
        return .{ .ptr = ptr };
    }

    pub fn enumerateAdapters(self: Instance, options: ?*const c.WGPUInstanceEnumerateAdapterOptions, adapters: ?*c.WGPUAdapter) usize {
        return c.wgpuInstanceEnumerateAdapters(@ptrCast(self.ptr), options, adapters);
    }

    pub fn createSurface(self: Instance, descriptor: ?*const c.WGPUSurfaceDescriptor) c.WGPUSurface {
        const result = c.wgpuInstanceCreateSurface(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn requestAdapter(self: Instance, options: ?*const c.WGPURequestAdapterOptions, callbackInfo: c.WGPURequestAdapterCallbackInfo) c.WGPUFuture {
        return c.wgpuInstanceRequestAdapter(@ptrCast(self.ptr), options, callbackInfo);
    }

    pub fn getWGSLLanguageFeatures(self: Instance) !c.WGPUSupportedWGSLLanguageFeatures {
        var result: c.WGPUSupportedWGSLLanguageFeatures = undefined;
        const status = c.wgpuInstanceGetWGSLLanguageFeatures(@ptrCast(self.ptr), &result);
        if (status != 1) return error.Unexpected;
        return result;
    }

    pub fn generateReport(self: Instance, report: ?*c.WGPUGlobalReport) void {
        c.wgpuGenerateReport(@ptrCast(self.ptr), report);
    }

    pub fn hasWGSLLanguageFeature(self: Instance, feature: c.WGPUWGSLLanguageFeatureName) bool {
        return c.wgpuInstanceHasWGSLLanguageFeature(@ptrCast(self.ptr), feature);
    }

    pub fn processEvents(self: Instance) void {
        c.wgpuInstanceProcessEvents(@ptrCast(self.ptr));
    }

    pub fn waitAny(self: Instance, futureCount: usize, futures: ?*c.WGPUFutureWaitInfo, timeoutNS: u64) c.WGPUWaitStatus {
        return c.wgpuInstanceWaitAny(@ptrCast(self.ptr), futureCount, futures, timeoutNS);
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

pub const QuerySet = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) QuerySet {
        return .{ .ptr = ptr };
    }

    pub fn getCount(self: QuerySet) u32 {
        return c.wgpuQuerySetGetCount(@ptrCast(self.ptr));
    }

    pub fn getType(self: QuerySet) c.WGPUQueryType {
        return c.wgpuQuerySetGetType(@ptrCast(self.ptr));
    }

    pub fn destroy(self: QuerySet) void {
        c.wgpuQuerySetDestroy(@ptrCast(self.ptr));
    }

    pub fn setLabel(self: QuerySet, label: c.WGPUStringView) void {
        c.wgpuQuerySetSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const Queue = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Queue {
        return .{ .ptr = ptr };
    }

    pub fn writeTexture(self: Queue, destination: ?*const c.WGPUTexelCopyTextureInfo, data: ?*const anyopaque, dataSize: usize, dataLayout: ?*const c.WGPUTexelCopyBufferLayout, writeSize: ?*const c.WGPUExtent3D) void {
        c.wgpuQueueWriteTexture(@ptrCast(self.ptr), destination, data, dataSize, dataLayout, writeSize);
    }

    pub fn onSubmittedWorkDone(self: Queue, callbackInfo: c.WGPUQueueWorkDoneCallbackInfo) c.WGPUFuture {
        return c.wgpuQueueOnSubmittedWorkDone(@ptrCast(self.ptr), callbackInfo);
    }

    pub fn setLabel(self: Queue, label: c.WGPUStringView) void {
        c.wgpuQueueSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn writeBuffer(self: Queue, buffer: c.WGPUBuffer, bufferOffset: u64, data: ?*const anyopaque, size: usize) void {
        c.wgpuQueueWriteBuffer(@ptrCast(self.ptr), buffer, bufferOffset, data, size);
    }

    pub fn getTimestampPeriod(self: Queue) f32 {
        return c.wgpuQueueGetTimestampPeriod(@ptrCast(self.ptr));
    }

    pub fn submit(self: Queue, commandCount: usize, commands: ?*const c.WGPUCommandBuffer) void {
        c.wgpuQueueSubmit(@ptrCast(self.ptr), commandCount, commands);
    }

    pub fn submitForIndex(self: Queue, commandCount: usize, commands: ?*const c.WGPUCommandBuffer) c.WGPUSubmissionIndex {
        return c.wgpuQueueSubmitForIndex(@ptrCast(self.ptr), commandCount, commands);
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

    pub fn setPushConstants(self: RenderBundleEncoder, stages: c.WGPUShaderStage, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void {
        c.wgpuRenderBundleEncoderSetPushConstants(@ptrCast(self.ptr), stages, offset, sizeBytes, data);
    }

    pub fn setLabel(self: RenderBundleEncoder, label: c.WGPUStringView) void {
        c.wgpuRenderBundleEncoderSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn finish(self: RenderBundleEncoder, descriptor: ?*const c.WGPURenderBundleDescriptor) c.WGPURenderBundle {
        const result = c.wgpuRenderBundleEncoderFinish(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn drawIndirect(self: RenderBundleEncoder, indirectBuffer: c.WGPUBuffer, indirectOffset: u64) void {
        c.wgpuRenderBundleEncoderDrawIndirect(@ptrCast(self.ptr), indirectBuffer, indirectOffset);
    }

    pub fn setPipeline(self: RenderBundleEncoder, pipeline: c.WGPURenderPipeline) void {
        c.wgpuRenderBundleEncoderSetPipeline(@ptrCast(self.ptr), pipeline);
    }

    pub fn setIndexBuffer(self: RenderBundleEncoder, buffer: c.WGPUBuffer, format: c.WGPUIndexFormat, offset: u64, size: u64) void {
        c.wgpuRenderBundleEncoderSetIndexBuffer(@ptrCast(self.ptr), buffer, format, offset, size);
    }

    pub fn drawIndexed(self: RenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void {
        c.wgpuRenderBundleEncoderDrawIndexed(@ptrCast(self.ptr), indexCount, instanceCount, firstIndex, baseVertex, firstInstance);
    }

    pub fn setVertexBuffer(self: RenderBundleEncoder, slot: u32, buffer: c.WGPUBuffer, offset: u64, size: u64) void {
        c.wgpuRenderBundleEncoderSetVertexBuffer(@ptrCast(self.ptr), slot, buffer, offset, size);
    }

    pub fn popDebugGroup(self: RenderBundleEncoder) void {
        c.wgpuRenderBundleEncoderPopDebugGroup(@ptrCast(self.ptr));
    }

    pub fn drawIndexedIndirect(self: RenderBundleEncoder, indirectBuffer: c.WGPUBuffer, indirectOffset: u64) void {
        c.wgpuRenderBundleEncoderDrawIndexedIndirect(@ptrCast(self.ptr), indirectBuffer, indirectOffset);
    }

    pub fn setBindGroup(self: RenderBundleEncoder, groupIndex: u32, group: c.WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: ?*const u32) void {
        c.wgpuRenderBundleEncoderSetBindGroup(@ptrCast(self.ptr), groupIndex, group, dynamicOffsetCount, dynamicOffsets);
    }

};

pub const RenderPassEncoder = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) RenderPassEncoder {
        return .{ .ptr = ptr };
    }

    pub fn multiDrawIndexedIndirectCount(self: RenderPassEncoder, buffer: c.WGPUBuffer, offset: u64, count_buffer: c.WGPUBuffer, count_buffer_offset: u64, max_count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndexedIndirectCount(@ptrCast(self.ptr), buffer, offset, count_buffer, count_buffer_offset, max_count);
    }

    pub fn setBindGroup(self: RenderPassEncoder, groupIndex: u32, group: c.WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: ?*const u32) void {
        c.wgpuRenderPassEncoderSetBindGroup(@ptrCast(self.ptr), groupIndex, group, dynamicOffsetCount, dynamicOffsets);
    }

    pub fn popDebugGroup(self: RenderPassEncoder) void {
        c.wgpuRenderPassEncoderPopDebugGroup(@ptrCast(self.ptr));
    }

    pub fn setVertexBuffer(self: RenderPassEncoder, slot: u32, buffer: c.WGPUBuffer, offset: u64, size: u64) void {
        c.wgpuRenderPassEncoderSetVertexBuffer(@ptrCast(self.ptr), slot, buffer, offset, size);
    }

    pub fn setPushConstants(self: RenderPassEncoder, stages: c.WGPUShaderStage, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void {
        c.wgpuRenderPassEncoderSetPushConstants(@ptrCast(self.ptr), stages, offset, sizeBytes, data);
    }

    pub fn multiDrawIndirect(self: RenderPassEncoder, buffer: c.WGPUBuffer, offset: u64, count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndirect(@ptrCast(self.ptr), buffer, offset, count);
    }

    pub fn insertDebugMarker(self: RenderPassEncoder, markerLabel: c.WGPUStringView) void {
        c.wgpuRenderPassEncoderInsertDebugMarker(@ptrCast(self.ptr), markerLabel);
    }

    pub fn multiDrawIndexedIndirect(self: RenderPassEncoder, buffer: c.WGPUBuffer, offset: u64, count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndexedIndirect(@ptrCast(self.ptr), buffer, offset, count);
    }

    pub fn setStencilReference(self: RenderPassEncoder, reference: u32) void {
        c.wgpuRenderPassEncoderSetStencilReference(@ptrCast(self.ptr), reference);
    }

    pub fn beginPipelineStatisticsQuery(self: RenderPassEncoder, querySet: c.WGPUQuerySet, queryIndex: u32) void {
        c.wgpuRenderPassEncoderBeginPipelineStatisticsQuery(@ptrCast(self.ptr), querySet, queryIndex);
    }

    pub fn setViewport(self: RenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) void {
        c.wgpuRenderPassEncoderSetViewport(@ptrCast(self.ptr), x, y, width, height, minDepth, maxDepth);
    }

    pub fn setBlendConstant(self: RenderPassEncoder, color: ?*const c.WGPUColor) void {
        c.wgpuRenderPassEncoderSetBlendConstant(@ptrCast(self.ptr), color);
    }

    pub fn drawIndexedIndirect(self: RenderPassEncoder, indirectBuffer: c.WGPUBuffer, indirectOffset: u64) void {
        c.wgpuRenderPassEncoderDrawIndexedIndirect(@ptrCast(self.ptr), indirectBuffer, indirectOffset);
    }

    pub fn multiDrawIndirectCount(self: RenderPassEncoder, buffer: c.WGPUBuffer, offset: u64, count_buffer: c.WGPUBuffer, count_buffer_offset: u64, max_count: u32) void {
        c.wgpuRenderPassEncoderMultiDrawIndirectCount(@ptrCast(self.ptr), buffer, offset, count_buffer, count_buffer_offset, max_count);
    }

    pub fn executeBundles(self: RenderPassEncoder, bundleCount: usize, bundles: ?*const c.WGPURenderBundle) void {
        c.wgpuRenderPassEncoderExecuteBundles(@ptrCast(self.ptr), bundleCount, bundles);
    }

    pub fn beginOcclusionQuery(self: RenderPassEncoder, queryIndex: u32) void {
        c.wgpuRenderPassEncoderBeginOcclusionQuery(@ptrCast(self.ptr), queryIndex);
    }

    pub fn endOcclusionQuery(self: RenderPassEncoder) void {
        c.wgpuRenderPassEncoderEndOcclusionQuery(@ptrCast(self.ptr));
    }

    pub fn writeTimestamp(self: RenderPassEncoder, querySet: c.WGPUQuerySet, queryIndex: u32) void {
        c.wgpuRenderPassEncoderWriteTimestamp(@ptrCast(self.ptr), querySet, queryIndex);
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

    pub fn drawIndirect(self: RenderPassEncoder, indirectBuffer: c.WGPUBuffer, indirectOffset: u64) void {
        c.wgpuRenderPassEncoderDrawIndirect(@ptrCast(self.ptr), indirectBuffer, indirectOffset);
    }

    pub fn setIndexBuffer(self: RenderPassEncoder, buffer: c.WGPUBuffer, format: c.WGPUIndexFormat, offset: u64, size: u64) void {
        c.wgpuRenderPassEncoderSetIndexBuffer(@ptrCast(self.ptr), buffer, format, offset, size);
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

    pub fn setPipeline(self: RenderPassEncoder, pipeline: c.WGPURenderPipeline) void {
        c.wgpuRenderPassEncoderSetPipeline(@ptrCast(self.ptr), pipeline);
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

    pub fn getBindGroupLayout(self: RenderPipeline, groupIndex: u32) c.WGPUBindGroupLayout {
        const result = c.wgpuRenderPipelineGetBindGroupLayout(@ptrCast(self.ptr), groupIndex);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
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

pub const ShaderModule = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) ShaderModule {
        return .{ .ptr = ptr };
    }

    pub fn setLabel(self: ShaderModule, label: c.WGPUStringView) void {
        c.wgpuShaderModuleSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn getCompilationInfo(self: ShaderModule, callbackInfo: c.WGPUCompilationInfoCallbackInfo) c.WGPUFuture {
        return c.wgpuShaderModuleGetCompilationInfo(@ptrCast(self.ptr), callbackInfo);
    }

};

pub const Surface = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Surface {
        return .{ .ptr = ptr };
    }

    pub fn configure(self: Surface, config: ?*const c.WGPUSurfaceConfiguration) void {
        c.wgpuSurfaceConfigure(@ptrCast(self.ptr), config);
    }

    pub fn present(self: Surface) !void {
        const status = c.wgpuSurfacePresent(@ptrCast(self.ptr));
        if (status != 1) return error.Unexpected;
    }

    pub fn unconfigure(self: Surface) void {
        c.wgpuSurfaceUnconfigure(@ptrCast(self.ptr));
    }

    pub fn getCapabilities(self: Surface, capabilities: ?*c.WGPUSurfaceCapabilities) !c.WGPUAdapter {
        var result: c.WGPUAdapter = undefined;
        const status = c.wgpuSurfaceGetCapabilities(@ptrCast(self.ptr), &result, capabilities);
        if (status != 1) return error.Unexpected;
        return result;
    }

    pub fn getCurrentTexture(self: Surface, surfaceTexture: ?*c.WGPUSurfaceTexture) void {
        c.wgpuSurfaceGetCurrentTexture(@ptrCast(self.ptr), surfaceTexture);
    }

    pub fn setLabel(self: Surface, label: c.WGPUStringView) void {
        c.wgpuSurfaceSetLabel(@ptrCast(self.ptr), label);
    }

};

pub const Texture = struct {
    ptr: *anyopaque,

    pub fn fromPtr(ptr: *anyopaque) Texture {
        return .{ .ptr = ptr };
    }

    pub fn getSampleCount(self: Texture) u32 {
        return c.wgpuTextureGetSampleCount(@ptrCast(self.ptr));
    }

    pub fn getFormat(self: Texture) c.WGPUTextureFormat {
        return c.wgpuTextureGetFormat(@ptrCast(self.ptr));
    }

    pub fn createView(self: Texture, descriptor: ?*const c.WGPUTextureViewDescriptor) c.WGPUTextureView {
        const result = c.wgpuTextureCreateView(@ptrCast(self.ptr), descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
    }

    pub fn getDimension(self: Texture) c.WGPUTextureDimension {
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

    pub fn getUsage(self: Texture) c.WGPUTextureUsage {
        return c.wgpuTextureGetUsage(@ptrCast(self.ptr));
    }

    pub fn setLabel(self: Texture, label: c.WGPUStringView) void {
        c.wgpuTextureSetLabel(@ptrCast(self.ptr), label);
    }

    pub fn getHeight(self: Texture) u32 {
        return c.wgpuTextureGetHeight(@ptrCast(self.ptr));
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

pub fn getInstanceCapabilities() !c.WGPUInstanceCapabilities {
        var result: c.WGPUInstanceCapabilities = undefined;
        const status = c.wgpuGetInstanceCapabilities(&result);
        if (status != 1) return error.Unexpected;
        return result;
}

pub fn adapterInfoFreeMembers(adapterInfo: c.WGPUAdapterInfo) void {
        c.wgpuAdapterInfoFreeMembers(adapterInfo);
}

pub fn createInstance(descriptor: ?*const c.WGPUInstanceDescriptor) Instance {
        const result = c.wgpuCreateInstance(descriptor);
        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };
}

pub fn supportedWGSLLanguageFeaturesFreeMembers(supportedWGSLLanguageFeatures: c.WGPUSupportedWGSLLanguageFeatures) void {
        c.wgpuSupportedWGSLLanguageFeaturesFreeMembers(supportedWGSLLanguageFeatures);
}

pub fn getVersion() u32 {
        return c.wgpuGetVersion();
}

pub fn setLogLevel(level: c.WGPULogLevel) void {
        c.wgpuSetLogLevel(level);
}

/// Wait for one or more futures to complete.
/// Returns the number of completed futures, or an error on timeout.
pub fn waitAny(instance: Instance, futures: []c.WGPUFutureWaitInfo, timeout_ns: u64) !usize {
    const status = c.wgpuInstanceWaitAny(@ptrCast(instance.ptr), futures.len, futures.ptr, timeout_ns);
    if (status == c.WGPUWaitStatus_Success) return futures.len;
    if (status == c.WGPUWaitStatus_TimedOut) return error.Timeout;
    return error.Unexpected;
}
