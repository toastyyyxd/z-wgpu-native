const std = @import("std");
const c = @import("c_wgpu_native");
const types = @import("types.zig");
const handles = @import("handles.zig");

pub const LimitsWithCompatibilityModeLimits = struct {
    max_texture_dimension1d: @TypeOf((types.Limits{}).max_texture_dimension1d) = (types.Limits{}).max_texture_dimension1d,
    max_texture_dimension2d: @TypeOf((types.Limits{}).max_texture_dimension2d) = (types.Limits{}).max_texture_dimension2d,
    max_texture_dimension3d: @TypeOf((types.Limits{}).max_texture_dimension3d) = (types.Limits{}).max_texture_dimension3d,
    max_texture_array_layers: @TypeOf((types.Limits{}).max_texture_array_layers) = (types.Limits{}).max_texture_array_layers,
    max_bind_groups: @TypeOf((types.Limits{}).max_bind_groups) = (types.Limits{}).max_bind_groups,
    max_bind_groups_plus_vertex_buffers: @TypeOf((types.Limits{}).max_bind_groups_plus_vertex_buffers) = (types.Limits{}).max_bind_groups_plus_vertex_buffers,
    max_bindings_per_bind_group: @TypeOf((types.Limits{}).max_bindings_per_bind_group) = (types.Limits{}).max_bindings_per_bind_group,
    max_dynamic_uniform_buffers_per_pipeline_layout: @TypeOf((types.Limits{}).max_dynamic_uniform_buffers_per_pipeline_layout) = (types.Limits{}).max_dynamic_uniform_buffers_per_pipeline_layout,
    max_dynamic_storage_buffers_per_pipeline_layout: @TypeOf((types.Limits{}).max_dynamic_storage_buffers_per_pipeline_layout) = (types.Limits{}).max_dynamic_storage_buffers_per_pipeline_layout,
    max_sampled_textures_per_shader_stage: @TypeOf((types.Limits{}).max_sampled_textures_per_shader_stage) = (types.Limits{}).max_sampled_textures_per_shader_stage,
    max_samplers_per_shader_stage: @TypeOf((types.Limits{}).max_samplers_per_shader_stage) = (types.Limits{}).max_samplers_per_shader_stage,
    max_storage_buffers_per_shader_stage: @TypeOf((types.Limits{}).max_storage_buffers_per_shader_stage) = (types.Limits{}).max_storage_buffers_per_shader_stage,
    max_storage_textures_per_shader_stage: @TypeOf((types.Limits{}).max_storage_textures_per_shader_stage) = (types.Limits{}).max_storage_textures_per_shader_stage,
    max_uniform_buffers_per_shader_stage: @TypeOf((types.Limits{}).max_uniform_buffers_per_shader_stage) = (types.Limits{}).max_uniform_buffers_per_shader_stage,
    max_uniform_buffer_binding_size: @TypeOf((types.Limits{}).max_uniform_buffer_binding_size) = (types.Limits{}).max_uniform_buffer_binding_size,
    max_storage_buffer_binding_size: @TypeOf((types.Limits{}).max_storage_buffer_binding_size) = (types.Limits{}).max_storage_buffer_binding_size,
    min_uniform_buffer_offset_alignment: @TypeOf((types.Limits{}).min_uniform_buffer_offset_alignment) = (types.Limits{}).min_uniform_buffer_offset_alignment,
    min_storage_buffer_offset_alignment: @TypeOf((types.Limits{}).min_storage_buffer_offset_alignment) = (types.Limits{}).min_storage_buffer_offset_alignment,
    max_vertex_buffers: @TypeOf((types.Limits{}).max_vertex_buffers) = (types.Limits{}).max_vertex_buffers,
    max_buffer_size: @TypeOf((types.Limits{}).max_buffer_size) = (types.Limits{}).max_buffer_size,
    max_vertex_attributes: @TypeOf((types.Limits{}).max_vertex_attributes) = (types.Limits{}).max_vertex_attributes,
    max_vertex_buffer_array_stride: @TypeOf((types.Limits{}).max_vertex_buffer_array_stride) = (types.Limits{}).max_vertex_buffer_array_stride,
    max_inter_stage_shader_variables: @TypeOf((types.Limits{}).max_inter_stage_shader_variables) = (types.Limits{}).max_inter_stage_shader_variables,
    max_color_attachments: @TypeOf((types.Limits{}).max_color_attachments) = (types.Limits{}).max_color_attachments,
    max_color_attachment_bytes_per_sample: @TypeOf((types.Limits{}).max_color_attachment_bytes_per_sample) = (types.Limits{}).max_color_attachment_bytes_per_sample,
    max_compute_workgroup_storage_size: @TypeOf((types.Limits{}).max_compute_workgroup_storage_size) = (types.Limits{}).max_compute_workgroup_storage_size,
    max_compute_invocations_per_workgroup: @TypeOf((types.Limits{}).max_compute_invocations_per_workgroup) = (types.Limits{}).max_compute_invocations_per_workgroup,
    max_compute_workgroup_size_x: @TypeOf((types.Limits{}).max_compute_workgroup_size_x) = (types.Limits{}).max_compute_workgroup_size_x,
    max_compute_workgroup_size_y: @TypeOf((types.Limits{}).max_compute_workgroup_size_y) = (types.Limits{}).max_compute_workgroup_size_y,
    max_compute_workgroup_size_z: @TypeOf((types.Limits{}).max_compute_workgroup_size_z) = (types.Limits{}).max_compute_workgroup_size_z,
    max_compute_workgroups_per_dimension: @TypeOf((types.Limits{}).max_compute_workgroups_per_dimension) = (types.Limits{}).max_compute_workgroups_per_dimension,
    max_immediate_size: @TypeOf((types.Limits{}).max_immediate_size) = (types.Limits{}).max_immediate_size,
    max_storage_buffers_in_vertex_stage: @TypeOf((types.CompatibilityModeLimits{}).max_storage_buffers_in_vertex_stage) = (types.CompatibilityModeLimits{}).max_storage_buffers_in_vertex_stage,
    max_storage_textures_in_vertex_stage: @TypeOf((types.CompatibilityModeLimits{}).max_storage_textures_in_vertex_stage) = (types.CompatibilityModeLimits{}).max_storage_textures_in_vertex_stage,
    max_storage_buffers_in_fragment_stage: @TypeOf((types.CompatibilityModeLimits{}).max_storage_buffers_in_fragment_stage) = (types.CompatibilityModeLimits{}).max_storage_buffers_in_fragment_stage,
    max_storage_textures_in_fragment_stage: @TypeOf((types.CompatibilityModeLimits{}).max_storage_textures_in_fragment_stage) = (types.CompatibilityModeLimits{}).max_storage_textures_in_fragment_stage,
    _chain: types.CompatibilityModeLimits = undefined,
    _desc: types.Limits = undefined,

    pub fn descriptor(self: *@This()) *const types.Limits {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_CompatibilityModeLimits) }, .max_storage_buffers_in_vertex_stage = self.max_storage_buffers_in_vertex_stage, .max_storage_textures_in_vertex_stage = self.max_storage_textures_in_vertex_stage, .max_storage_buffers_in_fragment_stage = self.max_storage_buffers_in_fragment_stage, .max_storage_textures_in_fragment_stage = self.max_storage_textures_in_fragment_stage };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .max_texture_dimension1d = self.max_texture_dimension1d, .max_texture_dimension2d = self.max_texture_dimension2d, .max_texture_dimension3d = self.max_texture_dimension3d, .max_texture_array_layers = self.max_texture_array_layers, .max_bind_groups = self.max_bind_groups, .max_bind_groups_plus_vertex_buffers = self.max_bind_groups_plus_vertex_buffers, .max_bindings_per_bind_group = self.max_bindings_per_bind_group, .max_dynamic_uniform_buffers_per_pipeline_layout = self.max_dynamic_uniform_buffers_per_pipeline_layout, .max_dynamic_storage_buffers_per_pipeline_layout = self.max_dynamic_storage_buffers_per_pipeline_layout, .max_sampled_textures_per_shader_stage = self.max_sampled_textures_per_shader_stage, .max_samplers_per_shader_stage = self.max_samplers_per_shader_stage, .max_storage_buffers_per_shader_stage = self.max_storage_buffers_per_shader_stage, .max_storage_textures_per_shader_stage = self.max_storage_textures_per_shader_stage, .max_uniform_buffers_per_shader_stage = self.max_uniform_buffers_per_shader_stage, .max_uniform_buffer_binding_size = self.max_uniform_buffer_binding_size, .max_storage_buffer_binding_size = self.max_storage_buffer_binding_size, .min_uniform_buffer_offset_alignment = self.min_uniform_buffer_offset_alignment, .min_storage_buffer_offset_alignment = self.min_storage_buffer_offset_alignment, .max_vertex_buffers = self.max_vertex_buffers, .max_buffer_size = self.max_buffer_size, .max_vertex_attributes = self.max_vertex_attributes, .max_vertex_buffer_array_stride = self.max_vertex_buffer_array_stride, .max_inter_stage_shader_variables = self.max_inter_stage_shader_variables, .max_color_attachments = self.max_color_attachments, .max_color_attachment_bytes_per_sample = self.max_color_attachment_bytes_per_sample, .max_compute_workgroup_storage_size = self.max_compute_workgroup_storage_size, .max_compute_invocations_per_workgroup = self.max_compute_invocations_per_workgroup, .max_compute_workgroup_size_x = self.max_compute_workgroup_size_x, .max_compute_workgroup_size_y = self.max_compute_workgroup_size_y, .max_compute_workgroup_size_z = self.max_compute_workgroup_size_z, .max_compute_workgroups_per_dimension = self.max_compute_workgroups_per_dimension, .max_immediate_size = self.max_immediate_size };
        return &self._desc;
    }

};

