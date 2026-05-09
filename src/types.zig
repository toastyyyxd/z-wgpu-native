const c = @import("c_wgpu_native");
const std = @import("std");
const types = @This();

pub const MapAsyncStatus = enum(c_uint) {
    success = 1,
    instance_dropped = 2,
    @"error" = 3,
    aborted = 4,
    unknown = 5,
};

pub const PolygonMode = enum(c_uint) {
    fill = 0,
    line = 1,
    point = 2,
};

pub const CullMode = enum(c_uint) {
    @"undefined" = 0,
    none = 1,
    front = 2,
    back = 3,
};

pub const BackendType = enum(c_uint) {
    @"undefined" = 0,
    @"null" = 1,
    web_gpu = 2,
    d3d11 = 3,
    d3d12 = 4,
    metal = 5,
    vulkan = 6,
    open_gl = 7,
    open_gles = 8,
};

pub const BufferMapState = enum(c_uint) {
    unmapped = 1,
    pending = 2,
    mapped = 3,
};

pub const OptionalBool = enum(c_uint) {
    @"false" = 0,
    @"true" = 1,
    @"undefined" = 2,
};

pub const ErrorFilter = enum(c_uint) {
    validation = 1,
    out_of_memory = 2,
    internal = 3,
};

pub const Dx12SwapchainKind = enum(c_uint) {
    @"undefined" = 0,
    dxgi_from_hwnd = 1,
    dxgi_from_visual = 2,
};

pub const PowerPreference = enum(c_uint) {
    @"undefined" = 0,
    low_power = 1,
    high_performance = 2,
};

pub const Gles3MinorVersion = enum(c_uint) {
    automatic = 0,
    version0 = 1,
    version1 = 2,
    version2 = 3,
};

pub const CompilationInfoRequestStatus = enum(c_uint) {
    success = 1,
    instance_dropped = 2,
    @"error" = 3,
    unknown = 4,
};

pub const NativeTextureFormat = enum(c_uint) {
    r16_unorm = 196609,
    r16_snorm = 196610,
    rg16_unorm = 196611,
    rg16_snorm = 196612,
    rgba16_unorm = 196613,
    rgba16_snorm = 196614,
    nv12 = 196615,
    p010 = 196616,
};

pub const CompilationMessageType = enum(c_uint) {
    @"error" = 1,
    warning = 2,
    info = 3,
};

pub const MipmapFilterMode = enum(c_uint) {
    @"undefined" = 0,
    nearest = 1,
    linear = 2,
};

pub const WGSLLanguageFeatureName = enum(c_uint) {
    readonly_and_readwrite_storage_textures = 1,
    packed4x8_integer_dot_product = 2,
    unrestricted_pointer_parameters = 3,
    pointer_composite_access = 4,
};

pub const AddressMode = enum(c_uint) {
    @"undefined" = 0,
    clamp_to_edge = 1,
    repeat = 2,
    mirror_repeat = 3,
};

pub const TextureSampleType = enum(c_uint) {
    binding_not_used = 0,
    @"undefined" = 1,
    float = 2,
    unfilterable_float = 3,
    depth = 4,
    sint = 5,
    uint = 6,
};

pub const ErrorType = enum(c_uint) {
    no_error = 1,
    validation = 2,
    out_of_memory = 3,
    internal = 4,
    unknown = 5,
};

pub const PopErrorScopeStatus = enum(c_uint) {
    success = 1,
    instance_dropped = 2,
    empty_stack = 3,
};

pub const RequestDeviceStatus = enum(c_uint) {
    success = 1,
    instance_dropped = 2,
    @"error" = 3,
    unknown = 4,
};

pub const VertexStepMode = enum(c_uint) {
    vertex_buffer_not_used = 0,
    @"undefined" = 1,
    vertex = 2,
    instance = 3,
};

pub const LogLevel = enum(c_uint) {
    off = 0,
    @"error" = 1,
    warn = 2,
    info = 3,
    debug = 4,
    trace = 5,
};

pub const NativeFeature = enum(c_uint) {
    immediates = 196609,
    texture_adapter_specific_format_features = 196610,
    multi_draw_indirect_count = 196612,
    vertex_writable_storage = 196613,
    texture_binding_array = 196614,
    sampled_texture_and_storage_buffer_array_non_uniform_indexing = 196615,
    pipeline_statistics_query = 196616,
    storage_resource_binding_array = 196617,
    partially_bound_binding_array = 196618,
    texture_format16bit_norm = 196619,
    texture_compression_astc_hdr = 196620,
    mappable_primary_buffers = 196622,
    buffer_binding_array = 196623,
    storage_texture_array_non_uniform_indexing = 196624,
    polygon_mode_line = 196627,
    polygon_mode_point = 196628,
    conservative_rasterization = 196629,
    clear_texture = 196630,
    multiview = 196632,
    vertex_attribute64bit = 196633,
    texture_format_nv12 = 196634,
    ray_query = 196636,
    shader_f64 = 196637,
    shader_i16 = 196638,
    shader_early_depth_test = 196640,
    subgroup = 196641,
    subgroup_vertex = 196642,
    subgroup_barrier = 196643,
    timestamp_query_inside_encoders = 196644,
    timestamp_query_inside_passes = 196645,
    shader_int64 = 196646,
    shader_float32_atomic = 196647,
    texture_atomic = 196648,
    texture_format_p010 = 196649,
    pipeline_cache = 196651,
    shader_int64_atomic_min_max = 196652,
    shader_int64_atomic_all_ops = 196653,
    texture_int64_atomic = 196656,
    shader_barycentrics = 196663,
    selective_multiview = 196664,
    multisample_array = 196666,
    cooperative_matrix = 196667,
    shader_per_vertex = 196668,
    shader_draw_index = 196669,
    acceleration_structure_binding_array = 196670,
    memory_decoration_coherent = 196671,
    memory_decoration_volatile = 196672,
};

