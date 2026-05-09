const c = @import("c_wgpu_native");
const std = @import("std");
const types = @This();

pub const MapAsyncStatus = enum(c_uint) {
    success = 1,
    callback_cancelled = 2,
    @"error" = 3,
    aborted = 4,
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
    callback_cancelled = 2,
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
    uniform_buffer_standard_layout = 5,
    subgroup_id = 6,
    texture_and_sampler_let = 7,
    subgroup_uniformity = 8,
    texture_formats_tier1 = 9,
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
    callback_cancelled = 2,
    @"error" = 3,
};

pub const RequestDeviceStatus = enum(c_uint) {
    success = 1,
    callback_cancelled = 2,
    @"error" = 3,
};

pub const VertexStepMode = enum(c_uint) {
    @"undefined" = 0,
    vertex = 1,
    instance = 2,
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
    r16_unorm = 5,
    r16_snorm = 6,
    r16_uint = 7,
    r16_sint = 8,
    r16_float = 9,
    rg8_unorm = 10,
    rg8_snorm = 11,
    rg8_uint = 12,
    rg8_sint = 13,
    r32_float = 14,
    r32_uint = 15,
    r32_sint = 16,
    rg16_unorm = 17,
    rg16_snorm = 18,
    rg16_uint = 19,
    rg16_sint = 20,
    rg16_float = 21,
    rgba8_unorm = 22,
    rgba8_unorm_srgb = 23,
    rgba8_snorm = 24,
    rgba8_uint = 25,
    rgba8_sint = 26,
    bgra8_unorm = 27,
    bgra8_unorm_srgb = 28,
    rgb10a2_uint = 29,
    rgb10a2_unorm = 30,
    rg11b10_ufloat = 31,
    rgb9e5_ufloat = 32,
    rg32_float = 33,
    rg32_uint = 34,
    rg32_sint = 35,
    rgba16_unorm = 36,
    rgba16_snorm = 37,
    rgba16_uint = 38,
    rgba16_sint = 39,
    rgba16_float = 40,
    rgba32_float = 41,
    rgba32_uint = 42,
    rgba32_sint = 43,
    stencil8 = 44,
    depth16_unorm = 45,
    depth24_plus = 46,
    depth24_plus_stencil8 = 47,
    depth32_float = 48,
    depth32_float_stencil8 = 49,
    bc1rgba_unorm = 50,
    bc1rgba_unorm_srgb = 51,
    bc2rgba_unorm = 52,
    bc2rgba_unorm_srgb = 53,
    bc3rgba_unorm = 54,
    bc3rgba_unorm_srgb = 55,
    bc4r_unorm = 56,
    bc4r_snorm = 57,
    bc5rg_unorm = 58,
    bc5rg_snorm = 59,
    bc6hrgb_ufloat = 60,
    bc6hrgb_float = 61,
    bc7rgba_unorm = 62,
    bc7rgba_unorm_srgb = 63,
    etc2rgb8_unorm = 64,
    etc2rgb8_unorm_srgb = 65,
    etc2rgb8a1_unorm = 66,
    etc2rgb8a1_unorm_srgb = 67,
    etc2rgba8_unorm = 68,
    etc2rgba8_unorm_srgb = 69,
    eacr11_unorm = 70,
    eacr11_snorm = 71,
    eacrg11_unorm = 72,
    eacrg11_snorm = 73,
    astc4x4_unorm = 74,
    astc4x4_unorm_srgb = 75,
    astc5x4_unorm = 76,
    astc5x4_unorm_srgb = 77,
    astc5x5_unorm = 78,
    astc5x5_unorm_srgb = 79,
    astc6x5_unorm = 80,
    astc6x5_unorm_srgb = 81,
    astc6x6_unorm = 82,
    astc6x6_unorm_srgb = 83,
    astc8x5_unorm = 84,
    astc8x5_unorm_srgb = 85,
    astc8x6_unorm = 86,
    astc8x6_unorm_srgb = 87,
    astc8x8_unorm = 88,
    astc8x8_unorm_srgb = 89,
    astc10x5_unorm = 90,
    astc10x5_unorm_srgb = 91,
    astc10x6_unorm = 92,
    astc10x6_unorm_srgb = 93,
    astc10x8_unorm = 94,
    astc10x8_unorm_srgb = 95,
    astc10x10_unorm = 96,
    astc10x10_unorm_srgb = 97,
    astc12x10_unorm = 98,
    astc12x10_unorm_srgb = 99,
    astc12x12_unorm = 100,
    astc12x12_unorm_srgb = 101,
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
    callback_cancelled = 2,
    @"error" = 3,
};