pub const BindGroupEntryWithExternalTextureBindingEntry = struct {
    binding: @TypeOf((types.BindGroupEntry{}).binding) = (types.BindGroupEntry{}).binding,
    buffer: @TypeOf((types.BindGroupEntry{}).buffer) = (types.BindGroupEntry{}).buffer,
    offset: @TypeOf((types.BindGroupEntry{}).offset) = (types.BindGroupEntry{}).offset,
    size: @TypeOf((types.BindGroupEntry{}).size) = (types.BindGroupEntry{}).size,
    sampler: @TypeOf((types.BindGroupEntry{}).sampler) = (types.BindGroupEntry{}).sampler,
    texture_view: @TypeOf((types.BindGroupEntry{}).texture_view) = (types.BindGroupEntry{}).texture_view,
    external_texture: @TypeOf((types.ExternalTextureBindingEntry{}).external_texture) = (types.ExternalTextureBindingEntry{}).external_texture,
    _chain: types.ExternalTextureBindingEntry = undefined,
    _desc: types.BindGroupEntry = undefined,

    pub fn descriptor(self: *@This()) *const types.BindGroupEntry {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_ExternalTextureBindingEntry) }, .external_texture = self.external_texture };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .binding = self.binding, .buffer = self.buffer, .offset = self.offset, .size = self.size, .sampler = self.sampler, .texture_view = self.texture_view };
        return &self._desc;
    }

};

pub const BindGroupLayoutEntryWithExternalTextureBindingLayout = struct {
    binding: @TypeOf((types.BindGroupLayoutEntry{}).binding) = (types.BindGroupLayoutEntry{}).binding,
    visibility: @TypeOf((types.BindGroupLayoutEntry{}).visibility) = (types.BindGroupLayoutEntry{}).visibility,
    binding_array_size: @TypeOf((types.BindGroupLayoutEntry{}).binding_array_size) = (types.BindGroupLayoutEntry{}).binding_array_size,
    buffer: @TypeOf((types.BindGroupLayoutEntry{}).buffer) = (types.BindGroupLayoutEntry{}).buffer,
    sampler: @TypeOf((types.BindGroupLayoutEntry{}).sampler) = (types.BindGroupLayoutEntry{}).sampler,
    texture: @TypeOf((types.BindGroupLayoutEntry{}).texture) = (types.BindGroupLayoutEntry{}).texture,
    storage_texture: @TypeOf((types.BindGroupLayoutEntry{}).storage_texture) = (types.BindGroupLayoutEntry{}).storage_texture,
    _chain: types.ExternalTextureBindingLayout = undefined,
    _desc: types.BindGroupLayoutEntry = undefined,

    pub fn descriptor(self: *@This()) *const types.BindGroupLayoutEntry {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_ExternalTextureBindingLayout) } };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .binding = self.binding, .visibility = self.visibility, .binding_array_size = self.binding_array_size, .buffer = self.buffer, .sampler = self.sampler, .texture = self.texture, .storage_texture = self.storage_texture };
        return &self._desc;
    }

};

pub const RenderPassDescriptorWithRenderPassMaxDrawCount = struct {
    label: @TypeOf((types.RenderPassDescriptor{}).label) = (types.RenderPassDescriptor{}).label,
    color_attachment_count: @TypeOf((types.RenderPassDescriptor{}).color_attachment_count) = (types.RenderPassDescriptor{}).color_attachment_count,
    color_attachments: @TypeOf((types.RenderPassDescriptor{}).color_attachments) = (types.RenderPassDescriptor{}).color_attachments,
    depth_stencil_attachment: @TypeOf((types.RenderPassDescriptor{}).depth_stencil_attachment) = (types.RenderPassDescriptor{}).depth_stencil_attachment,
    occlusion_query_set: @TypeOf((types.RenderPassDescriptor{}).occlusion_query_set) = (types.RenderPassDescriptor{}).occlusion_query_set,
    timestamp_writes: @TypeOf((types.RenderPassDescriptor{}).timestamp_writes) = (types.RenderPassDescriptor{}).timestamp_writes,
    max_draw_count: @TypeOf((types.RenderPassMaxDrawCount{}).max_draw_count) = (types.RenderPassMaxDrawCount{}).max_draw_count,
    _chain: types.RenderPassMaxDrawCount = undefined,
    _desc: types.RenderPassDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.RenderPassDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_RenderPassMaxDrawCount) }, .max_draw_count = self.max_draw_count };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label, .color_attachment_count = self.color_attachment_count, .color_attachments = self.color_attachments, .depth_stencil_attachment = self.depth_stencil_attachment, .occlusion_query_set = self.occlusion_query_set, .timestamp_writes = self.timestamp_writes };
        return &self._desc;
    }

    pub fn setColorAttachments(self: *RenderPassDescriptorWithRenderPassMaxDrawCount, items: []const types.RenderPassColorAttachment) void {
        self.color_attachment_count = @intCast(items.len);
        self.color_attachments = items.ptr;
    }

};