pub const BlendOperation = enum(c_uint) {
    @"undefined" = 0,
    add = 1,
    subtract = 2,
    reverse_subtract = 3,
    min = 4,
    max = 5,
};

pub const CallbackMode = enum(c_uint) {
    wait_any_only = 1,
    allow_process_events = 2,
    allow_spontaneous = 3,
};

pub const BlendFactor = enum(c_uint) {
    @"undefined" = 0,
    zero = 1,
    one = 2,
    src = 3,
    one_minus_src = 4,
    src_alpha = 5,
    one_minus_src_alpha = 6,
    dst = 7,
    one_minus_dst = 8,
    dst_alpha = 9,
    one_minus_dst_alpha = 10,
    src_alpha_saturated = 11,
    constant = 12,
    one_minus_constant = 13,
    src1 = 14,
    one_minus_src1 = 15,
    src1_alpha = 16,
    one_minus_src1_alpha = 17,
};

pub const TextureFormat = enum(c_uint) {
    @"undefined" = 0,
    r8_unorm = 1,
    r8_snorm = 2,
    r8_uint = 3,
    r8_sint = 4,
    r16_uint = 5,
    r16_sint = 6,
    r16_float = 7,
    rg8_unorm = 8,
    rg8_snorm = 9,
    rg8_uint = 10,
    rg8_sint = 11,
    r32_float = 12,
    r32_uint = 13,
    r32_sint = 14,
    rg16_uint = 15,
    rg16_sint = 16,
    rg16_float = 17,
    rgba8_unorm = 18,
    rgba8_unorm_srgb = 19,
    rgba8_snorm = 20,
    rgba8_uint = 21,
    rgba8_sint = 22,
    bgra8_unorm = 23,
    bgra8_unorm_srgb = 24,
    rgb10a2_uint = 25,
    rgb10a2_unorm = 26,
    rg11b10_ufloat = 27,
    rgb9e5_ufloat = 28,
    rg32_float = 29,
    rg32_uint = 30,
    rg32_sint = 31,
    rgba16_uint = 32,
    rgba16_sint = 33,
    rgba16_float = 34,
    rgba32_float = 35,
    rgba32_uint = 36,
    rgba32_sint = 37,
    stencil8 = 38,
    depth16_unorm = 39,
    depth24_plus = 40,
    depth24_plus_stencil8 = 41,
    depth32_float = 42,
    depth32_float_stencil8 = 43,
    bc1rgba_unorm = 44,
    bc1rgba_unorm_srgb = 45,
    bc2rgba_unorm = 46,
    bc2rgba_unorm_srgb = 47,
    bc3rgba_unorm = 48,
    bc3rgba_unorm_srgb = 49,
    bc4r_unorm = 50,
    bc4r_snorm = 51,
    bc5rg_unorm = 52,
    bc5rg_snorm = 53,
    bc6hrgb_ufloat = 54,
    bc6hrgb_float = 55,
    bc7rgba_unorm = 56,
    bc7rgba_unorm_srgb = 57,
    etc2rgb8_unorm = 58,
    etc2rgb8_unorm_srgb = 59,
    etc2rgb8a1_unorm = 60,
    etc2rgb8a1_unorm_srgb = 61,
    etc2rgba8_unorm = 62,
    etc2rgba8_unorm_srgb = 63,
    eacr11_unorm = 64,
    eacr11_snorm = 65,
    eacrg11_unorm = 66,
    eacrg11_snorm = 67,
    astc4x4_unorm = 68,
    astc4x4_unorm_srgb = 69,
    astc5x4_unorm = 70,
    astc5x4_unorm_srgb = 71,
    astc5x5_unorm = 72,
    astc5x5_unorm_srgb = 73,
    astc6x5_unorm = 74,
    astc6x5_unorm_srgb = 75,
    astc6x6_unorm = 76,
    astc6x6_unorm_srgb = 77,
    astc8x5_unorm = 78,
    astc8x5_unorm_srgb = 79,
    astc8x6_unorm = 80,
    astc8x6_unorm_srgb = 81,
    astc8x8_unorm = 82,
    astc8x8_unorm_srgb = 83,
    astc10x5_unorm = 84,
    astc10x5_unorm_srgb = 85,
    astc10x6_unorm = 86,
    astc10x6_unorm_srgb = 87,
    astc10x8_unorm = 88,
    astc10x8_unorm_srgb = 89,
    astc10x10_unorm = 90,
    astc10x10_unorm_srgb = 91,
    astc12x10_unorm = 92,
    astc12x10_unorm_srgb = 93,
    astc12x12_unorm = 94,
    astc12x12_unorm_srgb = 95,
};

pub const StoreOp = enum(c_uint) {
    @"undefined" = 0,
    store = 1,
    discard = 2,
};

pub const StorageTextureAccess = enum(c_uint) {
    binding_not_used = 0,
    @"undefined" = 1,
    write_only = 2,
    read_only = 3,
    read_write = 4,
};

pub const QueueWorkDoneStatus = enum(c_uint) {
    success = 1,
    instance_dropped = 2,
    @"error" = 3,
    unknown = 4,
};