pub const TextureDimension = enum(c_uint) {
    @"undefined" = 0,
    _1d = 1,
    _2d = 2,
    _3d = 3,
};

pub const DeviceLostReason = enum(c_uint) {
    unknown = 1,
    destroyed = 2,
    callback_cancelled = 3,
    failed_creation = 4,
};

pub const InstanceFeatureName = enum(c_uint) {
    timed_wait_any = 1,
    shader_source_spirv = 2,
    multiple_devices_per_adapter = 3,
};

pub const ToneMappingMode = enum(c_uint) {
    standard = 1,
    extended = 2,
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
    @"error" = 6,
    occluded = 196609,
};

pub const WaitStatus = enum(c_uint) {
    success = 1,
    timed_out = 2,
    @"error" = 3,
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

pub const PredefinedColorSpace = enum(c_uint) {
    srgb = 1,
    display_p3 = 2,
};

pub const ComponentSwizzle = enum(c_uint) {
    @"undefined" = 0,
    zero = 1,
    one = 2,
    r = 3,
    g = 4,
    b = 5,
    a = 6,
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
    surface_color_management = 10,
    request_adapter_web_xr_options = 11,
    texture_component_swizzle_descriptor = 12,
    external_texture_binding_layout = 13,
    external_texture_binding_entry = 14,
    compatibility_mode_limits = 15,
    texture_binding_view_dimension = 16,
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
    callback_cancelled = 2,
    unavailable = 3,
    @"error" = 4,
};

pub const LoadOp = enum(c_uint) {
    @"undefined" = 0,
    load = 1,
    clear = 2,
};

pub const CreatePipelineAsyncStatus = enum(c_uint) {
    success = 1,
    callback_cancelled = 2,
    validation_error = 3,
    internal_error = 4,
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
    core_features_and_limits = 1,
    depth_clip_control = 2,
    depth32_float_stencil8 = 3,
    texture_compression_bc = 4,
    texture_compression_bc_sliced3d = 5,
    texture_compression_etc2 = 6,
    texture_compression_astc = 7,
    texture_compression_astc_sliced3d = 8,
    timestamp_query = 9,
    indirect_first_instance = 10,
    shader_f16 = 11,
    rg11b10_ufloat_renderable = 12,
    bgra8_unorm_storage = 13,
    float32_filterable = 14,
    float32_blendable = 15,
    clip_distances = 16,
    dual_source_blending = 17,
    subgroups = 18,
    texture_formats_tier1 = 19,
    texture_formats_tier2 = 20,
    primitive_index = 21,
    texture_component_swizzle = 22,
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

pub const FeatureLevel = enum(c_uint) {
    @"undefined" = 0,
    compatibility = 1,
    core = 2,
};

pub const FrontFace = enum(c_uint) {
    @"undefined" = 0,
    ccw = 1,
    cw = 2,
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
    green: bool = false,
    blue: bool = false,
    alpha: bool = false,
    __: u60 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u64)); }
};

pub const ShaderStage = packed struct(u64) {
    vertex: bool = false,
    fragment: bool = false,
    compute: bool = false,
    __: u61 = 0,
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
    __: u54 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u64)); }
};

pub const TextureUsage = packed struct(u64) {
    copy_src: bool = false,
    copy_dst: bool = false,
    texture_binding: bool = false,
    storage_binding: bool = false,
    render_attachment: bool = false,
    transient_attachment: bool = false,
    __: u58 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u64)); }
};