pub const RequestAdapterOptionsWithRequestAdapterWebXROptions = struct {
    feature_level: @TypeOf((types.RequestAdapterOptions{}).feature_level) = (types.RequestAdapterOptions{}).feature_level,
    power_preference: @TypeOf((types.RequestAdapterOptions{}).power_preference) = (types.RequestAdapterOptions{}).power_preference,
    force_fallback_adapter: @TypeOf((types.RequestAdapterOptions{}).force_fallback_adapter) = (types.RequestAdapterOptions{}).force_fallback_adapter,
    backend_type: @TypeOf((types.RequestAdapterOptions{}).backend_type) = (types.RequestAdapterOptions{}).backend_type,
    compatible_surface: @TypeOf((types.RequestAdapterOptions{}).compatible_surface) = (types.RequestAdapterOptions{}).compatible_surface,
    xr_compatible: @TypeOf((types.RequestAdapterWebXROptions{}).xr_compatible) = (types.RequestAdapterWebXROptions{}).xr_compatible,
    _chain: types.RequestAdapterWebXROptions = undefined,
    _desc: types.RequestAdapterOptions = undefined,

    pub fn descriptor(self: *@This()) *const types.RequestAdapterOptions {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_RequestAdapterWebXROptions) }, .xr_compatible = self.xr_compatible };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .feature_level = self.feature_level, .power_preference = self.power_preference, .force_fallback_adapter = self.force_fallback_adapter, .backend_type = self.backend_type, .compatible_surface = self.compatible_surface };
        return &self._desc;
    }

};

pub const ShaderModuleDescriptorWithShaderSourceSPIRV = struct {
    label: @TypeOf((types.ShaderModuleDescriptor{}).label) = (types.ShaderModuleDescriptor{}).label,
    code_size: @TypeOf((types.ShaderSourceSPIRV{}).code_size) = (types.ShaderSourceSPIRV{}).code_size,
    code: @TypeOf((types.ShaderSourceSPIRV{}).code) = (types.ShaderSourceSPIRV{}).code,
    _chain: types.ShaderSourceSPIRV = undefined,
    _desc: types.ShaderModuleDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.ShaderModuleDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_ShaderSourceSPIRV) }, .code_size = self.code_size, .code = self.code };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label };
        return &self._desc;
    }

};

pub const ShaderModuleDescriptorWithShaderSourceWGSL = struct {
    label: @TypeOf((types.ShaderModuleDescriptor{}).label) = (types.ShaderModuleDescriptor{}).label,
    code: @TypeOf((types.ShaderSourceWGSL{}).code) = (types.ShaderSourceWGSL{}).code,
    _chain: types.ShaderSourceWGSL = undefined,
    _desc: types.ShaderModuleDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.ShaderModuleDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_ShaderSourceWGSL) }, .code = self.code };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label };
        return &self._desc;
    }

};

pub const SurfaceDescriptorWithSurfaceSourceAndroidNativeWindow = struct {
    label: @TypeOf((types.SurfaceDescriptor{}).label) = (types.SurfaceDescriptor{}).label,
    window: @TypeOf((types.SurfaceSourceAndroidNativeWindow{}).window) = (types.SurfaceSourceAndroidNativeWindow{}).window,
    _chain: types.SurfaceSourceAndroidNativeWindow = undefined,
    _desc: types.SurfaceDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.SurfaceDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_SurfaceSourceAndroidNativeWindow) }, .window = self.window };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label };
        return &self._desc;
    }

};

pub const SurfaceDescriptorWithSurfaceSourceMetalLayer = struct {
    label: @TypeOf((types.SurfaceDescriptor{}).label) = (types.SurfaceDescriptor{}).label,
    layer: @TypeOf((types.SurfaceSourceMetalLayer{}).layer) = (types.SurfaceSourceMetalLayer{}).layer,
    _chain: types.SurfaceSourceMetalLayer = undefined,
    _desc: types.SurfaceDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.SurfaceDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_SurfaceSourceMetalLayer) }, .layer = self.layer };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label };
        return &self._desc;
    }

};

pub const SurfaceDescriptorWithSurfaceSourceWaylandSurface = struct {
    label: @TypeOf((types.SurfaceDescriptor{}).label) = (types.SurfaceDescriptor{}).label,
    display: @TypeOf((types.SurfaceSourceWaylandSurface{}).display) = (types.SurfaceSourceWaylandSurface{}).display,
    surface: @TypeOf((types.SurfaceSourceWaylandSurface{}).surface) = (types.SurfaceSourceWaylandSurface{}).surface,
    _chain: types.SurfaceSourceWaylandSurface = undefined,
    _desc: types.SurfaceDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.SurfaceDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_SurfaceSourceWaylandSurface) }, .display = self.display, .surface = self.surface };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label };
        return &self._desc;
    }

};

pub const SurfaceDescriptorWithSurfaceSourceWindowsHWND = struct {
    label: @TypeOf((types.SurfaceDescriptor{}).label) = (types.SurfaceDescriptor{}).label,
    hinstance: @TypeOf((types.SurfaceSourceWindowsHWND{}).hinstance) = (types.SurfaceSourceWindowsHWND{}).hinstance,
    hwnd: @TypeOf((types.SurfaceSourceWindowsHWND{}).hwnd) = (types.SurfaceSourceWindowsHWND{}).hwnd,
    _chain: types.SurfaceSourceWindowsHWND = undefined,
    _desc: types.SurfaceDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.SurfaceDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_SurfaceSourceWindowsHWND) }, .hinstance = self.hinstance, .hwnd = self.hwnd };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label };
        return &self._desc;
    }

};

pub const SurfaceDescriptorWithSurfaceSourceXCBWindow = struct {
    label: @TypeOf((types.SurfaceDescriptor{}).label) = (types.SurfaceDescriptor{}).label,
    connection: @TypeOf((types.SurfaceSourceXCBWindow{}).connection) = (types.SurfaceSourceXCBWindow{}).connection,
    window: @TypeOf((types.SurfaceSourceXCBWindow{}).window) = (types.SurfaceSourceXCBWindow{}).window,
    _chain: types.SurfaceSourceXCBWindow = undefined,
    _desc: types.SurfaceDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.SurfaceDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_SurfaceSourceXCBWindow) }, .connection = self.connection, .window = self.window };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label };
        return &self._desc;
    }

};

pub const SurfaceDescriptorWithSurfaceSourceXlibWindow = struct {
    label: @TypeOf((types.SurfaceDescriptor{}).label) = (types.SurfaceDescriptor{}).label,
    display: @TypeOf((types.SurfaceSourceXlibWindow{}).display) = (types.SurfaceSourceXlibWindow{}).display,
    window: @TypeOf((types.SurfaceSourceXlibWindow{}).window) = (types.SurfaceSourceXlibWindow{}).window,
    _chain: types.SurfaceSourceXlibWindow = undefined,
    _desc: types.SurfaceDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.SurfaceDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_SurfaceSourceXlibWindow) }, .display = self.display, .window = self.window };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label };
        return &self._desc;
    }

};

