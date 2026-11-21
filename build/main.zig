const std = @import("std");
const Io = std.Io;
const Mapping = @import("Mapping.zig");
const MapEnums = @import("MapEnums.zig");
const MapFlags = @import("MapFlags.zig");
const MapStructs = @import("MapStructs.zig");
const MapHandles = @import("MapHandles.zig");
const MapFunctions = @import("MapFunctions.zig");
const MapCallbacks = @import("MapCallbacks.zig");
const Output = @import("Output.zig");
const Headers = @import("Headers.zig");

pub fn main(init: std.process.Init) !void {
    // Use our own allocator because a leak must fail the build. init.gpa only
    // logs leaks. Safety stays on so release codegen still checks.
    var debug_allocator: std.heap.DebugAllocator(.{ .safety = true }) = .init;
    defer {
        if (debug_allocator.deinit() == .leak) {
            std.log.err("code generator leaked memory; failing the build step", .{});
            @panic("codegen leaked memory");
        }
    }
    const gpa = debug_allocator.allocator();
    const arena = init.arena.allocator();

    const args = (try init.minimal.args.toSlice(arena))[1..];
    if (args.len != 2) return error.IncorrectArguments;

    const root_bindings = try openFile(init.io, args[0]);
    const content = try readFileAll(gpa, init.io, root_bindings);
    defer gpa.free(content);

    var ast = try std.zig.Ast.parse(gpa, content, .{ .mode = .zig });
    defer ast.deinit(gpa);

    const mapping = try Mapping.init(gpa, arena, &ast);
    defer mapping.deinit();

    try mapping.premap();
    try MapEnums.discover(mapping);
    try MapEnums.generate(mapping);
    try MapFlags.discover(mapping);
    try MapFlags.generate(mapping);
    try MapStructs.discover(mapping);
    try MapStructs.generate(mapping);
    try MapHandles.discover(mapping);
    try MapHandles.generate(mapping);
    try MapFunctions.discover(mapping);
    try MapFunctions.generate(mapping);
    try MapCallbacks.discover(mapping);
    try MapCallbacks.generate(mapping);
    try loadUnimplemented(init.io, gpa, arena, mapping);
    try loadNullability(init.io, gpa, arena, mapping);
    try loadBuilderPairs(init.io, gpa, arena, mapping);

    try Output.writeOutput(init.io, gpa, mapping, args[1]);
}

fn schemaNameToC(arena: std.mem.Allocator, schema_name: []const u8) ![]const u8 {
    var out: std.ArrayList(u8) = .empty;
    try out.appendSlice(arena, "WGPU");
    var it = std.mem.splitScalar(u8, schema_name, '_');
    while (it.next()) |segment| {
        if (segment.len == 0) continue;
        const piece = try arena.dupe(u8, segment);
        piece[0] = std.ascii.toUpper(piece[0]);
        try out.appendSlice(arena, piece);
    }
    return try out.toOwnedSlice(arena);
}