pub const TextureDimension = enum(c_uint) {
    @"undefined" = 0,
    _1d = 1,
    _2d = 2,
    _3d = 3,
};

pub const WaitStatus = enum(c_uint) {
    success = 1,
    timed_out = 2,
    unsupported_timeout = 3,
    unsupported_count = 4,
    unsupported_mixed_sources = 5,
};

pub const DeviceLostReason = enum(c_uint) {
    unknown = 1,
    destroyed = 2,
    instance_dropped = 3,
    failed_creation = 4,
};

pub const Status = enum(c_uint) {
    success = 1,
    @"error" = 2,
};

pub const SurfaceGetCurrentTextureStatus = enum(c_uint) {
    success_optimal = 1,
    success_suboptimal = 2,
    timeout = 3,
    outdated = 4,
    lost = 5,
    out_of_memory = 6,
    device_lost = 7,
    @"error" = 8,
    occluded = 196609,
};

pub const BufferBindingType = enum(c_uint) {
    binding_not_used = 0,
    @"undefined" = 1,
    uniform = 2,
    storage = 3,
    read_only_storage = 4,
};

pub const StencilOperation = enum(c_uint) {
    @"undefined" = 0,
    keep = 1,
    zero = 2,
    replace = 3,
    invert = 4,
    increment_clamp = 5,
    decrement_clamp = 6,
    increment_wrap = 7,
    decrement_wrap = 8,
};

pub const GLFenceBehaviour = enum(c_uint) {
    normal = 0,
    auto_finish = 1,
};

pub const AdapterType = enum(c_uint) {
    discrete_gpu = 1,
    integrated_gpu = 2,
    cpu = 3,
    unknown = 4,
};

pub const VertexFormat = enum(c_uint) {
    uint8 = 1,
    uint8x2 = 2,
    uint8x4 = 3,
    sint8 = 4,
    sint8x2 = 5,
    sint8x4 = 6,
    unorm8 = 7,
    unorm8x2 = 8,
    unorm8x4 = 9,
    snorm8 = 10,
    snorm8x2 = 11,
    snorm8x4 = 12,
    uint16 = 13,
    uint16x2 = 14,
    uint16x4 = 15,
    sint16 = 16,
    sint16x2 = 17,
    sint16x4 = 18,
    unorm16 = 19,
    unorm16x2 = 20,
    unorm16x4 = 21,
    snorm16 = 22,
    snorm16x2 = 23,
    snorm16x4 = 24,
    float16 = 25,
    float16x2 = 26,
    float16x4 = 27,
    float32 = 28,
    float32x2 = 29,
    float32x3 = 30,
    float32x4 = 31,
    uint32 = 32,
    uint32x2 = 33,
    uint32x3 = 34,
    uint32x4 = 35,
    sint32 = 36,
    sint32x2 = 37,
    sint32x3 = 38,
    sint32x4 = 39,
    unorm10_10_10_2 = 40,
    unorm8x4bgra = 41,
};

pub const NativeQueryType = enum(c_uint) {
    pipeline_statistics = 196608,
};

pub const IndexFormat = enum(c_uint) {
    @"undefined" = 0,
    uint16 = 1,
    uint32 = 2,
};

pub const TextureViewDimension = enum(c_uint) {
    @"undefined" = 0,
    _1d = 1,
    _2d = 2,
    _2d_array = 3,
    cube = 4,
    cube_array = 5,
    _3d = 6,
};

pub const TextureAspect = enum(c_uint) {
    @"undefined" = 0,
    all = 1,
    stencil_only = 2,
    depth_only = 3,
};

pub const SType = enum(c_uint) {
    shader_source_spirv = 1,
    shader_source_wgsl = 2,
    render_pass_max_draw_count = 3,
    surface_source_metal_layer = 4,
    surface_source_windows_hwnd = 5,
    surface_source_xlib_window = 6,
    surface_source_wayland_surface = 7,
    surface_source_android_native_window = 8,
    surface_source_xcb_window = 9,
    device_extras = 196609,
    native_limits = 196610,
    pipeline_layout_extras = 196611,
    shader_source_glsl = 196612,
    instance_extras = 196614,
    bind_group_entry_extras = 196615,
    bind_group_layout_entry_extras = 196616,
    query_set_descriptor_extras = 196617,
    surface_configuration_extras = 196618,
    surface_source_swap_chain_panel = 196619,
    primitive_state_extras = 196620,
};

pub const Dx12Compiler = enum(c_uint) {
    @"undefined" = 0,
    fxc = 1,
    dxc = 2,
};

pub const NativeDisplayHandleType = enum(c_uint) {
    none = 0,
    xlib = 1,
    xcb = 2,
    wayland = 3,
};

pub const RequestAdapterStatus = enum(c_uint) {
    success = 1,
    instance_dropped = 2,
    unavailable = 3,
    @"error" = 4,
    unknown = 5,
};

pub const LoadOp = enum(c_uint) {
    @"undefined" = 0,
    load = 1,
    clear = 2,
};

pub const CreatePipelineAsyncStatus = enum(c_uint) {
    success = 1,
    instance_dropped = 2,
    validation_error = 3,
    internal_error = 4,
    unknown = 5,
};

pub const DxcMaxShaderModel = enum(c_uint) {
    v6_0 = 0,
    v6_1 = 1,
    v6_2 = 2,
    v6_3 = 3,
    v6_4 = 4,
    v6_5 = 5,
    v6_6 = 6,
    v6_7 = 7,
};