pub const MapMode = packed struct(u64) {
    read: bool = false,
    write: bool = false,
    __: u62 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u64)); }
};

pub const InstanceBackend = packed struct(u32) {
    vulkan: bool = false,
    gl: bool = false,
    metal: bool = false,
    dx12: bool = false,
    _: u1 = 0,
    browser_web_gpu: bool = false,
    __: u26 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u32)); }
};

pub const InstanceBackend_primary: InstanceBackend = @bitCast(@as(c_long, (((@as(c_int, 1) << @intCast(@as(c_int, 0))) | (@as(c_int, 1) << @intCast(@as(c_int, 2)))) | (@as(c_int, 1) << @intCast(@as(c_int, 3)))) | (@as(c_int, 1) << @intCast(@as(c_int, 5)))));

pub const InstanceFlag = packed struct(u32) {
    debug: bool = false,
    validation: bool = false,
    discard_hal_labels: bool = false,
    allow_underlying_noncompliant_adapter: bool = false,
    gpu_based_validation: bool = false,
    validation_indirect_call: bool = false,
    automatic_timestamp_normalization: bool = false,
    _: u17 = 0,
    default: bool = false,
    debugging: bool = false,
    advanced_debugging: bool = false,
    with_env: bool = false,
    __: u4 = 0,
    comptime { std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf(u32)); }
};

pub const StringView = extern struct {
    data: ?*const u8 = null,
    length: usize = 0,

    pub fn toSlice(sv: StringView) [:0]const u8 {
        const ptr: [*]const u8 = @ptrCast(sv.data orelse return "");
        return ptr[0..sv.length :0];
    }

    pub fn fromSlice(slice: [:0]const u8) StringView {
        return .{ .data = @ptrCast(slice.ptr), .length = slice.len };
    }
};

pub const ChainedStruct = extern struct {
    next: ?*ChainedStruct = null,
    s_type: SType = undefined,
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
pub const AdapterInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    vendor: StringView = undefined,
    architecture: StringView = undefined,
    device: StringView = undefined,
    description: StringView = undefined,
    backend_type: BackendType = .@"undefined",
    adapter_type: AdapterType = undefined,
    vendor_id: u32 = 0,
    device_id: u32 = 0,
    subgroup_min_size: u32 = 0,
    subgroup_max_size: u32 = 0,
};

pub const BlendComponent = extern struct {
    operation: BlendOperation = .@"undefined",
    src_factor: BlendFactor = .@"undefined",
    dst_factor: BlendFactor = .@"undefined",
};

pub const BufferBindingLayout = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    type: BufferBindingType = .binding_not_used,
    has_dynamic_offset: bool = false,
    min_binding_size: u64 = 0,
};

pub const BufferDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
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
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
};

pub const CommandEncoderDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
};

pub const CompatibilityModeLimits = extern struct {
    chain: ChainedStruct = undefined,
    max_storage_buffers_in_vertex_stage: u32 = 0,
    max_storage_textures_in_vertex_stage: u32 = 0,
    max_storage_buffers_in_fragment_stage: u32 = 0,
    max_storage_textures_in_fragment_stage: u32 = 0,
};

pub const CompilationMessage = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    message: StringView = undefined,
    type: CompilationMessageType = undefined,
    line_num: u64 = 0,
    line_pos: u64 = 0,
    offset: u64 = 0,
    length: u64 = 0,
};

pub const ConstantEntry = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    key: StringView = undefined,
    value: f64 = 0,
};

pub const Extent3D = extern struct {
    width: u32 = 0,
    height: u32 = 0,
    depth_or_array_layers: u32 = 0,
};

pub const ExternalTextureBindingEntry = extern struct {
    chain: ChainedStruct = undefined,
    external_texture: c.WGPUExternalTexture = null,
};

pub const ExternalTextureBindingLayout = extern struct {
    chain: ChainedStruct = undefined,
};