fn loadBuilderPairs(io: Io, gpa: std.mem.Allocator, arena: std.mem.Allocator, mapping: *Mapping) !void {
    const file = openFile(io, "vendor/wgpu-native/ffi/webgpu-headers/webgpu.json") catch return;
    defer Io.File.close(file, io);
    const data = readFileAll(gpa, io, file) catch return;
    defer gpa.free(data);

    const parsed = std.json.parseFromSlice(std.json.Value, gpa, data, .{}) catch return;
    defer parsed.deinit();
    const structs = parsed.value.object.get("structs") orelse return;

    for (structs.array.items) |item| {
        const obj = item.object;
        const kind = obj.get("type") orelse continue;
        if (!std.mem.eql(u8, kind.string, "extension")) continue;
        const child_name = obj.get("name") orelse continue;
        const extends = obj.get("extends") orelse continue;
        if (extends.array.items.len == 0) continue;

        const child_c = try schemaNameToC(arena, child_name.string);
        const parent_c = try schemaNameToC(arena, extends.array.items[0].string);
        if (!mapping.struct_decls.contains(child_c)) continue;
        if (!mapping.struct_decls.contains(parent_c)) continue;

        const suffix = child_c["WGPU".len..];
        const s_const = try std.fmt.allocPrint(arena, "WGPUSType_{s}", .{suffix});
        if (!mapping.symbols.contains(s_const)) continue;

        try mapping.builder_pairs.append(gpa, .{
            .parent_c = parent_c,
            .child_c = child_c,
            .s_type_const = s_const,
        });
    }

    // wgpu-native extras (and SurfaceColorManagement) whose parent is not
    // expressed in webgpu.json. Their parents come from the C docs and the
    // wgpu-native Rust conversion code.
    const extra_pairs = [_]struct { parent: []const u8, child: []const u8 }{
        .{ .parent = "WGPUInstanceDescriptor", .child = "WGPUInstanceExtras" },
        .{ .parent = "WGPUDeviceDescriptor", .child = "WGPUDeviceExtras" },
        .{ .parent = "WGPULimits", .child = "WGPUNativeLimits" },
        .{ .parent = "WGPUShaderModuleDescriptor", .child = "WGPUShaderSourceGLSL" },
        .{ .parent = "WGPUBindGroupEntry", .child = "WGPUBindGroupEntryExtras" },
        .{ .parent = "WGPUBindGroupLayoutEntry", .child = "WGPUBindGroupLayoutEntryExtras" },
        .{ .parent = "WGPUQuerySetDescriptor", .child = "WGPUQuerySetDescriptorExtras" },
        .{ .parent = "WGPUSurfaceConfiguration", .child = "WGPUSurfaceConfigurationExtras" },
        .{ .parent = "WGPUSurfaceDescriptor", .child = "WGPUSurfaceSourceSwapChainPanel" },
        .{ .parent = "WGPUPrimitiveState", .child = "WGPUPrimitiveStateExtras" },
        .{ .parent = "WGPUSamplerDescriptor", .child = "WGPUSamplerDescriptorExtras" },
        .{ .parent = "WGPUSurfaceConfiguration", .child = "WGPUSurfaceColorManagement" },
    };
    for (extra_pairs) |pair| {
        if (!mapping.struct_decls.contains(pair.parent)) continue;
        if (!mapping.struct_decls.contains(pair.child)) continue;

        const suffix = pair.child["WGPU".len..];
        const s_const = try std.fmt.allocPrint(arena, "WGPUSType_{s}", .{suffix});
        if (!mapping.symbols.contains(s_const)) continue;

        try mapping.builder_pairs.append(gpa, .{
            .parent_c = pair.parent,
            .child_c = pair.child,
            .s_type_const = s_const,
        });
    }
}

/// All stubbed entry points: unimplemented.rs plus inline ones in lib.rs.
fn loadUnimplemented(io: Io, gpa: std.mem.Allocator, arena: std.mem.Allocator, mapping: *Mapping) !void {
    try loadUnimplementedFile(io, gpa, arena, &mapping.unimplemented, "vendor/wgpu-native/src/unimplemented.rs", .explicit_stubs);
    try loadUnimplementedFile(io, gpa, arena, &mapping.unimplemented, "vendor/wgpu-native/src/lib.rs", .inline_stubs);

    if (mapping.unimplemented.count() == 0) {
        std.log.err("could not find any unimplemented wgpu-native entry points; are the vendor submodules checked out?", .{});
        return error.MissingVendorSources;
    }
}

pub const UnimplementedKind = enum {
    /// A stub declared as a `pub extern "C" fn`.
    explicit_stubs,
    /// An extern fn whose body calls `unimplemented!()`.
    inline_stubs,
};

fn loadUnimplementedFile(
    io: Io,
    gpa: std.mem.Allocator,
    arena: std.mem.Allocator,
    set: *std.StringHashMapUnmanaged(void),
    path: []const u8,
    kind: UnimplementedKind,
) !void {
    const file = openFile(io, path) catch |err| switch (err) {
        // Both files are required, so never emit half the list.
        error.FileNotFound => return error.MissingVendorSources,
        else => return err,
    };
    defer Io.File.close(file, io);
    const data = try readFileAll(gpa, io, file);
    defer gpa.free(data);

    try collectUnimplemented(arena, gpa, set, data, kind);
}