pub const TextureDescriptorWithTextureBindingViewDimension = struct {
    label: @TypeOf((types.TextureDescriptor{}).label) = (types.TextureDescriptor{}).label,
    usage: @TypeOf((types.TextureDescriptor{}).usage) = (types.TextureDescriptor{}).usage,
    dimension: @TypeOf((types.TextureDescriptor{}).dimension) = (types.TextureDescriptor{}).dimension,
    size: @TypeOf((types.TextureDescriptor{}).size) = (types.TextureDescriptor{}).size,
    format: @TypeOf((types.TextureDescriptor{}).format) = (types.TextureDescriptor{}).format,
    mip_level_count: @TypeOf((types.TextureDescriptor{}).mip_level_count) = (types.TextureDescriptor{}).mip_level_count,
    sample_count: @TypeOf((types.TextureDescriptor{}).sample_count) = (types.TextureDescriptor{}).sample_count,
    view_format_count: @TypeOf((types.TextureDescriptor{}).view_format_count) = (types.TextureDescriptor{}).view_format_count,
    view_formats: @TypeOf((types.TextureDescriptor{}).view_formats) = (types.TextureDescriptor{}).view_formats,
    texture_binding_view_dimension: @TypeOf((types.TextureBindingViewDimension{}).texture_binding_view_dimension) = (types.TextureBindingViewDimension{}).texture_binding_view_dimension,
    _chain: types.TextureBindingViewDimension = undefined,
    _desc: types.TextureDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.TextureDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_TextureBindingViewDimension) }, .texture_binding_view_dimension = self.texture_binding_view_dimension };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label, .usage = self.usage, .dimension = self.dimension, .size = self.size, .format = self.format, .mip_level_count = self.mip_level_count, .sample_count = self.sample_count, .view_format_count = self.view_format_count, .view_formats = self.view_formats };
        return &self._desc;
    }

    pub fn setViewFormats(self: *TextureDescriptorWithTextureBindingViewDimension, items: []const types.TextureFormat) void {
        self.view_format_count = @intCast(items.len);
        self.view_formats = items.ptr;
    }

};

pub const TextureViewDescriptorWithTextureComponentSwizzleDescriptor = struct {
    label: @TypeOf((types.TextureViewDescriptor{}).label) = (types.TextureViewDescriptor{}).label,
    format: @TypeOf((types.TextureViewDescriptor{}).format) = (types.TextureViewDescriptor{}).format,
    dimension: @TypeOf((types.TextureViewDescriptor{}).dimension) = (types.TextureViewDescriptor{}).dimension,
    base_mip_level: @TypeOf((types.TextureViewDescriptor{}).base_mip_level) = (types.TextureViewDescriptor{}).base_mip_level,
    mip_level_count: @TypeOf((types.TextureViewDescriptor{}).mip_level_count) = (types.TextureViewDescriptor{}).mip_level_count,
    base_array_layer: @TypeOf((types.TextureViewDescriptor{}).base_array_layer) = (types.TextureViewDescriptor{}).base_array_layer,
    array_layer_count: @TypeOf((types.TextureViewDescriptor{}).array_layer_count) = (types.TextureViewDescriptor{}).array_layer_count,
    aspect: @TypeOf((types.TextureViewDescriptor{}).aspect) = (types.TextureViewDescriptor{}).aspect,
    usage: @TypeOf((types.TextureViewDescriptor{}).usage) = (types.TextureViewDescriptor{}).usage,
    swizzle: @TypeOf((types.TextureComponentSwizzleDescriptor{}).swizzle) = (types.TextureComponentSwizzleDescriptor{}).swizzle,
    _chain: types.TextureComponentSwizzleDescriptor = undefined,
    _desc: types.TextureViewDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.TextureViewDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_TextureComponentSwizzleDescriptor) }, .swizzle = self.swizzle };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label, .format = self.format, .dimension = self.dimension, .base_mip_level = self.base_mip_level, .mip_level_count = self.mip_level_count, .base_array_layer = self.base_array_layer, .array_layer_count = self.array_layer_count, .aspect = self.aspect, .usage = self.usage };
        return &self._desc;
    }

};

pub const InstanceDescriptorWithInstanceExtras = struct {
    required_feature_count: @TypeOf((types.InstanceDescriptor{}).required_feature_count) = (types.InstanceDescriptor{}).required_feature_count,
    required_features: @TypeOf((types.InstanceDescriptor{}).required_features) = (types.InstanceDescriptor{}).required_features,
    required_limits: @TypeOf((types.InstanceDescriptor{}).required_limits) = (types.InstanceDescriptor{}).required_limits,
    backends: @TypeOf((types.InstanceExtras{}).backends) = (types.InstanceExtras{}).backends,
    flags: @TypeOf((types.InstanceExtras{}).flags) = (types.InstanceExtras{}).flags,
    dx12_shader_compiler: @TypeOf((types.InstanceExtras{}).dx12_shader_compiler) = (types.InstanceExtras{}).dx12_shader_compiler,
    gles3_minor_version: @TypeOf((types.InstanceExtras{}).gles3_minor_version) = (types.InstanceExtras{}).gles3_minor_version,
    gl_fence_behaviour: @TypeOf((types.InstanceExtras{}).gl_fence_behaviour) = (types.InstanceExtras{}).gl_fence_behaviour,
    dxc_path: @TypeOf((types.InstanceExtras{}).dxc_path) = (types.InstanceExtras{}).dxc_path,
    dxc_max_shader_model: @TypeOf((types.InstanceExtras{}).dxc_max_shader_model) = (types.InstanceExtras{}).dxc_max_shader_model,
    dx12_presentation_system: @TypeOf((types.InstanceExtras{}).dx12_presentation_system) = (types.InstanceExtras{}).dx12_presentation_system,
    budget_for_device_creation: @TypeOf((types.InstanceExtras{}).budget_for_device_creation) = (types.InstanceExtras{}).budget_for_device_creation,
    budget_for_device_loss: @TypeOf((types.InstanceExtras{}).budget_for_device_loss) = (types.InstanceExtras{}).budget_for_device_loss,
    display_handle: @TypeOf((types.InstanceExtras{}).display_handle) = (types.InstanceExtras{}).display_handle,
    _chain: types.InstanceExtras = undefined,
    _desc: types.InstanceDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.InstanceDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_InstanceExtras) }, .backends = self.backends, .flags = self.flags, .dx12_shader_compiler = self.dx12_shader_compiler, .gles3_minor_version = self.gles3_minor_version, .gl_fence_behaviour = self.gl_fence_behaviour, .dxc_path = self.dxc_path, .dxc_max_shader_model = self.dxc_max_shader_model, .dx12_presentation_system = self.dx12_presentation_system, .budget_for_device_creation = self.budget_for_device_creation, .budget_for_device_loss = self.budget_for_device_loss, .display_handle = self.display_handle };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .required_feature_count = self.required_feature_count, .required_features = self.required_features, .required_limits = self.required_limits };
        return &self._desc;
    }

    pub fn setRequiredFeatures(self: *InstanceDescriptorWithInstanceExtras, items: []const types.InstanceFeatureName) void {
        self.required_feature_count = @intCast(items.len);
        self.required_features = items.ptr;
    }

};