pub const Future = extern struct {
    id: u64 = 0,
};

pub const InstanceLimits = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    timed_wait_any_max_count: usize = 0,
};

pub const MultisampleState = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    count: u32 = 0,
    mask: u32 = 0,
    alpha_to_coverage_enabled: bool = false,
};

pub const Origin3D = extern struct {
    x: u32 = 0,
    y: u32 = 0,
    z: u32 = 0,
};

pub const PassTimestampWrites = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    query_set: c.WGPUQuerySet = null,
    beginning_of_pass_write_index: u32 = 0,
    end_of_pass_write_index: u32 = 0,
};

pub const PipelineLayoutDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    bind_group_layout_count: usize = 0,
    bind_group_layouts: ?*const c.WGPUBindGroupLayout = null,
    immediate_size: u32 = 0,
};

pub const PrimitiveState = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    topology: PrimitiveTopology = .@"undefined",
    strip_index_format: IndexFormat = .@"undefined",
    front_face: FrontFace = .@"undefined",
    cull_mode: CullMode = .@"undefined",
    unclipped_depth: bool = false,
};

pub const QuerySetDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    type: QueryType = undefined,
    count: u32 = 0,
};

pub const QueueDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
};

pub const RenderBundleDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
};

pub const RenderBundleEncoderDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    color_format_count: usize = 0,
    color_formats: ?*const TextureFormat = null,
    depth_stencil_format: TextureFormat = .@"undefined",
    sample_count: u32 = 0,
    depth_read_only: bool = false,
    stencil_read_only: bool = false,
};

pub const RenderPassDepthStencilAttachment = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    view: c.WGPUTextureView = null,
    depth_load_op: LoadOp = .@"undefined",
    depth_store_op: StoreOp = .@"undefined",
    depth_clear_value: f32 = 0,
    depth_read_only: bool = false,
    stencil_load_op: LoadOp = .@"undefined",
    stencil_store_op: StoreOp = .@"undefined",
    stencil_clear_value: u32 = 0,
    stencil_read_only: bool = false,
};

pub const RenderPassMaxDrawCount = extern struct {
    chain: ChainedStruct = undefined,
    max_draw_count: u64 = 0,
};

pub const RequestAdapterWebXROptions = extern struct {
    chain: ChainedStruct = undefined,
    xr_compatible: bool = false,
};

pub const SamplerBindingLayout = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    type: SamplerBindingType = .binding_not_used,
};

pub const SamplerDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    address_mode_u: AddressMode = .@"undefined",
    address_mode_v: AddressMode = .@"undefined",
    address_mode_w: AddressMode = .@"undefined",
    mag_filter: FilterMode = .@"undefined",
    min_filter: FilterMode = .@"undefined",
    mipmap_filter: MipmapFilterMode = .@"undefined",
    lod_min_clamp: f32 = 0,
    lod_max_clamp: f32 = 0,
    compare: CompareFunction = .@"undefined",
    max_anisotropy: u16 = 0,
};

pub const ShaderSourceSPIRV = extern struct {
    chain: ChainedStruct = undefined,
    code_size: u32 = 0,
    code: ?*const u32 = null,
};

pub const ShaderSourceWGSL = extern struct {
    chain: ChainedStruct = undefined,
    code: StringView = undefined,
};

pub const StencilFaceState = extern struct {
    compare: CompareFunction = .@"undefined",
    fail_op: StencilOperation = .@"undefined",
    depth_fail_op: StencilOperation = .@"undefined",
    pass_op: StencilOperation = .@"undefined",
};

pub const StorageTextureBindingLayout = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    access: StorageTextureAccess = .binding_not_used,
    format: TextureFormat = .@"undefined",
    view_dimension: TextureViewDimension = .@"undefined",
};

pub const SupportedFeatures = extern struct {
    feature_count: usize = 0,
    features: ?*const FeatureName = null,
};

pub const SupportedInstanceFeatures = extern struct {
    feature_count: usize = 0,
    features: ?*const InstanceFeatureName = null,
};