pub const FeatureName = enum(c_uint) {
    @"undefined" = 0,
    depth_clip_control = 1,
    depth32_float_stencil8 = 2,
    timestamp_query = 3,
    texture_compression_bc = 4,
    texture_compression_bc_sliced3d = 5,
    texture_compression_etc2 = 6,
    texture_compression_astc = 7,
    texture_compression_astc_sliced3d = 8,
    indirect_first_instance = 9,
    shader_f16 = 10,
    rg11b10_ufloat_renderable = 11,
    bgra8_unorm_storage = 12,
    float32_filterable = 13,
    float32_blendable = 14,
    clip_distances = 15,
    dual_source_blending = 16,
};

pub const PipelineStatisticName = enum(c_uint) {
    vertex_shader_invocations = 0,
    clipper_invocations = 1,
    clipper_primitives_out = 2,
    fragment_shader_invocations = 3,
    compute_shader_invocations = 4,
};

pub const QueryType = enum(c_uint) {
    occlusion = 1,
    timestamp = 2,
};

pub const SamplerBindingType = enum(c_uint) {
    binding_not_used = 0,
    @"undefined" = 1,
    filtering = 2,
    non_filtering = 3,
    comparison = 4,
};

pub const CompositeAlphaMode = enum(c_uint) {
    auto = 0,
    @"opaque" = 1,
    premultiplied = 2,
    unpremultiplied = 3,
    inherit = 4,
};

pub const FrontFace = enum(c_uint) {
    @"undefined" = 0,
    ccw = 1,
    cw = 2,
};

pub const FeatureLevel = enum(c_uint) {
    compatibility = 1,
    core = 2,
};

pub const FilterMode = enum(c_uint) {
    @"undefined" = 0,
    nearest = 1,
    linear = 2,
};

pub const CompareFunction = enum(c_uint) {
    @"undefined" = 0,
    never = 1,
    less = 2,
    equal = 3,
    less_equal = 4,
    greater = 5,
    not_equal = 6,
    greater_equal = 7,
    always = 8,
};

pub const PresentMode = enum(c_uint) {
    @"undefined" = 0,
    fifo = 1,
    fifo_relaxed = 2,
    immediate = 3,
    mailbox = 4,
};

pub const PrimitiveTopology = enum(c_uint) {
    @"undefined" = 0,
    point_list = 1,
    line_list = 2,
    line_strip = 3,
    triangle_list = 4,
    triangle_strip = 5,
};

pub const ColorWriteMask = packed struct(u64) {
    all: bool = false,
    red: bool = false,
    green: bool = false,
    blue: bool = false,
    alpha: bool = false,
    _: u60 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u64)); }
};

pub const ShaderStage = packed struct(u64) {
    vertex: bool = false,
    fragment: bool = false,
    compute: bool = false,
    _: u61 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u64)); }
};

pub const BufferUsage = packed struct(u64) {
    map_read: bool = false,
    map_write: bool = false,
    copy_src: bool = false,
    copy_dst: bool = false,
    index: bool = false,
    vertex: bool = false,
    uniform: bool = false,
    storage: bool = false,
    indirect: bool = false,
    query_resolve: bool = false,
    _: u54 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u64)); }
};

pub const TextureUsage = packed struct(u64) {
    copy_src: bool = false,
    copy_dst: bool = false,
    texture_binding: bool = false,
    storage_binding: bool = false,
    render_attachment: bool = false,
    _: u59 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u64)); }
};

pub const MapMode = packed struct(u64) {
    read: bool = false,
    write: bool = false,
    _: u62 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u64)); }
};

pub const InstanceBackend = packed struct(u32) {
    metal: bool = false,
    dx12: bool = false,
    secondary: bool = false,
    vulkan: bool = false,
    browser_web_gpu: bool = false,
    all: bool = false,
    gl: bool = false,
    _: u31 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u32)); }
};

pub const InstanceBackend_primary: InstanceBackend = @bitCast(@as(c_long, (((@as(c_int, 1) << @intCast(@as(c_int, 0))) | (@as(c_int, 1) << @intCast(@as(c_int, 2)))) | (@as(c_int, 1) << @intCast(@as(c_int, 3)))) | (@as(c_int, 1) << @intCast(@as(c_int, 5)))));

pub const InstanceFlag = packed struct(u32) {
    empty: bool = false,
    advanced_debugging: bool = false,
    discard_hal_labels: bool = false,
    allow_underlying_noncompliant_adapter: bool = false,
    default: bool = false,
    validation: bool = false,
    validation_indirect_call: bool = false,
    automatic_timestamp_normalization: bool = false,
    debug: bool = false,
    debugging: bool = false,
    gpu_based_validation: bool = false,
    with_env: bool = false,
    _: u31 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u32)); }
};

pub const StringView = extern struct {
    data: ?*const u8 = null,
    length: usize = 0,

    pub fn toSlice(sv: StringView) [:0]const u8 {
        return sv.data[0..sv.length :0];
    }

    pub fn fromSlice(slice: [:0]const u8) StringView {
        return .{ .data = slice.ptr, .length = slice.len };
    }
};

pub const ChainedStructOut = extern struct {
    next: ?*ChainedStructOut = null,
    s_type: SType = .{},
};

pub const AdapterInfo = extern struct {
    next_in_chain: ?*ChainedStructOut = null,
    vendor: [:0]const u8 = "",
    architecture: [:0]const u8 = "",
    device: [:0]const u8 = "",
    description: [:0]const u8 = "",
    backend_type: BackendType = .{},
    adapter_type: AdapterType = .{},
    vendor_id: u32 = 0,
    device_id: u32 = 0,
};