pub const DeviceDescriptorWithDeviceExtras = struct {
    label: @TypeOf((types.DeviceDescriptor{}).label) = (types.DeviceDescriptor{}).label,
    required_feature_count: @TypeOf((types.DeviceDescriptor{}).required_feature_count) = (types.DeviceDescriptor{}).required_feature_count,
    required_features: @TypeOf((types.DeviceDescriptor{}).required_features) = (types.DeviceDescriptor{}).required_features,
    required_limits: @TypeOf((types.DeviceDescriptor{}).required_limits) = (types.DeviceDescriptor{}).required_limits,
    default_queue: @TypeOf((types.DeviceDescriptor{}).default_queue) = (types.DeviceDescriptor{}).default_queue,
    device_lost_callback_info: @TypeOf((types.DeviceDescriptor{}).device_lost_callback_info) = (types.DeviceDescriptor{}).device_lost_callback_info,
    uncaptured_error_callback_info: @TypeOf((types.DeviceDescriptor{}).uncaptured_error_callback_info) = (types.DeviceDescriptor{}).uncaptured_error_callback_info,
    trace_path: @TypeOf((types.DeviceExtras{}).trace_path) = (types.DeviceExtras{}).trace_path,
    _chain: types.DeviceExtras = undefined,
    _desc: types.DeviceDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.DeviceDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_DeviceExtras) }, .trace_path = self.trace_path };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label, .required_feature_count = self.required_feature_count, .required_features = self.required_features, .required_limits = self.required_limits, .default_queue = self.default_queue, .device_lost_callback_info = self.device_lost_callback_info, .uncaptured_error_callback_info = self.uncaptured_error_callback_info };
        return &self._desc;
    }

    pub fn setRequiredFeatures(self: *DeviceDescriptorWithDeviceExtras, items: []const types.FeatureName) void {
        self.required_feature_count = @intCast(items.len);
        self.required_features = items.ptr;
    }

};

pub const LimitsWithNativeLimits = struct {
    max_texture_dimension1d: @TypeOf((types.Limits{}).max_texture_dimension1d) = (types.Limits{}).max_texture_dimension1d,
    max_texture_dimension2d: @TypeOf((types.Limits{}).max_texture_dimension2d) = (types.Limits{}).max_texture_dimension2d,
    max_texture_dimension3d: @TypeOf((types.Limits{}).max_texture_dimension3d) = (types.Limits{}).max_texture_dimension3d,
    max_texture_array_layers: @TypeOf((types.Limits{}).max_texture_array_layers) = (types.Limits{}).max_texture_array_layers,
    max_bind_groups: @TypeOf((types.Limits{}).max_bind_groups) = (types.Limits{}).max_bind_groups,
    max_bind_groups_plus_vertex_buffers: @TypeOf((types.Limits{}).max_bind_groups_plus_vertex_buffers) = (types.Limits{}).max_bind_groups_plus_vertex_buffers,
    max_bindings_per_bind_group: @TypeOf((types.Limits{}).max_bindings_per_bind_group) = (types.Limits{}).max_bindings_per_bind_group,
    max_dynamic_uniform_buffers_per_pipeline_layout: @TypeOf((types.Limits{}).max_dynamic_uniform_buffers_per_pipeline_layout) = (types.Limits{}).max_dynamic_uniform_buffers_per_pipeline_layout,
    max_dynamic_storage_buffers_per_pipeline_layout: @TypeOf((types.Limits{}).max_dynamic_storage_buffers_per_pipeline_layout) = (types.Limits{}).max_dynamic_storage_buffers_per_pipeline_layout,
    max_sampled_textures_per_shader_stage: @TypeOf((types.Limits{}).max_sampled_textures_per_shader_stage) = (types.Limits{}).max_sampled_textures_per_shader_stage,
    max_samplers_per_shader_stage: @TypeOf((types.Limits{}).max_samplers_per_shader_stage) = (types.Limits{}).max_samplers_per_shader_stage,
    max_storage_buffers_per_shader_stage: @TypeOf((types.Limits{}).max_storage_buffers_per_shader_stage) = (types.Limits{}).max_storage_buffers_per_shader_stage,
    max_storage_textures_per_shader_stage: @TypeOf((types.Limits{}).max_storage_textures_per_shader_stage) = (types.Limits{}).max_storage_textures_per_shader_stage,
    max_uniform_buffers_per_shader_stage: @TypeOf((types.Limits{}).max_uniform_buffers_per_shader_stage) = (types.Limits{}).max_uniform_buffers_per_shader_stage,
    max_uniform_buffer_binding_size: @TypeOf((types.Limits{}).max_uniform_buffer_binding_size) = (types.Limits{}).max_uniform_buffer_binding_size,
    max_storage_buffer_binding_size: @TypeOf((types.Limits{}).max_storage_buffer_binding_size) = (types.Limits{}).max_storage_buffer_binding_size,
    min_uniform_buffer_offset_alignment: @TypeOf((types.Limits{}).min_uniform_buffer_offset_alignment) = (types.Limits{}).min_uniform_buffer_offset_alignment,
    min_storage_buffer_offset_alignment: @TypeOf((types.Limits{}).min_storage_buffer_offset_alignment) = (types.Limits{}).min_storage_buffer_offset_alignment,
    max_vertex_buffers: @TypeOf((types.Limits{}).max_vertex_buffers) = (types.Limits{}).max_vertex_buffers,
    max_buffer_size: @TypeOf((types.Limits{}).max_buffer_size) = (types.Limits{}).max_buffer_size,
    max_vertex_attributes: @TypeOf((types.Limits{}).max_vertex_attributes) = (types.Limits{}).max_vertex_attributes,
    max_vertex_buffer_array_stride: @TypeOf((types.Limits{}).max_vertex_buffer_array_stride) = (types.Limits{}).max_vertex_buffer_array_stride,
    max_inter_stage_shader_variables: @TypeOf((types.Limits{}).max_inter_stage_shader_variables) = (types.Limits{}).max_inter_stage_shader_variables,
    max_color_attachments: @TypeOf((types.Limits{}).max_color_attachments) = (types.Limits{}).max_color_attachments,
    max_color_attachment_bytes_per_sample: @TypeOf((types.Limits{}).max_color_attachment_bytes_per_sample) = (types.Limits{}).max_color_attachment_bytes_per_sample,
    max_compute_workgroup_storage_size: @TypeOf((types.Limits{}).max_compute_workgroup_storage_size) = (types.Limits{}).max_compute_workgroup_storage_size,
    max_compute_invocations_per_workgroup: @TypeOf((types.Limits{}).max_compute_invocations_per_workgroup) = (types.Limits{}).max_compute_invocations_per_workgroup,
    max_compute_workgroup_size_x: @TypeOf((types.Limits{}).max_compute_workgroup_size_x) = (types.Limits{}).max_compute_workgroup_size_x,
    max_compute_workgroup_size_y: @TypeOf((types.Limits{}).max_compute_workgroup_size_y) = (types.Limits{}).max_compute_workgroup_size_y,
    max_compute_workgroup_size_z: @TypeOf((types.Limits{}).max_compute_workgroup_size_z) = (types.Limits{}).max_compute_workgroup_size_z,
    max_compute_workgroups_per_dimension: @TypeOf((types.Limits{}).max_compute_workgroups_per_dimension) = (types.Limits{}).max_compute_workgroups_per_dimension,
    max_immediate_size: @TypeOf((types.Limits{}).max_immediate_size) = (types.Limits{}).max_immediate_size,
    max_non_sampler_bindings: @TypeOf((types.NativeLimits{}).max_non_sampler_bindings) = (types.NativeLimits{}).max_non_sampler_bindings,
    max_binding_array_elements_per_shader_stage: @TypeOf((types.NativeLimits{}).max_binding_array_elements_per_shader_stage) = (types.NativeLimits{}).max_binding_array_elements_per_shader_stage,
    max_binding_array_sampler_elements_per_shader_stage: @TypeOf((types.NativeLimits{}).max_binding_array_sampler_elements_per_shader_stage) = (types.NativeLimits{}).max_binding_array_sampler_elements_per_shader_stage,
    max_multiview_view_count: @TypeOf((types.NativeLimits{}).max_multiview_view_count) = (types.NativeLimits{}).max_multiview_view_count,
    _chain: types.NativeLimits = undefined,
    _desc: types.Limits = undefined,

    pub fn descriptor(self: *@This()) *const types.Limits {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_NativeLimits) }, .max_non_sampler_bindings = self.max_non_sampler_bindings, .max_binding_array_elements_per_shader_stage = self.max_binding_array_elements_per_shader_stage, .max_binding_array_sampler_elements_per_shader_stage = self.max_binding_array_sampler_elements_per_shader_stage, .max_multiview_view_count = self.max_multiview_view_count };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .max_texture_dimension1d = self.max_texture_dimension1d, .max_texture_dimension2d = self.max_texture_dimension2d, .max_texture_dimension3d = self.max_texture_dimension3d, .max_texture_array_layers = self.max_texture_array_layers, .max_bind_groups = self.max_bind_groups, .max_bind_groups_plus_vertex_buffers = self.max_bind_groups_plus_vertex_buffers, .max_bindings_per_bind_group = self.max_bindings_per_bind_group, .max_dynamic_uniform_buffers_per_pipeline_layout = self.max_dynamic_uniform_buffers_per_pipeline_layout, .max_dynamic_storage_buffers_per_pipeline_layout = self.max_dynamic_storage_buffers_per_pipeline_layout, .max_sampled_textures_per_shader_stage = self.max_sampled_textures_per_shader_stage, .max_samplers_per_shader_stage = self.max_samplers_per_shader_stage, .max_storage_buffers_per_shader_stage = self.max_storage_buffers_per_shader_stage, .max_storage_textures_per_shader_stage = self.max_storage_textures_per_shader_stage, .max_uniform_buffers_per_shader_stage = self.max_uniform_buffers_per_shader_stage, .max_uniform_buffer_binding_size = self.max_uniform_buffer_binding_size, .max_storage_buffer_binding_size = self.max_storage_buffer_binding_size, .min_uniform_buffer_offset_alignment = self.min_uniform_buffer_offset_alignment, .min_storage_buffer_offset_alignment = self.min_storage_buffer_offset_alignment, .max_vertex_buffers = self.max_vertex_buffers, .max_buffer_size = self.max_buffer_size, .max_vertex_attributes = self.max_vertex_attributes, .max_vertex_buffer_array_stride = self.max_vertex_buffer_array_stride, .max_inter_stage_shader_variables = self.max_inter_stage_shader_variables, .max_color_attachments = self.max_color_attachments, .max_color_attachment_bytes_per_sample = self.max_color_attachment_bytes_per_sample, .max_compute_workgroup_storage_size = self.max_compute_workgroup_storage_size, .max_compute_invocations_per_workgroup = self.max_compute_invocations_per_workgroup, .max_compute_workgroup_size_x = self.max_compute_workgroup_size_x, .max_compute_workgroup_size_y = self.max_compute_workgroup_size_y, .max_compute_workgroup_size_z = self.max_compute_workgroup_size_z, .max_compute_workgroups_per_dimension = self.max_compute_workgroups_per_dimension, .max_immediate_size = self.max_immediate_size };
        return &self._desc;
    }

};