pub const SupportedWGSLLanguageFeatures = extern struct {
    feature_count: usize = 0,
    features: ?*const WGSLLanguageFeatureName = null,
};

pub const SurfaceCapabilities = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    usages: TextureUsage = 0,
    format_count: usize = 0,
    formats: ?*const TextureFormat = null,
    present_mode_count: usize = 0,
    present_modes: ?*const PresentMode = null,
    alpha_mode_count: usize = 0,
    alpha_modes: ?*const CompositeAlphaMode = null,
};

pub const SurfaceColorManagement = extern struct {
    chain: ChainedStruct = undefined,
    color_space: PredefinedColorSpace = undefined,
    tone_mapping_mode: ToneMappingMode = undefined,
};

pub const SurfaceConfiguration = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    device: c.WGPUDevice = null,
    format: TextureFormat = .@"undefined",
    usage: TextureUsage = 0,
    width: u32 = 0,
    height: u32 = 0,
    view_format_count: usize = 0,
    view_formats: ?*const TextureFormat = null,
    alpha_mode: CompositeAlphaMode = .auto,
    present_mode: PresentMode = .@"undefined",
};

pub const SurfaceSourceAndroidNativeWindow = extern struct {
    chain: ChainedStruct = undefined,
    window: ?*anyopaque = null,
};

pub const SurfaceSourceMetalLayer = extern struct {
    chain: ChainedStruct = undefined,
    layer: ?*anyopaque = null,
};

pub const SurfaceSourceWaylandSurface = extern struct {
    chain: ChainedStruct = undefined,
    display: ?*anyopaque = null,
    surface: ?*anyopaque = null,
};

pub const SurfaceSourceWindowsHWND = extern struct {
    chain: ChainedStruct = undefined,
    hinstance: ?*anyopaque = null,
    hwnd: ?*anyopaque = null,
};

pub const SurfaceSourceXCBWindow = extern struct {
    chain: ChainedStruct = undefined,
    connection: ?*anyopaque = null,
    window: u32 = 0,
};

pub const SurfaceSourceXlibWindow = extern struct {
    chain: ChainedStruct = undefined,
    display: ?*anyopaque = null,
    window: u64 = 0,
};

pub const SurfaceTexture = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    texture: c.WGPUTexture = null,
    status: SurfaceGetCurrentTextureStatus = undefined,
};

pub const TexelCopyBufferLayout = extern struct {
    offset: u64 = 0,
    bytes_per_row: u32 = 0,
    rows_per_image: u32 = 0,
};

pub const TextureBindingLayout = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    sample_type: TextureSampleType = .binding_not_used,
    view_dimension: TextureViewDimension = .@"undefined",
    multisampled: bool = false,
};

pub const TextureBindingViewDimension = extern struct {
    chain: ChainedStruct = undefined,
    texture_binding_view_dimension: TextureViewDimension = .@"undefined",
};

pub const TextureComponentSwizzle = extern struct {
    r: ComponentSwizzle = .@"undefined",
    g: ComponentSwizzle = .@"undefined",
    b: ComponentSwizzle = .@"undefined",
    a: ComponentSwizzle = .@"undefined",
};

pub const VertexAttribute = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    format: VertexFormat = undefined,
    offset: u64 = 0,
    shader_location: u32 = 0,
};

pub const BindGroupEntry = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    binding: u32 = 0,
    buffer: c.WGPUBuffer = null,
    offset: u64 = 0,
    size: u64 = 0,
    sampler: c.WGPUSampler = null,
    texture_view: c.WGPUTextureView = null,
};

pub const BindGroupLayoutEntry = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    binding: u32 = 0,
    visibility: ShaderStage = 0,
    binding_array_size: u32 = 0,
    buffer: BufferBindingLayout = undefined,
    sampler: SamplerBindingLayout = undefined,
    texture: TextureBindingLayout = undefined,
    storage_texture: StorageTextureBindingLayout = undefined,
};