pub const ChainedStruct = extern struct {
    next: ?*const ChainedStruct = null,
    s_type: SType = .{},
};

pub const ChainedIterator = struct {
    current: ?*const ChainedStruct,

    pub fn next(self: *ChainedIterator) ?*const ChainedStruct {
        const cur = self.current orelse return null;
        self.current = cur.next;
        return cur;
    }
};

pub fn chainedIterator(first: ?*const ChainedStruct) ChainedIterator {
    return .{ .current = first };
}
pub const BindGroupEntry = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    binding: u32 = 0,
    buffer: c.WGPUBuffer = null,
    offset: u64 = 0,
    size: u64 = 0,
    sampler: c.WGPUSampler = null,
    texture_view: c.WGPUTextureView = null,
};

pub const BlendComponent = extern struct {
    operation: BlendOperation = .{},
    src_factor: BlendFactor = .{},
    dst_factor: BlendFactor = .{},
};

pub const BufferBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    type: BufferBindingType = .{},
    has_dynamic_offset: bool = false,
    min_binding_size: u64 = 0,
};

pub const BufferDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    usage: BufferUsage = 0,
    size: u64 = 0,
    mapped_at_creation: bool = false,
};

pub const Color = extern struct {
    r: f64 = 0,
    g: f64 = 0,
    b: f64 = 0,
    a: f64 = 0,
};

pub const CommandBufferDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
};

pub const CommandEncoderDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
};

pub const CompilationMessage = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    message: [:0]const u8 = "",
    type: CompilationMessageType = .{},
    line_num: u64 = 0,
    line_pos: u64 = 0,
    offset: u64 = 0,
    length: u64 = 0,
};

pub const ComputePassTimestampWrites = extern struct {
    query_set: c.WGPUQuerySet = null,
    beginning_of_pass_write_index: u32 = 0,
    end_of_pass_write_index: u32 = 0,
};

pub const ConstantEntry = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    key: [:0]const u8 = "",
    value: f64 = 0,
};

pub const Extent3D = extern struct {
    width: u32 = 0,
    height: u32 = 0,
    depth_or_array_layers: u32 = 0,
};

pub const Future = extern struct {
    id: u64 = 0,
};

pub const InstanceCapabilities = extern struct {
    next_in_chain: ?*ChainedStructOut = null,
    timed_wait_any_enable: bool = false,
    timed_wait_any_max_count: usize = 0,
};

pub const Limits = extern struct {
    next_in_chain: ?*ChainedStructOut = null,
    max_texture_dimension1d: u32 = 0,
    max_texture_dimension2d: u32 = 0,
    max_texture_dimension3d: u32 = 0,
    max_texture_array_layers: u32 = 0,
    max_bind_groups: u32 = 0,
    max_bind_groups_plus_vertex_buffers: u32 = 0,
    max_bindings_per_bind_group: u32 = 0,
    max_dynamic_uniform_buffers_per_pipeline_layout: u32 = 0,
    max_dynamic_storage_buffers_per_pipeline_layout: u32 = 0,
    max_sampled_textures_per_shader_stage: u32 = 0,
    max_samplers_per_shader_stage: u32 = 0,
    max_storage_buffers_per_shader_stage: u32 = 0,
    max_storage_textures_per_shader_stage: u32 = 0,
    max_uniform_buffers_per_shader_stage: u32 = 0,
    max_uniform_buffer_binding_size: u64 = 0,
    max_storage_buffer_binding_size: u64 = 0,
    min_uniform_buffer_offset_alignment: u32 = 0,
    min_storage_buffer_offset_alignment: u32 = 0,
    max_vertex_buffers: u32 = 0,
    max_buffer_size: u64 = 0,
    max_vertex_attributes: u32 = 0,
    max_vertex_buffer_array_stride: u32 = 0,
    max_inter_stage_shader_variables: u32 = 0,
    max_color_attachments: u32 = 0,
    max_color_attachment_bytes_per_sample: u32 = 0,
    max_compute_workgroup_storage_size: u32 = 0,
    max_compute_invocations_per_workgroup: u32 = 0,
    max_compute_workgroup_size_x: u32 = 0,
    max_compute_workgroup_size_y: u32 = 0,
    max_compute_workgroup_size_z: u32 = 0,
    max_compute_workgroups_per_dimension: u32 = 0,
};

pub const MultisampleState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    count: u32 = 0,
    mask: u32 = 0,
    alpha_to_coverage_enabled: bool = false,
};

pub const Origin3D = extern struct {
    x: u32 = 0,
    y: u32 = 0,
    z: u32 = 0,
};

pub const PipelineLayoutDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    bind_group_layout_count: usize = 0,
    bind_group_layouts: ?*const c.WGPUBindGroupLayout = null,
};

pub const PrimitiveState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    topology: PrimitiveTopology = .{},
    strip_index_format: IndexFormat = .{},
    front_face: FrontFace = .{},
    cull_mode: CullMode = .{},
    unclipped_depth: bool = false,
};

pub const QuerySetDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    type: QueryType = .{},
    count: u32 = 0,
};

pub const QueueDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
};

pub const RenderBundleDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
};

pub const RenderBundleEncoderDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    color_format_count: usize = 0,
    color_formats: ?*const TextureFormat = null,
    depth_stencil_format: TextureFormat = .{},
    sample_count: u32 = 0,
    depth_read_only: bool = false,
    stencil_read_only: bool = false,
};