/// Merge WGPU_NULLABLE from both headers.
fn loadNullability(io: Io, gpa: std.mem.Allocator, arena: std.mem.Allocator, mapping: *Mapping) !void {
    const paths = [_][]const u8{
        "vendor/wgpu-native/ffi/webgpu-headers/webgpu.h",
        "vendor/wgpu-native/ffi/wgpu.h",
    };

    for (paths) |path| {
        const file = openFile(io, path) catch |err| switch (err) {
            error.FileNotFound => return error.MissingVendorSources,
            else => return err,
        };
        defer Io.File.close(file, io);
        const data = try readFileAll(gpa, io, file);
        defer gpa.free(data);

        var parsed = try Headers.parse(gpa, arena, data);
        defer parsed.deinit(gpa);

        var it = parsed.iterator();
        while (it.next()) |entry| {
            const name = entry.key_ptr.*;
            const info = entry.value_ptr.*;
            if (mapping.fn_nullability.getPtr(name)) |existing| {
                if (existing.params.len == info.params.len) {
                    for (existing.params, info.params) |*dst, src| dst.* = dst.* or src;
                } else {
                    std.log.warn("nullability: {s} has mismatched parameter counts between headers", .{name});
                }
                existing.returns = existing.returns or info.returns;
            } else {
                try mapping.fn_nullability.put(gpa, name, info);
            }
        }
    }
}

/// Pure parser used by the tests.
pub fn collectUnimplemented(
    key_arena: std.mem.Allocator,
    map_gpa: std.mem.Allocator,
    set: *std.StringHashMapUnmanaged(void),
    source: []const u8,
    kind: UnimplementedKind,
) !void {
    switch (kind) {
        .explicit_stubs => {
            const marker = "pub extern \"C\" fn ";
            var it = std.mem.splitScalar(u8, source, '\n');
            while (it.next()) |line| {
                const idx = std.mem.indexOf(u8, line, marker) orelse continue;
                const rest = line[idx + marker.len ..];
                const end = std.mem.indexOfScalar(u8, rest, '(') orelse continue;
                const name = std.mem.trim(u8, rest[0..end], " \t");
                if (name.len == 0) continue;
                try set.put(map_gpa, try key_arena.dupe(u8, name), {});
            }
        },
        .inline_stubs => {
            const marker = "extern \"C\" fn ";
            var current: ?[]const u8 = null;
            var it = std.mem.splitScalar(u8, source, '\n');
            while (it.next()) |line| {
                if (std.mem.indexOf(u8, line, marker)) |idx| {
                    const rest = line[idx + marker.len ..];
                    const end = std.mem.indexOfScalar(u8, rest, '(') orelse rest.len;
                    const name = std.mem.trim(u8, rest[0..end], " \t");
                    if (name.len != 0) current = name;
                }
                if (std.mem.indexOf(u8, line, "unimplemented!(") != null) {
                    if (current) |name| {
                        try set.put(map_gpa, try key_arena.dupe(u8, name), {});
                        current = null;
                    }
                }
            }
        },
    }
}

fn openFile(io: Io, file_path: []const u8) !Io.File {
    if (std.fs.path.isAbsolute(file_path)) {
        return Io.Dir.openFileAbsolute(io, file_path, .{});
    } else {
        const cwd = Io.Dir.cwd();
        return Io.Dir.openFile(cwd, io, file_path, .{});
    }
}

fn readFileAll(gpa: std.mem.Allocator, io: Io, file: Io.File) ![:0]u8 {
    const stat = try Io.File.stat(file, io);
    const buf = try gpa.allocSentinel(u8, stat.size, 0);
    const read = try Io.File.readPositionalAll(file, io, buf, 0);
    if (read != stat.size) return error.UnexpectedReadSize;
    return buf;
}

test "parses explicit unimplemented.rs stubs" {
    var arena_state = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();
    var set: std.StringHashMapUnmanaged(void) = .empty;

    try collectUnimplemented(arena, arena, &set,
        \\pub extern "C" fn wgpuDeviceSetLabel(device: WGPUDevice, label: WGPUStringView) {
        \\    unimplemented!();
        \\}
        \\pub extern "C" fn wgpuBufferGetMapState(buffer: WGPUBuffer) WGPUBufferMapState {
        \\    unimplemented!();
        \\}
    , .explicit_stubs);

    try std.testing.expectEqual(@as(usize, 2), set.count());
    try std.testing.expect(set.contains("wgpuDeviceSetLabel"));
    try std.testing.expect(set.contains("wgpuBufferGetMapState"));
}