pub const BlendState = extern struct {
    color: BlendComponent = undefined,
    alpha: BlendComponent = undefined,
};

pub const CompilationInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    message_count: usize = 0,
    messages: ?*const CompilationMessage = null,
};

pub const ComputePassDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    timestamp_writes: ?*const PassTimestampWrites = null,
};

pub const ComputeState = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    module: c.WGPUShaderModule = null,
    entry_point: StringView = undefined,
    constant_count: usize = 0,
    constants: ?*const ConstantEntry = null,
};

pub const DepthStencilState = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    format: TextureFormat = .@"undefined",
    depth_write_enabled: OptionalBool = .@"false",
    depth_compare: CompareFunction = .@"undefined",
    stencil_front: StencilFaceState = undefined,
    stencil_back: StencilFaceState = undefined,
    stencil_read_mask: u32 = 0,
    stencil_write_mask: u32 = 0,
    depth_bias: i32 = 0,
    depth_bias_slope_scale: f32 = 0,
    depth_bias_clamp: f32 = 0,
};

pub const FutureWaitInfo = extern struct {
    future: Future = undefined,
    completed: bool = false,
};

pub const InstanceDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    required_feature_count: usize = 0,
    required_features: ?*const InstanceFeatureName = null,
    required_limits: ?*const InstanceLimits = null,
};

pub const Limits = extern struct {
    next_in_chain: ?*ChainedStruct = null,
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
    max_immediate_size: u32 = 0,
};

pub const RenderPassColorAttachment = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    view: c.WGPUTextureView = null,
    depth_slice: u32 = 0,
    resolve_target: c.WGPUTextureView = null,
    load_op: LoadOp = .@"undefined",
    store_op: StoreOp = .@"undefined",
    clear_value: Color = undefined,
};

pub const RequestAdapterOptions = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    feature_level: FeatureLevel = .@"undefined",
    power_preference: PowerPreference = .@"undefined",
    force_fallback_adapter: bool = false,
    backend_type: BackendType = .@"undefined",
    compatible_surface: c.WGPUSurface = null,
};

pub const ShaderModuleDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
};

pub const SurfaceDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
};

pub const TexelCopyBufferInfo = extern struct {
    layout: TexelCopyBufferLayout = undefined,
    buffer: c.WGPUBuffer = null,
};

pub const TexelCopyTextureInfo = extern struct {
    texture: c.WGPUTexture = null,
    mip_level: u32 = 0,
    origin: Origin3D = undefined,
    aspect: TextureAspect = .@"undefined",
};

pub const TextureComponentSwizzleDescriptor = extern struct {
    chain: ChainedStruct = undefined,
    swizzle: TextureComponentSwizzle = undefined,
};

pub const TextureDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    usage: TextureUsage = 0,
    dimension: TextureDimension = .@"undefined",
    size: Extent3D = undefined,
    format: TextureFormat = .@"undefined",
    mip_level_count: u32 = 0,
    sample_count: u32 = 0,
    view_format_count: usize = 0,
    view_formats: ?*const TextureFormat = null,
};

pub const VertexBufferLayout = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    step_mode: VertexStepMode = .@"undefined",
    array_stride: u64 = 0,
    attribute_count: usize = 0,
    attributes: ?*const VertexAttribute = null,
};

pub const BindGroupDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    layout: c.WGPUBindGroupLayout = null,
    entry_count: usize = 0,
    entries: ?*const BindGroupEntry = null,
};

pub const BindGroupLayoutDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    entry_count: usize = 0,
    entries: ?*const BindGroupLayoutEntry = null,
};

pub const ColorTargetState = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    format: TextureFormat = .@"undefined",
    blend: ?*const BlendState = null,
    write_mask: ColorWriteMask = 0,
};

pub const ComputePipelineDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    layout: c.WGPUPipelineLayout = null,
    compute: ComputeState = undefined,
};