pub const RenderPassDepthStencilAttachment = extern struct {
    view: c.WGPUTextureView = null,
    depth_load_op: LoadOp = .{},
    depth_store_op: StoreOp = .{},
    depth_clear_value: f32 = 0,
    depth_read_only: bool = false,
    stencil_load_op: LoadOp = .{},
    stencil_store_op: StoreOp = .{},
    stencil_clear_value: u32 = 0,
    stencil_read_only: bool = false,
};

pub const RenderPassMaxDrawCount = extern struct {
    chain: ChainedStruct = .{},
    max_draw_count: u64 = 0,
};

pub const RenderPassTimestampWrites = extern struct {
    query_set: c.WGPUQuerySet = null,
    beginning_of_pass_write_index: u32 = 0,
    end_of_pass_write_index: u32 = 0,
};

pub const RequestAdapterOptions = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    feature_level: FeatureLevel = .{},
    power_preference: PowerPreference = .{},
    force_fallback_adapter: bool = false,
    backend_type: BackendType = .{},
    compatible_surface: c.WGPUSurface = null,
};

pub const SamplerBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    type: SamplerBindingType = .{},
};

pub const SamplerDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    address_mode_u: AddressMode = .{},
    address_mode_v: AddressMode = .{},
    address_mode_w: AddressMode = .{},
    mag_filter: FilterMode = .{},
    min_filter: FilterMode = .{},
    mipmap_filter: MipmapFilterMode = .{},
    lod_min_clamp: f32 = 0,
    lod_max_clamp: f32 = 0,
    compare: CompareFunction = .{},
    max_anisotropy: u16 = 0,
};

pub const ShaderModuleDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
};

pub const ShaderSourceSPIRV = extern struct {
    chain: ChainedStruct = .{},
    code_size: u32 = 0,
    code: ?*const u32 = null,
};

pub const ShaderSourceWGSL = extern struct {
    chain: ChainedStruct = .{},
    code: [:0]const u8 = "",
};

pub const StencilFaceState = extern struct {
    compare: CompareFunction = .{},
    fail_op: StencilOperation = .{},
    depth_fail_op: StencilOperation = .{},
    pass_op: StencilOperation = .{},
};

pub const StorageTextureBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    access: StorageTextureAccess = .{},
    format: TextureFormat = .{},
    view_dimension: TextureViewDimension = .{},
};

pub const SupportedFeatures = extern struct {
    feature_count: usize = 0,
    features: ?*const FeatureName = null,
};

pub const SupportedWGSLLanguageFeatures = extern struct {
    feature_count: usize = 0,
    features: ?*const WGSLLanguageFeatureName = null,
};

pub const SurfaceCapabilities = extern struct {
    next_in_chain: ?*ChainedStructOut = null,
    usages: TextureUsage = 0,
    format_count: usize = 0,
    formats: ?*const TextureFormat = null,
    present_mode_count: usize = 0,
    present_modes: ?*const PresentMode = null,
    alpha_mode_count: usize = 0,
    alpha_modes: ?*const CompositeAlphaMode = null,
};

pub const SurfaceConfiguration = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    device: c.WGPUDevice = null,
    format: TextureFormat = .{},
    usage: TextureUsage = 0,
    width: u32 = 0,
    height: u32 = 0,
    view_format_count: usize = 0,
    view_formats: ?*const TextureFormat = null,
    alpha_mode: CompositeAlphaMode = .{},
    present_mode: PresentMode = .{},
};

pub const SurfaceDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
};

pub const SurfaceSourceAndroidNativeWindow = extern struct {
    chain: ChainedStruct = .{},
    window: ?*anyopaque = null,
};

pub const SurfaceSourceMetalLayer = extern struct {
    chain: ChainedStruct = .{},
    layer: ?*anyopaque = null,
};

pub const SurfaceSourceWaylandSurface = extern struct {
    chain: ChainedStruct = .{},
    display: ?*anyopaque = null,
    surface: ?*anyopaque = null,
};

pub const SurfaceSourceWindowsHWND = extern struct {
    chain: ChainedStruct = .{},
    hinstance: ?*anyopaque = null,
    hwnd: ?*anyopaque = null,
};

pub const SurfaceSourceXCBWindow = extern struct {
    chain: ChainedStruct = .{},
    connection: ?*anyopaque = null,
    window: u32 = 0,
};

pub const SurfaceSourceXlibWindow = extern struct {
    chain: ChainedStruct = .{},
    display: ?*anyopaque = null,
    window: u64 = 0,
};

pub const SurfaceTexture = extern struct {
    next_in_chain: ?*ChainedStructOut = null,
    texture: c.WGPUTexture = null,
    status: SurfaceGetCurrentTextureStatus = .{},
};

pub const TexelCopyBufferLayout = extern struct {
    offset: u64 = 0,
    bytes_per_row: u32 = 0,
    rows_per_image: u32 = 0,
};

pub const TextureBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    sample_type: TextureSampleType = .{},
    view_dimension: TextureViewDimension = .{},
    multisampled: bool = false,
};

pub const TextureViewDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    format: TextureFormat = .{},
    dimension: TextureViewDimension = .{},
    base_mip_level: u32 = 0,
    mip_level_count: u32 = 0,
    base_array_layer: u32 = 0,
    array_layer_count: u32 = 0,
    aspect: TextureAspect = .{},
    usage: TextureUsage = 0,
};

pub const VertexAttribute = extern struct {
    format: VertexFormat = .{},
    offset: u64 = 0,
    shader_location: u32 = 0,
};