pub const ShaderModuleDescriptorWithShaderSourceGLSL = struct {
    label: @TypeOf((types.ShaderModuleDescriptor{}).label) = (types.ShaderModuleDescriptor{}).label,
    stage: @TypeOf((types.ShaderSourceGLSL{}).stage) = (types.ShaderSourceGLSL{}).stage,
    code: @TypeOf((types.ShaderSourceGLSL{}).code) = (types.ShaderSourceGLSL{}).code,
    define_count: @TypeOf((types.ShaderSourceGLSL{}).define_count) = (types.ShaderSourceGLSL{}).define_count,
    defines: @TypeOf((types.ShaderSourceGLSL{}).defines) = (types.ShaderSourceGLSL{}).defines,
    _chain: types.ShaderSourceGLSL = undefined,
    _desc: types.ShaderModuleDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.ShaderModuleDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_ShaderSourceGLSL) }, .stage = self.stage, .code = self.code, .define_count = self.define_count, .defines = self.defines };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label };
        return &self._desc;
    }

    pub fn setDefines(self: *ShaderModuleDescriptorWithShaderSourceGLSL, items: []const types.ShaderDefine) void {
        self.define_count = @intCast(items.len);
        self.defines = items.ptr;
    }

};

pub const BindGroupEntryWithBindGroupEntryExtras = struct {
    binding: @TypeOf((types.BindGroupEntry{}).binding) = (types.BindGroupEntry{}).binding,
    buffer: @TypeOf((types.BindGroupEntry{}).buffer) = (types.BindGroupEntry{}).buffer,
    offset: @TypeOf((types.BindGroupEntry{}).offset) = (types.BindGroupEntry{}).offset,
    size: @TypeOf((types.BindGroupEntry{}).size) = (types.BindGroupEntry{}).size,
    sampler: @TypeOf((types.BindGroupEntry{}).sampler) = (types.BindGroupEntry{}).sampler,
    texture_view: @TypeOf((types.BindGroupEntry{}).texture_view) = (types.BindGroupEntry{}).texture_view,
    buffers: @TypeOf((types.BindGroupEntryExtras{}).buffers) = (types.BindGroupEntryExtras{}).buffers,
    buffer_count: @TypeOf((types.BindGroupEntryExtras{}).buffer_count) = (types.BindGroupEntryExtras{}).buffer_count,
    samplers: @TypeOf((types.BindGroupEntryExtras{}).samplers) = (types.BindGroupEntryExtras{}).samplers,
    sampler_count: @TypeOf((types.BindGroupEntryExtras{}).sampler_count) = (types.BindGroupEntryExtras{}).sampler_count,
    texture_views: @TypeOf((types.BindGroupEntryExtras{}).texture_views) = (types.BindGroupEntryExtras{}).texture_views,
    texture_view_count: @TypeOf((types.BindGroupEntryExtras{}).texture_view_count) = (types.BindGroupEntryExtras{}).texture_view_count,
    _chain: types.BindGroupEntryExtras = undefined,
    _desc: types.BindGroupEntry = undefined,

    pub fn descriptor(self: *@This()) *const types.BindGroupEntry {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_BindGroupEntryExtras) }, .buffers = self.buffers, .buffer_count = self.buffer_count, .samplers = self.samplers, .sampler_count = self.sampler_count, .texture_views = self.texture_views, .texture_view_count = self.texture_view_count };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .binding = self.binding, .buffer = self.buffer, .offset = self.offset, .size = self.size, .sampler = self.sampler, .texture_view = self.texture_view };
        return &self._desc;
    }

    pub fn setBuffers(self: *BindGroupEntryWithBindGroupEntryExtras, items: []const ?*handles.Buffer) void {
        self.buffer_count = @intCast(items.len);
        self.buffers = items.ptr;
    }

    pub fn setSamplers(self: *BindGroupEntryWithBindGroupEntryExtras, items: []const ?*handles.Sampler) void {
        self.sampler_count = @intCast(items.len);
        self.samplers = items.ptr;
    }

    pub fn setTextureViews(self: *BindGroupEntryWithBindGroupEntryExtras, items: []const ?*handles.TextureView) void {
        self.texture_view_count = @intCast(items.len);
        self.texture_views = items.ptr;
    }

};