pub const DeviceLostCallbackInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    mode: CallbackMode = undefined,
    callback: c.WGPUDeviceLostCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const UncapturedErrorCallbackInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    callback: c.WGPUUncapturedErrorCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const DeviceDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    required_feature_count: usize = 0,
    required_features: ?*const FeatureName = null,
    required_limits: ?*const Limits = null,
    default_queue: QueueDescriptor = undefined,
    device_lost_callback_info: c.WGPUDeviceLostCallbackInfo = undefined,
    uncaptured_error_callback_info: c.WGPUUncapturedErrorCallbackInfo = undefined,
};

pub const RenderPassDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    color_attachment_count: usize = 0,
    color_attachments: ?*const RenderPassColorAttachment = null,
    depth_stencil_attachment: ?*const RenderPassDepthStencilAttachment = null,
    occlusion_query_set: c.WGPUQuerySet = null,
    timestamp_writes: ?*const PassTimestampWrites = null,
};

pub const TextureViewDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    format: TextureFormat = .@"undefined",
    dimension: TextureViewDimension = .@"undefined",
    base_mip_level: u32 = 0,
    mip_level_count: u32 = 0,
    base_array_layer: u32 = 0,
    array_layer_count: u32 = 0,
    aspect: TextureAspect = .@"undefined",
    usage: TextureUsage = 0,
};

pub const VertexState = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    module: c.WGPUShaderModule = null,
    entry_point: StringView = undefined,
    constant_count: usize = 0,
    constants: ?*const ConstantEntry = null,
    buffer_count: usize = 0,
    buffers: ?*const VertexBufferLayout = null,
};

pub const FragmentState = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    module: c.WGPUShaderModule = null,
    entry_point: StringView = undefined,
    constant_count: usize = 0,
    constants: ?*const ConstantEntry = null,
    target_count: usize = 0,
    targets: ?*const ColorTargetState = null,
};

pub const RenderPipelineDescriptor = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    label: StringView = undefined,
    layout: c.WGPUPipelineLayout = null,
    vertex: VertexState = undefined,
    primitive: PrimitiveState = undefined,
    depth_stencil: ?*const DepthStencilState = null,
    multisample: MultisampleState = undefined,
    fragment: ?*const FragmentState = null,
};