pub const BindGroupDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    layout: c.WGPUBindGroupLayout = null,
    entry_count: usize = 0,
    entries: ?*const BindGroupEntry = null,
};

pub const BindGroupLayoutEntry = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    binding: u32 = 0,
    visibility: ShaderStage = 0,
    buffer: BufferBindingLayout = .{},
    sampler: SamplerBindingLayout = .{},
    texture: TextureBindingLayout = .{},
    storage_texture: StorageTextureBindingLayout = .{},
};

pub const BlendState = extern struct {
    color: BlendComponent = .{},
    alpha: BlendComponent = .{},
};

pub const CompilationInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    message_count: usize = 0,
    messages: ?*const CompilationMessage = null,
};

pub const ComputePassDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    timestamp_writes: ?*const ComputePassTimestampWrites = null,
};

pub const DepthStencilState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    format: TextureFormat = .{},
    depth_write_enabled: OptionalBool = .{},
    depth_compare: CompareFunction = .{},
    stencil_front: StencilFaceState = .{},
    stencil_back: StencilFaceState = .{},
    stencil_read_mask: u32 = 0,
    stencil_write_mask: u32 = 0,
    depth_bias: i32 = 0,
    depth_bias_slope_scale: f32 = 0,
    depth_bias_clamp: f32 = 0,
};

pub const DeviceLostCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .{},
    callback: c.WGPUDeviceLostCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const UncapturedErrorCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    callback: c.WGPUUncapturedErrorCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const DeviceDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    required_feature_count: usize = 0,
    required_features: ?*const FeatureName = null,
    required_limits: ?*const Limits = null,
    default_queue: QueueDescriptor = .{},
    device_lost_callback_info: c.WGPUDeviceLostCallbackInfo = .{},
    uncaptured_error_callback_info: c.WGPUUncapturedErrorCallbackInfo = .{},
};

pub const FutureWaitInfo = extern struct {
    future: Future = .{},
    completed: bool = false,
};

pub const InstanceDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    features: InstanceCapabilities = .{},
};

pub const ProgrammableStageDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    module: c.WGPUShaderModule = null,
    entry_point: [:0]const u8 = "",
    constant_count: usize = 0,
    constants: ?*const ConstantEntry = null,
};

pub const RenderPassColorAttachment = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    view: c.WGPUTextureView = null,
    depth_slice: u32 = 0,
    resolve_target: c.WGPUTextureView = null,
    load_op: LoadOp = .{},
    store_op: StoreOp = .{},
    clear_value: Color = .{},
};

pub const TexelCopyBufferInfo = extern struct {
    layout: TexelCopyBufferLayout = .{},
    buffer: c.WGPUBuffer = null,
};

pub const TexelCopyTextureInfo = extern struct {
    texture: c.WGPUTexture = null,
    mip_level: u32 = 0,
    origin: Origin3D = .{},
    aspect: TextureAspect = .{},
};

pub const TextureDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    usage: TextureUsage = 0,
    dimension: TextureDimension = .{},
    size: Extent3D = .{},
    format: TextureFormat = .{},
    mip_level_count: u32 = 0,
    sample_count: u32 = 0,
    view_format_count: usize = 0,
    view_formats: ?*const TextureFormat = null,
};

pub const VertexBufferLayout = extern struct {
    step_mode: VertexStepMode = .{},
    array_stride: u64 = 0,
    attribute_count: usize = 0,
    attributes: ?*const VertexAttribute = null,
};

pub const BindGroupLayoutDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    entry_count: usize = 0,
    entries: ?*const BindGroupLayoutEntry = null,
};

pub const ColorTargetState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    format: TextureFormat = .{},
    blend: ?*const BlendState = null,
    write_mask: ColorWriteMask = 0,
};

pub const ComputePipelineDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    layout: c.WGPUPipelineLayout = null,
    compute: ProgrammableStageDescriptor = .{},
};

pub const RenderPassDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    color_attachment_count: usize = 0,
    color_attachments: ?*const RenderPassColorAttachment = null,
    depth_stencil_attachment: ?*const RenderPassDepthStencilAttachment = null,
    occlusion_query_set: c.WGPUQuerySet = null,
    timestamp_writes: ?*const RenderPassTimestampWrites = null,
};

pub const VertexState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    module: c.WGPUShaderModule = null,
    entry_point: [:0]const u8 = "",
    constant_count: usize = 0,
    constants: ?*const ConstantEntry = null,
    buffer_count: usize = 0,
    buffers: ?*const VertexBufferLayout = null,
};

pub const FragmentState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    module: c.WGPUShaderModule = null,
    entry_point: [:0]const u8 = "",
    constant_count: usize = 0,
    constants: ?*const ConstantEntry = null,
    target_count: usize = 0,
    targets: ?*const ColorTargetState = null,
};

pub const RenderPipelineDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: [:0]const u8 = "",
    layout: c.WGPUPipelineLayout = null,
    vertex: VertexState = .{},
    primitive: PrimitiveState = .{},
    depth_stencil: ?*const DepthStencilState = null,
    multisample: MultisampleState = .{},
    fragment: ?*const FragmentState = null,
};

