const __root = @This();
pub const __builtin = @import("std").zig.c_translation.builtins;
pub const __helpers = @import("std").zig.c_translation.helpers;

pub const __u_char = u8;
pub const __u_short = c_ushort;
pub const __u_int = c_uint;
pub const __u_long = c_ulong;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_long;
pub const __uint64_t = c_ulong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __quad_t = c_long;
pub const __u_quad_t = c_ulong;
pub const __intmax_t = c_long;
pub const __uintmax_t = c_ulong;
pub const __dev_t = c_ulong;
pub const __uid_t = c_uint;
pub const __gid_t = c_uint;
pub const __ino_t = c_ulong;
pub const __ino64_t = c_ulong;
pub const __mode_t = c_uint;
pub const __nlink_t = c_ulong;
pub const __off_t = c_long;
pub const __off64_t = c_long;
pub const __pid_t = c_int;
pub const __fsid_t = extern struct {
    __val: [2]c_int = @import("std").mem.zeroes([2]c_int),
};
pub const __clock_t = c_long;
pub const __rlim_t = c_ulong;
pub const __rlim64_t = c_ulong;
pub const __id_t = c_uint;
pub const __time_t = c_long;
pub const __useconds_t = c_uint;
pub const __suseconds_t = c_long;
pub const __suseconds64_t = c_long;
pub const __daddr_t = c_int;
pub const __key_t = c_int;
pub const __clockid_t = c_int;
pub const __timer_t = ?*anyopaque;
pub const __blksize_t = c_long;
pub const __blkcnt_t = c_long;
pub const __blkcnt64_t = c_long;
pub const __fsblkcnt_t = c_ulong;
pub const __fsblkcnt64_t = c_ulong;
pub const __fsfilcnt_t = c_ulong;
pub const __fsfilcnt64_t = c_ulong;
pub const __fsword_t = c_long;
pub const __ssize_t = c_long;
pub const __syscall_slong_t = c_long;
pub const __syscall_ulong_t = c_ulong;
pub const __loff_t = __off64_t;
pub const __caddr_t = [*c]u8;
pub const __intptr_t = c_long;
pub const __socklen_t = c_uint;
pub const __sig_atomic_t = c_int;
pub const int_least8_t = __int_least8_t;
pub const int_least16_t = __int_least16_t;
pub const int_least32_t = __int_least32_t;
pub const int_least64_t = __int_least64_t;
pub const uint_least8_t = __uint_least8_t;
pub const uint_least16_t = __uint_least16_t;
pub const uint_least32_t = __uint_least32_t;
pub const uint_least64_t = __uint_least64_t;
pub const int_fast8_t = i8;
pub const int_fast16_t = c_long;
pub const int_fast32_t = c_long;
pub const int_fast64_t = c_long;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = c_ulong;
pub const uint_fast32_t = c_ulong;
pub const uint_fast64_t = c_ulong;
pub const intmax_t = __intmax_t;
pub const uintmax_t = __uintmax_t;
pub const ptrdiff_t = c_long;
pub const wchar_t = c_int;
pub const max_align_t = extern struct {
    __clang_max_align_nonce1: c_longlong = 0,
    __clang_max_align_nonce2: c_longdouble = 0,
};
pub const WGPUFlags = u64;
pub const WGPUBool = u32;
pub const struct_WGPUStringView = extern struct {
    data: [*c]const u8 = null,
    length: usize = 0,
    pub const wgpuGetProcAddress = __root.wgpuGetProcAddress;
};
pub const WGPUStringView = struct_WGPUStringView;
pub const struct_WGPUAdapterImpl = opaque {
    pub const wgpuAdapterGetFeatures = __root.wgpuAdapterGetFeatures;
    pub const wgpuAdapterGetInfo = __root.wgpuAdapterGetInfo;
    pub const wgpuAdapterGetLimits = __root.wgpuAdapterGetLimits;
    pub const wgpuAdapterHasFeature = __root.wgpuAdapterHasFeature;
    pub const wgpuAdapterRequestDevice = __root.wgpuAdapterRequestDevice;
    pub const wgpuAdapterAddRef = __root.wgpuAdapterAddRef;
    pub const wgpuAdapterRelease = __root.wgpuAdapterRelease;
};
pub const WGPUAdapter = ?*struct_WGPUAdapterImpl;
pub const struct_WGPUBindGroupImpl = opaque {
    pub const wgpuBindGroupSetLabel = __root.wgpuBindGroupSetLabel;
    pub const wgpuBindGroupAddRef = __root.wgpuBindGroupAddRef;
    pub const wgpuBindGroupRelease = __root.wgpuBindGroupRelease;
};
pub const WGPUBindGroup = ?*struct_WGPUBindGroupImpl;
pub const struct_WGPUBindGroupLayoutImpl = opaque {
    pub const wgpuBindGroupLayoutSetLabel = __root.wgpuBindGroupLayoutSetLabel;
    pub const wgpuBindGroupLayoutAddRef = __root.wgpuBindGroupLayoutAddRef;
    pub const wgpuBindGroupLayoutRelease = __root.wgpuBindGroupLayoutRelease;
};
pub const WGPUBindGroupLayout = ?*struct_WGPUBindGroupLayoutImpl;
pub const struct_WGPUBufferImpl = opaque {
    pub const wgpuBufferDestroy = __root.wgpuBufferDestroy;
    pub const wgpuBufferGetConstMappedRange = __root.wgpuBufferGetConstMappedRange;
    pub const wgpuBufferGetMapState = __root.wgpuBufferGetMapState;
    pub const wgpuBufferGetMappedRange = __root.wgpuBufferGetMappedRange;
    pub const wgpuBufferGetSize = __root.wgpuBufferGetSize;
    pub const wgpuBufferGetUsage = __root.wgpuBufferGetUsage;
    pub const wgpuBufferMapAsync = __root.wgpuBufferMapAsync;
    pub const wgpuBufferSetLabel = __root.wgpuBufferSetLabel;
    pub const wgpuBufferUnmap = __root.wgpuBufferUnmap;
    pub const wgpuBufferAddRef = __root.wgpuBufferAddRef;
    pub const wgpuBufferRelease = __root.wgpuBufferRelease;
};
pub const WGPUBuffer = ?*struct_WGPUBufferImpl;
pub const struct_WGPUCommandBufferImpl = opaque {
    pub const wgpuCommandBufferSetLabel = __root.wgpuCommandBufferSetLabel;
    pub const wgpuCommandBufferAddRef = __root.wgpuCommandBufferAddRef;
    pub const wgpuCommandBufferRelease = __root.wgpuCommandBufferRelease;
};
pub const WGPUCommandBuffer = ?*struct_WGPUCommandBufferImpl;
pub const struct_WGPUCommandEncoderImpl = opaque {
    pub const wgpuCommandEncoderBeginComputePass = __root.wgpuCommandEncoderBeginComputePass;
    pub const wgpuCommandEncoderBeginRenderPass = __root.wgpuCommandEncoderBeginRenderPass;
    pub const wgpuCommandEncoderClearBuffer = __root.wgpuCommandEncoderClearBuffer;
    pub const wgpuCommandEncoderCopyBufferToBuffer = __root.wgpuCommandEncoderCopyBufferToBuffer;
    pub const wgpuCommandEncoderCopyBufferToTexture = __root.wgpuCommandEncoderCopyBufferToTexture;
    pub const wgpuCommandEncoderCopyTextureToBuffer = __root.wgpuCommandEncoderCopyTextureToBuffer;
    pub const wgpuCommandEncoderCopyTextureToTexture = __root.wgpuCommandEncoderCopyTextureToTexture;
    pub const wgpuCommandEncoderFinish = __root.wgpuCommandEncoderFinish;
    pub const wgpuCommandEncoderInsertDebugMarker = __root.wgpuCommandEncoderInsertDebugMarker;
    pub const wgpuCommandEncoderPopDebugGroup = __root.wgpuCommandEncoderPopDebugGroup;
    pub const wgpuCommandEncoderPushDebugGroup = __root.wgpuCommandEncoderPushDebugGroup;
    pub const wgpuCommandEncoderResolveQuerySet = __root.wgpuCommandEncoderResolveQuerySet;
    pub const wgpuCommandEncoderSetLabel = __root.wgpuCommandEncoderSetLabel;
    pub const wgpuCommandEncoderWriteTimestamp = __root.wgpuCommandEncoderWriteTimestamp;
    pub const wgpuCommandEncoderAddRef = __root.wgpuCommandEncoderAddRef;
    pub const wgpuCommandEncoderRelease = __root.wgpuCommandEncoderRelease;
};
pub const WGPUCommandEncoder = ?*struct_WGPUCommandEncoderImpl;
pub const struct_WGPUComputePassEncoderImpl = opaque {
    pub const wgpuComputePassEncoderDispatchWorkgroups = __root.wgpuComputePassEncoderDispatchWorkgroups;
    pub const wgpuComputePassEncoderDispatchWorkgroupsIndirect = __root.wgpuComputePassEncoderDispatchWorkgroupsIndirect;
    pub const wgpuComputePassEncoderEnd = __root.wgpuComputePassEncoderEnd;
    pub const wgpuComputePassEncoderInsertDebugMarker = __root.wgpuComputePassEncoderInsertDebugMarker;
    pub const wgpuComputePassEncoderPopDebugGroup = __root.wgpuComputePassEncoderPopDebugGroup;
    pub const wgpuComputePassEncoderPushDebugGroup = __root.wgpuComputePassEncoderPushDebugGroup;
    pub const wgpuComputePassEncoderSetBindGroup = __root.wgpuComputePassEncoderSetBindGroup;
    pub const wgpuComputePassEncoderSetLabel = __root.wgpuComputePassEncoderSetLabel;
    pub const wgpuComputePassEncoderSetPipeline = __root.wgpuComputePassEncoderSetPipeline;
    pub const wgpuComputePassEncoderAddRef = __root.wgpuComputePassEncoderAddRef;
    pub const wgpuComputePassEncoderRelease = __root.wgpuComputePassEncoderRelease;
    pub const wgpuComputePassEncoderSetPushConstants = __root.wgpuComputePassEncoderSetPushConstants;
    pub const wgpuComputePassEncoderBeginPipelineStatisticsQuery = __root.wgpuComputePassEncoderBeginPipelineStatisticsQuery;
    pub const wgpuComputePassEncoderEndPipelineStatisticsQuery = __root.wgpuComputePassEncoderEndPipelineStatisticsQuery;
    pub const wgpuComputePassEncoderWriteTimestamp = __root.wgpuComputePassEncoderWriteTimestamp;
};
pub const WGPUComputePassEncoder = ?*struct_WGPUComputePassEncoderImpl;
pub const struct_WGPUComputePipelineImpl = opaque {
    pub const wgpuComputePipelineGetBindGroupLayout = __root.wgpuComputePipelineGetBindGroupLayout;
    pub const wgpuComputePipelineSetLabel = __root.wgpuComputePipelineSetLabel;
    pub const wgpuComputePipelineAddRef = __root.wgpuComputePipelineAddRef;
    pub const wgpuComputePipelineRelease = __root.wgpuComputePipelineRelease;
};
pub const WGPUComputePipeline = ?*struct_WGPUComputePipelineImpl;
pub const struct_WGPUDeviceImpl = opaque {
    pub const wgpuDeviceCreateBindGroup = __root.wgpuDeviceCreateBindGroup;
    pub const wgpuDeviceCreateBindGroupLayout = __root.wgpuDeviceCreateBindGroupLayout;
    pub const wgpuDeviceCreateBuffer = __root.wgpuDeviceCreateBuffer;
    pub const wgpuDeviceCreateCommandEncoder = __root.wgpuDeviceCreateCommandEncoder;
    pub const wgpuDeviceCreateComputePipeline = __root.wgpuDeviceCreateComputePipeline;
    pub const wgpuDeviceCreateComputePipelineAsync = __root.wgpuDeviceCreateComputePipelineAsync;
    pub const wgpuDeviceCreatePipelineLayout = __root.wgpuDeviceCreatePipelineLayout;
    pub const wgpuDeviceCreateQuerySet = __root.wgpuDeviceCreateQuerySet;
    pub const wgpuDeviceCreateRenderBundleEncoder = __root.wgpuDeviceCreateRenderBundleEncoder;
    pub const wgpuDeviceCreateRenderPipeline = __root.wgpuDeviceCreateRenderPipeline;
    pub const wgpuDeviceCreateRenderPipelineAsync = __root.wgpuDeviceCreateRenderPipelineAsync;
    pub const wgpuDeviceCreateSampler = __root.wgpuDeviceCreateSampler;
    pub const wgpuDeviceCreateShaderModule = __root.wgpuDeviceCreateShaderModule;
    pub const wgpuDeviceCreateTexture = __root.wgpuDeviceCreateTexture;
    pub const wgpuDeviceDestroy = __root.wgpuDeviceDestroy;
    pub const wgpuDeviceGetAdapterInfo = __root.wgpuDeviceGetAdapterInfo;
    pub const wgpuDeviceGetFeatures = __root.wgpuDeviceGetFeatures;
    pub const wgpuDeviceGetLimits = __root.wgpuDeviceGetLimits;
    pub const wgpuDeviceGetLostFuture = __root.wgpuDeviceGetLostFuture;
    pub const wgpuDeviceGetQueue = __root.wgpuDeviceGetQueue;
    pub const wgpuDeviceHasFeature = __root.wgpuDeviceHasFeature;
    pub const wgpuDevicePopErrorScope = __root.wgpuDevicePopErrorScope;
    pub const wgpuDevicePushErrorScope = __root.wgpuDevicePushErrorScope;
    pub const wgpuDeviceSetLabel = __root.wgpuDeviceSetLabel;
    pub const wgpuDeviceAddRef = __root.wgpuDeviceAddRef;
    pub const wgpuDeviceRelease = __root.wgpuDeviceRelease;
    pub const wgpuDevicePoll = __root.wgpuDevicePoll;
    pub const wgpuDeviceCreateShaderModuleSpirV = __root.wgpuDeviceCreateShaderModuleSpirV;
};
pub const WGPUDevice = ?*struct_WGPUDeviceImpl;
pub const struct_WGPUInstanceImpl = opaque {
    pub const wgpuInstanceCreateSurface = __root.wgpuInstanceCreateSurface;
    pub const wgpuInstanceGetWGSLLanguageFeatures = __root.wgpuInstanceGetWGSLLanguageFeatures;
    pub const wgpuInstanceHasWGSLLanguageFeature = __root.wgpuInstanceHasWGSLLanguageFeature;
    pub const wgpuInstanceProcessEvents = __root.wgpuInstanceProcessEvents;
    pub const wgpuInstanceRequestAdapter = __root.wgpuInstanceRequestAdapter;
    pub const wgpuInstanceWaitAny = __root.wgpuInstanceWaitAny;
    pub const wgpuInstanceAddRef = __root.wgpuInstanceAddRef;
    pub const wgpuInstanceRelease = __root.wgpuInstanceRelease;
    pub const wgpuGenerateReport = __root.wgpuGenerateReport;
    pub const wgpuInstanceEnumerateAdapters = __root.wgpuInstanceEnumerateAdapters;
};
pub const WGPUInstance = ?*struct_WGPUInstanceImpl;
pub const struct_WGPUPipelineLayoutImpl = opaque {
    pub const wgpuPipelineLayoutSetLabel = __root.wgpuPipelineLayoutSetLabel;
    pub const wgpuPipelineLayoutAddRef = __root.wgpuPipelineLayoutAddRef;
    pub const wgpuPipelineLayoutRelease = __root.wgpuPipelineLayoutRelease;
};
pub const WGPUPipelineLayout = ?*struct_WGPUPipelineLayoutImpl;
pub const struct_WGPUQuerySetImpl = opaque {
    pub const wgpuQuerySetDestroy = __root.wgpuQuerySetDestroy;
    pub const wgpuQuerySetGetCount = __root.wgpuQuerySetGetCount;
    pub const wgpuQuerySetGetType = __root.wgpuQuerySetGetType;
    pub const wgpuQuerySetSetLabel = __root.wgpuQuerySetSetLabel;
    pub const wgpuQuerySetAddRef = __root.wgpuQuerySetAddRef;
    pub const wgpuQuerySetRelease = __root.wgpuQuerySetRelease;
};
pub const WGPUQuerySet = ?*struct_WGPUQuerySetImpl;
pub const struct_WGPUQueueImpl = opaque {
    pub const wgpuQueueOnSubmittedWorkDone = __root.wgpuQueueOnSubmittedWorkDone;
    pub const wgpuQueueSetLabel = __root.wgpuQueueSetLabel;
    pub const wgpuQueueSubmit = __root.wgpuQueueSubmit;
    pub const wgpuQueueWriteBuffer = __root.wgpuQueueWriteBuffer;
    pub const wgpuQueueWriteTexture = __root.wgpuQueueWriteTexture;
    pub const wgpuQueueAddRef = __root.wgpuQueueAddRef;
    pub const wgpuQueueRelease = __root.wgpuQueueRelease;
    pub const wgpuQueueSubmitForIndex = __root.wgpuQueueSubmitForIndex;
    pub const wgpuQueueGetTimestampPeriod = __root.wgpuQueueGetTimestampPeriod;
};
pub const WGPUQueue = ?*struct_WGPUQueueImpl;
pub const struct_WGPURenderBundleImpl = opaque {
    pub const wgpuRenderBundleSetLabel = __root.wgpuRenderBundleSetLabel;
    pub const wgpuRenderBundleAddRef = __root.wgpuRenderBundleAddRef;
    pub const wgpuRenderBundleRelease = __root.wgpuRenderBundleRelease;
};
pub const WGPURenderBundle = ?*struct_WGPURenderBundleImpl;
pub const struct_WGPURenderBundleEncoderImpl = opaque {
    pub const wgpuRenderBundleEncoderDraw = __root.wgpuRenderBundleEncoderDraw;
    pub const wgpuRenderBundleEncoderDrawIndexed = __root.wgpuRenderBundleEncoderDrawIndexed;
    pub const wgpuRenderBundleEncoderDrawIndexedIndirect = __root.wgpuRenderBundleEncoderDrawIndexedIndirect;
    pub const wgpuRenderBundleEncoderDrawIndirect = __root.wgpuRenderBundleEncoderDrawIndirect;
    pub const wgpuRenderBundleEncoderFinish = __root.wgpuRenderBundleEncoderFinish;
    pub const wgpuRenderBundleEncoderInsertDebugMarker = __root.wgpuRenderBundleEncoderInsertDebugMarker;
    pub const wgpuRenderBundleEncoderPopDebugGroup = __root.wgpuRenderBundleEncoderPopDebugGroup;
    pub const wgpuRenderBundleEncoderPushDebugGroup = __root.wgpuRenderBundleEncoderPushDebugGroup;
    pub const wgpuRenderBundleEncoderSetBindGroup = __root.wgpuRenderBundleEncoderSetBindGroup;
    pub const wgpuRenderBundleEncoderSetIndexBuffer = __root.wgpuRenderBundleEncoderSetIndexBuffer;
    pub const wgpuRenderBundleEncoderSetLabel = __root.wgpuRenderBundleEncoderSetLabel;
    pub const wgpuRenderBundleEncoderSetPipeline = __root.wgpuRenderBundleEncoderSetPipeline;
    pub const wgpuRenderBundleEncoderSetVertexBuffer = __root.wgpuRenderBundleEncoderSetVertexBuffer;
    pub const wgpuRenderBundleEncoderAddRef = __root.wgpuRenderBundleEncoderAddRef;
    pub const wgpuRenderBundleEncoderRelease = __root.wgpuRenderBundleEncoderRelease;
    pub const wgpuRenderBundleEncoderSetPushConstants = __root.wgpuRenderBundleEncoderSetPushConstants;
};
pub const WGPURenderBundleEncoder = ?*struct_WGPURenderBundleEncoderImpl;
pub const struct_WGPURenderPassEncoderImpl = opaque {
    pub const wgpuRenderPassEncoderBeginOcclusionQuery = __root.wgpuRenderPassEncoderBeginOcclusionQuery;
    pub const wgpuRenderPassEncoderDraw = __root.wgpuRenderPassEncoderDraw;
    pub const wgpuRenderPassEncoderDrawIndexed = __root.wgpuRenderPassEncoderDrawIndexed;
    pub const wgpuRenderPassEncoderDrawIndexedIndirect = __root.wgpuRenderPassEncoderDrawIndexedIndirect;
    pub const wgpuRenderPassEncoderDrawIndirect = __root.wgpuRenderPassEncoderDrawIndirect;
    pub const wgpuRenderPassEncoderEnd = __root.wgpuRenderPassEncoderEnd;
    pub const wgpuRenderPassEncoderEndOcclusionQuery = __root.wgpuRenderPassEncoderEndOcclusionQuery;
    pub const wgpuRenderPassEncoderExecuteBundles = __root.wgpuRenderPassEncoderExecuteBundles;
    pub const wgpuRenderPassEncoderInsertDebugMarker = __root.wgpuRenderPassEncoderInsertDebugMarker;
    pub const wgpuRenderPassEncoderPopDebugGroup = __root.wgpuRenderPassEncoderPopDebugGroup;
    pub const wgpuRenderPassEncoderPushDebugGroup = __root.wgpuRenderPassEncoderPushDebugGroup;
    pub const wgpuRenderPassEncoderSetBindGroup = __root.wgpuRenderPassEncoderSetBindGroup;
    pub const wgpuRenderPassEncoderSetBlendConstant = __root.wgpuRenderPassEncoderSetBlendConstant;
    pub const wgpuRenderPassEncoderSetIndexBuffer = __root.wgpuRenderPassEncoderSetIndexBuffer;
    pub const wgpuRenderPassEncoderSetLabel = __root.wgpuRenderPassEncoderSetLabel;
    pub const wgpuRenderPassEncoderSetPipeline = __root.wgpuRenderPassEncoderSetPipeline;
    pub const wgpuRenderPassEncoderSetScissorRect = __root.wgpuRenderPassEncoderSetScissorRect;
    pub const wgpuRenderPassEncoderSetStencilReference = __root.wgpuRenderPassEncoderSetStencilReference;
    pub const wgpuRenderPassEncoderSetVertexBuffer = __root.wgpuRenderPassEncoderSetVertexBuffer;
    pub const wgpuRenderPassEncoderSetViewport = __root.wgpuRenderPassEncoderSetViewport;
    pub const wgpuRenderPassEncoderAddRef = __root.wgpuRenderPassEncoderAddRef;
    pub const wgpuRenderPassEncoderRelease = __root.wgpuRenderPassEncoderRelease;
    pub const wgpuRenderPassEncoderSetPushConstants = __root.wgpuRenderPassEncoderSetPushConstants;
    pub const wgpuRenderPassEncoderMultiDrawIndirect = __root.wgpuRenderPassEncoderMultiDrawIndirect;
    pub const wgpuRenderPassEncoderMultiDrawIndexedIndirect = __root.wgpuRenderPassEncoderMultiDrawIndexedIndirect;
    pub const wgpuRenderPassEncoderMultiDrawIndirectCount = __root.wgpuRenderPassEncoderMultiDrawIndirectCount;
    pub const wgpuRenderPassEncoderMultiDrawIndexedIndirectCount = __root.wgpuRenderPassEncoderMultiDrawIndexedIndirectCount;
    pub const wgpuRenderPassEncoderBeginPipelineStatisticsQuery = __root.wgpuRenderPassEncoderBeginPipelineStatisticsQuery;
    pub const wgpuRenderPassEncoderEndPipelineStatisticsQuery = __root.wgpuRenderPassEncoderEndPipelineStatisticsQuery;
    pub const wgpuRenderPassEncoderWriteTimestamp = __root.wgpuRenderPassEncoderWriteTimestamp;
};
pub const WGPURenderPassEncoder = ?*struct_WGPURenderPassEncoderImpl;
pub const struct_WGPURenderPipelineImpl = opaque {
    pub const wgpuRenderPipelineGetBindGroupLayout = __root.wgpuRenderPipelineGetBindGroupLayout;
    pub const wgpuRenderPipelineSetLabel = __root.wgpuRenderPipelineSetLabel;
    pub const wgpuRenderPipelineAddRef = __root.wgpuRenderPipelineAddRef;
    pub const wgpuRenderPipelineRelease = __root.wgpuRenderPipelineRelease;
};
pub const WGPURenderPipeline = ?*struct_WGPURenderPipelineImpl;
pub const struct_WGPUSamplerImpl = opaque {
    pub const wgpuSamplerSetLabel = __root.wgpuSamplerSetLabel;
    pub const wgpuSamplerAddRef = __root.wgpuSamplerAddRef;
    pub const wgpuSamplerRelease = __root.wgpuSamplerRelease;
};
pub const WGPUSampler = ?*struct_WGPUSamplerImpl;
pub const struct_WGPUShaderModuleImpl = opaque {
    pub const wgpuShaderModuleGetCompilationInfo = __root.wgpuShaderModuleGetCompilationInfo;
    pub const wgpuShaderModuleSetLabel = __root.wgpuShaderModuleSetLabel;
    pub const wgpuShaderModuleAddRef = __root.wgpuShaderModuleAddRef;
    pub const wgpuShaderModuleRelease = __root.wgpuShaderModuleRelease;
};
pub const WGPUShaderModule = ?*struct_WGPUShaderModuleImpl;
pub const struct_WGPUSurfaceImpl = opaque {
    pub const wgpuSurfaceConfigure = __root.wgpuSurfaceConfigure;
    pub const wgpuSurfaceGetCapabilities = __root.wgpuSurfaceGetCapabilities;
    pub const wgpuSurfaceGetCurrentTexture = __root.wgpuSurfaceGetCurrentTexture;
    pub const wgpuSurfacePresent = __root.wgpuSurfacePresent;
    pub const wgpuSurfaceSetLabel = __root.wgpuSurfaceSetLabel;
    pub const wgpuSurfaceUnconfigure = __root.wgpuSurfaceUnconfigure;
    pub const wgpuSurfaceAddRef = __root.wgpuSurfaceAddRef;
    pub const wgpuSurfaceRelease = __root.wgpuSurfaceRelease;
};
pub const WGPUSurface = ?*struct_WGPUSurfaceImpl;
pub const struct_WGPUTextureImpl = opaque {
    pub const wgpuTextureCreateView = __root.wgpuTextureCreateView;
    pub const wgpuTextureDestroy = __root.wgpuTextureDestroy;
    pub const wgpuTextureGetDepthOrArrayLayers = __root.wgpuTextureGetDepthOrArrayLayers;
    pub const wgpuTextureGetDimension = __root.wgpuTextureGetDimension;
    pub const wgpuTextureGetFormat = __root.wgpuTextureGetFormat;
    pub const wgpuTextureGetHeight = __root.wgpuTextureGetHeight;
    pub const wgpuTextureGetMipLevelCount = __root.wgpuTextureGetMipLevelCount;
    pub const wgpuTextureGetSampleCount = __root.wgpuTextureGetSampleCount;
    pub const wgpuTextureGetUsage = __root.wgpuTextureGetUsage;
    pub const wgpuTextureGetWidth = __root.wgpuTextureGetWidth;
    pub const wgpuTextureSetLabel = __root.wgpuTextureSetLabel;
    pub const wgpuTextureAddRef = __root.wgpuTextureAddRef;
    pub const wgpuTextureRelease = __root.wgpuTextureRelease;
};
pub const WGPUTexture = ?*struct_WGPUTextureImpl;
pub const struct_WGPUTextureViewImpl = opaque {
    pub const wgpuTextureViewSetLabel = __root.wgpuTextureViewSetLabel;
    pub const wgpuTextureViewAddRef = __root.wgpuTextureViewAddRef;
    pub const wgpuTextureViewRelease = __root.wgpuTextureViewRelease;
};
pub const WGPUTextureView = ?*struct_WGPUTextureViewImpl;
pub const WGPUAdapterType_DiscreteGPU: c_int = 1;
pub const WGPUAdapterType_IntegratedGPU: c_int = 2;
pub const WGPUAdapterType_CPU: c_int = 3;
pub const WGPUAdapterType_Unknown: c_int = 4;
pub const WGPUAdapterType_Force32: c_int = 2147483647;
pub const enum_WGPUAdapterType = c_uint;
pub const WGPUAdapterType = enum_WGPUAdapterType;
pub const WGPUAddressMode_Undefined: c_int = 0;
pub const WGPUAddressMode_ClampToEdge: c_int = 1;
pub const WGPUAddressMode_Repeat: c_int = 2;
pub const WGPUAddressMode_MirrorRepeat: c_int = 3;
pub const WGPUAddressMode_Force32: c_int = 2147483647;
pub const enum_WGPUAddressMode = c_uint;
pub const WGPUAddressMode = enum_WGPUAddressMode;
pub const WGPUBackendType_Undefined: c_int = 0;
pub const WGPUBackendType_Null: c_int = 1;
pub const WGPUBackendType_WebGPU: c_int = 2;
pub const WGPUBackendType_D3D11: c_int = 3;
pub const WGPUBackendType_D3D12: c_int = 4;
pub const WGPUBackendType_Metal: c_int = 5;
pub const WGPUBackendType_Vulkan: c_int = 6;
pub const WGPUBackendType_OpenGL: c_int = 7;
pub const WGPUBackendType_OpenGLES: c_int = 8;
pub const WGPUBackendType_Force32: c_int = 2147483647;
pub const enum_WGPUBackendType = c_uint;
pub const WGPUBackendType = enum_WGPUBackendType;
pub const WGPUBlendFactor_Undefined: c_int = 0;
pub const WGPUBlendFactor_Zero: c_int = 1;
pub const WGPUBlendFactor_One: c_int = 2;
pub const WGPUBlendFactor_Src: c_int = 3;
pub const WGPUBlendFactor_OneMinusSrc: c_int = 4;
pub const WGPUBlendFactor_SrcAlpha: c_int = 5;
pub const WGPUBlendFactor_OneMinusSrcAlpha: c_int = 6;
pub const WGPUBlendFactor_Dst: c_int = 7;
pub const WGPUBlendFactor_OneMinusDst: c_int = 8;
pub const WGPUBlendFactor_DstAlpha: c_int = 9;
pub const WGPUBlendFactor_OneMinusDstAlpha: c_int = 10;
pub const WGPUBlendFactor_SrcAlphaSaturated: c_int = 11;
pub const WGPUBlendFactor_Constant: c_int = 12;
pub const WGPUBlendFactor_OneMinusConstant: c_int = 13;
pub const WGPUBlendFactor_Src1: c_int = 14;
pub const WGPUBlendFactor_OneMinusSrc1: c_int = 15;
pub const WGPUBlendFactor_Src1Alpha: c_int = 16;
pub const WGPUBlendFactor_OneMinusSrc1Alpha: c_int = 17;
pub const WGPUBlendFactor_Force32: c_int = 2147483647;
pub const enum_WGPUBlendFactor = c_uint;
pub const WGPUBlendFactor = enum_WGPUBlendFactor;
pub const WGPUBlendOperation_Undefined: c_int = 0;
pub const WGPUBlendOperation_Add: c_int = 1;
pub const WGPUBlendOperation_Subtract: c_int = 2;
pub const WGPUBlendOperation_ReverseSubtract: c_int = 3;
pub const WGPUBlendOperation_Min: c_int = 4;
pub const WGPUBlendOperation_Max: c_int = 5;
pub const WGPUBlendOperation_Force32: c_int = 2147483647;
pub const enum_WGPUBlendOperation = c_uint;
pub const WGPUBlendOperation = enum_WGPUBlendOperation;
pub const WGPUBufferBindingType_BindingNotUsed: c_int = 0;
pub const WGPUBufferBindingType_Undefined: c_int = 1;
pub const WGPUBufferBindingType_Uniform: c_int = 2;
pub const WGPUBufferBindingType_Storage: c_int = 3;
pub const WGPUBufferBindingType_ReadOnlyStorage: c_int = 4;
pub const WGPUBufferBindingType_Force32: c_int = 2147483647;
pub const enum_WGPUBufferBindingType = c_uint;
pub const WGPUBufferBindingType = enum_WGPUBufferBindingType;
pub const WGPUBufferMapState_Unmapped: c_int = 1;
pub const WGPUBufferMapState_Pending: c_int = 2;
pub const WGPUBufferMapState_Mapped: c_int = 3;
pub const WGPUBufferMapState_Force32: c_int = 2147483647;
pub const enum_WGPUBufferMapState = c_uint;
pub const WGPUBufferMapState = enum_WGPUBufferMapState;
pub const WGPUCallbackMode_WaitAnyOnly: c_int = 1;
pub const WGPUCallbackMode_AllowProcessEvents: c_int = 2;
pub const WGPUCallbackMode_AllowSpontaneous: c_int = 3;
pub const WGPUCallbackMode_Force32: c_int = 2147483647;
pub const enum_WGPUCallbackMode = c_uint;
pub const WGPUCallbackMode = enum_WGPUCallbackMode;
pub const WGPUCompareFunction_Undefined: c_int = 0;
pub const WGPUCompareFunction_Never: c_int = 1;
pub const WGPUCompareFunction_Less: c_int = 2;
pub const WGPUCompareFunction_Equal: c_int = 3;
pub const WGPUCompareFunction_LessEqual: c_int = 4;
pub const WGPUCompareFunction_Greater: c_int = 5;
pub const WGPUCompareFunction_NotEqual: c_int = 6;
pub const WGPUCompareFunction_GreaterEqual: c_int = 7;
pub const WGPUCompareFunction_Always: c_int = 8;
pub const WGPUCompareFunction_Force32: c_int = 2147483647;
pub const enum_WGPUCompareFunction = c_uint;
pub const WGPUCompareFunction = enum_WGPUCompareFunction;
pub const WGPUCompilationInfoRequestStatus_Success: c_int = 1;
pub const WGPUCompilationInfoRequestStatus_InstanceDropped: c_int = 2;
pub const WGPUCompilationInfoRequestStatus_Error: c_int = 3;
pub const WGPUCompilationInfoRequestStatus_Unknown: c_int = 4;
pub const WGPUCompilationInfoRequestStatus_Force32: c_int = 2147483647;
pub const enum_WGPUCompilationInfoRequestStatus = c_uint;
pub const WGPUCompilationInfoRequestStatus = enum_WGPUCompilationInfoRequestStatus;
pub const WGPUCompilationMessageType_Error: c_int = 1;
pub const WGPUCompilationMessageType_Warning: c_int = 2;
pub const WGPUCompilationMessageType_Info: c_int = 3;
pub const WGPUCompilationMessageType_Force32: c_int = 2147483647;
pub const enum_WGPUCompilationMessageType = c_uint;
pub const WGPUCompilationMessageType = enum_WGPUCompilationMessageType;
pub const WGPUCompositeAlphaMode_Auto: c_int = 0;
pub const WGPUCompositeAlphaMode_Opaque: c_int = 1;
pub const WGPUCompositeAlphaMode_Premultiplied: c_int = 2;
pub const WGPUCompositeAlphaMode_Unpremultiplied: c_int = 3;
pub const WGPUCompositeAlphaMode_Inherit: c_int = 4;
pub const WGPUCompositeAlphaMode_Force32: c_int = 2147483647;
pub const enum_WGPUCompositeAlphaMode = c_uint;
pub const WGPUCompositeAlphaMode = enum_WGPUCompositeAlphaMode;
pub const WGPUCreatePipelineAsyncStatus_Success: c_int = 1;
pub const WGPUCreatePipelineAsyncStatus_InstanceDropped: c_int = 2;
pub const WGPUCreatePipelineAsyncStatus_ValidationError: c_int = 3;
pub const WGPUCreatePipelineAsyncStatus_InternalError: c_int = 4;
pub const WGPUCreatePipelineAsyncStatus_Unknown: c_int = 5;
pub const WGPUCreatePipelineAsyncStatus_Force32: c_int = 2147483647;
pub const enum_WGPUCreatePipelineAsyncStatus = c_uint;
pub const WGPUCreatePipelineAsyncStatus = enum_WGPUCreatePipelineAsyncStatus;
pub const WGPUCullMode_Undefined: c_int = 0;
pub const WGPUCullMode_None: c_int = 1;
pub const WGPUCullMode_Front: c_int = 2;
pub const WGPUCullMode_Back: c_int = 3;
pub const WGPUCullMode_Force32: c_int = 2147483647;
pub const enum_WGPUCullMode = c_uint;
pub const WGPUCullMode = enum_WGPUCullMode;
pub const WGPUDeviceLostReason_Unknown: c_int = 1;
pub const WGPUDeviceLostReason_Destroyed: c_int = 2;
pub const WGPUDeviceLostReason_InstanceDropped: c_int = 3;
pub const WGPUDeviceLostReason_FailedCreation: c_int = 4;
pub const WGPUDeviceLostReason_Force32: c_int = 2147483647;
pub const enum_WGPUDeviceLostReason = c_uint;
pub const WGPUDeviceLostReason = enum_WGPUDeviceLostReason;
pub const WGPUErrorFilter_Validation: c_int = 1;
pub const WGPUErrorFilter_OutOfMemory: c_int = 2;
pub const WGPUErrorFilter_Internal: c_int = 3;
pub const WGPUErrorFilter_Force32: c_int = 2147483647;
pub const enum_WGPUErrorFilter = c_uint;
pub const WGPUErrorFilter = enum_WGPUErrorFilter;
pub const WGPUErrorType_NoError: c_int = 1;
pub const WGPUErrorType_Validation: c_int = 2;
pub const WGPUErrorType_OutOfMemory: c_int = 3;
pub const WGPUErrorType_Internal: c_int = 4;
pub const WGPUErrorType_Unknown: c_int = 5;
pub const WGPUErrorType_Force32: c_int = 2147483647;
pub const enum_WGPUErrorType = c_uint;
pub const WGPUErrorType = enum_WGPUErrorType;
pub const WGPUFeatureLevel_Compatibility: c_int = 1;
pub const WGPUFeatureLevel_Core: c_int = 2;
pub const WGPUFeatureLevel_Force32: c_int = 2147483647;
pub const enum_WGPUFeatureLevel = c_uint;
pub const WGPUFeatureLevel = enum_WGPUFeatureLevel;
pub const WGPUFeatureName_Undefined: c_int = 0;
pub const WGPUFeatureName_DepthClipControl: c_int = 1;
pub const WGPUFeatureName_Depth32FloatStencil8: c_int = 2;
pub const WGPUFeatureName_TimestampQuery: c_int = 3;
pub const WGPUFeatureName_TextureCompressionBC: c_int = 4;
pub const WGPUFeatureName_TextureCompressionBCSliced3D: c_int = 5;
pub const WGPUFeatureName_TextureCompressionETC2: c_int = 6;
pub const WGPUFeatureName_TextureCompressionASTC: c_int = 7;
pub const WGPUFeatureName_TextureCompressionASTCSliced3D: c_int = 8;
pub const WGPUFeatureName_IndirectFirstInstance: c_int = 9;
pub const WGPUFeatureName_ShaderF16: c_int = 10;
pub const WGPUFeatureName_RG11B10UfloatRenderable: c_int = 11;
pub const WGPUFeatureName_BGRA8UnormStorage: c_int = 12;
pub const WGPUFeatureName_Float32Filterable: c_int = 13;
pub const WGPUFeatureName_Float32Blendable: c_int = 14;
pub const WGPUFeatureName_ClipDistances: c_int = 15;
pub const WGPUFeatureName_DualSourceBlending: c_int = 16;
pub const WGPUFeatureName_Force32: c_int = 2147483647;
pub const enum_WGPUFeatureName = c_uint;
pub const WGPUFeatureName = enum_WGPUFeatureName;
pub const WGPUFilterMode_Undefined: c_int = 0;
pub const WGPUFilterMode_Nearest: c_int = 1;
pub const WGPUFilterMode_Linear: c_int = 2;
pub const WGPUFilterMode_Force32: c_int = 2147483647;
pub const enum_WGPUFilterMode = c_uint;
pub const WGPUFilterMode = enum_WGPUFilterMode;
pub const WGPUFrontFace_Undefined: c_int = 0;
pub const WGPUFrontFace_CCW: c_int = 1;
pub const WGPUFrontFace_CW: c_int = 2;
pub const WGPUFrontFace_Force32: c_int = 2147483647;
pub const enum_WGPUFrontFace = c_uint;
pub const WGPUFrontFace = enum_WGPUFrontFace;
pub const WGPUIndexFormat_Undefined: c_int = 0;
pub const WGPUIndexFormat_Uint16: c_int = 1;
pub const WGPUIndexFormat_Uint32: c_int = 2;
pub const WGPUIndexFormat_Force32: c_int = 2147483647;
pub const enum_WGPUIndexFormat = c_uint;
pub const WGPUIndexFormat = enum_WGPUIndexFormat;
pub const WGPULoadOp_Undefined: c_int = 0;
pub const WGPULoadOp_Load: c_int = 1;
pub const WGPULoadOp_Clear: c_int = 2;
pub const WGPULoadOp_Force32: c_int = 2147483647;
pub const enum_WGPULoadOp = c_uint;
pub const WGPULoadOp = enum_WGPULoadOp;
pub const WGPUMapAsyncStatus_Success: c_int = 1;
pub const WGPUMapAsyncStatus_InstanceDropped: c_int = 2;
pub const WGPUMapAsyncStatus_Error: c_int = 3;
pub const WGPUMapAsyncStatus_Aborted: c_int = 4;
pub const WGPUMapAsyncStatus_Unknown: c_int = 5;
pub const WGPUMapAsyncStatus_Force32: c_int = 2147483647;
pub const enum_WGPUMapAsyncStatus = c_uint;
pub const WGPUMapAsyncStatus = enum_WGPUMapAsyncStatus;
pub const WGPUMipmapFilterMode_Undefined: c_int = 0;
pub const WGPUMipmapFilterMode_Nearest: c_int = 1;
pub const WGPUMipmapFilterMode_Linear: c_int = 2;
pub const WGPUMipmapFilterMode_Force32: c_int = 2147483647;
pub const enum_WGPUMipmapFilterMode = c_uint;
pub const WGPUMipmapFilterMode = enum_WGPUMipmapFilterMode;
pub const WGPUOptionalBool_False: c_int = 0;
pub const WGPUOptionalBool_True: c_int = 1;
pub const WGPUOptionalBool_Undefined: c_int = 2;
pub const WGPUOptionalBool_Force32: c_int = 2147483647;
pub const enum_WGPUOptionalBool = c_uint;
pub const WGPUOptionalBool = enum_WGPUOptionalBool;
pub const WGPUPopErrorScopeStatus_Success: c_int = 1;
pub const WGPUPopErrorScopeStatus_InstanceDropped: c_int = 2;
pub const WGPUPopErrorScopeStatus_EmptyStack: c_int = 3;
pub const WGPUPopErrorScopeStatus_Force32: c_int = 2147483647;
pub const enum_WGPUPopErrorScopeStatus = c_uint;
pub const WGPUPopErrorScopeStatus = enum_WGPUPopErrorScopeStatus;
pub const WGPUPowerPreference_Undefined: c_int = 0;
pub const WGPUPowerPreference_LowPower: c_int = 1;
pub const WGPUPowerPreference_HighPerformance: c_int = 2;
pub const WGPUPowerPreference_Force32: c_int = 2147483647;
pub const enum_WGPUPowerPreference = c_uint;
pub const WGPUPowerPreference = enum_WGPUPowerPreference;
pub const WGPUPresentMode_Undefined: c_int = 0;
pub const WGPUPresentMode_Fifo: c_int = 1;
pub const WGPUPresentMode_FifoRelaxed: c_int = 2;
pub const WGPUPresentMode_Immediate: c_int = 3;
pub const WGPUPresentMode_Mailbox: c_int = 4;
pub const WGPUPresentMode_Force32: c_int = 2147483647;
pub const enum_WGPUPresentMode = c_uint;
pub const WGPUPresentMode = enum_WGPUPresentMode;
pub const WGPUPrimitiveTopology_Undefined: c_int = 0;
pub const WGPUPrimitiveTopology_PointList: c_int = 1;
pub const WGPUPrimitiveTopology_LineList: c_int = 2;
pub const WGPUPrimitiveTopology_LineStrip: c_int = 3;
pub const WGPUPrimitiveTopology_TriangleList: c_int = 4;
pub const WGPUPrimitiveTopology_TriangleStrip: c_int = 5;
pub const WGPUPrimitiveTopology_Force32: c_int = 2147483647;
pub const enum_WGPUPrimitiveTopology = c_uint;
pub const WGPUPrimitiveTopology = enum_WGPUPrimitiveTopology;
pub const WGPUQueryType_Occlusion: c_int = 1;
pub const WGPUQueryType_Timestamp: c_int = 2;
pub const WGPUQueryType_Force32: c_int = 2147483647;
pub const enum_WGPUQueryType = c_uint;
pub const WGPUQueryType = enum_WGPUQueryType;
pub const WGPUQueueWorkDoneStatus_Success: c_int = 1;
pub const WGPUQueueWorkDoneStatus_InstanceDropped: c_int = 2;
pub const WGPUQueueWorkDoneStatus_Error: c_int = 3;
pub const WGPUQueueWorkDoneStatus_Unknown: c_int = 4;
pub const WGPUQueueWorkDoneStatus_Force32: c_int = 2147483647;
pub const enum_WGPUQueueWorkDoneStatus = c_uint;
pub const WGPUQueueWorkDoneStatus = enum_WGPUQueueWorkDoneStatus;
pub const WGPURequestAdapterStatus_Success: c_int = 1;
pub const WGPURequestAdapterStatus_InstanceDropped: c_int = 2;
pub const WGPURequestAdapterStatus_Unavailable: c_int = 3;
pub const WGPURequestAdapterStatus_Error: c_int = 4;
pub const WGPURequestAdapterStatus_Unknown: c_int = 5;
pub const WGPURequestAdapterStatus_Force32: c_int = 2147483647;
pub const enum_WGPURequestAdapterStatus = c_uint;
pub const WGPURequestAdapterStatus = enum_WGPURequestAdapterStatus;
pub const WGPURequestDeviceStatus_Success: c_int = 1;
pub const WGPURequestDeviceStatus_InstanceDropped: c_int = 2;
pub const WGPURequestDeviceStatus_Error: c_int = 3;
pub const WGPURequestDeviceStatus_Unknown: c_int = 4;
pub const WGPURequestDeviceStatus_Force32: c_int = 2147483647;
pub const enum_WGPURequestDeviceStatus = c_uint;
pub const WGPURequestDeviceStatus = enum_WGPURequestDeviceStatus;
pub const WGPUSType_ShaderSourceSPIRV: c_int = 1;
pub const WGPUSType_ShaderSourceWGSL: c_int = 2;
pub const WGPUSType_RenderPassMaxDrawCount: c_int = 3;
pub const WGPUSType_SurfaceSourceMetalLayer: c_int = 4;
pub const WGPUSType_SurfaceSourceWindowsHWND: c_int = 5;
pub const WGPUSType_SurfaceSourceXlibWindow: c_int = 6;
pub const WGPUSType_SurfaceSourceWaylandSurface: c_int = 7;
pub const WGPUSType_SurfaceSourceAndroidNativeWindow: c_int = 8;
pub const WGPUSType_SurfaceSourceXCBWindow: c_int = 9;
pub const WGPUSType_Force32: c_int = 2147483647;
pub const enum_WGPUSType = c_uint;
pub const WGPUSType = enum_WGPUSType;
pub const WGPUSamplerBindingType_BindingNotUsed: c_int = 0;
pub const WGPUSamplerBindingType_Undefined: c_int = 1;
pub const WGPUSamplerBindingType_Filtering: c_int = 2;
pub const WGPUSamplerBindingType_NonFiltering: c_int = 3;
pub const WGPUSamplerBindingType_Comparison: c_int = 4;
pub const WGPUSamplerBindingType_Force32: c_int = 2147483647;
pub const enum_WGPUSamplerBindingType = c_uint;
pub const WGPUSamplerBindingType = enum_WGPUSamplerBindingType;
pub const WGPUStatus_Success: c_int = 1;
pub const WGPUStatus_Error: c_int = 2;
pub const WGPUStatus_Force32: c_int = 2147483647;
pub const enum_WGPUStatus = c_uint;
pub const WGPUStatus = enum_WGPUStatus;
pub const WGPUStencilOperation_Undefined: c_int = 0;
pub const WGPUStencilOperation_Keep: c_int = 1;
pub const WGPUStencilOperation_Zero: c_int = 2;
pub const WGPUStencilOperation_Replace: c_int = 3;
pub const WGPUStencilOperation_Invert: c_int = 4;
pub const WGPUStencilOperation_IncrementClamp: c_int = 5;
pub const WGPUStencilOperation_DecrementClamp: c_int = 6;
pub const WGPUStencilOperation_IncrementWrap: c_int = 7;
pub const WGPUStencilOperation_DecrementWrap: c_int = 8;
pub const WGPUStencilOperation_Force32: c_int = 2147483647;
pub const enum_WGPUStencilOperation = c_uint;
pub const WGPUStencilOperation = enum_WGPUStencilOperation;
pub const WGPUStorageTextureAccess_BindingNotUsed: c_int = 0;
pub const WGPUStorageTextureAccess_Undefined: c_int = 1;
pub const WGPUStorageTextureAccess_WriteOnly: c_int = 2;
pub const WGPUStorageTextureAccess_ReadOnly: c_int = 3;
pub const WGPUStorageTextureAccess_ReadWrite: c_int = 4;
pub const WGPUStorageTextureAccess_Force32: c_int = 2147483647;
pub const enum_WGPUStorageTextureAccess = c_uint;
pub const WGPUStorageTextureAccess = enum_WGPUStorageTextureAccess;
pub const WGPUStoreOp_Undefined: c_int = 0;
pub const WGPUStoreOp_Store: c_int = 1;
pub const WGPUStoreOp_Discard: c_int = 2;
pub const WGPUStoreOp_Force32: c_int = 2147483647;
pub const enum_WGPUStoreOp = c_uint;
pub const WGPUStoreOp = enum_WGPUStoreOp;
pub const WGPUSurfaceGetCurrentTextureStatus_SuccessOptimal: c_int = 1;
pub const WGPUSurfaceGetCurrentTextureStatus_SuccessSuboptimal: c_int = 2;
pub const WGPUSurfaceGetCurrentTextureStatus_Timeout: c_int = 3;
pub const WGPUSurfaceGetCurrentTextureStatus_Outdated: c_int = 4;
pub const WGPUSurfaceGetCurrentTextureStatus_Lost: c_int = 5;
pub const WGPUSurfaceGetCurrentTextureStatus_OutOfMemory: c_int = 6;
pub const WGPUSurfaceGetCurrentTextureStatus_DeviceLost: c_int = 7;
pub const WGPUSurfaceGetCurrentTextureStatus_Error: c_int = 8;
pub const WGPUSurfaceGetCurrentTextureStatus_Force32: c_int = 2147483647;
pub const enum_WGPUSurfaceGetCurrentTextureStatus = c_uint;
pub const WGPUSurfaceGetCurrentTextureStatus = enum_WGPUSurfaceGetCurrentTextureStatus;
pub const WGPUTextureAspect_Undefined: c_int = 0;
pub const WGPUTextureAspect_All: c_int = 1;
pub const WGPUTextureAspect_StencilOnly: c_int = 2;
pub const WGPUTextureAspect_DepthOnly: c_int = 3;
pub const WGPUTextureAspect_Force32: c_int = 2147483647;
pub const enum_WGPUTextureAspect = c_uint;
pub const WGPUTextureAspect = enum_WGPUTextureAspect;
pub const WGPUTextureDimension_Undefined: c_int = 0;
pub const WGPUTextureDimension_1D: c_int = 1;
pub const WGPUTextureDimension_2D: c_int = 2;
pub const WGPUTextureDimension_3D: c_int = 3;
pub const WGPUTextureDimension_Force32: c_int = 2147483647;
pub const enum_WGPUTextureDimension = c_uint;
pub const WGPUTextureDimension = enum_WGPUTextureDimension;
pub const WGPUTextureFormat_Undefined: c_int = 0;
pub const WGPUTextureFormat_R8Unorm: c_int = 1;
pub const WGPUTextureFormat_R8Snorm: c_int = 2;
pub const WGPUTextureFormat_R8Uint: c_int = 3;
pub const WGPUTextureFormat_R8Sint: c_int = 4;
pub const WGPUTextureFormat_R16Uint: c_int = 5;
pub const WGPUTextureFormat_R16Sint: c_int = 6;
pub const WGPUTextureFormat_R16Float: c_int = 7;
pub const WGPUTextureFormat_RG8Unorm: c_int = 8;
pub const WGPUTextureFormat_RG8Snorm: c_int = 9;
pub const WGPUTextureFormat_RG8Uint: c_int = 10;
pub const WGPUTextureFormat_RG8Sint: c_int = 11;
pub const WGPUTextureFormat_R32Float: c_int = 12;
pub const WGPUTextureFormat_R32Uint: c_int = 13;
pub const WGPUTextureFormat_R32Sint: c_int = 14;
pub const WGPUTextureFormat_RG16Uint: c_int = 15;
pub const WGPUTextureFormat_RG16Sint: c_int = 16;
pub const WGPUTextureFormat_RG16Float: c_int = 17;
pub const WGPUTextureFormat_RGBA8Unorm: c_int = 18;
pub const WGPUTextureFormat_RGBA8UnormSrgb: c_int = 19;
pub const WGPUTextureFormat_RGBA8Snorm: c_int = 20;
pub const WGPUTextureFormat_RGBA8Uint: c_int = 21;
pub const WGPUTextureFormat_RGBA8Sint: c_int = 22;
pub const WGPUTextureFormat_BGRA8Unorm: c_int = 23;
pub const WGPUTextureFormat_BGRA8UnormSrgb: c_int = 24;
pub const WGPUTextureFormat_RGB10A2Uint: c_int = 25;
pub const WGPUTextureFormat_RGB10A2Unorm: c_int = 26;
pub const WGPUTextureFormat_RG11B10Ufloat: c_int = 27;
pub const WGPUTextureFormat_RGB9E5Ufloat: c_int = 28;
pub const WGPUTextureFormat_RG32Float: c_int = 29;
pub const WGPUTextureFormat_RG32Uint: c_int = 30;
pub const WGPUTextureFormat_RG32Sint: c_int = 31;
pub const WGPUTextureFormat_RGBA16Uint: c_int = 32;
pub const WGPUTextureFormat_RGBA16Sint: c_int = 33;
pub const WGPUTextureFormat_RGBA16Float: c_int = 34;
pub const WGPUTextureFormat_RGBA32Float: c_int = 35;
pub const WGPUTextureFormat_RGBA32Uint: c_int = 36;
pub const WGPUTextureFormat_RGBA32Sint: c_int = 37;
pub const WGPUTextureFormat_Stencil8: c_int = 38;
pub const WGPUTextureFormat_Depth16Unorm: c_int = 39;
pub const WGPUTextureFormat_Depth24Plus: c_int = 40;
pub const WGPUTextureFormat_Depth24PlusStencil8: c_int = 41;
pub const WGPUTextureFormat_Depth32Float: c_int = 42;
pub const WGPUTextureFormat_Depth32FloatStencil8: c_int = 43;
pub const WGPUTextureFormat_BC1RGBAUnorm: c_int = 44;
pub const WGPUTextureFormat_BC1RGBAUnormSrgb: c_int = 45;
pub const WGPUTextureFormat_BC2RGBAUnorm: c_int = 46;
pub const WGPUTextureFormat_BC2RGBAUnormSrgb: c_int = 47;
pub const WGPUTextureFormat_BC3RGBAUnorm: c_int = 48;
pub const WGPUTextureFormat_BC3RGBAUnormSrgb: c_int = 49;
pub const WGPUTextureFormat_BC4RUnorm: c_int = 50;
pub const WGPUTextureFormat_BC4RSnorm: c_int = 51;
pub const WGPUTextureFormat_BC5RGUnorm: c_int = 52;
pub const WGPUTextureFormat_BC5RGSnorm: c_int = 53;
pub const WGPUTextureFormat_BC6HRGBUfloat: c_int = 54;
pub const WGPUTextureFormat_BC6HRGBFloat: c_int = 55;
pub const WGPUTextureFormat_BC7RGBAUnorm: c_int = 56;
pub const WGPUTextureFormat_BC7RGBAUnormSrgb: c_int = 57;
pub const WGPUTextureFormat_ETC2RGB8Unorm: c_int = 58;
pub const WGPUTextureFormat_ETC2RGB8UnormSrgb: c_int = 59;
pub const WGPUTextureFormat_ETC2RGB8A1Unorm: c_int = 60;
pub const WGPUTextureFormat_ETC2RGB8A1UnormSrgb: c_int = 61;
pub const WGPUTextureFormat_ETC2RGBA8Unorm: c_int = 62;
pub const WGPUTextureFormat_ETC2RGBA8UnormSrgb: c_int = 63;
pub const WGPUTextureFormat_EACR11Unorm: c_int = 64;
pub const WGPUTextureFormat_EACR11Snorm: c_int = 65;
pub const WGPUTextureFormat_EACRG11Unorm: c_int = 66;
pub const WGPUTextureFormat_EACRG11Snorm: c_int = 67;
pub const WGPUTextureFormat_ASTC4x4Unorm: c_int = 68;
pub const WGPUTextureFormat_ASTC4x4UnormSrgb: c_int = 69;
pub const WGPUTextureFormat_ASTC5x4Unorm: c_int = 70;
pub const WGPUTextureFormat_ASTC5x4UnormSrgb: c_int = 71;
pub const WGPUTextureFormat_ASTC5x5Unorm: c_int = 72;
pub const WGPUTextureFormat_ASTC5x5UnormSrgb: c_int = 73;
pub const WGPUTextureFormat_ASTC6x5Unorm: c_int = 74;
pub const WGPUTextureFormat_ASTC6x5UnormSrgb: c_int = 75;
pub const WGPUTextureFormat_ASTC6x6Unorm: c_int = 76;
pub const WGPUTextureFormat_ASTC6x6UnormSrgb: c_int = 77;
pub const WGPUTextureFormat_ASTC8x5Unorm: c_int = 78;
pub const WGPUTextureFormat_ASTC8x5UnormSrgb: c_int = 79;
pub const WGPUTextureFormat_ASTC8x6Unorm: c_int = 80;
pub const WGPUTextureFormat_ASTC8x6UnormSrgb: c_int = 81;
pub const WGPUTextureFormat_ASTC8x8Unorm: c_int = 82;
pub const WGPUTextureFormat_ASTC8x8UnormSrgb: c_int = 83;
pub const WGPUTextureFormat_ASTC10x5Unorm: c_int = 84;
pub const WGPUTextureFormat_ASTC10x5UnormSrgb: c_int = 85;
pub const WGPUTextureFormat_ASTC10x6Unorm: c_int = 86;
pub const WGPUTextureFormat_ASTC10x6UnormSrgb: c_int = 87;
pub const WGPUTextureFormat_ASTC10x8Unorm: c_int = 88;
pub const WGPUTextureFormat_ASTC10x8UnormSrgb: c_int = 89;
pub const WGPUTextureFormat_ASTC10x10Unorm: c_int = 90;
pub const WGPUTextureFormat_ASTC10x10UnormSrgb: c_int = 91;
pub const WGPUTextureFormat_ASTC12x10Unorm: c_int = 92;
pub const WGPUTextureFormat_ASTC12x10UnormSrgb: c_int = 93;
pub const WGPUTextureFormat_ASTC12x12Unorm: c_int = 94;
pub const WGPUTextureFormat_ASTC12x12UnormSrgb: c_int = 95;
pub const WGPUTextureFormat_Force32: c_int = 2147483647;
pub const enum_WGPUTextureFormat = c_uint;
pub const WGPUTextureFormat = enum_WGPUTextureFormat;
pub const WGPUTextureSampleType_BindingNotUsed: c_int = 0;
pub const WGPUTextureSampleType_Undefined: c_int = 1;
pub const WGPUTextureSampleType_Float: c_int = 2;
pub const WGPUTextureSampleType_UnfilterableFloat: c_int = 3;
pub const WGPUTextureSampleType_Depth: c_int = 4;
pub const WGPUTextureSampleType_Sint: c_int = 5;
pub const WGPUTextureSampleType_Uint: c_int = 6;
pub const WGPUTextureSampleType_Force32: c_int = 2147483647;
pub const enum_WGPUTextureSampleType = c_uint;
pub const WGPUTextureSampleType = enum_WGPUTextureSampleType;
pub const WGPUTextureViewDimension_Undefined: c_int = 0;
pub const WGPUTextureViewDimension_1D: c_int = 1;
pub const WGPUTextureViewDimension_2D: c_int = 2;
pub const WGPUTextureViewDimension_2DArray: c_int = 3;
pub const WGPUTextureViewDimension_Cube: c_int = 4;
pub const WGPUTextureViewDimension_CubeArray: c_int = 5;
pub const WGPUTextureViewDimension_3D: c_int = 6;
pub const WGPUTextureViewDimension_Force32: c_int = 2147483647;
pub const enum_WGPUTextureViewDimension = c_uint;
pub const WGPUTextureViewDimension = enum_WGPUTextureViewDimension;
pub const WGPUVertexFormat_Uint8: c_int = 1;
pub const WGPUVertexFormat_Uint8x2: c_int = 2;
pub const WGPUVertexFormat_Uint8x4: c_int = 3;
pub const WGPUVertexFormat_Sint8: c_int = 4;
pub const WGPUVertexFormat_Sint8x2: c_int = 5;
pub const WGPUVertexFormat_Sint8x4: c_int = 6;
pub const WGPUVertexFormat_Unorm8: c_int = 7;
pub const WGPUVertexFormat_Unorm8x2: c_int = 8;
pub const WGPUVertexFormat_Unorm8x4: c_int = 9;
pub const WGPUVertexFormat_Snorm8: c_int = 10;
pub const WGPUVertexFormat_Snorm8x2: c_int = 11;
pub const WGPUVertexFormat_Snorm8x4: c_int = 12;
pub const WGPUVertexFormat_Uint16: c_int = 13;
pub const WGPUVertexFormat_Uint16x2: c_int = 14;
pub const WGPUVertexFormat_Uint16x4: c_int = 15;
pub const WGPUVertexFormat_Sint16: c_int = 16;
pub const WGPUVertexFormat_Sint16x2: c_int = 17;
pub const WGPUVertexFormat_Sint16x4: c_int = 18;
pub const WGPUVertexFormat_Unorm16: c_int = 19;
pub const WGPUVertexFormat_Unorm16x2: c_int = 20;
pub const WGPUVertexFormat_Unorm16x4: c_int = 21;
pub const WGPUVertexFormat_Snorm16: c_int = 22;
pub const WGPUVertexFormat_Snorm16x2: c_int = 23;
pub const WGPUVertexFormat_Snorm16x4: c_int = 24;
pub const WGPUVertexFormat_Float16: c_int = 25;
pub const WGPUVertexFormat_Float16x2: c_int = 26;
pub const WGPUVertexFormat_Float16x4: c_int = 27;
pub const WGPUVertexFormat_Float32: c_int = 28;
pub const WGPUVertexFormat_Float32x2: c_int = 29;
pub const WGPUVertexFormat_Float32x3: c_int = 30;
pub const WGPUVertexFormat_Float32x4: c_int = 31;
pub const WGPUVertexFormat_Uint32: c_int = 32;
pub const WGPUVertexFormat_Uint32x2: c_int = 33;
pub const WGPUVertexFormat_Uint32x3: c_int = 34;
pub const WGPUVertexFormat_Uint32x4: c_int = 35;
pub const WGPUVertexFormat_Sint32: c_int = 36;
pub const WGPUVertexFormat_Sint32x2: c_int = 37;
pub const WGPUVertexFormat_Sint32x3: c_int = 38;
pub const WGPUVertexFormat_Sint32x4: c_int = 39;
pub const WGPUVertexFormat_Unorm10_10_10_2: c_int = 40;
pub const WGPUVertexFormat_Unorm8x4BGRA: c_int = 41;
pub const WGPUVertexFormat_Force32: c_int = 2147483647;
pub const enum_WGPUVertexFormat = c_uint;
pub const WGPUVertexFormat = enum_WGPUVertexFormat;
pub const WGPUVertexStepMode_VertexBufferNotUsed: c_int = 0;
pub const WGPUVertexStepMode_Undefined: c_int = 1;
pub const WGPUVertexStepMode_Vertex: c_int = 2;
pub const WGPUVertexStepMode_Instance: c_int = 3;
pub const WGPUVertexStepMode_Force32: c_int = 2147483647;
pub const enum_WGPUVertexStepMode = c_uint;
pub const WGPUVertexStepMode = enum_WGPUVertexStepMode;
pub const WGPUWGSLLanguageFeatureName_ReadonlyAndReadwriteStorageTextures: c_int = 1;
pub const WGPUWGSLLanguageFeatureName_Packed4x8IntegerDotProduct: c_int = 2;
pub const WGPUWGSLLanguageFeatureName_UnrestrictedPointerParameters: c_int = 3;
pub const WGPUWGSLLanguageFeatureName_PointerCompositeAccess: c_int = 4;
pub const WGPUWGSLLanguageFeatureName_Force32: c_int = 2147483647;
pub const enum_WGPUWGSLLanguageFeatureName = c_uint;
pub const WGPUWGSLLanguageFeatureName = enum_WGPUWGSLLanguageFeatureName;
pub const WGPUWaitStatus_Success: c_int = 1;
pub const WGPUWaitStatus_TimedOut: c_int = 2;
pub const WGPUWaitStatus_UnsupportedTimeout: c_int = 3;
pub const WGPUWaitStatus_UnsupportedCount: c_int = 4;
pub const WGPUWaitStatus_UnsupportedMixedSources: c_int = 5;
pub const WGPUWaitStatus_Force32: c_int = 2147483647;
pub const enum_WGPUWaitStatus = c_uint;
pub const WGPUWaitStatus = enum_WGPUWaitStatus;
pub const WGPUBufferUsage = WGPUFlags;
pub const WGPUBufferUsage_None: WGPUBufferUsage = 0;
pub const WGPUBufferUsage_MapRead: WGPUBufferUsage = 1;
pub const WGPUBufferUsage_MapWrite: WGPUBufferUsage = 2;
pub const WGPUBufferUsage_CopySrc: WGPUBufferUsage = 4;
pub const WGPUBufferUsage_CopyDst: WGPUBufferUsage = 8;
pub const WGPUBufferUsage_Index: WGPUBufferUsage = 16;
pub const WGPUBufferUsage_Vertex: WGPUBufferUsage = 32;
pub const WGPUBufferUsage_Uniform: WGPUBufferUsage = 64;
pub const WGPUBufferUsage_Storage: WGPUBufferUsage = 128;
pub const WGPUBufferUsage_Indirect: WGPUBufferUsage = 256;
pub const WGPUBufferUsage_QueryResolve: WGPUBufferUsage = 512;
pub const WGPUColorWriteMask = WGPUFlags;
pub const WGPUColorWriteMask_None: WGPUColorWriteMask = 0;
pub const WGPUColorWriteMask_Red: WGPUColorWriteMask = 1;
pub const WGPUColorWriteMask_Green: WGPUColorWriteMask = 2;
pub const WGPUColorWriteMask_Blue: WGPUColorWriteMask = 4;
pub const WGPUColorWriteMask_Alpha: WGPUColorWriteMask = 8;
pub const WGPUColorWriteMask_All: WGPUColorWriteMask = 15;
pub const WGPUMapMode = WGPUFlags;
pub const WGPUMapMode_None: WGPUMapMode = 0;
pub const WGPUMapMode_Read: WGPUMapMode = 1;
pub const WGPUMapMode_Write: WGPUMapMode = 2;
pub const WGPUShaderStage = WGPUFlags;
pub const WGPUShaderStage_None: WGPUShaderStage = 0;
pub const WGPUShaderStage_Vertex: WGPUShaderStage = 1;
pub const WGPUShaderStage_Fragment: WGPUShaderStage = 2;
pub const WGPUShaderStage_Compute: WGPUShaderStage = 4;
pub const WGPUTextureUsage = WGPUFlags;
pub const WGPUTextureUsage_None: WGPUTextureUsage = 0;
pub const WGPUTextureUsage_CopySrc: WGPUTextureUsage = 1;
pub const WGPUTextureUsage_CopyDst: WGPUTextureUsage = 2;
pub const WGPUTextureUsage_TextureBinding: WGPUTextureUsage = 4;
pub const WGPUTextureUsage_StorageBinding: WGPUTextureUsage = 8;
pub const WGPUTextureUsage_RenderAttachment: WGPUTextureUsage = 16;
pub const WGPUProc = ?*const fn () callconv(.c) void;
pub const WGPUBufferMapCallback = ?*const fn (status: WGPUMapAsyncStatus, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPUChainedStruct = extern struct {
    next: [*c]const struct_WGPUChainedStruct = null,
    sType: WGPUSType = @import("std").mem.zeroes(WGPUSType),
};
pub const WGPUChainedStruct = struct_WGPUChainedStruct;
pub const struct_WGPUCompilationMessage = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    message: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    type: WGPUCompilationMessageType = @import("std").mem.zeroes(WGPUCompilationMessageType),
    lineNum: u64 = 0,
    linePos: u64 = 0,
    offset: u64 = 0,
    length: u64 = 0,
};
pub const WGPUCompilationMessage = struct_WGPUCompilationMessage;
pub const struct_WGPUCompilationInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    messageCount: usize = 0,
    messages: [*c]const WGPUCompilationMessage = null,
};
pub const WGPUCompilationInfoCallback = ?*const fn (status: WGPUCompilationInfoRequestStatus, compilationInfo: [*c]const struct_WGPUCompilationInfo, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const WGPUCreateComputePipelineAsyncCallback = ?*const fn (status: WGPUCreatePipelineAsyncStatus, pipeline: WGPUComputePipeline, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const WGPUCreateRenderPipelineAsyncCallback = ?*const fn (status: WGPUCreatePipelineAsyncStatus, pipeline: WGPURenderPipeline, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const WGPUDeviceLostCallback = ?*const fn (device: [*c]const WGPUDevice, reason: WGPUDeviceLostReason, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const WGPUPopErrorScopeCallback = ?*const fn (status: WGPUPopErrorScopeStatus, @"type": WGPUErrorType, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const WGPUQueueWorkDoneCallback = ?*const fn (status: WGPUQueueWorkDoneStatus, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const WGPURequestAdapterCallback = ?*const fn (status: WGPURequestAdapterStatus, adapter: WGPUAdapter, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const WGPURequestDeviceCallback = ?*const fn (status: WGPURequestDeviceStatus, device: WGPUDevice, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const WGPUUncapturedErrorCallback = ?*const fn (device: [*c]const WGPUDevice, @"type": WGPUErrorType, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPUChainedStructOut = extern struct {
    next: [*c]struct_WGPUChainedStructOut = null,
    sType: WGPUSType = @import("std").mem.zeroes(WGPUSType),
};
pub const WGPUChainedStructOut = struct_WGPUChainedStructOut;
pub const struct_WGPUBufferMapCallbackInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUBufferMapCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUBufferMapCallbackInfo = struct_WGPUBufferMapCallbackInfo;
pub const struct_WGPUCompilationInfoCallbackInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUCompilationInfoCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUCompilationInfoCallbackInfo = struct_WGPUCompilationInfoCallbackInfo;
pub const struct_WGPUCreateComputePipelineAsyncCallbackInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUCreateComputePipelineAsyncCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUCreateComputePipelineAsyncCallbackInfo = struct_WGPUCreateComputePipelineAsyncCallbackInfo;
pub const struct_WGPUCreateRenderPipelineAsyncCallbackInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUCreateRenderPipelineAsyncCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUCreateRenderPipelineAsyncCallbackInfo = struct_WGPUCreateRenderPipelineAsyncCallbackInfo;
pub const struct_WGPUDeviceLostCallbackInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUDeviceLostCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUDeviceLostCallbackInfo = struct_WGPUDeviceLostCallbackInfo;
pub const struct_WGPUPopErrorScopeCallbackInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUPopErrorScopeCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUPopErrorScopeCallbackInfo = struct_WGPUPopErrorScopeCallbackInfo;
pub const struct_WGPUQueueWorkDoneCallbackInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUQueueWorkDoneCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUQueueWorkDoneCallbackInfo = struct_WGPUQueueWorkDoneCallbackInfo;
pub const struct_WGPURequestAdapterCallbackInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPURequestAdapterCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPURequestAdapterCallbackInfo = struct_WGPURequestAdapterCallbackInfo;
pub const struct_WGPURequestDeviceCallbackInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPURequestDeviceCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPURequestDeviceCallbackInfo = struct_WGPURequestDeviceCallbackInfo;
pub const struct_WGPUUncapturedErrorCallbackInfo = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    callback: WGPUUncapturedErrorCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUUncapturedErrorCallbackInfo = struct_WGPUUncapturedErrorCallbackInfo;
pub const struct_WGPUAdapterInfo = extern struct {
    nextInChain: [*c]WGPUChainedStructOut = null,
    vendor: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    architecture: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    device: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    description: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    backendType: WGPUBackendType = @import("std").mem.zeroes(WGPUBackendType),
    adapterType: WGPUAdapterType = @import("std").mem.zeroes(WGPUAdapterType),
    vendorID: u32 = 0,
    deviceID: u32 = 0,
    pub const wgpuAdapterInfoFreeMembers = __root.wgpuAdapterInfoFreeMembers;
};
pub const WGPUAdapterInfo = struct_WGPUAdapterInfo;
pub const struct_WGPUBindGroupEntry = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    binding: u32 = 0,
    buffer: WGPUBuffer = null,
    offset: u64 = 0,
    size: u64 = 0,
    sampler: WGPUSampler = null,
    textureView: WGPUTextureView = null,
};
pub const WGPUBindGroupEntry = struct_WGPUBindGroupEntry;
pub const struct_WGPUBlendComponent = extern struct {
    operation: WGPUBlendOperation = @import("std").mem.zeroes(WGPUBlendOperation),
    srcFactor: WGPUBlendFactor = @import("std").mem.zeroes(WGPUBlendFactor),
    dstFactor: WGPUBlendFactor = @import("std").mem.zeroes(WGPUBlendFactor),
};
pub const WGPUBlendComponent = struct_WGPUBlendComponent;
pub const struct_WGPUBufferBindingLayout = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    type: WGPUBufferBindingType = @import("std").mem.zeroes(WGPUBufferBindingType),
    hasDynamicOffset: WGPUBool = 0,
    minBindingSize: u64 = 0,
};
pub const WGPUBufferBindingLayout = struct_WGPUBufferBindingLayout;
pub const struct_WGPUBufferDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    usage: WGPUBufferUsage = 0,
    size: u64 = 0,
    mappedAtCreation: WGPUBool = 0,
};
pub const WGPUBufferDescriptor = struct_WGPUBufferDescriptor;
pub const struct_WGPUColor = extern struct {
    r: f64 = 0,
    g: f64 = 0,
    b: f64 = 0,
    a: f64 = 0,
};
pub const WGPUColor = struct_WGPUColor;
pub const struct_WGPUCommandBufferDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUCommandBufferDescriptor = struct_WGPUCommandBufferDescriptor;
pub const struct_WGPUCommandEncoderDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUCommandEncoderDescriptor = struct_WGPUCommandEncoderDescriptor;
pub const struct_WGPUComputePassTimestampWrites = extern struct {
    querySet: WGPUQuerySet = null,
    beginningOfPassWriteIndex: u32 = 0,
    endOfPassWriteIndex: u32 = 0,
};
pub const WGPUComputePassTimestampWrites = struct_WGPUComputePassTimestampWrites;
pub const struct_WGPUConstantEntry = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    key: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    value: f64 = 0,
};
pub const WGPUConstantEntry = struct_WGPUConstantEntry;
pub const struct_WGPUExtent3D = extern struct {
    width: u32 = 0,
    height: u32 = 0,
    depthOrArrayLayers: u32 = 0,
};
pub const WGPUExtent3D = struct_WGPUExtent3D;
pub const struct_WGPUFuture = extern struct {
    id: u64 = 0,
};
pub const WGPUFuture = struct_WGPUFuture;
pub const struct_WGPUInstanceCapabilities = extern struct {
    nextInChain: [*c]WGPUChainedStructOut = null,
    timedWaitAnyEnable: WGPUBool = 0,
    timedWaitAnyMaxCount: usize = 0,
    pub const wgpuGetInstanceCapabilities = __root.wgpuGetInstanceCapabilities;
};
pub const WGPUInstanceCapabilities = struct_WGPUInstanceCapabilities;
pub const struct_WGPULimits = extern struct {
    nextInChain: [*c]WGPUChainedStructOut = null,
    maxTextureDimension1D: u32 = 0,
    maxTextureDimension2D: u32 = 0,
    maxTextureDimension3D: u32 = 0,
    maxTextureArrayLayers: u32 = 0,
    maxBindGroups: u32 = 0,
    maxBindGroupsPlusVertexBuffers: u32 = 0,
    maxBindingsPerBindGroup: u32 = 0,
    maxDynamicUniformBuffersPerPipelineLayout: u32 = 0,
    maxDynamicStorageBuffersPerPipelineLayout: u32 = 0,
    maxSampledTexturesPerShaderStage: u32 = 0,
    maxSamplersPerShaderStage: u32 = 0,
    maxStorageBuffersPerShaderStage: u32 = 0,
    maxStorageTexturesPerShaderStage: u32 = 0,
    maxUniformBuffersPerShaderStage: u32 = 0,
    maxUniformBufferBindingSize: u64 = 0,
    maxStorageBufferBindingSize: u64 = 0,
    minUniformBufferOffsetAlignment: u32 = 0,
    minStorageBufferOffsetAlignment: u32 = 0,
    maxVertexBuffers: u32 = 0,
    maxBufferSize: u64 = 0,
    maxVertexAttributes: u32 = 0,
    maxVertexBufferArrayStride: u32 = 0,
    maxInterStageShaderVariables: u32 = 0,
    maxColorAttachments: u32 = 0,
    maxColorAttachmentBytesPerSample: u32 = 0,
    maxComputeWorkgroupStorageSize: u32 = 0,
    maxComputeInvocationsPerWorkgroup: u32 = 0,
    maxComputeWorkgroupSizeX: u32 = 0,
    maxComputeWorkgroupSizeY: u32 = 0,
    maxComputeWorkgroupSizeZ: u32 = 0,
    maxComputeWorkgroupsPerDimension: u32 = 0,
};
pub const WGPULimits = struct_WGPULimits;
pub const struct_WGPUMultisampleState = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    count: u32 = 0,
    mask: u32 = 0,
    alphaToCoverageEnabled: WGPUBool = 0,
};
pub const WGPUMultisampleState = struct_WGPUMultisampleState;
pub const struct_WGPUOrigin3D = extern struct {
    x: u32 = 0,
    y: u32 = 0,
    z: u32 = 0,
};
pub const WGPUOrigin3D = struct_WGPUOrigin3D;
pub const struct_WGPUPipelineLayoutDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    bindGroupLayoutCount: usize = 0,
    bindGroupLayouts: [*c]const WGPUBindGroupLayout = null,
};
pub const WGPUPipelineLayoutDescriptor = struct_WGPUPipelineLayoutDescriptor;
pub const struct_WGPUPrimitiveState = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    topology: WGPUPrimitiveTopology = @import("std").mem.zeroes(WGPUPrimitiveTopology),
    stripIndexFormat: WGPUIndexFormat = @import("std").mem.zeroes(WGPUIndexFormat),
    frontFace: WGPUFrontFace = @import("std").mem.zeroes(WGPUFrontFace),
    cullMode: WGPUCullMode = @import("std").mem.zeroes(WGPUCullMode),
    unclippedDepth: WGPUBool = 0,
};
pub const WGPUPrimitiveState = struct_WGPUPrimitiveState;
pub const struct_WGPUQuerySetDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    type: WGPUQueryType = @import("std").mem.zeroes(WGPUQueryType),
    count: u32 = 0,
};
pub const WGPUQuerySetDescriptor = struct_WGPUQuerySetDescriptor;
pub const struct_WGPUQueueDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUQueueDescriptor = struct_WGPUQueueDescriptor;
pub const struct_WGPURenderBundleDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPURenderBundleDescriptor = struct_WGPURenderBundleDescriptor;
pub const struct_WGPURenderBundleEncoderDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    colorFormatCount: usize = 0,
    colorFormats: [*c]const WGPUTextureFormat = null,
    depthStencilFormat: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    sampleCount: u32 = 0,
    depthReadOnly: WGPUBool = 0,
    stencilReadOnly: WGPUBool = 0,
};
pub const WGPURenderBundleEncoderDescriptor = struct_WGPURenderBundleEncoderDescriptor;
pub const struct_WGPURenderPassDepthStencilAttachment = extern struct {
    view: WGPUTextureView = null,
    depthLoadOp: WGPULoadOp = @import("std").mem.zeroes(WGPULoadOp),
    depthStoreOp: WGPUStoreOp = @import("std").mem.zeroes(WGPUStoreOp),
    depthClearValue: f32 = 0,
    depthReadOnly: WGPUBool = 0,
    stencilLoadOp: WGPULoadOp = @import("std").mem.zeroes(WGPULoadOp),
    stencilStoreOp: WGPUStoreOp = @import("std").mem.zeroes(WGPUStoreOp),
    stencilClearValue: u32 = 0,
    stencilReadOnly: WGPUBool = 0,
};
pub const WGPURenderPassDepthStencilAttachment = struct_WGPURenderPassDepthStencilAttachment;
pub const struct_WGPURenderPassMaxDrawCount = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    maxDrawCount: u64 = 0,
};
pub const WGPURenderPassMaxDrawCount = struct_WGPURenderPassMaxDrawCount;
pub const struct_WGPURenderPassTimestampWrites = extern struct {
    querySet: WGPUQuerySet = null,
    beginningOfPassWriteIndex: u32 = 0,
    endOfPassWriteIndex: u32 = 0,
};
pub const WGPURenderPassTimestampWrites = struct_WGPURenderPassTimestampWrites;
pub const struct_WGPURequestAdapterOptions = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    featureLevel: WGPUFeatureLevel = @import("std").mem.zeroes(WGPUFeatureLevel),
    powerPreference: WGPUPowerPreference = @import("std").mem.zeroes(WGPUPowerPreference),
    forceFallbackAdapter: WGPUBool = 0,
    backendType: WGPUBackendType = @import("std").mem.zeroes(WGPUBackendType),
    compatibleSurface: WGPUSurface = null,
};
pub const WGPURequestAdapterOptions = struct_WGPURequestAdapterOptions;
pub const struct_WGPUSamplerBindingLayout = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    type: WGPUSamplerBindingType = @import("std").mem.zeroes(WGPUSamplerBindingType),
};
pub const WGPUSamplerBindingLayout = struct_WGPUSamplerBindingLayout;
pub const struct_WGPUSamplerDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    addressModeU: WGPUAddressMode = @import("std").mem.zeroes(WGPUAddressMode),
    addressModeV: WGPUAddressMode = @import("std").mem.zeroes(WGPUAddressMode),
    addressModeW: WGPUAddressMode = @import("std").mem.zeroes(WGPUAddressMode),
    magFilter: WGPUFilterMode = @import("std").mem.zeroes(WGPUFilterMode),
    minFilter: WGPUFilterMode = @import("std").mem.zeroes(WGPUFilterMode),
    mipmapFilter: WGPUMipmapFilterMode = @import("std").mem.zeroes(WGPUMipmapFilterMode),
    lodMinClamp: f32 = 0,
    lodMaxClamp: f32 = 0,
    compare: WGPUCompareFunction = @import("std").mem.zeroes(WGPUCompareFunction),
    maxAnisotropy: u16 = 0,
};
pub const WGPUSamplerDescriptor = struct_WGPUSamplerDescriptor;
pub const struct_WGPUShaderModuleDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUShaderModuleDescriptor = struct_WGPUShaderModuleDescriptor;
pub const struct_WGPUShaderSourceSPIRV = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    codeSize: u32 = 0,
    code: [*c]const u32 = null,
};
pub const WGPUShaderSourceSPIRV = struct_WGPUShaderSourceSPIRV;
pub const struct_WGPUShaderSourceWGSL = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    code: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUShaderSourceWGSL = struct_WGPUShaderSourceWGSL;
pub const struct_WGPUStencilFaceState = extern struct {
    compare: WGPUCompareFunction = @import("std").mem.zeroes(WGPUCompareFunction),
    failOp: WGPUStencilOperation = @import("std").mem.zeroes(WGPUStencilOperation),
    depthFailOp: WGPUStencilOperation = @import("std").mem.zeroes(WGPUStencilOperation),
    passOp: WGPUStencilOperation = @import("std").mem.zeroes(WGPUStencilOperation),
};
pub const WGPUStencilFaceState = struct_WGPUStencilFaceState;
pub const struct_WGPUStorageTextureBindingLayout = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    access: WGPUStorageTextureAccess = @import("std").mem.zeroes(WGPUStorageTextureAccess),
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    viewDimension: WGPUTextureViewDimension = @import("std").mem.zeroes(WGPUTextureViewDimension),
};
pub const WGPUStorageTextureBindingLayout = struct_WGPUStorageTextureBindingLayout;
pub const struct_WGPUSupportedFeatures = extern struct {
    featureCount: usize = 0,
    features: [*c]const WGPUFeatureName = null,
    pub const wgpuSupportedFeaturesFreeMembers = __root.wgpuSupportedFeaturesFreeMembers;
};
pub const WGPUSupportedFeatures = struct_WGPUSupportedFeatures;
pub const struct_WGPUSupportedWGSLLanguageFeatures = extern struct {
    featureCount: usize = 0,
    features: [*c]const WGPUWGSLLanguageFeatureName = null,
    pub const wgpuSupportedWGSLLanguageFeaturesFreeMembers = __root.wgpuSupportedWGSLLanguageFeaturesFreeMembers;
};
pub const WGPUSupportedWGSLLanguageFeatures = struct_WGPUSupportedWGSLLanguageFeatures;
pub const struct_WGPUSurfaceCapabilities = extern struct {
    nextInChain: [*c]WGPUChainedStructOut = null,
    usages: WGPUTextureUsage = 0,
    formatCount: usize = 0,
    formats: [*c]const WGPUTextureFormat = null,
    presentModeCount: usize = 0,
    presentModes: [*c]const WGPUPresentMode = null,
    alphaModeCount: usize = 0,
    alphaModes: [*c]const WGPUCompositeAlphaMode = null,
    pub const wgpuSurfaceCapabilitiesFreeMembers = __root.wgpuSurfaceCapabilitiesFreeMembers;
};
pub const WGPUSurfaceCapabilities = struct_WGPUSurfaceCapabilities;
pub const struct_WGPUSurfaceConfiguration = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    device: WGPUDevice = null,
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    usage: WGPUTextureUsage = 0,
    width: u32 = 0,
    height: u32 = 0,
    viewFormatCount: usize = 0,
    viewFormats: [*c]const WGPUTextureFormat = null,
    alphaMode: WGPUCompositeAlphaMode = @import("std").mem.zeroes(WGPUCompositeAlphaMode),
    presentMode: WGPUPresentMode = @import("std").mem.zeroes(WGPUPresentMode),
};
pub const WGPUSurfaceConfiguration = struct_WGPUSurfaceConfiguration;
pub const struct_WGPUSurfaceDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUSurfaceDescriptor = struct_WGPUSurfaceDescriptor;
pub const struct_WGPUSurfaceSourceAndroidNativeWindow = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    window: ?*anyopaque = null,
};
pub const WGPUSurfaceSourceAndroidNativeWindow = struct_WGPUSurfaceSourceAndroidNativeWindow;
pub const struct_WGPUSurfaceSourceMetalLayer = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    layer: ?*anyopaque = null,
};
pub const WGPUSurfaceSourceMetalLayer = struct_WGPUSurfaceSourceMetalLayer;
pub const struct_WGPUSurfaceSourceWaylandSurface = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    display: ?*anyopaque = null,
    surface: ?*anyopaque = null,
};
pub const WGPUSurfaceSourceWaylandSurface = struct_WGPUSurfaceSourceWaylandSurface;
pub const struct_WGPUSurfaceSourceWindowsHWND = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    hinstance: ?*anyopaque = null,
    hwnd: ?*anyopaque = null,
};
pub const WGPUSurfaceSourceWindowsHWND = struct_WGPUSurfaceSourceWindowsHWND;
pub const struct_WGPUSurfaceSourceXCBWindow = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    connection: ?*anyopaque = null,
    window: u32 = 0,
};
pub const WGPUSurfaceSourceXCBWindow = struct_WGPUSurfaceSourceXCBWindow;
pub const struct_WGPUSurfaceSourceXlibWindow = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    display: ?*anyopaque = null,
    window: u64 = 0,
};
pub const WGPUSurfaceSourceXlibWindow = struct_WGPUSurfaceSourceXlibWindow;
pub const struct_WGPUSurfaceTexture = extern struct {
    nextInChain: [*c]WGPUChainedStructOut = null,
    texture: WGPUTexture = null,
    status: WGPUSurfaceGetCurrentTextureStatus = @import("std").mem.zeroes(WGPUSurfaceGetCurrentTextureStatus),
};
pub const WGPUSurfaceTexture = struct_WGPUSurfaceTexture;
pub const struct_WGPUTexelCopyBufferLayout = extern struct {
    offset: u64 = 0,
    bytesPerRow: u32 = 0,
    rowsPerImage: u32 = 0,
};
pub const WGPUTexelCopyBufferLayout = struct_WGPUTexelCopyBufferLayout;
pub const struct_WGPUTextureBindingLayout = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    sampleType: WGPUTextureSampleType = @import("std").mem.zeroes(WGPUTextureSampleType),
    viewDimension: WGPUTextureViewDimension = @import("std").mem.zeroes(WGPUTextureViewDimension),
    multisampled: WGPUBool = 0,
};
pub const WGPUTextureBindingLayout = struct_WGPUTextureBindingLayout;
pub const struct_WGPUTextureViewDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    dimension: WGPUTextureViewDimension = @import("std").mem.zeroes(WGPUTextureViewDimension),
    baseMipLevel: u32 = 0,
    mipLevelCount: u32 = 0,
    baseArrayLayer: u32 = 0,
    arrayLayerCount: u32 = 0,
    aspect: WGPUTextureAspect = @import("std").mem.zeroes(WGPUTextureAspect),
    usage: WGPUTextureUsage = 0,
};
pub const WGPUTextureViewDescriptor = struct_WGPUTextureViewDescriptor;
pub const struct_WGPUVertexAttribute = extern struct {
    format: WGPUVertexFormat = @import("std").mem.zeroes(WGPUVertexFormat),
    offset: u64 = 0,
    shaderLocation: u32 = 0,
};
pub const WGPUVertexAttribute = struct_WGPUVertexAttribute;
pub const struct_WGPUBindGroupDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    layout: WGPUBindGroupLayout = null,
    entryCount: usize = 0,
    entries: [*c]const WGPUBindGroupEntry = null,
};
pub const WGPUBindGroupDescriptor = struct_WGPUBindGroupDescriptor;
pub const struct_WGPUBindGroupLayoutEntry = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    binding: u32 = 0,
    visibility: WGPUShaderStage = 0,
    buffer: WGPUBufferBindingLayout = @import("std").mem.zeroes(WGPUBufferBindingLayout),
    sampler: WGPUSamplerBindingLayout = @import("std").mem.zeroes(WGPUSamplerBindingLayout),
    texture: WGPUTextureBindingLayout = @import("std").mem.zeroes(WGPUTextureBindingLayout),
    storageTexture: WGPUStorageTextureBindingLayout = @import("std").mem.zeroes(WGPUStorageTextureBindingLayout),
};
pub const WGPUBindGroupLayoutEntry = struct_WGPUBindGroupLayoutEntry;
pub const struct_WGPUBlendState = extern struct {
    color: WGPUBlendComponent = @import("std").mem.zeroes(WGPUBlendComponent),
    alpha: WGPUBlendComponent = @import("std").mem.zeroes(WGPUBlendComponent),
};
pub const WGPUBlendState = struct_WGPUBlendState;
pub const WGPUCompilationInfo = struct_WGPUCompilationInfo;
pub const struct_WGPUComputePassDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    timestampWrites: [*c]const WGPUComputePassTimestampWrites = null,
};
pub const WGPUComputePassDescriptor = struct_WGPUComputePassDescriptor;
pub const struct_WGPUDepthStencilState = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    depthWriteEnabled: WGPUOptionalBool = @import("std").mem.zeroes(WGPUOptionalBool),
    depthCompare: WGPUCompareFunction = @import("std").mem.zeroes(WGPUCompareFunction),
    stencilFront: WGPUStencilFaceState = @import("std").mem.zeroes(WGPUStencilFaceState),
    stencilBack: WGPUStencilFaceState = @import("std").mem.zeroes(WGPUStencilFaceState),
    stencilReadMask: u32 = 0,
    stencilWriteMask: u32 = 0,
    depthBias: i32 = 0,
    depthBiasSlopeScale: f32 = 0,
    depthBiasClamp: f32 = 0,
};
pub const WGPUDepthStencilState = struct_WGPUDepthStencilState;
pub const struct_WGPUDeviceDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    requiredFeatureCount: usize = 0,
    requiredFeatures: [*c]const WGPUFeatureName = null,
    requiredLimits: [*c]const WGPULimits = null,
    defaultQueue: WGPUQueueDescriptor = @import("std").mem.zeroes(WGPUQueueDescriptor),
    deviceLostCallbackInfo: WGPUDeviceLostCallbackInfo = @import("std").mem.zeroes(WGPUDeviceLostCallbackInfo),
    uncapturedErrorCallbackInfo: WGPUUncapturedErrorCallbackInfo = @import("std").mem.zeroes(WGPUUncapturedErrorCallbackInfo),
};
pub const WGPUDeviceDescriptor = struct_WGPUDeviceDescriptor;
pub const struct_WGPUFutureWaitInfo = extern struct {
    future: WGPUFuture = @import("std").mem.zeroes(WGPUFuture),
    completed: WGPUBool = 0,
};
pub const WGPUFutureWaitInfo = struct_WGPUFutureWaitInfo;
pub const struct_WGPUInstanceDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    features: WGPUInstanceCapabilities = @import("std").mem.zeroes(WGPUInstanceCapabilities),
    pub const wgpuCreateInstance = __root.wgpuCreateInstance;
};
pub const WGPUInstanceDescriptor = struct_WGPUInstanceDescriptor;
pub const struct_WGPUProgrammableStageDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    module: WGPUShaderModule = null,
    entryPoint: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    constantCount: usize = 0,
    constants: [*c]const WGPUConstantEntry = null,
};
pub const WGPUProgrammableStageDescriptor = struct_WGPUProgrammableStageDescriptor;
pub const struct_WGPURenderPassColorAttachment = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    view: WGPUTextureView = null,
    depthSlice: u32 = 0,
    resolveTarget: WGPUTextureView = null,
    loadOp: WGPULoadOp = @import("std").mem.zeroes(WGPULoadOp),
    storeOp: WGPUStoreOp = @import("std").mem.zeroes(WGPUStoreOp),
    clearValue: WGPUColor = @import("std").mem.zeroes(WGPUColor),
};
pub const WGPURenderPassColorAttachment = struct_WGPURenderPassColorAttachment;
pub const struct_WGPUTexelCopyBufferInfo = extern struct {
    layout: WGPUTexelCopyBufferLayout = @import("std").mem.zeroes(WGPUTexelCopyBufferLayout),
    buffer: WGPUBuffer = null,
};
pub const WGPUTexelCopyBufferInfo = struct_WGPUTexelCopyBufferInfo;
pub const struct_WGPUTexelCopyTextureInfo = extern struct {
    texture: WGPUTexture = null,
    mipLevel: u32 = 0,
    origin: WGPUOrigin3D = @import("std").mem.zeroes(WGPUOrigin3D),
    aspect: WGPUTextureAspect = @import("std").mem.zeroes(WGPUTextureAspect),
};
pub const WGPUTexelCopyTextureInfo = struct_WGPUTexelCopyTextureInfo;
pub const struct_WGPUTextureDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    usage: WGPUTextureUsage = 0,
    dimension: WGPUTextureDimension = @import("std").mem.zeroes(WGPUTextureDimension),
    size: WGPUExtent3D = @import("std").mem.zeroes(WGPUExtent3D),
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    mipLevelCount: u32 = 0,
    sampleCount: u32 = 0,
    viewFormatCount: usize = 0,
    viewFormats: [*c]const WGPUTextureFormat = null,
};
pub const WGPUTextureDescriptor = struct_WGPUTextureDescriptor;
pub const struct_WGPUVertexBufferLayout = extern struct {
    stepMode: WGPUVertexStepMode = @import("std").mem.zeroes(WGPUVertexStepMode),
    arrayStride: u64 = 0,
    attributeCount: usize = 0,
    attributes: [*c]const WGPUVertexAttribute = null,
};
pub const WGPUVertexBufferLayout = struct_WGPUVertexBufferLayout;
pub const struct_WGPUBindGroupLayoutDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    entryCount: usize = 0,
    entries: [*c]const WGPUBindGroupLayoutEntry = null,
};
pub const WGPUBindGroupLayoutDescriptor = struct_WGPUBindGroupLayoutDescriptor;
pub const struct_WGPUColorTargetState = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    blend: [*c]const WGPUBlendState = null,
    writeMask: WGPUColorWriteMask = 0,
};
pub const WGPUColorTargetState = struct_WGPUColorTargetState;
pub const struct_WGPUComputePipelineDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    layout: WGPUPipelineLayout = null,
    compute: WGPUProgrammableStageDescriptor = @import("std").mem.zeroes(WGPUProgrammableStageDescriptor),
};
pub const WGPUComputePipelineDescriptor = struct_WGPUComputePipelineDescriptor;
pub const struct_WGPURenderPassDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    colorAttachmentCount: usize = 0,
    colorAttachments: [*c]const WGPURenderPassColorAttachment = null,
    depthStencilAttachment: [*c]const WGPURenderPassDepthStencilAttachment = null,
    occlusionQuerySet: WGPUQuerySet = null,
    timestampWrites: [*c]const WGPURenderPassTimestampWrites = null,
};
pub const WGPURenderPassDescriptor = struct_WGPURenderPassDescriptor;
pub const struct_WGPUVertexState = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    module: WGPUShaderModule = null,
    entryPoint: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    constantCount: usize = 0,
    constants: [*c]const WGPUConstantEntry = null,
    bufferCount: usize = 0,
    buffers: [*c]const WGPUVertexBufferLayout = null,
};
pub const WGPUVertexState = struct_WGPUVertexState;
pub const struct_WGPUFragmentState = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    module: WGPUShaderModule = null,
    entryPoint: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    constantCount: usize = 0,
    constants: [*c]const WGPUConstantEntry = null,
    targetCount: usize = 0,
    targets: [*c]const WGPUColorTargetState = null,
};
pub const WGPUFragmentState = struct_WGPUFragmentState;
pub const struct_WGPURenderPipelineDescriptor = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    layout: WGPUPipelineLayout = null,
    vertex: WGPUVertexState = @import("std").mem.zeroes(WGPUVertexState),
    primitive: WGPUPrimitiveState = @import("std").mem.zeroes(WGPUPrimitiveState),
    depthStencil: [*c]const WGPUDepthStencilState = null,
    multisample: WGPUMultisampleState = @import("std").mem.zeroes(WGPUMultisampleState),
    fragment: [*c]const WGPUFragmentState = null,
};
pub const WGPURenderPipelineDescriptor = struct_WGPURenderPipelineDescriptor;
pub const WGPUProcCreateInstance = ?*const fn (descriptor: [*c]const WGPUInstanceDescriptor) callconv(.c) WGPUInstance;
pub const WGPUProcGetInstanceCapabilities = ?*const fn (capabilities: [*c]WGPUInstanceCapabilities) callconv(.c) WGPUStatus;
pub const WGPUProcGetProcAddress = ?*const fn (procName: WGPUStringView) callconv(.c) WGPUProc;
pub const WGPUProcAdapterGetFeatures = ?*const fn (adapter: WGPUAdapter, features: [*c]WGPUSupportedFeatures) callconv(.c) void;
pub const WGPUProcAdapterGetInfo = ?*const fn (adapter: WGPUAdapter, info: [*c]WGPUAdapterInfo) callconv(.c) WGPUStatus;
pub const WGPUProcAdapterGetLimits = ?*const fn (adapter: WGPUAdapter, limits: [*c]WGPULimits) callconv(.c) WGPUStatus;
pub const WGPUProcAdapterHasFeature = ?*const fn (adapter: WGPUAdapter, feature: WGPUFeatureName) callconv(.c) WGPUBool;
pub const WGPUProcAdapterRequestDevice = ?*const fn (adapter: WGPUAdapter, descriptor: [*c]const WGPUDeviceDescriptor, callbackInfo: WGPURequestDeviceCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcAdapterAddRef = ?*const fn (adapter: WGPUAdapter) callconv(.c) void;
pub const WGPUProcAdapterRelease = ?*const fn (adapter: WGPUAdapter) callconv(.c) void;
pub const WGPUProcAdapterInfoFreeMembers = ?*const fn (adapterInfo: WGPUAdapterInfo) callconv(.c) void;
pub const WGPUProcBindGroupSetLabel = ?*const fn (bindGroup: WGPUBindGroup, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcBindGroupAddRef = ?*const fn (bindGroup: WGPUBindGroup) callconv(.c) void;
pub const WGPUProcBindGroupRelease = ?*const fn (bindGroup: WGPUBindGroup) callconv(.c) void;
pub const WGPUProcBindGroupLayoutSetLabel = ?*const fn (bindGroupLayout: WGPUBindGroupLayout, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcBindGroupLayoutAddRef = ?*const fn (bindGroupLayout: WGPUBindGroupLayout) callconv(.c) void;
pub const WGPUProcBindGroupLayoutRelease = ?*const fn (bindGroupLayout: WGPUBindGroupLayout) callconv(.c) void;
pub const WGPUProcBufferDestroy = ?*const fn (buffer: WGPUBuffer) callconv(.c) void;
pub const WGPUProcBufferGetConstMappedRange = ?*const fn (buffer: WGPUBuffer, offset: usize, size: usize) callconv(.c) ?*const anyopaque;
pub const WGPUProcBufferGetMapState = ?*const fn (buffer: WGPUBuffer) callconv(.c) WGPUBufferMapState;
pub const WGPUProcBufferGetMappedRange = ?*const fn (buffer: WGPUBuffer, offset: usize, size: usize) callconv(.c) ?*anyopaque;
pub const WGPUProcBufferGetSize = ?*const fn (buffer: WGPUBuffer) callconv(.c) u64;
pub const WGPUProcBufferGetUsage = ?*const fn (buffer: WGPUBuffer) callconv(.c) WGPUBufferUsage;
pub const WGPUProcBufferMapAsync = ?*const fn (buffer: WGPUBuffer, mode: WGPUMapMode, offset: usize, size: usize, callbackInfo: WGPUBufferMapCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcBufferSetLabel = ?*const fn (buffer: WGPUBuffer, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcBufferUnmap = ?*const fn (buffer: WGPUBuffer) callconv(.c) void;
pub const WGPUProcBufferAddRef = ?*const fn (buffer: WGPUBuffer) callconv(.c) void;
pub const WGPUProcBufferRelease = ?*const fn (buffer: WGPUBuffer) callconv(.c) void;
pub const WGPUProcCommandBufferSetLabel = ?*const fn (commandBuffer: WGPUCommandBuffer, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcCommandBufferAddRef = ?*const fn (commandBuffer: WGPUCommandBuffer) callconv(.c) void;
pub const WGPUProcCommandBufferRelease = ?*const fn (commandBuffer: WGPUCommandBuffer) callconv(.c) void;
pub const WGPUProcCommandEncoderBeginComputePass = ?*const fn (commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPUComputePassDescriptor) callconv(.c) WGPUComputePassEncoder;
pub const WGPUProcCommandEncoderBeginRenderPass = ?*const fn (commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPURenderPassDescriptor) callconv(.c) WGPURenderPassEncoder;
pub const WGPUProcCommandEncoderClearBuffer = ?*const fn (commandEncoder: WGPUCommandEncoder, buffer: WGPUBuffer, offset: u64, size: u64) callconv(.c) void;
pub const WGPUProcCommandEncoderCopyBufferToBuffer = ?*const fn (commandEncoder: WGPUCommandEncoder, source: WGPUBuffer, sourceOffset: u64, destination: WGPUBuffer, destinationOffset: u64, size: u64) callconv(.c) void;
pub const WGPUProcCommandEncoderCopyBufferToTexture = ?*const fn (commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyBufferInfo, destination: [*c]const WGPUTexelCopyTextureInfo, copySize: [*c]const WGPUExtent3D) callconv(.c) void;
pub const WGPUProcCommandEncoderCopyTextureToBuffer = ?*const fn (commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyTextureInfo, destination: [*c]const WGPUTexelCopyBufferInfo, copySize: [*c]const WGPUExtent3D) callconv(.c) void;
pub const WGPUProcCommandEncoderCopyTextureToTexture = ?*const fn (commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyTextureInfo, destination: [*c]const WGPUTexelCopyTextureInfo, copySize: [*c]const WGPUExtent3D) callconv(.c) void;
pub const WGPUProcCommandEncoderFinish = ?*const fn (commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPUCommandBufferDescriptor) callconv(.c) WGPUCommandBuffer;
pub const WGPUProcCommandEncoderInsertDebugMarker = ?*const fn (commandEncoder: WGPUCommandEncoder, markerLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcCommandEncoderPopDebugGroup = ?*const fn (commandEncoder: WGPUCommandEncoder) callconv(.c) void;
pub const WGPUProcCommandEncoderPushDebugGroup = ?*const fn (commandEncoder: WGPUCommandEncoder, groupLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcCommandEncoderResolveQuerySet = ?*const fn (commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, firstQuery: u32, queryCount: u32, destination: WGPUBuffer, destinationOffset: u64) callconv(.c) void;
pub const WGPUProcCommandEncoderSetLabel = ?*const fn (commandEncoder: WGPUCommandEncoder, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcCommandEncoderWriteTimestamp = ?*const fn (commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, queryIndex: u32) callconv(.c) void;
pub const WGPUProcCommandEncoderAddRef = ?*const fn (commandEncoder: WGPUCommandEncoder) callconv(.c) void;
pub const WGPUProcCommandEncoderRelease = ?*const fn (commandEncoder: WGPUCommandEncoder) callconv(.c) void;
pub const WGPUProcComputePassEncoderDispatchWorkgroups = ?*const fn (computePassEncoder: WGPUComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) callconv(.c) void;
pub const WGPUProcComputePassEncoderDispatchWorkgroupsIndirect = ?*const fn (computePassEncoder: WGPUComputePassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) callconv(.c) void;
pub const WGPUProcComputePassEncoderEnd = ?*const fn (computePassEncoder: WGPUComputePassEncoder) callconv(.c) void;
pub const WGPUProcComputePassEncoderInsertDebugMarker = ?*const fn (computePassEncoder: WGPUComputePassEncoder, markerLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcComputePassEncoderPopDebugGroup = ?*const fn (computePassEncoder: WGPUComputePassEncoder) callconv(.c) void;
pub const WGPUProcComputePassEncoderPushDebugGroup = ?*const fn (computePassEncoder: WGPUComputePassEncoder, groupLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcComputePassEncoderSetBindGroup = ?*const fn (computePassEncoder: WGPUComputePassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) callconv(.c) void;
pub const WGPUProcComputePassEncoderSetLabel = ?*const fn (computePassEncoder: WGPUComputePassEncoder, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcComputePassEncoderSetPipeline = ?*const fn (computePassEncoder: WGPUComputePassEncoder, pipeline: WGPUComputePipeline) callconv(.c) void;
pub const WGPUProcComputePassEncoderAddRef = ?*const fn (computePassEncoder: WGPUComputePassEncoder) callconv(.c) void;
pub const WGPUProcComputePassEncoderRelease = ?*const fn (computePassEncoder: WGPUComputePassEncoder) callconv(.c) void;
pub const WGPUProcComputePipelineGetBindGroupLayout = ?*const fn (computePipeline: WGPUComputePipeline, groupIndex: u32) callconv(.c) WGPUBindGroupLayout;
pub const WGPUProcComputePipelineSetLabel = ?*const fn (computePipeline: WGPUComputePipeline, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcComputePipelineAddRef = ?*const fn (computePipeline: WGPUComputePipeline) callconv(.c) void;
pub const WGPUProcComputePipelineRelease = ?*const fn (computePipeline: WGPUComputePipeline) callconv(.c) void;
pub const WGPUProcDeviceCreateBindGroup = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUBindGroupDescriptor) callconv(.c) WGPUBindGroup;
pub const WGPUProcDeviceCreateBindGroupLayout = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUBindGroupLayoutDescriptor) callconv(.c) WGPUBindGroupLayout;
pub const WGPUProcDeviceCreateBuffer = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUBufferDescriptor) callconv(.c) WGPUBuffer;
pub const WGPUProcDeviceCreateCommandEncoder = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUCommandEncoderDescriptor) callconv(.c) WGPUCommandEncoder;
pub const WGPUProcDeviceCreateComputePipeline = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUComputePipelineDescriptor) callconv(.c) WGPUComputePipeline;
pub const WGPUProcDeviceCreateComputePipelineAsync = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUComputePipelineDescriptor, callbackInfo: WGPUCreateComputePipelineAsyncCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcDeviceCreatePipelineLayout = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUPipelineLayoutDescriptor) callconv(.c) WGPUPipelineLayout;
pub const WGPUProcDeviceCreateQuerySet = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUQuerySetDescriptor) callconv(.c) WGPUQuerySet;
pub const WGPUProcDeviceCreateRenderBundleEncoder = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPURenderBundleEncoderDescriptor) callconv(.c) WGPURenderBundleEncoder;
pub const WGPUProcDeviceCreateRenderPipeline = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPURenderPipelineDescriptor) callconv(.c) WGPURenderPipeline;
pub const WGPUProcDeviceCreateRenderPipelineAsync = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPURenderPipelineDescriptor, callbackInfo: WGPUCreateRenderPipelineAsyncCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcDeviceCreateSampler = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUSamplerDescriptor) callconv(.c) WGPUSampler;
pub const WGPUProcDeviceCreateShaderModule = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUShaderModuleDescriptor) callconv(.c) WGPUShaderModule;
pub const WGPUProcDeviceCreateTexture = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUTextureDescriptor) callconv(.c) WGPUTexture;
pub const WGPUProcDeviceDestroy = ?*const fn (device: WGPUDevice) callconv(.c) void;
pub const WGPUProcDeviceGetAdapterInfo = ?*const fn (device: WGPUDevice) callconv(.c) WGPUAdapterInfo;
pub const WGPUProcDeviceGetFeatures = ?*const fn (device: WGPUDevice, features: [*c]WGPUSupportedFeatures) callconv(.c) void;
pub const WGPUProcDeviceGetLimits = ?*const fn (device: WGPUDevice, limits: [*c]WGPULimits) callconv(.c) WGPUStatus;
pub const WGPUProcDeviceGetLostFuture = ?*const fn (device: WGPUDevice) callconv(.c) WGPUFuture;
pub const WGPUProcDeviceGetQueue = ?*const fn (device: WGPUDevice) callconv(.c) WGPUQueue;
pub const WGPUProcDeviceHasFeature = ?*const fn (device: WGPUDevice, feature: WGPUFeatureName) callconv(.c) WGPUBool;
pub const WGPUProcDevicePopErrorScope = ?*const fn (device: WGPUDevice, callbackInfo: WGPUPopErrorScopeCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcDevicePushErrorScope = ?*const fn (device: WGPUDevice, filter: WGPUErrorFilter) callconv(.c) void;
pub const WGPUProcDeviceSetLabel = ?*const fn (device: WGPUDevice, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcDeviceAddRef = ?*const fn (device: WGPUDevice) callconv(.c) void;
pub const WGPUProcDeviceRelease = ?*const fn (device: WGPUDevice) callconv(.c) void;
pub const WGPUProcInstanceCreateSurface = ?*const fn (instance: WGPUInstance, descriptor: [*c]const WGPUSurfaceDescriptor) callconv(.c) WGPUSurface;
pub const WGPUProcInstanceGetWGSLLanguageFeatures = ?*const fn (instance: WGPUInstance, features: [*c]WGPUSupportedWGSLLanguageFeatures) callconv(.c) WGPUStatus;
pub const WGPUProcInstanceHasWGSLLanguageFeature = ?*const fn (instance: WGPUInstance, feature: WGPUWGSLLanguageFeatureName) callconv(.c) WGPUBool;
pub const WGPUProcInstanceProcessEvents = ?*const fn (instance: WGPUInstance) callconv(.c) void;
pub const WGPUProcInstanceRequestAdapter = ?*const fn (instance: WGPUInstance, options: [*c]const WGPURequestAdapterOptions, callbackInfo: WGPURequestAdapterCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcInstanceWaitAny = ?*const fn (instance: WGPUInstance, futureCount: usize, futures: [*c]WGPUFutureWaitInfo, timeoutNS: u64) callconv(.c) WGPUWaitStatus;
pub const WGPUProcInstanceAddRef = ?*const fn (instance: WGPUInstance) callconv(.c) void;
pub const WGPUProcInstanceRelease = ?*const fn (instance: WGPUInstance) callconv(.c) void;
pub const WGPUProcPipelineLayoutSetLabel = ?*const fn (pipelineLayout: WGPUPipelineLayout, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcPipelineLayoutAddRef = ?*const fn (pipelineLayout: WGPUPipelineLayout) callconv(.c) void;
pub const WGPUProcPipelineLayoutRelease = ?*const fn (pipelineLayout: WGPUPipelineLayout) callconv(.c) void;
pub const WGPUProcQuerySetDestroy = ?*const fn (querySet: WGPUQuerySet) callconv(.c) void;
pub const WGPUProcQuerySetGetCount = ?*const fn (querySet: WGPUQuerySet) callconv(.c) u32;
pub const WGPUProcQuerySetGetType = ?*const fn (querySet: WGPUQuerySet) callconv(.c) WGPUQueryType;
pub const WGPUProcQuerySetSetLabel = ?*const fn (querySet: WGPUQuerySet, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcQuerySetAddRef = ?*const fn (querySet: WGPUQuerySet) callconv(.c) void;
pub const WGPUProcQuerySetRelease = ?*const fn (querySet: WGPUQuerySet) callconv(.c) void;
pub const WGPUProcQueueOnSubmittedWorkDone = ?*const fn (queue: WGPUQueue, callbackInfo: WGPUQueueWorkDoneCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcQueueSetLabel = ?*const fn (queue: WGPUQueue, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcQueueSubmit = ?*const fn (queue: WGPUQueue, commandCount: usize, commands: [*c]const WGPUCommandBuffer) callconv(.c) void;
pub const WGPUProcQueueWriteBuffer = ?*const fn (queue: WGPUQueue, buffer: WGPUBuffer, bufferOffset: u64, data: ?*const anyopaque, size: usize) callconv(.c) void;
pub const WGPUProcQueueWriteTexture = ?*const fn (queue: WGPUQueue, destination: [*c]const WGPUTexelCopyTextureInfo, data: ?*const anyopaque, dataSize: usize, dataLayout: [*c]const WGPUTexelCopyBufferLayout, writeSize: [*c]const WGPUExtent3D) callconv(.c) void;
pub const WGPUProcQueueAddRef = ?*const fn (queue: WGPUQueue) callconv(.c) void;
pub const WGPUProcQueueRelease = ?*const fn (queue: WGPUQueue) callconv(.c) void;
pub const WGPUProcRenderBundleSetLabel = ?*const fn (renderBundle: WGPURenderBundle, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderBundleAddRef = ?*const fn (renderBundle: WGPURenderBundle) callconv(.c) void;
pub const WGPUProcRenderBundleRelease = ?*const fn (renderBundle: WGPURenderBundle) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderDraw = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderDrawIndexed = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderDrawIndexedIndirect = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderDrawIndirect = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderFinish = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, descriptor: [*c]const WGPURenderBundleDescriptor) callconv(.c) WGPURenderBundle;
pub const WGPUProcRenderBundleEncoderInsertDebugMarker = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, markerLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderPopDebugGroup = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderPushDebugGroup = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, groupLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderSetBindGroup = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderSetIndexBuffer = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderSetLabel = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderSetPipeline = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, pipeline: WGPURenderPipeline) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderSetVertexBuffer = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderAddRef = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderRelease = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder) callconv(.c) void;
pub const WGPUProcRenderPassEncoderBeginOcclusionQuery = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, queryIndex: u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderDraw = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderDrawIndexed = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderDrawIndexedIndirect = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) callconv(.c) void;
pub const WGPUProcRenderPassEncoderDrawIndirect = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) callconv(.c) void;
pub const WGPUProcRenderPassEncoderEnd = ?*const fn (renderPassEncoder: WGPURenderPassEncoder) callconv(.c) void;
pub const WGPUProcRenderPassEncoderEndOcclusionQuery = ?*const fn (renderPassEncoder: WGPURenderPassEncoder) callconv(.c) void;
pub const WGPUProcRenderPassEncoderExecuteBundles = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, bundleCount: usize, bundles: [*c]const WGPURenderBundle) callconv(.c) void;
pub const WGPUProcRenderPassEncoderInsertDebugMarker = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, markerLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderPassEncoderPopDebugGroup = ?*const fn (renderPassEncoder: WGPURenderPassEncoder) callconv(.c) void;
pub const WGPUProcRenderPassEncoderPushDebugGroup = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, groupLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetBindGroup = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetBlendConstant = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, color: [*c]const WGPUColor) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetIndexBuffer = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetLabel = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetPipeline = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, pipeline: WGPURenderPipeline) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetScissorRect = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, x: u32, y: u32, width: u32, height: u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetStencilReference = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, reference: u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetVertexBuffer = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetViewport = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderAddRef = ?*const fn (renderPassEncoder: WGPURenderPassEncoder) callconv(.c) void;
pub const WGPUProcRenderPassEncoderRelease = ?*const fn (renderPassEncoder: WGPURenderPassEncoder) callconv(.c) void;
pub const WGPUProcRenderPipelineGetBindGroupLayout = ?*const fn (renderPipeline: WGPURenderPipeline, groupIndex: u32) callconv(.c) WGPUBindGroupLayout;
pub const WGPUProcRenderPipelineSetLabel = ?*const fn (renderPipeline: WGPURenderPipeline, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderPipelineAddRef = ?*const fn (renderPipeline: WGPURenderPipeline) callconv(.c) void;
pub const WGPUProcRenderPipelineRelease = ?*const fn (renderPipeline: WGPURenderPipeline) callconv(.c) void;
pub const WGPUProcSamplerSetLabel = ?*const fn (sampler: WGPUSampler, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcSamplerAddRef = ?*const fn (sampler: WGPUSampler) callconv(.c) void;
pub const WGPUProcSamplerRelease = ?*const fn (sampler: WGPUSampler) callconv(.c) void;
pub const WGPUProcShaderModuleGetCompilationInfo = ?*const fn (shaderModule: WGPUShaderModule, callbackInfo: WGPUCompilationInfoCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcShaderModuleSetLabel = ?*const fn (shaderModule: WGPUShaderModule, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcShaderModuleAddRef = ?*const fn (shaderModule: WGPUShaderModule) callconv(.c) void;
pub const WGPUProcShaderModuleRelease = ?*const fn (shaderModule: WGPUShaderModule) callconv(.c) void;
pub const WGPUProcSupportedFeaturesFreeMembers = ?*const fn (supportedFeatures: WGPUSupportedFeatures) callconv(.c) void;
pub const WGPUProcSupportedWGSLLanguageFeaturesFreeMembers = ?*const fn (supportedWGSLLanguageFeatures: WGPUSupportedWGSLLanguageFeatures) callconv(.c) void;
pub const WGPUProcSurfaceConfigure = ?*const fn (surface: WGPUSurface, config: [*c]const WGPUSurfaceConfiguration) callconv(.c) void;
pub const WGPUProcSurfaceGetCapabilities = ?*const fn (surface: WGPUSurface, adapter: WGPUAdapter, capabilities: [*c]WGPUSurfaceCapabilities) callconv(.c) WGPUStatus;
pub const WGPUProcSurfaceGetCurrentTexture = ?*const fn (surface: WGPUSurface, surfaceTexture: [*c]WGPUSurfaceTexture) callconv(.c) void;
pub const WGPUProcSurfacePresent = ?*const fn (surface: WGPUSurface) callconv(.c) WGPUStatus;
pub const WGPUProcSurfaceSetLabel = ?*const fn (surface: WGPUSurface, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcSurfaceUnconfigure = ?*const fn (surface: WGPUSurface) callconv(.c) void;
pub const WGPUProcSurfaceAddRef = ?*const fn (surface: WGPUSurface) callconv(.c) void;
pub const WGPUProcSurfaceRelease = ?*const fn (surface: WGPUSurface) callconv(.c) void;
pub const WGPUProcSurfaceCapabilitiesFreeMembers = ?*const fn (surfaceCapabilities: WGPUSurfaceCapabilities) callconv(.c) void;
pub const WGPUProcTextureCreateView = ?*const fn (texture: WGPUTexture, descriptor: [*c]const WGPUTextureViewDescriptor) callconv(.c) WGPUTextureView;
pub const WGPUProcTextureDestroy = ?*const fn (texture: WGPUTexture) callconv(.c) void;
pub const WGPUProcTextureGetDepthOrArrayLayers = ?*const fn (texture: WGPUTexture) callconv(.c) u32;
pub const WGPUProcTextureGetDimension = ?*const fn (texture: WGPUTexture) callconv(.c) WGPUTextureDimension;
pub const WGPUProcTextureGetFormat = ?*const fn (texture: WGPUTexture) callconv(.c) WGPUTextureFormat;
pub const WGPUProcTextureGetHeight = ?*const fn (texture: WGPUTexture) callconv(.c) u32;
pub const WGPUProcTextureGetMipLevelCount = ?*const fn (texture: WGPUTexture) callconv(.c) u32;
pub const WGPUProcTextureGetSampleCount = ?*const fn (texture: WGPUTexture) callconv(.c) u32;
pub const WGPUProcTextureGetUsage = ?*const fn (texture: WGPUTexture) callconv(.c) WGPUTextureUsage;
pub const WGPUProcTextureGetWidth = ?*const fn (texture: WGPUTexture) callconv(.c) u32;
pub const WGPUProcTextureSetLabel = ?*const fn (texture: WGPUTexture, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcTextureAddRef = ?*const fn (texture: WGPUTexture) callconv(.c) void;
pub const WGPUProcTextureRelease = ?*const fn (texture: WGPUTexture) callconv(.c) void;
pub const WGPUProcTextureViewSetLabel = ?*const fn (textureView: WGPUTextureView, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcTextureViewAddRef = ?*const fn (textureView: WGPUTextureView) callconv(.c) void;
pub const WGPUProcTextureViewRelease = ?*const fn (textureView: WGPUTextureView) callconv(.c) void;
pub extern fn wgpuCreateInstance(descriptor: [*c]const WGPUInstanceDescriptor) WGPUInstance;
pub extern fn wgpuGetInstanceCapabilities(capabilities: [*c]WGPUInstanceCapabilities) WGPUStatus;
pub extern fn wgpuGetProcAddress(procName: WGPUStringView) WGPUProc;
pub extern fn wgpuAdapterGetFeatures(adapter: WGPUAdapter, features: [*c]WGPUSupportedFeatures) void;
pub extern fn wgpuAdapterGetInfo(adapter: WGPUAdapter, info: [*c]WGPUAdapterInfo) WGPUStatus;
pub extern fn wgpuAdapterGetLimits(adapter: WGPUAdapter, limits: [*c]WGPULimits) WGPUStatus;
pub extern fn wgpuAdapterHasFeature(adapter: WGPUAdapter, feature: WGPUFeatureName) WGPUBool;
pub extern fn wgpuAdapterRequestDevice(adapter: WGPUAdapter, descriptor: [*c]const WGPUDeviceDescriptor, callbackInfo: WGPURequestDeviceCallbackInfo) WGPUFuture;
pub extern fn wgpuAdapterAddRef(adapter: WGPUAdapter) void;
pub extern fn wgpuAdapterRelease(adapter: WGPUAdapter) void;
pub extern fn wgpuAdapterInfoFreeMembers(adapterInfo: WGPUAdapterInfo) void;
pub extern fn wgpuBindGroupSetLabel(bindGroup: WGPUBindGroup, label: WGPUStringView) void;
pub extern fn wgpuBindGroupAddRef(bindGroup: WGPUBindGroup) void;
pub extern fn wgpuBindGroupRelease(bindGroup: WGPUBindGroup) void;
pub extern fn wgpuBindGroupLayoutSetLabel(bindGroupLayout: WGPUBindGroupLayout, label: WGPUStringView) void;
pub extern fn wgpuBindGroupLayoutAddRef(bindGroupLayout: WGPUBindGroupLayout) void;
pub extern fn wgpuBindGroupLayoutRelease(bindGroupLayout: WGPUBindGroupLayout) void;
pub extern fn wgpuBufferDestroy(buffer: WGPUBuffer) void;
pub extern fn wgpuBufferGetConstMappedRange(buffer: WGPUBuffer, offset: usize, size: usize) ?*const anyopaque;
pub extern fn wgpuBufferGetMapState(buffer: WGPUBuffer) WGPUBufferMapState;
pub extern fn wgpuBufferGetMappedRange(buffer: WGPUBuffer, offset: usize, size: usize) ?*anyopaque;
pub extern fn wgpuBufferGetSize(buffer: WGPUBuffer) u64;
pub extern fn wgpuBufferGetUsage(buffer: WGPUBuffer) WGPUBufferUsage;
pub extern fn wgpuBufferMapAsync(buffer: WGPUBuffer, mode: WGPUMapMode, offset: usize, size: usize, callbackInfo: WGPUBufferMapCallbackInfo) WGPUFuture;
pub extern fn wgpuBufferSetLabel(buffer: WGPUBuffer, label: WGPUStringView) void;
pub extern fn wgpuBufferUnmap(buffer: WGPUBuffer) void;
pub extern fn wgpuBufferAddRef(buffer: WGPUBuffer) void;
pub extern fn wgpuBufferRelease(buffer: WGPUBuffer) void;
pub extern fn wgpuCommandBufferSetLabel(commandBuffer: WGPUCommandBuffer, label: WGPUStringView) void;
pub extern fn wgpuCommandBufferAddRef(commandBuffer: WGPUCommandBuffer) void;
pub extern fn wgpuCommandBufferRelease(commandBuffer: WGPUCommandBuffer) void;
pub extern fn wgpuCommandEncoderBeginComputePass(commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPUComputePassDescriptor) WGPUComputePassEncoder;
pub extern fn wgpuCommandEncoderBeginRenderPass(commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPURenderPassDescriptor) WGPURenderPassEncoder;
pub extern fn wgpuCommandEncoderClearBuffer(commandEncoder: WGPUCommandEncoder, buffer: WGPUBuffer, offset: u64, size: u64) void;
pub extern fn wgpuCommandEncoderCopyBufferToBuffer(commandEncoder: WGPUCommandEncoder, source: WGPUBuffer, sourceOffset: u64, destination: WGPUBuffer, destinationOffset: u64, size: u64) void;
pub extern fn wgpuCommandEncoderCopyBufferToTexture(commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyBufferInfo, destination: [*c]const WGPUTexelCopyTextureInfo, copySize: [*c]const WGPUExtent3D) void;
pub extern fn wgpuCommandEncoderCopyTextureToBuffer(commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyTextureInfo, destination: [*c]const WGPUTexelCopyBufferInfo, copySize: [*c]const WGPUExtent3D) void;
pub extern fn wgpuCommandEncoderCopyTextureToTexture(commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyTextureInfo, destination: [*c]const WGPUTexelCopyTextureInfo, copySize: [*c]const WGPUExtent3D) void;
pub extern fn wgpuCommandEncoderFinish(commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPUCommandBufferDescriptor) WGPUCommandBuffer;
pub extern fn wgpuCommandEncoderInsertDebugMarker(commandEncoder: WGPUCommandEncoder, markerLabel: WGPUStringView) void;
pub extern fn wgpuCommandEncoderPopDebugGroup(commandEncoder: WGPUCommandEncoder) void;
pub extern fn wgpuCommandEncoderPushDebugGroup(commandEncoder: WGPUCommandEncoder, groupLabel: WGPUStringView) void;
pub extern fn wgpuCommandEncoderResolveQuerySet(commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, firstQuery: u32, queryCount: u32, destination: WGPUBuffer, destinationOffset: u64) void;
pub extern fn wgpuCommandEncoderSetLabel(commandEncoder: WGPUCommandEncoder, label: WGPUStringView) void;
pub extern fn wgpuCommandEncoderWriteTimestamp(commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, queryIndex: u32) void;
pub extern fn wgpuCommandEncoderAddRef(commandEncoder: WGPUCommandEncoder) void;
pub extern fn wgpuCommandEncoderRelease(commandEncoder: WGPUCommandEncoder) void;
pub extern fn wgpuComputePassEncoderDispatchWorkgroups(computePassEncoder: WGPUComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) void;
pub extern fn wgpuComputePassEncoderDispatchWorkgroupsIndirect(computePassEncoder: WGPUComputePassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) void;
pub extern fn wgpuComputePassEncoderEnd(computePassEncoder: WGPUComputePassEncoder) void;
pub extern fn wgpuComputePassEncoderInsertDebugMarker(computePassEncoder: WGPUComputePassEncoder, markerLabel: WGPUStringView) void;
pub extern fn wgpuComputePassEncoderPopDebugGroup(computePassEncoder: WGPUComputePassEncoder) void;
pub extern fn wgpuComputePassEncoderPushDebugGroup(computePassEncoder: WGPUComputePassEncoder, groupLabel: WGPUStringView) void;
pub extern fn wgpuComputePassEncoderSetBindGroup(computePassEncoder: WGPUComputePassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) void;
pub extern fn wgpuComputePassEncoderSetLabel(computePassEncoder: WGPUComputePassEncoder, label: WGPUStringView) void;
pub extern fn wgpuComputePassEncoderSetPipeline(computePassEncoder: WGPUComputePassEncoder, pipeline: WGPUComputePipeline) void;
pub extern fn wgpuComputePassEncoderAddRef(computePassEncoder: WGPUComputePassEncoder) void;
pub extern fn wgpuComputePassEncoderRelease(computePassEncoder: WGPUComputePassEncoder) void;
pub extern fn wgpuComputePipelineGetBindGroupLayout(computePipeline: WGPUComputePipeline, groupIndex: u32) WGPUBindGroupLayout;
pub extern fn wgpuComputePipelineSetLabel(computePipeline: WGPUComputePipeline, label: WGPUStringView) void;
pub extern fn wgpuComputePipelineAddRef(computePipeline: WGPUComputePipeline) void;
pub extern fn wgpuComputePipelineRelease(computePipeline: WGPUComputePipeline) void;
pub extern fn wgpuDeviceCreateBindGroup(device: WGPUDevice, descriptor: [*c]const WGPUBindGroupDescriptor) WGPUBindGroup;
pub extern fn wgpuDeviceCreateBindGroupLayout(device: WGPUDevice, descriptor: [*c]const WGPUBindGroupLayoutDescriptor) WGPUBindGroupLayout;
pub extern fn wgpuDeviceCreateBuffer(device: WGPUDevice, descriptor: [*c]const WGPUBufferDescriptor) WGPUBuffer;
pub extern fn wgpuDeviceCreateCommandEncoder(device: WGPUDevice, descriptor: [*c]const WGPUCommandEncoderDescriptor) WGPUCommandEncoder;
pub extern fn wgpuDeviceCreateComputePipeline(device: WGPUDevice, descriptor: [*c]const WGPUComputePipelineDescriptor) WGPUComputePipeline;
pub extern fn wgpuDeviceCreateComputePipelineAsync(device: WGPUDevice, descriptor: [*c]const WGPUComputePipelineDescriptor, callbackInfo: WGPUCreateComputePipelineAsyncCallbackInfo) WGPUFuture;
pub extern fn wgpuDeviceCreatePipelineLayout(device: WGPUDevice, descriptor: [*c]const WGPUPipelineLayoutDescriptor) WGPUPipelineLayout;
pub extern fn wgpuDeviceCreateQuerySet(device: WGPUDevice, descriptor: [*c]const WGPUQuerySetDescriptor) WGPUQuerySet;
pub extern fn wgpuDeviceCreateRenderBundleEncoder(device: WGPUDevice, descriptor: [*c]const WGPURenderBundleEncoderDescriptor) WGPURenderBundleEncoder;
pub extern fn wgpuDeviceCreateRenderPipeline(device: WGPUDevice, descriptor: [*c]const WGPURenderPipelineDescriptor) WGPURenderPipeline;
pub extern fn wgpuDeviceCreateRenderPipelineAsync(device: WGPUDevice, descriptor: [*c]const WGPURenderPipelineDescriptor, callbackInfo: WGPUCreateRenderPipelineAsyncCallbackInfo) WGPUFuture;
pub extern fn wgpuDeviceCreateSampler(device: WGPUDevice, descriptor: [*c]const WGPUSamplerDescriptor) WGPUSampler;
pub extern fn wgpuDeviceCreateShaderModule(device: WGPUDevice, descriptor: [*c]const WGPUShaderModuleDescriptor) WGPUShaderModule;
pub extern fn wgpuDeviceCreateTexture(device: WGPUDevice, descriptor: [*c]const WGPUTextureDescriptor) WGPUTexture;
pub extern fn wgpuDeviceDestroy(device: WGPUDevice) void;
pub extern fn wgpuDeviceGetAdapterInfo(device: WGPUDevice) WGPUAdapterInfo;
pub extern fn wgpuDeviceGetFeatures(device: WGPUDevice, features: [*c]WGPUSupportedFeatures) void;
pub extern fn wgpuDeviceGetLimits(device: WGPUDevice, limits: [*c]WGPULimits) WGPUStatus;
pub extern fn wgpuDeviceGetLostFuture(device: WGPUDevice) WGPUFuture;
pub extern fn wgpuDeviceGetQueue(device: WGPUDevice) WGPUQueue;
pub extern fn wgpuDeviceHasFeature(device: WGPUDevice, feature: WGPUFeatureName) WGPUBool;
pub extern fn wgpuDevicePopErrorScope(device: WGPUDevice, callbackInfo: WGPUPopErrorScopeCallbackInfo) WGPUFuture;
pub extern fn wgpuDevicePushErrorScope(device: WGPUDevice, filter: WGPUErrorFilter) void;
pub extern fn wgpuDeviceSetLabel(device: WGPUDevice, label: WGPUStringView) void;
pub extern fn wgpuDeviceAddRef(device: WGPUDevice) void;
pub extern fn wgpuDeviceRelease(device: WGPUDevice) void;
pub extern fn wgpuInstanceCreateSurface(instance: WGPUInstance, descriptor: [*c]const WGPUSurfaceDescriptor) WGPUSurface;
pub extern fn wgpuInstanceGetWGSLLanguageFeatures(instance: WGPUInstance, features: [*c]WGPUSupportedWGSLLanguageFeatures) WGPUStatus;
pub extern fn wgpuInstanceHasWGSLLanguageFeature(instance: WGPUInstance, feature: WGPUWGSLLanguageFeatureName) WGPUBool;
pub extern fn wgpuInstanceProcessEvents(instance: WGPUInstance) void;
pub extern fn wgpuInstanceRequestAdapter(instance: WGPUInstance, options: [*c]const WGPURequestAdapterOptions, callbackInfo: WGPURequestAdapterCallbackInfo) WGPUFuture;
pub extern fn wgpuInstanceWaitAny(instance: WGPUInstance, futureCount: usize, futures: [*c]WGPUFutureWaitInfo, timeoutNS: u64) WGPUWaitStatus;
pub extern fn wgpuInstanceAddRef(instance: WGPUInstance) void;
pub extern fn wgpuInstanceRelease(instance: WGPUInstance) void;
pub extern fn wgpuPipelineLayoutSetLabel(pipelineLayout: WGPUPipelineLayout, label: WGPUStringView) void;
pub extern fn wgpuPipelineLayoutAddRef(pipelineLayout: WGPUPipelineLayout) void;
pub extern fn wgpuPipelineLayoutRelease(pipelineLayout: WGPUPipelineLayout) void;
pub extern fn wgpuQuerySetDestroy(querySet: WGPUQuerySet) void;
pub extern fn wgpuQuerySetGetCount(querySet: WGPUQuerySet) u32;
pub extern fn wgpuQuerySetGetType(querySet: WGPUQuerySet) WGPUQueryType;
pub extern fn wgpuQuerySetSetLabel(querySet: WGPUQuerySet, label: WGPUStringView) void;
pub extern fn wgpuQuerySetAddRef(querySet: WGPUQuerySet) void;
pub extern fn wgpuQuerySetRelease(querySet: WGPUQuerySet) void;
pub extern fn wgpuQueueOnSubmittedWorkDone(queue: WGPUQueue, callbackInfo: WGPUQueueWorkDoneCallbackInfo) WGPUFuture;
pub extern fn wgpuQueueSetLabel(queue: WGPUQueue, label: WGPUStringView) void;
pub extern fn wgpuQueueSubmit(queue: WGPUQueue, commandCount: usize, commands: [*c]const WGPUCommandBuffer) void;
pub extern fn wgpuQueueWriteBuffer(queue: WGPUQueue, buffer: WGPUBuffer, bufferOffset: u64, data: ?*const anyopaque, size: usize) void;
pub extern fn wgpuQueueWriteTexture(queue: WGPUQueue, destination: [*c]const WGPUTexelCopyTextureInfo, data: ?*const anyopaque, dataSize: usize, dataLayout: [*c]const WGPUTexelCopyBufferLayout, writeSize: [*c]const WGPUExtent3D) void;
pub extern fn wgpuQueueAddRef(queue: WGPUQueue) void;
pub extern fn wgpuQueueRelease(queue: WGPUQueue) void;
pub extern fn wgpuRenderBundleSetLabel(renderBundle: WGPURenderBundle, label: WGPUStringView) void;
pub extern fn wgpuRenderBundleAddRef(renderBundle: WGPURenderBundle) void;
pub extern fn wgpuRenderBundleRelease(renderBundle: WGPURenderBundle) void;
pub extern fn wgpuRenderBundleEncoderDraw(renderBundleEncoder: WGPURenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) void;
pub extern fn wgpuRenderBundleEncoderDrawIndexed(renderBundleEncoder: WGPURenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void;
pub extern fn wgpuRenderBundleEncoderDrawIndexedIndirect(renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) void;
pub extern fn wgpuRenderBundleEncoderDrawIndirect(renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) void;
pub extern fn wgpuRenderBundleEncoderFinish(renderBundleEncoder: WGPURenderBundleEncoder, descriptor: [*c]const WGPURenderBundleDescriptor) WGPURenderBundle;
pub extern fn wgpuRenderBundleEncoderInsertDebugMarker(renderBundleEncoder: WGPURenderBundleEncoder, markerLabel: WGPUStringView) void;
pub extern fn wgpuRenderBundleEncoderPopDebugGroup(renderBundleEncoder: WGPURenderBundleEncoder) void;
pub extern fn wgpuRenderBundleEncoderPushDebugGroup(renderBundleEncoder: WGPURenderBundleEncoder, groupLabel: WGPUStringView) void;
pub extern fn wgpuRenderBundleEncoderSetBindGroup(renderBundleEncoder: WGPURenderBundleEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) void;
pub extern fn wgpuRenderBundleEncoderSetIndexBuffer(renderBundleEncoder: WGPURenderBundleEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) void;
pub extern fn wgpuRenderBundleEncoderSetLabel(renderBundleEncoder: WGPURenderBundleEncoder, label: WGPUStringView) void;
pub extern fn wgpuRenderBundleEncoderSetPipeline(renderBundleEncoder: WGPURenderBundleEncoder, pipeline: WGPURenderPipeline) void;
pub extern fn wgpuRenderBundleEncoderSetVertexBuffer(renderBundleEncoder: WGPURenderBundleEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) void;
pub extern fn wgpuRenderBundleEncoderAddRef(renderBundleEncoder: WGPURenderBundleEncoder) void;
pub extern fn wgpuRenderBundleEncoderRelease(renderBundleEncoder: WGPURenderBundleEncoder) void;
pub extern fn wgpuRenderPassEncoderBeginOcclusionQuery(renderPassEncoder: WGPURenderPassEncoder, queryIndex: u32) void;
pub extern fn wgpuRenderPassEncoderDraw(renderPassEncoder: WGPURenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) void;
pub extern fn wgpuRenderPassEncoderDrawIndexed(renderPassEncoder: WGPURenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void;
pub extern fn wgpuRenderPassEncoderDrawIndexedIndirect(renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) void;
pub extern fn wgpuRenderPassEncoderDrawIndirect(renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) void;
pub extern fn wgpuRenderPassEncoderEnd(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderEndOcclusionQuery(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderExecuteBundles(renderPassEncoder: WGPURenderPassEncoder, bundleCount: usize, bundles: [*c]const WGPURenderBundle) void;
pub extern fn wgpuRenderPassEncoderInsertDebugMarker(renderPassEncoder: WGPURenderPassEncoder, markerLabel: WGPUStringView) void;
pub extern fn wgpuRenderPassEncoderPopDebugGroup(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderPushDebugGroup(renderPassEncoder: WGPURenderPassEncoder, groupLabel: WGPUStringView) void;
pub extern fn wgpuRenderPassEncoderSetBindGroup(renderPassEncoder: WGPURenderPassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) void;
pub extern fn wgpuRenderPassEncoderSetBlendConstant(renderPassEncoder: WGPURenderPassEncoder, color: [*c]const WGPUColor) void;
pub extern fn wgpuRenderPassEncoderSetIndexBuffer(renderPassEncoder: WGPURenderPassEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) void;
pub extern fn wgpuRenderPassEncoderSetLabel(renderPassEncoder: WGPURenderPassEncoder, label: WGPUStringView) void;
pub extern fn wgpuRenderPassEncoderSetPipeline(renderPassEncoder: WGPURenderPassEncoder, pipeline: WGPURenderPipeline) void;
pub extern fn wgpuRenderPassEncoderSetScissorRect(renderPassEncoder: WGPURenderPassEncoder, x: u32, y: u32, width: u32, height: u32) void;
pub extern fn wgpuRenderPassEncoderSetStencilReference(renderPassEncoder: WGPURenderPassEncoder, reference: u32) void;
pub extern fn wgpuRenderPassEncoderSetVertexBuffer(renderPassEncoder: WGPURenderPassEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) void;
pub extern fn wgpuRenderPassEncoderSetViewport(renderPassEncoder: WGPURenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) void;
pub extern fn wgpuRenderPassEncoderAddRef(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderRelease(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuRenderPipelineGetBindGroupLayout(renderPipeline: WGPURenderPipeline, groupIndex: u32) WGPUBindGroupLayout;
pub extern fn wgpuRenderPipelineSetLabel(renderPipeline: WGPURenderPipeline, label: WGPUStringView) void;
pub extern fn wgpuRenderPipelineAddRef(renderPipeline: WGPURenderPipeline) void;
pub extern fn wgpuRenderPipelineRelease(renderPipeline: WGPURenderPipeline) void;
pub extern fn wgpuSamplerSetLabel(sampler: WGPUSampler, label: WGPUStringView) void;
pub extern fn wgpuSamplerAddRef(sampler: WGPUSampler) void;
pub extern fn wgpuSamplerRelease(sampler: WGPUSampler) void;
pub extern fn wgpuShaderModuleGetCompilationInfo(shaderModule: WGPUShaderModule, callbackInfo: WGPUCompilationInfoCallbackInfo) WGPUFuture;
pub extern fn wgpuShaderModuleSetLabel(shaderModule: WGPUShaderModule, label: WGPUStringView) void;
pub extern fn wgpuShaderModuleAddRef(shaderModule: WGPUShaderModule) void;
pub extern fn wgpuShaderModuleRelease(shaderModule: WGPUShaderModule) void;
pub extern fn wgpuSupportedFeaturesFreeMembers(supportedFeatures: WGPUSupportedFeatures) void;
pub extern fn wgpuSupportedWGSLLanguageFeaturesFreeMembers(supportedWGSLLanguageFeatures: WGPUSupportedWGSLLanguageFeatures) void;
pub extern fn wgpuSurfaceConfigure(surface: WGPUSurface, config: [*c]const WGPUSurfaceConfiguration) void;
pub extern fn wgpuSurfaceGetCapabilities(surface: WGPUSurface, adapter: WGPUAdapter, capabilities: [*c]WGPUSurfaceCapabilities) WGPUStatus;
pub extern fn wgpuSurfaceGetCurrentTexture(surface: WGPUSurface, surfaceTexture: [*c]WGPUSurfaceTexture) void;
pub extern fn wgpuSurfacePresent(surface: WGPUSurface) WGPUStatus;
pub extern fn wgpuSurfaceSetLabel(surface: WGPUSurface, label: WGPUStringView) void;
pub extern fn wgpuSurfaceUnconfigure(surface: WGPUSurface) void;
pub extern fn wgpuSurfaceAddRef(surface: WGPUSurface) void;
pub extern fn wgpuSurfaceRelease(surface: WGPUSurface) void;
pub extern fn wgpuSurfaceCapabilitiesFreeMembers(surfaceCapabilities: WGPUSurfaceCapabilities) void;
pub extern fn wgpuTextureCreateView(texture: WGPUTexture, descriptor: [*c]const WGPUTextureViewDescriptor) WGPUTextureView;
pub extern fn wgpuTextureDestroy(texture: WGPUTexture) void;
pub extern fn wgpuTextureGetDepthOrArrayLayers(texture: WGPUTexture) u32;
pub extern fn wgpuTextureGetDimension(texture: WGPUTexture) WGPUTextureDimension;
pub extern fn wgpuTextureGetFormat(texture: WGPUTexture) WGPUTextureFormat;
pub extern fn wgpuTextureGetHeight(texture: WGPUTexture) u32;
pub extern fn wgpuTextureGetMipLevelCount(texture: WGPUTexture) u32;
pub extern fn wgpuTextureGetSampleCount(texture: WGPUTexture) u32;
pub extern fn wgpuTextureGetUsage(texture: WGPUTexture) WGPUTextureUsage;
pub extern fn wgpuTextureGetWidth(texture: WGPUTexture) u32;
pub extern fn wgpuTextureSetLabel(texture: WGPUTexture, label: WGPUStringView) void;
pub extern fn wgpuTextureAddRef(texture: WGPUTexture) void;
pub extern fn wgpuTextureRelease(texture: WGPUTexture) void;
pub extern fn wgpuTextureViewSetLabel(textureView: WGPUTextureView, label: WGPUStringView) void;
pub extern fn wgpuTextureViewAddRef(textureView: WGPUTextureView) void;
pub extern fn wgpuTextureViewRelease(textureView: WGPUTextureView) void;
pub const WGPUSType_DeviceExtras: c_int = 196609;
pub const WGPUSType_NativeLimits: c_int = 196610;
pub const WGPUSType_PipelineLayoutExtras: c_int = 196611;
pub const WGPUSType_ShaderSourceGLSL: c_int = 196612;
pub const WGPUSType_InstanceExtras: c_int = 196614;
pub const WGPUSType_BindGroupEntryExtras: c_int = 196615;
pub const WGPUSType_BindGroupLayoutEntryExtras: c_int = 196616;
pub const WGPUSType_QuerySetDescriptorExtras: c_int = 196617;
pub const WGPUSType_SurfaceConfigurationExtras: c_int = 196618;
pub const WGPUSType_SurfaceSourceSwapChainPanel: c_int = 196619;
pub const WGPUSType_PrimitiveStateExtras: c_int = 196620;
pub const WGPUNativeSType_Force32: c_int = 2147483647;
pub const enum_WGPUNativeSType = c_uint;
pub const WGPUNativeSType = enum_WGPUNativeSType;
pub const WGPUNativeFeature_PushConstants: c_int = 196609;
pub const WGPUNativeFeature_TextureAdapterSpecificFormatFeatures: c_int = 196610;
pub const WGPUNativeFeature_MultiDrawIndirectCount: c_int = 196612;
pub const WGPUNativeFeature_VertexWritableStorage: c_int = 196613;
pub const WGPUNativeFeature_TextureBindingArray: c_int = 196614;
pub const WGPUNativeFeature_SampledTextureAndStorageBufferArrayNonUniformIndexing: c_int = 196615;
pub const WGPUNativeFeature_PipelineStatisticsQuery: c_int = 196616;
pub const WGPUNativeFeature_StorageResourceBindingArray: c_int = 196617;
pub const WGPUNativeFeature_PartiallyBoundBindingArray: c_int = 196618;
pub const WGPUNativeFeature_TextureFormat16bitNorm: c_int = 196619;
pub const WGPUNativeFeature_TextureCompressionAstcHdr: c_int = 196620;
pub const WGPUNativeFeature_MappablePrimaryBuffers: c_int = 196622;
pub const WGPUNativeFeature_BufferBindingArray: c_int = 196623;
pub const WGPUNativeFeature_UniformBufferAndStorageTextureArrayNonUniformIndexing: c_int = 196624;
pub const WGPUNativeFeature_PolygonModeLine: c_int = 196627;
pub const WGPUNativeFeature_PolygonModePoint: c_int = 196628;
pub const WGPUNativeFeature_ConservativeRasterization: c_int = 196629;
pub const WGPUNativeFeature_SpirvShaderPassthrough: c_int = 196631;
pub const WGPUNativeFeature_VertexAttribute64bit: c_int = 196633;
pub const WGPUNativeFeature_TextureFormatNv12: c_int = 196634;
pub const WGPUNativeFeature_RayQuery: c_int = 196636;
pub const WGPUNativeFeature_ShaderF64: c_int = 196637;
pub const WGPUNativeFeature_ShaderI16: c_int = 196638;
pub const WGPUNativeFeature_ShaderPrimitiveIndex: c_int = 196639;
pub const WGPUNativeFeature_ShaderEarlyDepthTest: c_int = 196640;
pub const WGPUNativeFeature_Subgroup: c_int = 196641;
pub const WGPUNativeFeature_SubgroupVertex: c_int = 196642;
pub const WGPUNativeFeature_SubgroupBarrier: c_int = 196643;
pub const WGPUNativeFeature_TimestampQueryInsideEncoders: c_int = 196644;
pub const WGPUNativeFeature_TimestampQueryInsidePasses: c_int = 196645;
pub const WGPUNativeFeature_ShaderInt64: c_int = 196646;
pub const WGPUNativeFeature_Force32: c_int = 2147483647;
pub const enum_WGPUNativeFeature = c_uint;
pub const WGPUNativeFeature = enum_WGPUNativeFeature;
pub const WGPULogLevel_Off: c_int = 0;
pub const WGPULogLevel_Error: c_int = 1;
pub const WGPULogLevel_Warn: c_int = 2;
pub const WGPULogLevel_Info: c_int = 3;
pub const WGPULogLevel_Debug: c_int = 4;
pub const WGPULogLevel_Trace: c_int = 5;
pub const WGPULogLevel_Force32: c_int = 2147483647;
pub const enum_WGPULogLevel = c_uint;
pub const WGPULogLevel = enum_WGPULogLevel;
pub const WGPUInstanceBackend = WGPUFlags;
pub const WGPUInstanceBackend_All: WGPUInstanceBackend = 0;
pub const WGPUInstanceBackend_Vulkan: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(0)));
pub const WGPUInstanceBackend_GL: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(1)));
pub const WGPUInstanceBackend_Metal: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(2)));
pub const WGPUInstanceBackend_DX12: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(3)));
pub const WGPUInstanceBackend_DX11: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(4)));
pub const WGPUInstanceBackend_BrowserWebGPU: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(5)));
pub const WGPUInstanceBackend_Primary: WGPUInstanceBackend = @bitCast(@as(c_long, (((@as(c_int, 1) << @intCast(0)) | (@as(c_int, 1) << @intCast(2))) | (@as(c_int, 1) << @intCast(3))) | (@as(c_int, 1) << @intCast(5))));
pub const WGPUInstanceBackend_Secondary: WGPUInstanceBackend = @bitCast(@as(c_long, (@as(c_int, 1) << @intCast(1)) | (@as(c_int, 1) << @intCast(4))));
pub const WGPUInstanceBackend_Force32: WGPUInstanceBackend = 2147483647;
pub const WGPUInstanceFlag = WGPUFlags;
pub const WGPUInstanceFlag_Default: WGPUInstanceFlag = 0;
pub const WGPUInstanceFlag_Debug: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(0)));
pub const WGPUInstanceFlag_Validation: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(1)));
pub const WGPUInstanceFlag_DiscardHalLabels: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(2)));
pub const WGPUInstanceFlag_Force32: WGPUInstanceFlag = 2147483647;
pub const WGPUDx12Compiler_Undefined: c_int = 0;
pub const WGPUDx12Compiler_Fxc: c_int = 1;
pub const WGPUDx12Compiler_Dxc: c_int = 2;
pub const WGPUDx12Compiler_Force32: c_int = 2147483647;
pub const enum_WGPUDx12Compiler = c_uint;
pub const WGPUDx12Compiler = enum_WGPUDx12Compiler;
pub const WGPUGles3MinorVersion_Automatic: c_int = 0;
pub const WGPUGles3MinorVersion_Version0: c_int = 1;
pub const WGPUGles3MinorVersion_Version1: c_int = 2;
pub const WGPUGles3MinorVersion_Version2: c_int = 3;
pub const WGPUGles3MinorVersion_Force32: c_int = 2147483647;
pub const enum_WGPUGles3MinorVersion = c_uint;
pub const WGPUGles3MinorVersion = enum_WGPUGles3MinorVersion;
pub const WGPUPipelineStatisticName_VertexShaderInvocations: c_int = 0;
pub const WGPUPipelineStatisticName_ClipperInvocations: c_int = 1;
pub const WGPUPipelineStatisticName_ClipperPrimitivesOut: c_int = 2;
pub const WGPUPipelineStatisticName_FragmentShaderInvocations: c_int = 3;
pub const WGPUPipelineStatisticName_ComputeShaderInvocations: c_int = 4;
pub const WGPUPipelineStatisticName_Force32: c_int = 2147483647;
pub const enum_WGPUPipelineStatisticName = c_uint;
pub const WGPUPipelineStatisticName = enum_WGPUPipelineStatisticName;
pub const WGPUNativeQueryType_PipelineStatistics: c_int = 196608;
pub const WGPUNativeQueryType_Force32: c_int = 2147483647;
pub const enum_WGPUNativeQueryType = c_uint;
pub const WGPUNativeQueryType = enum_WGPUNativeQueryType;
pub const WGPUDxcMaxShaderModel_V6_0: c_int = 0;
pub const WGPUDxcMaxShaderModel_V6_1: c_int = 1;
pub const WGPUDxcMaxShaderModel_V6_2: c_int = 2;
pub const WGPUDxcMaxShaderModel_V6_3: c_int = 3;
pub const WGPUDxcMaxShaderModel_V6_4: c_int = 4;
pub const WGPUDxcMaxShaderModel_V6_5: c_int = 5;
pub const WGPUDxcMaxShaderModel_V6_6: c_int = 6;
pub const WGPUDxcMaxShaderModel_V6_7: c_int = 7;
pub const WGPUDxcMaxShaderModel_Force32: c_int = 2147483647;
pub const enum_WGPUDxcMaxShaderModel = c_uint;
pub const WGPUDxcMaxShaderModel = enum_WGPUDxcMaxShaderModel;
pub const WGPUGLFenceBehaviour_Normal: c_int = 0;
pub const WGPUGLFenceBehaviour_AutoFinish: c_int = 1;
pub const WGPUGLFenceBehaviour_Force32: c_int = 2147483647;
pub const enum_WGPUGLFenceBehaviour = c_uint;
pub const WGPUGLFenceBehaviour = enum_WGPUGLFenceBehaviour;
pub const WGPUDx12SwapchainKind_Undefined: c_int = 0;
pub const WGPUDx12SwapchainKind_DxgiFromHwnd: c_int = 1;
pub const WGPUDx12SwapchainKind_DxgiFromVisual: c_int = 2;
pub const WGPUDx12SwapchainKind_Force32: c_int = 2147483647;
pub const enum_WGPUDx12SwapchainKind = c_uint;
pub const WGPUDx12SwapchainKind = enum_WGPUDx12SwapchainKind;
pub const struct_WGPUInstanceExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    backends: WGPUInstanceBackend = 0,
    flags: WGPUInstanceFlag = 0,
    dx12ShaderCompiler: WGPUDx12Compiler = @import("std").mem.zeroes(WGPUDx12Compiler),
    gles3MinorVersion: WGPUGles3MinorVersion = @import("std").mem.zeroes(WGPUGles3MinorVersion),
    glFenceBehaviour: WGPUGLFenceBehaviour = @import("std").mem.zeroes(WGPUGLFenceBehaviour),
    dxcPath: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    dxcMaxShaderModel: WGPUDxcMaxShaderModel = @import("std").mem.zeroes(WGPUDxcMaxShaderModel),
    dx12PresentationSystem: WGPUDx12SwapchainKind = @import("std").mem.zeroes(WGPUDx12SwapchainKind),
    budgetForDeviceCreation: [*c]const u8 = null,
    budgetForDeviceLoss: [*c]const u8 = null,
};
pub const WGPUInstanceExtras = struct_WGPUInstanceExtras;
pub const struct_WGPUDeviceExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    tracePath: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUDeviceExtras = struct_WGPUDeviceExtras;
pub const struct_WGPUNativeLimits = extern struct {
    chain: WGPUChainedStructOut = @import("std").mem.zeroes(WGPUChainedStructOut),
    maxPushConstantSize: u32 = 0,
    maxNonSamplerBindings: u32 = 0,
    maxBindingArrayElementsPerShaderStage: u32 = 0,
};
pub const WGPUNativeLimits = struct_WGPUNativeLimits;
pub const struct_WGPUPushConstantRange = extern struct {
    stages: WGPUShaderStage = 0,
    start: u32 = 0,
    end: u32 = 0,
};
pub const WGPUPushConstantRange = struct_WGPUPushConstantRange;
pub const struct_WGPUPipelineLayoutExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    pushConstantRangeCount: usize = 0,
    pushConstantRanges: [*c]const WGPUPushConstantRange = null,
};
pub const WGPUPipelineLayoutExtras = struct_WGPUPipelineLayoutExtras;
pub const WGPUSubmissionIndex = u64;
pub const struct_WGPUShaderDefine = extern struct {
    name: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    value: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUShaderDefine = struct_WGPUShaderDefine;
pub const struct_WGPUShaderSourceGLSL = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    stage: WGPUShaderStage = 0,
    code: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    defineCount: u32 = 0,
    defines: [*c]WGPUShaderDefine = null,
};
pub const WGPUShaderSourceGLSL = struct_WGPUShaderSourceGLSL;
pub const struct_WGPUShaderModuleDescriptorSpirV = extern struct {
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    sourceSize: u32 = 0,
    source: [*c]const u32 = null,
};
pub const WGPUShaderModuleDescriptorSpirV = struct_WGPUShaderModuleDescriptorSpirV;
pub const struct_WGPURegistryReport = extern struct {
    numAllocated: usize = 0,
    numKeptFromUser: usize = 0,
    numReleasedFromUser: usize = 0,
    elementSize: usize = 0,
};
pub const WGPURegistryReport = struct_WGPURegistryReport;
pub const struct_WGPUHubReport = extern struct {
    adapters: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    devices: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    queues: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    pipelineLayouts: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    shaderModules: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    bindGroupLayouts: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    bindGroups: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    commandBuffers: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    renderBundles: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    renderPipelines: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    computePipelines: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    pipelineCaches: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    querySets: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    buffers: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    textures: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    textureViews: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    samplers: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
};
pub const WGPUHubReport = struct_WGPUHubReport;
pub const struct_WGPUGlobalReport = extern struct {
    surfaces: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    hub: WGPUHubReport = @import("std").mem.zeroes(WGPUHubReport),
};
pub const WGPUGlobalReport = struct_WGPUGlobalReport;
pub const struct_WGPUInstanceEnumerateAdapterOptions = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    backends: WGPUInstanceBackend = 0,
};
pub const WGPUInstanceEnumerateAdapterOptions = struct_WGPUInstanceEnumerateAdapterOptions;
pub const struct_WGPUBindGroupEntryExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    buffers: [*c]const WGPUBuffer = null,
    bufferCount: usize = 0,
    samplers: [*c]const WGPUSampler = null,
    samplerCount: usize = 0,
    textureViews: [*c]const WGPUTextureView = null,
    textureViewCount: usize = 0,
};
pub const WGPUBindGroupEntryExtras = struct_WGPUBindGroupEntryExtras;
pub const struct_WGPUBindGroupLayoutEntryExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    count: u32 = 0,
};
pub const WGPUBindGroupLayoutEntryExtras = struct_WGPUBindGroupLayoutEntryExtras;
pub const struct_WGPUQuerySetDescriptorExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    pipelineStatistics: [*c]const WGPUPipelineStatisticName = null,
    pipelineStatisticCount: usize = 0,
};
pub const WGPUQuerySetDescriptorExtras = struct_WGPUQuerySetDescriptorExtras;
pub const struct_WGPUSurfaceConfigurationExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    desiredMaximumFrameLatency: u32 = 0,
};
pub const WGPUSurfaceConfigurationExtras = struct_WGPUSurfaceConfigurationExtras;
pub const struct_WGPUSurfaceSourceSwapChainPanel = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    panelNative: ?*anyopaque = null,
};
pub const WGPUSurfaceSourceSwapChainPanel = struct_WGPUSurfaceSourceSwapChainPanel;
pub const WGPUPolygonMode_Fill: c_int = 0;
pub const WGPUPolygonMode_Line: c_int = 1;
pub const WGPUPolygonMode_Point: c_int = 2;
pub const enum_WGPUPolygonMode = c_uint;
pub const WGPUPolygonMode = enum_WGPUPolygonMode;
pub const struct_WGPUPrimitiveStateExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    polygonMode: WGPUPolygonMode = @import("std").mem.zeroes(WGPUPolygonMode),
    conservative: WGPUBool = 0,
};
pub const WGPUPrimitiveStateExtras = struct_WGPUPrimitiveStateExtras;
pub const WGPULogCallback = ?*const fn (level: WGPULogLevel, message: WGPUStringView, userdata: ?*anyopaque) callconv(.c) void;
pub const WGPUNativeTextureFormat_R16Unorm: c_int = 196609;
pub const WGPUNativeTextureFormat_R16Snorm: c_int = 196610;
pub const WGPUNativeTextureFormat_Rg16Unorm: c_int = 196611;
pub const WGPUNativeTextureFormat_Rg16Snorm: c_int = 196612;
pub const WGPUNativeTextureFormat_Rgba16Unorm: c_int = 196613;
pub const WGPUNativeTextureFormat_Rgba16Snorm: c_int = 196614;
pub const WGPUNativeTextureFormat_NV12: c_int = 196615;
pub const WGPUNativeTextureFormat_P010: c_int = 196616;
pub const enum_WGPUNativeTextureFormat = c_uint;
pub const WGPUNativeTextureFormat = enum_WGPUNativeTextureFormat;
pub extern fn wgpuGenerateReport(instance: WGPUInstance, report: [*c]WGPUGlobalReport) void;
pub extern fn wgpuInstanceEnumerateAdapters(instance: WGPUInstance, options: [*c]const WGPUInstanceEnumerateAdapterOptions, adapters: [*c]WGPUAdapter) usize;
pub extern fn wgpuQueueSubmitForIndex(queue: WGPUQueue, commandCount: usize, commands: [*c]const WGPUCommandBuffer) WGPUSubmissionIndex;
pub extern fn wgpuQueueGetTimestampPeriod(queue: WGPUQueue) f32;
pub extern fn wgpuDevicePoll(device: WGPUDevice, wait: WGPUBool, submissionIndex: [*c]const WGPUSubmissionIndex) WGPUBool;
pub extern fn wgpuDeviceCreateShaderModuleSpirV(device: WGPUDevice, descriptor: [*c]const WGPUShaderModuleDescriptorSpirV) WGPUShaderModule;
pub extern fn wgpuSetLogCallback(callback: WGPULogCallback, userdata: ?*anyopaque) void;
pub extern fn wgpuSetLogLevel(level: WGPULogLevel) void;
pub extern fn wgpuGetVersion() u32;
pub extern fn wgpuRenderPassEncoderSetPushConstants(encoder: WGPURenderPassEncoder, stages: WGPUShaderStage, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void;
pub extern fn wgpuComputePassEncoderSetPushConstants(encoder: WGPUComputePassEncoder, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void;
pub extern fn wgpuRenderBundleEncoderSetPushConstants(encoder: WGPURenderBundleEncoder, stages: WGPUShaderStage, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void;
pub extern fn wgpuRenderPassEncoderMultiDrawIndirect(encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count: u32) void;
pub extern fn wgpuRenderPassEncoderMultiDrawIndexedIndirect(encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count: u32) void;
pub extern fn wgpuRenderPassEncoderMultiDrawIndirectCount(encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count_buffer: WGPUBuffer, count_buffer_offset: u64, max_count: u32) void;
pub extern fn wgpuRenderPassEncoderMultiDrawIndexedIndirectCount(encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count_buffer: WGPUBuffer, count_buffer_offset: u64, max_count: u32) void;
pub extern fn wgpuComputePassEncoderBeginPipelineStatisticsQuery(computePassEncoder: WGPUComputePassEncoder, querySet: WGPUQuerySet, queryIndex: u32) void;
pub extern fn wgpuComputePassEncoderEndPipelineStatisticsQuery(computePassEncoder: WGPUComputePassEncoder) void;
pub extern fn wgpuRenderPassEncoderBeginPipelineStatisticsQuery(renderPassEncoder: WGPURenderPassEncoder, querySet: WGPUQuerySet, queryIndex: u32) void;
pub extern fn wgpuRenderPassEncoderEndPipelineStatisticsQuery(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuComputePassEncoderWriteTimestamp(computePassEncoder: WGPUComputePassEncoder, querySet: WGPUQuerySet, queryIndex: u32) void;
pub extern fn wgpuRenderPassEncoderWriteTimestamp(renderPassEncoder: WGPURenderPassEncoder, querySet: WGPUQuerySet, queryIndex: u32) void;

pub const __VERSION__ = "Aro aro-zig";
pub const __Aro__ = "";
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __GNUC__ = @as(c_int, 7);
pub const __GNUC_MINOR__ = @as(c_int, 1);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 0);
pub const __ARO_EMULATE_CLANG__ = @as(c_int, 1);
pub const __ARO_EMULATE_GCC__ = @as(c_int, 2);
pub const __ARO_EMULATE_MSVC__ = @as(c_int, 3);
pub const __ARO_EMULATE__ = __ARO_EMULATE_GCC__;
pub inline fn __building_module(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`"); // <builtin>:32:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`"); // <builtin>:33:9
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __VAES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __VPCLMULQDQ__ = @as(c_int, 1);
pub const __LZCNT__ = @as(c_int, 1);
pub const __RDRND__ = @as(c_int, 1);
pub const __FSGSBASE__ = @as(c_int, 1);
pub const __BMI__ = @as(c_int, 1);
pub const __BMI2__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __PRFCHW__ = @as(c_int, 1);
pub const __ADX__ = @as(c_int, 1);
pub const __MWAITX__ = @as(c_int, 1);
pub const __MOVBE__ = @as(c_int, 1);
pub const __SSE4A__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __GFNI__ = @as(c_int, 1);
pub const __EVEX512__ = @as(c_int, 1);
pub const __AVX512CD__ = @as(c_int, 1);
pub const __AVX512VPOPCNTDQ__ = @as(c_int, 1);
pub const __AVX512VNNI__ = @as(c_int, 1);
pub const __AVX512BF16__ = @as(c_int, 1);
pub const __AVX512DQ__ = @as(c_int, 1);
pub const __AVX512BITALG__ = @as(c_int, 1);
pub const __AVX512BW__ = @as(c_int, 1);
pub const __AVX512VL__ = @as(c_int, 1);
pub const __EVEX256__ = @as(c_int, 1);
pub const __AVX512VBMI__ = @as(c_int, 1);
pub const __AVX512VBMI2__ = @as(c_int, 1);
pub const __AVX512IFMA__ = @as(c_int, 1);
pub const __AVX512VP2INTERSECT__ = @as(c_int, 1);
pub const __SHA__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __XSAVE__ = @as(c_int, 1);
pub const __XSAVEOPT__ = @as(c_int, 1);
pub const __XSAVEC__ = @as(c_int, 1);
pub const __XSAVES__ = @as(c_int, 1);
pub const __PKU__ = @as(c_int, 1);
pub const __CLFLUSHOPT__ = @as(c_int, 1);
pub const __CLWB__ = @as(c_int, 1);
pub const __WBNOINVD__ = @as(c_int, 1);
pub const __SHSTK__ = @as(c_int, 1);
pub const __CLZERO__ = @as(c_int, 1);
pub const __RDPID__ = @as(c_int, 1);
pub const __RDPRU__ = @as(c_int, 1);
pub const __MOVDIRI__ = @as(c_int, 1);
pub const __MOVDIR64B__ = @as(c_int, 1);
pub const __INVPCID__ = @as(c_int, 1);
pub const __AVXVNNI__ = @as(c_int, 1);
pub const __CRC32__ = @as(c_int, 1);
pub const __AVX512F__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const __ELF__ = @as(c_int, 1);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __ATOMIC_BOOL_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_SHORT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_INT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LLONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_POINTER_LOCK_FREE = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SCHAR_WIDTH__ = @as(c_int, 8);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __LONG_LONG_WIDTH__ = @as(c_int, 64);
pub const __WCHAR_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIG_ATOMIC_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __BITINT_MAXWIDTH__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 10);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTPTR_TYPE__ = c_long;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:169:9
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:171:9
pub const __PTRDIFF_TYPE__ = c_long;
pub const __SIZE_TYPE__ = c_ulong;
pub const __WCHAR_TYPE__ = c_int;
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:192:9
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub const __UINT16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`"); // <builtin>:214:9
pub const __UINT32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:222:9
pub const __UINT64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const INT_LEAST8_FMTd__ = "hhd";
pub const INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const UINT_LEAST8_FMTo__ = "hho";
pub const UINT_LEAST8_FMTu__ = "hhu";
pub const UINT_LEAST8_FMTx__ = "hhx";
pub const UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const INT_FAST8_FMTd__ = "hhd";
pub const INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const UINT_FAST8_FMTo__ = "hho";
pub const UINT_FAST8_FMTu__ = "hhu";
pub const UINT_FAST8_FMTx__ = "hhx";
pub const UINT_FAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const INT_LEAST16_FMTd__ = "hd";
pub const INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST16_FMTo__ = "ho";
pub const UINT_LEAST16_FMTu__ = "hu";
pub const UINT_LEAST16_FMTx__ = "hx";
pub const UINT_LEAST16_FMTX__ = "hX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const INT_FAST16_FMTd__ = "hd";
pub const INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_FAST16_FMTo__ = "ho";
pub const UINT_FAST16_FMTu__ = "hu";
pub const UINT_FAST16_FMTx__ = "hx";
pub const UINT_FAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const INT_LEAST32_FMTd__ = "d";
pub const INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST32_FMTo__ = "o";
pub const UINT_LEAST32_FMTu__ = "u";
pub const UINT_LEAST32_FMTx__ = "x";
pub const UINT_LEAST32_FMTX__ = "X";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const INT_FAST32_FMTd__ = "d";
pub const INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_FAST32_FMTo__ = "o";
pub const UINT_FAST32_FMTu__ = "u";
pub const UINT_FAST32_FMTx__ = "x";
pub const UINT_FAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const INT_LEAST64_FMTd__ = "ld";
pub const INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_LEAST64_FMTo__ = "lo";
pub const UINT_LEAST64_FMTu__ = "lu";
pub const UINT_LEAST64_FMTx__ = "lx";
pub const UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const INT_FAST64_FMTd__ = "ld";
pub const INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_FMTo__ = "lo";
pub const UINT_FAST64_FMTu__ = "lu";
pub const UINT_FAST64_FMTx__ = "lx";
pub const UINT_FAST64_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = "";
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = "";
pub const __FLT16_HAS_QUIET_NAN__ = "";
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = "";
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = "";
pub const __FLT_HAS_QUIET_NAN__ = "";
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = "";
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = "";
pub const __DBL_HAS_QUIET_NAN__ = "";
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = "";
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = "";
pub const __LDBL_HAS_QUIET_NAN__ = "";
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __FLT_EVAL_METHOD__ = @as(c_int, 0);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const WGPUAdapterImpl = struct_WGPUAdapterImpl;
pub const WGPUBindGroupImpl = struct_WGPUBindGroupImpl;
pub const WGPUBindGroupLayoutImpl = struct_WGPUBindGroupLayoutImpl;
pub const WGPUBufferImpl = struct_WGPUBufferImpl;
pub const WGPUCommandBufferImpl = struct_WGPUCommandBufferImpl;
pub const WGPUCommandEncoderImpl = struct_WGPUCommandEncoderImpl;
pub const WGPUComputePassEncoderImpl = struct_WGPUComputePassEncoderImpl;
pub const WGPUComputePipelineImpl = struct_WGPUComputePipelineImpl;
pub const WGPUDeviceImpl = struct_WGPUDeviceImpl;
pub const WGPUInstanceImpl = struct_WGPUInstanceImpl;
pub const WGPUPipelineLayoutImpl = struct_WGPUPipelineLayoutImpl;
pub const WGPUQuerySetImpl = struct_WGPUQuerySetImpl;
pub const WGPUQueueImpl = struct_WGPUQueueImpl;
pub const WGPURenderBundleImpl = struct_WGPURenderBundleImpl;
pub const WGPURenderBundleEncoderImpl = struct_WGPURenderBundleEncoderImpl;
pub const WGPURenderPassEncoderImpl = struct_WGPURenderPassEncoderImpl;
pub const WGPURenderPipelineImpl = struct_WGPURenderPipelineImpl;
pub const WGPUSamplerImpl = struct_WGPUSamplerImpl;
pub const WGPUShaderModuleImpl = struct_WGPUShaderModuleImpl;
pub const WGPUSurfaceImpl = struct_WGPUSurfaceImpl;
pub const WGPUTextureImpl = struct_WGPUTextureImpl;
pub const WGPUTextureViewImpl = struct_WGPUTextureViewImpl;