pub const BufferMapCallbackInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    mode: CallbackMode = undefined,
    callback: c.WGPUBufferMapCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CompilationInfoCallbackInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    mode: CallbackMode = undefined,
    callback: c.WGPUCompilationInfoCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CreateComputePipelineAsyncCallbackInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    mode: CallbackMode = undefined,
    callback: c.WGPUCreateComputePipelineAsyncCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CreateRenderPipelineAsyncCallbackInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    mode: CallbackMode = undefined,
    callback: c.WGPUCreateRenderPipelineAsyncCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const PopErrorScopeCallbackInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    mode: CallbackMode = undefined,
    callback: c.WGPUPopErrorScopeCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const QueueWorkDoneCallbackInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    mode: CallbackMode = undefined,
    callback: c.WGPUQueueWorkDoneCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const RequestAdapterCallbackInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    mode: CallbackMode = undefined,
    callback: c.WGPURequestAdapterCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const RequestDeviceCallbackInfo = extern struct {
    next_in_chain: ?*ChainedStruct = null,
    mode: CallbackMode = undefined,
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

pub const unnamed_2 = extern union {
    xlib: XlibDisplayHandle,
    xcb: XcbDisplayHandle,
    wayland: WaylandDisplayHandle,
};

pub const NativeDisplayHandle = extern struct {
    type: NativeDisplayHandleType = .none,
    data: unnamed_2 = std.mem.zeroes(unnamed_2),
};

pub const InstanceExtras = extern struct {
    chain: ChainedStruct = undefined,
    backends: InstanceBackend = 0,
    flags: InstanceFlag = 0,
    dx12_shader_compiler: Dx12Compiler = .@"undefined",
    gles3_minor_version: Gles3MinorVersion = .automatic,
    gl_fence_behaviour: GLFenceBehaviour = .normal,
    dxc_path: StringView = undefined,
    dxc_max_shader_model: DxcMaxShaderModel = .v6_0,
    dx12_presentation_system: Dx12SwapchainKind = .@"undefined",
    budget_for_device_creation: ?*const u8 = null,
    budget_for_device_loss: ?*const u8 = null,
    display_handle: NativeDisplayHandle = undefined,
};

pub const DeviceExtras = extern struct {
    chain: ChainedStruct = undefined,
    trace_path: StringView = undefined,
};

pub const NativeLimits = extern struct {
    chain: ChainedStruct = undefined,
    max_non_sampler_bindings: u32 = 0,
    max_binding_array_elements_per_shader_stage: u32 = 0,
    max_binding_array_sampler_elements_per_shader_stage: u32 = 0,
    max_multiview_view_count: u32 = 0,
};

pub const PipelineLayoutExtras = extern struct {
    chain: ChainedStruct = undefined,
    immediate_data_size: u32 = 0,
};

pub const ShaderDefine = extern struct {
    name: StringView = undefined,
    value: StringView = undefined,
};

pub const ShaderSourceGLSL = extern struct {
    chain: ChainedStruct = undefined,
    stage: ShaderStage = 0,
    code: StringView = undefined,
    define_count: u32 = 0,
    defines: ?*const ShaderDefine = null,
};

pub const ShaderModuleDescriptorSpirV = extern struct {
    label: StringView = undefined,
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
    adapters: RegistryReport = undefined,
    devices: RegistryReport = undefined,
    queues: RegistryReport = undefined,
    pipeline_layouts: RegistryReport = undefined,
    shader_modules: RegistryReport = undefined,
    bind_group_layouts: RegistryReport = undefined,
    bind_groups: RegistryReport = undefined,
    command_buffers: RegistryReport = undefined,
    render_bundles: RegistryReport = undefined,
    render_pipelines: RegistryReport = undefined,
    compute_pipelines: RegistryReport = undefined,
    pipeline_caches: RegistryReport = undefined,
    query_sets: RegistryReport = undefined,
    buffers: RegistryReport = undefined,
    textures: RegistryReport = undefined,
    texture_views: RegistryReport = undefined,
    samplers: RegistryReport = undefined,
};

pub const GlobalReport = extern struct {
    surfaces: RegistryReport = undefined,
    hub: HubReport = undefined,
};

pub const InstanceEnumerateAdapterOptions = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    backends: InstanceBackend = 0,
};

pub const BindGroupEntryExtras = extern struct {
    chain: ChainedStruct = undefined,
    buffers: ?*const c.WGPUBuffer = null,
    buffer_count: usize = 0,
    samplers: ?*const c.WGPUSampler = null,
    sampler_count: usize = 0,
    texture_views: ?*const c.WGPUTextureView = null,
    texture_view_count: usize = 0,
};

pub const BindGroupLayoutEntryExtras = extern struct {
    chain: ChainedStruct = undefined,
    count: u32 = 0,
};

pub const QuerySetDescriptorExtras = extern struct {
    chain: ChainedStruct = undefined,
    pipeline_statistics: ?*const PipelineStatisticName = null,
    pipeline_statistic_count: usize = 0,
};

pub const SurfaceConfigurationExtras = extern struct {
    chain: ChainedStruct = undefined,
    desired_maximum_frame_latency: u32 = 0,
};

pub const SurfaceSourceSwapChainPanel = extern struct {
    chain: ChainedStruct = undefined,
    panel_native: ?*anyopaque = null,
};

pub const PrimitiveStateExtras = extern struct {
    chain: ChainedStruct = undefined,
    polygon_mode: PolygonMode = .fill,
    conservative: bool = false,
};

pub const ImageSubresourceRange = extern struct {
    aspect: TextureAspect = .@"undefined",
    base_mip_level: u32 = 0,
    mip_level_count: u32 = 0,
    base_array_layer: u32 = 0,
    array_layer_count: u32 = 0,
};