pub const BufferMapCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .{},
    callback: c.WGPUBufferMapCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CompilationInfoCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .{},
    callback: c.WGPUCompilationInfoCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CreateComputePipelineAsyncCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .{},
    callback: c.WGPUCreateComputePipelineAsyncCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CreateRenderPipelineAsyncCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .{},
    callback: c.WGPUCreateRenderPipelineAsyncCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const PopErrorScopeCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .{},
    callback: c.WGPUPopErrorScopeCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const QueueWorkDoneCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .{},
    callback: c.WGPUQueueWorkDoneCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const RequestAdapterCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .{},
    callback: c.WGPURequestAdapterCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const RequestDeviceCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .{},
    callback: c.WGPURequestDeviceCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const XlibDisplayHandle = extern struct {
    display: ?*anyopaque = null,
    screen: c_int = 0,
};

pub const XcbDisplayHandle = extern struct {
    connection: ?*anyopaque = null,
    screen: c_int = 0,
};

pub const WaylandDisplayHandle = extern struct {
    display: ?*anyopaque = null,
};

pub const unnamed_1 = extern union {
    xlib: XlibDisplayHandle,
    xcb: XcbDisplayHandle,
    wayland: WaylandDisplayHandle,
};

pub const NativeDisplayHandle = extern struct {
    type: NativeDisplayHandleType = .{},
    data: unnamed_1 = .{},
};

pub const InstanceExtras = extern struct {
    chain: ChainedStruct = .{},
    backends: InstanceBackend = 0,
    flags: InstanceFlag = 0,
    dx12_shader_compiler: Dx12Compiler = .{},
    gles3_minor_version: Gles3MinorVersion = .{},
    gl_fence_behaviour: GLFenceBehaviour = .{},
    dxc_path: [:0]const u8 = "",
    dxc_max_shader_model: DxcMaxShaderModel = .{},
    dx12_presentation_system: Dx12SwapchainKind = .{},
    budget_for_device_creation: ?*const u8 = null,
    budget_for_device_loss: ?*const u8 = null,
    display_handle: NativeDisplayHandle = .{},
};

pub const DeviceExtras = extern struct {
    chain: ChainedStruct = .{},
    trace_path: [:0]const u8 = "",
};

pub const NativeLimits = extern struct {
    chain: ChainedStruct = .{},
    max_non_sampler_bindings: u32 = 0,
    max_binding_array_elements_per_shader_stage: u32 = 0,
    max_binding_array_sampler_elements_per_shader_stage: u32 = 0,
    max_multiview_view_count: u32 = 0,
};

pub const PipelineLayoutExtras = extern struct {
    chain: ChainedStruct = .{},
    immediate_data_size: u32 = 0,
};

pub const ShaderDefine = extern struct {
    name: [:0]const u8 = "",
    value: [:0]const u8 = "",
};

pub const ShaderSourceGLSL = extern struct {
    chain: ChainedStruct = .{},
    stage: ShaderStage = 0,
    code: [:0]const u8 = "",
    define_count: u32 = 0,
    defines: ?*const ShaderDefine = null,
};

pub const ShaderModuleDescriptorSpirV = extern struct {
    label: [:0]const u8 = "",
    source_size: u32 = 0,
    source: ?*const u32 = null,
};

pub const RegistryReport = extern struct {
    num_allocated: usize = 0,
    num_kept_from_user: usize = 0,
    num_released_from_user: usize = 0,
    element_size: usize = 0,
};

pub const HubReport = extern struct {
    adapters: RegistryReport = .{},
    devices: RegistryReport = .{},
    queues: RegistryReport = .{},
    pipeline_layouts: RegistryReport = .{},
    shader_modules: RegistryReport = .{},
    bind_group_layouts: RegistryReport = .{},
    bind_groups: RegistryReport = .{},
    command_buffers: RegistryReport = .{},
    render_bundles: RegistryReport = .{},
    render_pipelines: RegistryReport = .{},
    compute_pipelines: RegistryReport = .{},
    pipeline_caches: RegistryReport = .{},
    query_sets: RegistryReport = .{},
    buffers: RegistryReport = .{},
    textures: RegistryReport = .{},
    texture_views: RegistryReport = .{},
    samplers: RegistryReport = .{},
};

pub const GlobalReport = extern struct {
    surfaces: RegistryReport = .{},
    hub: HubReport = .{},
};

pub const InstanceEnumerateAdapterOptions = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    backends: InstanceBackend = 0,
};

pub const BindGroupEntryExtras = extern struct {
    chain: ChainedStruct = .{},
    buffers: ?*const c.WGPUBuffer = null,
    buffer_count: usize = 0,
    samplers: ?*const c.WGPUSampler = null,
    sampler_count: usize = 0,
    texture_views: ?*const c.WGPUTextureView = null,
    texture_view_count: usize = 0,
};

pub const BindGroupLayoutEntryExtras = extern struct {
    chain: ChainedStruct = .{},
    count: u32 = 0,
};

pub const QuerySetDescriptorExtras = extern struct {
    chain: ChainedStruct = .{},
    pipeline_statistics: ?*const PipelineStatisticName = null,
    pipeline_statistic_count: usize = 0,
};

pub const SurfaceConfigurationExtras = extern struct {
    chain: ChainedStruct = .{},
    desired_maximum_frame_latency: u32 = 0,
};

pub const SurfaceSourceSwapChainPanel = extern struct {
    chain: ChainedStruct = .{},
    panel_native: ?*anyopaque = null,
};

pub const PrimitiveStateExtras = extern struct {
    chain: ChainedStruct = .{},
    polygon_mode: PolygonMode = .{},
    conservative: bool = false,
};

pub const ImageSubresourceRange = extern struct {
    aspect: TextureAspect = .{},
    base_mip_level: u32 = 0,
    mip_level_count: u32 = 0,
    base_array_layer: u32 = 0,
    array_layer_count: u32 = 0,
};