pub const BindGroupLayoutEntryWithBindGroupLayoutEntryExtras = struct {
    binding: @TypeOf((types.BindGroupLayoutEntry{}).binding) = (types.BindGroupLayoutEntry{}).binding,
    visibility: @TypeOf((types.BindGroupLayoutEntry{}).visibility) = (types.BindGroupLayoutEntry{}).visibility,
    binding_array_size: @TypeOf((types.BindGroupLayoutEntry{}).binding_array_size) = (types.BindGroupLayoutEntry{}).binding_array_size,
    buffer: @TypeOf((types.BindGroupLayoutEntry{}).buffer) = (types.BindGroupLayoutEntry{}).buffer,
    sampler: @TypeOf((types.BindGroupLayoutEntry{}).sampler) = (types.BindGroupLayoutEntry{}).sampler,
    texture: @TypeOf((types.BindGroupLayoutEntry{}).texture) = (types.BindGroupLayoutEntry{}).texture,
    storage_texture: @TypeOf((types.BindGroupLayoutEntry{}).storage_texture) = (types.BindGroupLayoutEntry{}).storage_texture,
    count: @TypeOf((types.BindGroupLayoutEntryExtras{}).count) = (types.BindGroupLayoutEntryExtras{}).count,
    _chain: types.BindGroupLayoutEntryExtras = undefined,
    _desc: types.BindGroupLayoutEntry = undefined,

    pub fn descriptor(self: *@This()) *const types.BindGroupLayoutEntry {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_BindGroupLayoutEntryExtras) }, .count = self.count };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .binding = self.binding, .visibility = self.visibility, .binding_array_size = self.binding_array_size, .buffer = self.buffer, .sampler = self.sampler, .texture = self.texture, .storage_texture = self.storage_texture };
        return &self._desc;
    }

};

pub const QuerySetDescriptorWithQuerySetDescriptorExtras = struct {
    label: @TypeOf((types.QuerySetDescriptor{}).label) = (types.QuerySetDescriptor{}).label,
    type: @TypeOf((types.QuerySetDescriptor{}).type) = (types.QuerySetDescriptor{}).type,
    count: @TypeOf((types.QuerySetDescriptor{}).count) = (types.QuerySetDescriptor{}).count,
    pipeline_statistics: @TypeOf((types.QuerySetDescriptorExtras{}).pipeline_statistics) = (types.QuerySetDescriptorExtras{}).pipeline_statistics,
    pipeline_statistic_count: @TypeOf((types.QuerySetDescriptorExtras{}).pipeline_statistic_count) = (types.QuerySetDescriptorExtras{}).pipeline_statistic_count,
    _chain: types.QuerySetDescriptorExtras = undefined,
    _desc: types.QuerySetDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.QuerySetDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_QuerySetDescriptorExtras) }, .pipeline_statistics = self.pipeline_statistics, .pipeline_statistic_count = self.pipeline_statistic_count };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label, .type = self.type, .count = self.count };
        return &self._desc;
    }

    pub fn setPipelineStatistics(self: *QuerySetDescriptorWithQuerySetDescriptorExtras, items: []const types.PipelineStatisticName) void {
        self.pipeline_statistic_count = @intCast(items.len);
        self.pipeline_statistics = items.ptr;
    }

};

pub const SurfaceConfigurationWithSurfaceConfigurationExtras = struct {
    device: @TypeOf((types.SurfaceConfiguration{}).device) = (types.SurfaceConfiguration{}).device,
    format: @TypeOf((types.SurfaceConfiguration{}).format) = (types.SurfaceConfiguration{}).format,
    usage: @TypeOf((types.SurfaceConfiguration{}).usage) = (types.SurfaceConfiguration{}).usage,
    width: @TypeOf((types.SurfaceConfiguration{}).width) = (types.SurfaceConfiguration{}).width,
    height: @TypeOf((types.SurfaceConfiguration{}).height) = (types.SurfaceConfiguration{}).height,
    view_format_count: @TypeOf((types.SurfaceConfiguration{}).view_format_count) = (types.SurfaceConfiguration{}).view_format_count,
    view_formats: @TypeOf((types.SurfaceConfiguration{}).view_formats) = (types.SurfaceConfiguration{}).view_formats,
    alpha_mode: @TypeOf((types.SurfaceConfiguration{}).alpha_mode) = (types.SurfaceConfiguration{}).alpha_mode,
    present_mode: @TypeOf((types.SurfaceConfiguration{}).present_mode) = (types.SurfaceConfiguration{}).present_mode,
    desired_maximum_frame_latency: @TypeOf((types.SurfaceConfigurationExtras{}).desired_maximum_frame_latency) = (types.SurfaceConfigurationExtras{}).desired_maximum_frame_latency,
    _chain: types.SurfaceConfigurationExtras = undefined,
    _desc: types.SurfaceConfiguration = undefined,

    pub fn descriptor(self: *@This()) *const types.SurfaceConfiguration {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_SurfaceConfigurationExtras) }, .desired_maximum_frame_latency = self.desired_maximum_frame_latency };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .device = self.device, .format = self.format, .usage = self.usage, .width = self.width, .height = self.height, .view_format_count = self.view_format_count, .view_formats = self.view_formats, .alpha_mode = self.alpha_mode, .present_mode = self.present_mode };
        return &self._desc;
    }

    pub fn setViewFormats(self: *SurfaceConfigurationWithSurfaceConfigurationExtras, items: []const types.TextureFormat) void {
        self.view_format_count = @intCast(items.len);
        self.view_formats = items.ptr;
    }

};