test "parses inline lib.rs stubs" {
    var arena_state = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();
    var set: std.StringHashMapUnmanaged(void) = .empty;

    try collectUnimplemented(arena, arena, &set,
        \\pub unsafe extern "C" fn wgpuGetInstanceFeatures(
        \\    out: *mut WGPUInstanceFeatures,
        \\) WGPUStatus {
        \\    unimplemented!("wgpuGetInstanceFeatures is not implemented");
        \\}
        \\pub unsafe extern "C" fn wgpuImplemented() WGPUStatus {
        \\    return WGPUStatus_Success;
        \\}
    , .inline_stubs);

    try std.testing.expectEqual(@as(usize, 1), set.count());
    try std.testing.expect(set.contains("wgpuGetInstanceFeatures"));
    try std.testing.expect(!set.contains("wgpuImplemented"));
}

test "vendored sources list aborting entry points" {
    var arena_state = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();
    var set: std.StringHashMapUnmanaged(void) = .empty;

    var threaded: std.Io.Threaded = .init(std.heap.smp_allocator, .{});
    defer threaded.deinit();
    const io = threaded.io();
    const cwd = Io.Dir.cwd();

    const sources = .{
        .{ "vendor/wgpu-native/src/unimplemented.rs", UnimplementedKind.explicit_stubs },
        .{ "vendor/wgpu-native/src/lib.rs", UnimplementedKind.inline_stubs },
    };
    inline for (sources) |source| {
        const data = cwd.readFileAlloc(io, source[0], arena, .limited(32 * 1024 * 1024)) catch |err| switch (err) {
            error.FileNotFound => return error.SkipZigTest,
            else => return err,
        };
        try collectUnimplemented(arena, arena, &set, data, source[1]);
    }

    // 35 explicit stubs plus 5 inline ones.
    try std.testing.expectEqual(@as(usize, 40), set.count());
    try std.testing.expect(set.contains("wgpuDeviceSetLabel"));
    try std.testing.expect(set.contains("wgpuGetInstanceFeatures"));
    try std.testing.expect(set.contains("wgpuHasInstanceFeature"));
    try std.testing.expect(set.contains("wgpuSupportedInstanceFeaturesFreeMembers"));
    try std.testing.expect(set.contains("wgpuBufferReadMappedRange"));
    try std.testing.expect(set.contains("wgpuBufferWriteMappedRange"));
}

test "vendored headers annotate nullability" {
    var arena_state = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    var threaded: std.Io.Threaded = .init(std.heap.smp_allocator, .{});
    defer threaded.deinit();
    const io = threaded.io();
    const cwd = Io.Dir.cwd();

    const files = .{
        .{ "vendor/wgpu-native/ffi/webgpu-headers/webgpu.h", "wgpuCreateInstance", @as(usize, 1) },
        .{ "vendor/wgpu-native/ffi/wgpu.h", "wgpuDevicePoll", @as(usize, 3) },
    };
    inline for (files) |file| {
        const data = cwd.readFileAlloc(io, file[0], arena, .limited(32 * 1024 * 1024)) catch |err| switch (err) {
            error.FileNotFound => return error.SkipZigTest,
            else => return err,
        };
        var parsed = try Headers.parse(arena, arena, data);
        defer parsed.deinit(arena);

        const fn_info = parsed.get(file[1]) orelse {
            std.log.err("missing nullability entry for {s}", .{file[1]});
            return error.MissingNullability;
        };
        try std.testing.expectEqual(file[2], fn_info.params.len);
    }

    // Spot-check the annotations the API depends on.
    const webgpu = try cwd.readFileAlloc(io, "vendor/wgpu-native/ffi/webgpu-headers/webgpu.h", arena, .limited(32 * 1024 * 1024));
    var wg = try Headers.parse(arena, arena, webgpu);
    defer wg.deinit(arena);
    try std.testing.expect(wg.get("wgpuCreateInstance").?.params[0]);
    try std.testing.expect(!wg.get("wgpuCreateInstance").?.returns);
    try std.testing.expect(wg.get("wgpuDeviceCreateBuffer").?.returns);
    try std.testing.expect(!wg.get("wgpuDeviceCreateBuffer").?.params[1]);
    try std.testing.expect(wg.get("wgpuDeviceCreateSampler").?.params[1]);

    const native = try cwd.readFileAlloc(io, "vendor/wgpu-native/ffi/wgpu.h", arena, .limited(32 * 1024 * 1024));
    var wn = try Headers.parse(arena, arena, native);
    defer wn.deinit(arena);
    try std.testing.expect(!wn.get("wgpuDevicePoll").?.params[1]);
    try std.testing.expect(wn.get("wgpuDevicePoll").?.params[2]);
    try std.testing.expect(wn.get("wgpuInstanceEnumerateAdapters").?.params[1]);
}