pub const SurfaceDescriptorWithSurfaceSourceSwapChainPanel = struct {
    label: @TypeOf((types.SurfaceDescriptor{}).label) = (types.SurfaceDescriptor{}).label,
    panel_native: @TypeOf((types.SurfaceSourceSwapChainPanel{}).panel_native) = (types.SurfaceSourceSwapChainPanel{}).panel_native,
    _chain: types.SurfaceSourceSwapChainPanel = undefined,
    _desc: types.SurfaceDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.SurfaceDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_SurfaceSourceSwapChainPanel) }, .panel_native = self.panel_native };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label };
        return &self._desc;
    }

};

pub const PrimitiveStateWithPrimitiveStateExtras = struct {
    topology: @TypeOf((types.PrimitiveState{}).topology) = (types.PrimitiveState{}).topology,
    strip_index_format: @TypeOf((types.PrimitiveState{}).strip_index_format) = (types.PrimitiveState{}).strip_index_format,
    front_face: @TypeOf((types.PrimitiveState{}).front_face) = (types.PrimitiveState{}).front_face,
    cull_mode: @TypeOf((types.PrimitiveState{}).cull_mode) = (types.PrimitiveState{}).cull_mode,
    unclipped_depth: @TypeOf((types.PrimitiveState{}).unclipped_depth) = (types.PrimitiveState{}).unclipped_depth,
    polygon_mode: @TypeOf((types.PrimitiveStateExtras{}).polygon_mode) = (types.PrimitiveStateExtras{}).polygon_mode,
    conservative: @TypeOf((types.PrimitiveStateExtras{}).conservative) = (types.PrimitiveStateExtras{}).conservative,
    _chain: types.PrimitiveStateExtras = undefined,
    _desc: types.PrimitiveState = undefined,

    pub fn descriptor(self: *@This()) *const types.PrimitiveState {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_PrimitiveStateExtras) }, .polygon_mode = self.polygon_mode, .conservative = self.conservative };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .topology = self.topology, .strip_index_format = self.strip_index_format, .front_face = self.front_face, .cull_mode = self.cull_mode, .unclipped_depth = self.unclipped_depth };
        return &self._desc;
    }

};

pub const SamplerDescriptorWithSamplerDescriptorExtras = struct {
    label: @TypeOf((types.SamplerDescriptor{}).label) = (types.SamplerDescriptor{}).label,
    address_mode_u: @TypeOf((types.SamplerDescriptor{}).address_mode_u) = (types.SamplerDescriptor{}).address_mode_u,
    address_mode_v: @TypeOf((types.SamplerDescriptor{}).address_mode_v) = (types.SamplerDescriptor{}).address_mode_v,
    address_mode_w: @TypeOf((types.SamplerDescriptor{}).address_mode_w) = (types.SamplerDescriptor{}).address_mode_w,
    mag_filter: @TypeOf((types.SamplerDescriptor{}).mag_filter) = (types.SamplerDescriptor{}).mag_filter,
    min_filter: @TypeOf((types.SamplerDescriptor{}).min_filter) = (types.SamplerDescriptor{}).min_filter,
    mipmap_filter: @TypeOf((types.SamplerDescriptor{}).mipmap_filter) = (types.SamplerDescriptor{}).mipmap_filter,
    lod_min_clamp: @TypeOf((types.SamplerDescriptor{}).lod_min_clamp) = (types.SamplerDescriptor{}).lod_min_clamp,
    lod_max_clamp: @TypeOf((types.SamplerDescriptor{}).lod_max_clamp) = (types.SamplerDescriptor{}).lod_max_clamp,
    compare: @TypeOf((types.SamplerDescriptor{}).compare) = (types.SamplerDescriptor{}).compare,
    max_anisotropy: @TypeOf((types.SamplerDescriptor{}).max_anisotropy) = (types.SamplerDescriptor{}).max_anisotropy,
    sampler_border_color: @TypeOf((types.SamplerDescriptorExtras{}).sampler_border_color) = (types.SamplerDescriptorExtras{}).sampler_border_color,
    _chain: types.SamplerDescriptorExtras = undefined,
    _desc: types.SamplerDescriptor = undefined,

    pub fn descriptor(self: *@This()) *const types.SamplerDescriptor {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_SamplerDescriptorExtras) }, .sampler_border_color = self.sampler_border_color };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .label = self.label, .address_mode_u = self.address_mode_u, .address_mode_v = self.address_mode_v, .address_mode_w = self.address_mode_w, .mag_filter = self.mag_filter, .min_filter = self.min_filter, .mipmap_filter = self.mipmap_filter, .lod_min_clamp = self.lod_min_clamp, .lod_max_clamp = self.lod_max_clamp, .compare = self.compare, .max_anisotropy = self.max_anisotropy };
        return &self._desc;
    }

};

pub const SurfaceConfigurationWithSurfaceColorManagement = struct {
    device: @TypeOf((types.SurfaceConfiguration{}).device) = (types.SurfaceConfiguration{}).device,
    format: @TypeOf((types.SurfaceConfiguration{}).format) = (types.SurfaceConfiguration{}).format,
    usage: @TypeOf((types.SurfaceConfiguration{}).usage) = (types.SurfaceConfiguration{}).usage,
    width: @TypeOf((types.SurfaceConfiguration{}).width) = (types.SurfaceConfiguration{}).width,
    height: @TypeOf((types.SurfaceConfiguration{}).height) = (types.SurfaceConfiguration{}).height,
    view_format_count: @TypeOf((types.SurfaceConfiguration{}).view_format_count) = (types.SurfaceConfiguration{}).view_format_count,
    view_formats: @TypeOf((types.SurfaceConfiguration{}).view_formats) = (types.SurfaceConfiguration{}).view_formats,
    alpha_mode: @TypeOf((types.SurfaceConfiguration{}).alpha_mode) = (types.SurfaceConfiguration{}).alpha_mode,
    present_mode: @TypeOf((types.SurfaceConfiguration{}).present_mode) = (types.SurfaceConfiguration{}).present_mode,
    color_space: @TypeOf((types.SurfaceColorManagement{}).color_space) = (types.SurfaceColorManagement{}).color_space,
    tone_mapping_mode: @TypeOf((types.SurfaceColorManagement{}).tone_mapping_mode) = (types.SurfaceColorManagement{}).tone_mapping_mode,
    _chain: types.SurfaceColorManagement = undefined,
    _desc: types.SurfaceConfiguration = undefined,

    pub fn descriptor(self: *@This()) *const types.SurfaceConfiguration {
        self._chain = .{ .chain = .{ .s_type = @enumFromInt(c.WGPUSType_SurfaceColorManagement) }, .color_space = self.color_space, .tone_mapping_mode = self.tone_mapping_mode };
        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain), .device = self.device, .format = self.format, .usage = self.usage, .width = self.width, .height = self.height, .view_format_count = self.view_format_count, .view_formats = self.view_formats, .alpha_mode = self.alpha_mode, .present_mode = self.present_mode };
        return &self._desc;
    }

    pub fn setViewFormats(self: *SurfaceConfigurationWithSurfaceColorManagement, items: []const types.TextureFormat) void {
        self.view_format_count = @intCast(items.len);
        self.view_formats = items.ptr;
    }

};

