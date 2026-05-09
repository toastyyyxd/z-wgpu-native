const std = @import("std");
const Ast = std.zig.Ast;
const Io = std.Io;
const Mapping = @import("Mapping.zig");
const MapEnums = @import("MapEnums.zig");
const MapFlags = @import("MapFlags.zig");
const MapStructs = @import("MapStructs.zig");
const MapHandles = @import("MapHandles.zig");
const MapFunctions = @import("MapFunctions.zig");
const MapCallbacks = @import("MapCallbacks.zig");

pub fn main(init: std.process.Init) !void {
    const args = (try init.minimal.args.toSlice(init.arena.allocator()))[1..];
    if (args.len != 2) return error.IncorrectArguments;

    const root_bindings = try openFile(init.io, args[0]);
    const content = try readFileAll(init.gpa, init.io, root_bindings);
    defer init.gpa.free(content);

    var ast = try std.zig.Ast.parse(init.gpa, content, .zig);
    defer ast.deinit(init.gpa);

    const mapping = try Mapping.init(init.gpa, init.arena.allocator(), &ast);
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

    try writeOutput(init.io, init.gpa, mapping, args[1]);
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

fn openOrCreateDir(parent: Io.Dir, io: Io, sub_path: []const u8) !Io.Dir {
    return Io.Dir.openDir(parent, io, sub_path, .{}) catch |err| switch (err) {
        error.NotDir, error.FileNotFound => {
            try Io.Dir.createDir(parent, io, sub_path, .default_dir);
            return Io.Dir.openDir(parent, io, sub_path, .{});
        },
        else => return err,
    };
}

fn writeFile(dir: Io.Dir, io: Io, name: []const u8, content: []const u8) !void {
    const file = try Io.Dir.createFile(dir, io, name, .{});
    try Io.File.writePositionalAll(file, io, content, 0);
    Io.File.close(file, io);
}

// ---------------------------------------------------------------------------
// Name helpers
// ---------------------------------------------------------------------------

fn stripWgpu(name: []const u8) []const u8 {
    if (std.mem.startsWith(u8, name, "WGPU")) return name[4..];
    return name;
}

fn stripWgpuFunc(name: []const u8) []const u8 {
    if (std.mem.startsWith(u8, name, "wgpu")) return name[4..];
    return name;
}

fn lowerFirst(s: []const u8, buf: []u8) []u8 {
    if (s.len == 0) return buf[0..0];
    @memcpy(buf[0..s.len], s);
    if (buf[0] >= 'A' and buf[0] <= 'Z') {
        buf[0] += ('a' - 'A');
    }
    return buf[0..s.len];
}

fn snakeCase(input: []const u8, buf: []u8) []u8 {
    if (input.len == 0) return buf[0..0];
    var out_idx: u32 = 0;
    var prev_lower = false;
    for (input, 0..) |c, i| {
        if (c >= 'A' and c <= 'Z') {
            if (prev_lower or (i > 0 and i + 1 < input.len and input[i + 1] >= 'a' and input[i + 1] <= 'z')) {
                if (out_idx > 0 and out_idx < buf.len and buf[out_idx - 1] != '_') {
                    buf[out_idx] = '_';
                    out_idx += 1;
                }
            }
            if (out_idx < buf.len) {
                buf[out_idx] = @intCast(c + ('a' - 'A'));
                out_idx += 1;
            }
            prev_lower = false;
        } else {
            if (out_idx < buf.len) {
                buf[out_idx] = c;
                out_idx += 1;
            }
            prev_lower = (c >= 'a' and c <= 'z');
        }
    }
    return buf[0..out_idx];
}

fn zigStructName(name: []const u8) []const u8 {
    var n = name;
    if (std.mem.startsWith(u8, n, "struct_")) n = n["struct_".len..];
    if (std.mem.startsWith(u8, n, "WGPU")) n = n["WGPU".len..];
    if (std.mem.endsWith(u8, n, "Impl")) n = n[0 .. n.len - "Impl".len];
    return n;
}

fn zigHandleName(name: []const u8) []const u8 {
    return zigStructName(name);
}

fn zigEnumName(name: []const u8) []const u8 {
    return stripWgpu(name);
}

fn zigFlagsName(name: []const u8) []const u8 {
    return stripWgpu(name);
}

fn zigFieldName(name: []const u8, buf: []u8) []u8 {
    return snakeCase(name, buf);
}

fn zigValueName(name: []const u8, buf: []u8) []u8 {
    const snaked = snakeCase(name, buf);
    if (snaked.len > 0 and snaked[0] >= '0' and snaked[0] <= '9') {
        // Prepend underscore for names starting with digits
        if (buf.len > snaked.len) {
            std.mem.copyBackwards(u8, buf[1..][0..snaked.len], snaked);
            buf[0] = '_';
            return buf[0 .. snaked.len + 1];
        }
    }
    return snaked;
}

fn isZigKeyword(name: []const u8) bool {
    const keywords = [_][]const u8{
        "null",    "error",   "undefined", "true",  "false",
        "void",    "type",    "anytype",   "anyframe",
        "comptime","inline",  "noalias",   "noinline",
        "export",  "extern",  "packed",    "opaque",
        "async",   "await",   "suspend",   "resume",
        "try",     "catch",   "and",       "or",     "orelse",
        "if",      "else",    "switch",    "for",    "while",
        "break",   "continue","return",    "fn",     "pub",
        "const",   "var",     "threadlocal","usingnamespace",
        "defer",   "errdefer","test",      "struct", "enum",   "union",
        "allowzero","volatile","addrspace", "linksection",
        "callconv","align",
    };
    for (keywords) |kw| {
        if (std.mem.eql(u8, name, kw)) return true;
    }
    return false;
}

// ---------------------------------------------------------------------------
// C type → Zig type name mapping
// ---------------------------------------------------------------------------

fn isCallbackType(ctype: []const u8) bool {
    return std.mem.endsWith(u8, ctype, "Callback") or
        std.mem.endsWith(u8, ctype, "Proc") or
        std.mem.endsWith(u8, ctype, "CallbackInfo") or
        std.mem.startsWith(u8, ctype, "WGPUProc");
}

fn isHandleLikeType(ctype: []const u8) bool {
    // Handle types: WGPUAdapter, WGPUBuffer, etc. (opaque pointer types)
    // These are NOT in types.zig, they're in handles.zig or raw C bindings
    const handle_names = [_][]const u8{
        "Adapter", "BindGroup", "BindGroupLayout", "Buffer",
        "CommandBuffer", "CommandEncoder", "ComputePassEncoder",
        "ComputePipeline", "Device", "Instance", "PipelineLayout",
        "QuerySet", "Queue", "RenderBundle", "RenderBundleEncoder",
        "RenderPassEncoder", "RenderPipeline", "Sampler",
        "ShaderModule", "Surface", "Texture", "TextureView",
    };
    const stripped = stripWgpu(ctype);
    for (handle_names) |h| {
        if (std.mem.eql(u8, stripped, h)) return true;
    }
    return false;
}

fn mapTypeName(ctype: []const u8, buf: []u8) []const u8 {
    if (std.mem.startsWith(u8, ctype, "[*c]const ")) {
        const inner = ctype["[*c]const ".len..];
        var inner_buf: [256]u8 = undefined;
        const zig_inner = mapTypeName(inner, &inner_buf);
        return std.fmt.bufPrint(buf, "?*const {s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "[*c]")) {
        const inner = ctype["[*c]".len..];
        var inner_buf: [256]u8 = undefined;
        const zig_inner = mapTypeName(inner, &inner_buf);
        return std.fmt.bufPrint(buf, "?*{s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "?*")) {
        const inner = ctype["?*".len..];
        var inner_buf: [256]u8 = undefined;
        const zig_inner = mapTypeName(inner, &inner_buf);
        return std.fmt.bufPrint(buf, "?*{s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.eql(u8, ctype, "WGPUBool")) return "bool";
    if (std.mem.eql(u8, ctype, "WGPUStringView")) return "[:0]const u8";
    if (std.mem.eql(u8, ctype, "WGPUFlags")) return "u64";
    if (std.mem.eql(u8, ctype, "void")) return "void";
    if (std.mem.startsWith(u8, ctype, "WGPU")) {
        if (isCallbackType(ctype) or isHandleLikeType(ctype)) {
            return std.fmt.bufPrint(buf, "c.{s}", .{ctype}) catch unreachable;
        }
        return stripWgpu(ctype);
    }
    if (std.mem.startsWith(u8, ctype, "struct_")) return zigStructName(ctype);
    return ctype;
}

/// Map a C type to its raw C reference (from c_wgpu_native module)
fn mapCTypeRef(ctype: []const u8, buf: []u8) []const u8 {
    if (std.mem.startsWith(u8, ctype, "[*c]const ")) {
        const inner = ctype["[*c]const ".len..];
        var inner_buf: [256]u8 = undefined;
        const zig_inner = mapCTypeRef(inner, &inner_buf);
        return std.fmt.bufPrint(buf, "?*const {s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "[*c]")) {
        const inner = ctype["[*c]".len..];
        var inner_buf: [256]u8 = undefined;
        const zig_inner = mapCTypeRef(inner, &inner_buf);
        return std.fmt.bufPrint(buf, "?*{s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "?*")) {
        const inner = ctype["?*".len..];
        var inner_buf: [256]u8 = undefined;
        const zig_inner = mapCTypeRef(inner, &inner_buf);
        return std.fmt.bufPrint(buf, "?*{s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.eql(u8, ctype, "WGPUBool")) return "bool";
    if (std.mem.eql(u8, ctype, "WGPUStringView")) return "c.WGPUStringView";
    if (std.mem.eql(u8, ctype, "WGPUFlags")) return "u64";
    if (std.mem.eql(u8, ctype, "void")) return "void";
    if (std.mem.eql(u8, ctype, "WGPUStatus")) return "!void";
    if (std.mem.eql(u8, ctype, "WGPUFuture")) return "c.WGPUFuture";
    if (std.mem.startsWith(u8, ctype, "WGPU") or std.mem.startsWith(u8, ctype, "struct_")) {
        return std.fmt.bufPrint(buf, "c.{s}", .{ctype}) catch unreachable;
    }
    return ctype;
}

fn mapRetTypeName(ctype: []const u8, buf: []u8) []const u8 {
    if (std.mem.eql(u8, ctype, "WGPUStatus")) return "!void";
    if (std.mem.startsWith(u8, ctype, "[*c]const ")) {
        const inner = ctype["[*c]const ".len..];
        var inner_buf: [256]u8 = undefined;
        const zig_inner = mapTypeName(inner, &inner_buf);
        return std.fmt.bufPrint(buf, "?*const {s}", .{zig_inner}) catch unreachable;
    }
    return mapTypeName(ctype, buf);
}

// ---------------------------------------------------------------------------
// Output generation
// ---------------------------------------------------------------------------

fn writeOutput(io: Io, gpa: std.mem.Allocator, mapping: *Mapping, out_path: []const u8) !void {
    const cwd = Io.Dir.cwd();
    const src_dir = try openOrCreateDir(cwd, io, out_path);
    defer Io.Dir.close(src_dir, io);

    var buf: std.array_list.Managed(u8) = .init(gpa);
    defer buf.deinit();

    try writeTypes(&buf, mapping);
    try writeFile(src_dir, io, "types.zig", buf.items);
    buf.clearRetainingCapacity();

    try writeHandlesAndFuncs(&buf, mapping);
    try writeFile(src_dir, io, "handles.zig", buf.items);
    buf.clearRetainingCapacity();

    try writeCallbacks(&buf, mapping);
    try writeFile(src_dir, io, "callbacks.zig", buf.items);
    buf.clearRetainingCapacity();

    try writeRoot(&buf);
    try writeFile(src_dir, io, "root.zig", buf.items);
}

// ---------------------------------------------------------------------------
// Types output
// ---------------------------------------------------------------------------

fn writeTypes(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    try buf.appendSlice("const c = @import(\"c_wgpu_native\");\nconst std = @import(\"std\");\nconst types = @This();\n\n");
    try writeEnums(buf, mapping);
    try writeFlags(buf, mapping);
    try writeStructs(buf, mapping);
}

fn writeEnums(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    var enum_iter = mapping.enum_decls.iterator();
    while (enum_iter.next()) |entry| {
        const cname = entry.key_ptr.*;
        const decl = entry.value_ptr.*;
        if (decl.values.count() == 0) continue;

        const zname = zigEnumName(cname);

        var val_iter = decl.values.iterator();
        // Skip enums with only Force32 (shouldn't happen, but safety)
        var has_real: bool = false;
        while (val_iter.next()) |val| {
            if (!std.mem.eql(u8, val.key_ptr.*, "Force32")) has_real = true;
        }
        if (!has_real) continue;

        try buf.print("pub const {s} = enum(c_uint) {{\n", .{zname});

        // Collect values for sorting
        var sorted_vals: std.ArrayListUnmanaged(struct { name: []const u8, value: i64 }) = .empty;
        defer sorted_vals.deinit(mapping.gpa);

        val_iter = decl.values.iterator();
        while (val_iter.next()) |val| {
            const field_decl = val.value_ptr.*;
            const init_slice = mapping.ast.getNodeSource(field_decl.init.unwrap().?);
            const int_val = std.fmt.parseInt(i64, init_slice, 10) catch continue;
            try sorted_vals.append(mapping.gpa, .{ .name = val.key_ptr.*, .value = int_val });
        }

        std.sort.insertion(
            @TypeOf(sorted_vals.items[0]),
            sorted_vals.items,
            {},
            struct {
                fn lessThan(_: void, a: @TypeOf(sorted_vals.items[0]), b: @TypeOf(sorted_vals.items[0])) bool {
                    return a.value < b.value;
                }
            }.lessThan,
        );

        for (sorted_vals.items) |sv| {
            var name_buf: [128]u8 = undefined;
            const vname = zigValueName(sv.name, &name_buf);
            if (isZigKeyword(vname)) {
                try buf.print("    @\"{s}\" = {d},\n", .{ vname, sv.value });
            } else {
                try buf.print("    {s} = {d},\n", .{ vname, sv.value });
            }
        }

        try buf.appendSlice("};\n\n");
    }
}

fn writeFlags(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    var flag_iter = mapping.flag_decls.iterator();
    while (flag_iter.next()) |entry| {
        const cname = entry.key_ptr.*;
        const decl = entry.value_ptr.*;
        if (decl.values.count() == 0) continue;

        const zname = zigFlagsName(cname);

        // Collect sorted values
        const SortedVal = struct { name: []const u8, bit: u8 };
        var sorted_vals: std.ArrayListUnmanaged(SortedVal) = .empty;
        defer sorted_vals.deinit(mapping.gpa);

        var val_iter = decl.values.iterator();
        while (val_iter.next()) |val| {
            const field_decl = val.value_ptr.*;
            const init_text = mapping.ast.getNodeSource(field_decl.init.unwrap().?);
            const bit_pos = parseFlagBit(init_text);
            try sorted_vals.append(mapping.gpa, .{ .name = val.key_ptr.*, .bit = bit_pos });
        }

        // Sort by bit position
        std.sort.insertion(SortedVal, sorted_vals.items, {}, struct {
            fn lt(_: void, a: SortedVal, b: SortedVal) bool { return a.bit < b.bit; }
        }.lt);

        // Force32 sentinel → u32 backing
        const backing = if (decl.has_force32) "u32" else "u64";
        const backing_bits: u8 = if (decl.has_force32) 32 else 64;
        var max_bit: u8 = 0;
        for (sorted_vals.items) |sv| {
            if (sv.bit > max_bit) max_bit = sv.bit;
        }
        const pad_bits = backing_bits - max_bit - 1;

        try buf.print("pub const {s} = packed struct({s}) {{\n", .{ zname, backing });

        for (sorted_vals.items) |sv| {
            var name_buf: [128]u8 = undefined;
            const vname = zigValueName(sv.name, &name_buf);
            if (isZigKeyword(vname)) {
                try buf.print("    @\"{s}\": bool = false,\n", .{vname});
            } else {
                try buf.print("    {s}: bool = false,\n", .{vname});
            }
        }

        try buf.print("    _: u{d} = 0,\n", .{pad_bits});
        try buf.print(
            \\    comptime {{ std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf({s})); }}
            \\
        , .{backing});
        try buf.appendSlice("};\n\n");

        // Composite/preset flag constants (sorted by name)
        if (decl.composites.count() > 0) {
            const SortedComp = struct { name: []const u8, init_text: []const u8 };
            var sorted_comps: std.ArrayListUnmanaged(SortedComp) = .empty;
            defer sorted_comps.deinit(mapping.gpa);

            var comp_iter = decl.composites.iterator();
            while (comp_iter.next()) |comp| {
                const field_decl = comp.value_ptr.*;
                const init_text = mapping.ast.getNodeSource(field_decl.init.unwrap().?);
                try sorted_comps.append(mapping.gpa, .{ .name = comp.key_ptr.*, .init_text = init_text });
            }

            std.sort.insertion(SortedComp, sorted_comps.items, {}, struct {
                fn lt(_: void, a: SortedComp, b: SortedComp) bool {
                    return std.ascii.orderIgnoreCase(a.name, b.name) == .lt;
                }
            }.lt);

            for (sorted_comps.items) |comp| {
                var name_buf: [128]u8 = undefined;
                const vname = zigValueName(comp.name, &name_buf);
                try buf.print("pub const {s}_{s}: {s} = {s};\n", .{ zname, vname, zname, comp.init_text });
            }
            try buf.appendSlice("\n");
        }
    }
}

fn isSimpleInt(s: []const u8) bool {
    for (s) |c| {
        if (c < '0' or c > '9') return false;
    }
    return s.len > 0;
}

fn parseFlagBit(init_text: []const u8) u8 {
    if (std.mem.startsWith(u8, init_text, "@bitCast")) {
        if (std.mem.lastIndexOfScalar(u8, init_text, '(')) |p| {
            // Extract N from ...@intCast(N)))]
            const after = init_text[p + 1 ..];
            const end = std.mem.indexOfScalar(u8, after, ')') orelse return 0;
            return std.fmt.parseInt(u8, after[0..end], 10) catch 0;
        }
        return 0;
    }
    if (isSimpleInt(init_text)) {
        const v = std.fmt.parseInt(u64, init_text, 10) catch return 0;
        if (v == 0) return 0;
        return @intCast(@ctz(v));
    }
    return 0;
}

fn writeStructs(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    for (mapping.struct_names.items) |sname| {
        const decl = mapping.struct_decls.get(sname) orelse continue;
        if (decl.fields.items.len == 0) continue;

        const zname = zigStructName(sname);

        try buf.print("pub const {s} = extern struct {{\n", .{zname});

        for (decl.fields.items) |f| {
            var type_buf: [256]u8 = undefined;
            var name_buf: [128]u8 = undefined;
            const fname = zigFieldName(f.name, &name_buf);
            const type_slice = mapping.ast.getNodeSource(f.type);
            const ztype = mapTypeName(type_slice, &type_buf);

            if (f.init != .none) {
                const init_slice = mapping.ast.getNodeSource(f.init.unwrap().?);
                const zinit = mapFieldInit(type_slice, init_slice);
                try buf.print("    {s}: {s} = {s},\n", .{ fname, ztype, zinit });
            } else {
                try buf.print("    {s}: {s},\n", .{ fname, ztype });
            }
        }

        // Inject StringView helpers inside the struct body
        if (std.mem.eql(u8, zname, "StringView")) {
            try buf.appendSlice(
                \\
                \\    pub fn toSlice(sv: StringView) [:0]const u8 {
                \\        return sv.data[0..sv.length :0];
                \\    }
                \\
                \\    pub fn fromSlice(slice: [:0]const u8) StringView {
                \\        return .{ .data = slice.ptr, .length = slice.len };
                \\    }
                \\
            );
        }

        try buf.appendSlice("};\n\n");

        // Inject ChainedStruct iterator (only once for ChainedStruct, not ChainedStructOut)
        if (std.mem.eql(u8, zname, "ChainedStruct")) {
            try buf.appendSlice(
                \\pub const ChainedIterator = struct {
                \\    current: ?*const ChainedStruct,
                \\
                \\    pub fn next(self: *ChainedIterator) ?*const ChainedStruct {
                \\        const cur = self.current orelse return null;
                \\        self.current = cur.next;
                \\        return cur;
                \\    }
                \\};
                \\
                \\pub fn chainedIterator(first: ?*const ChainedStruct) ChainedIterator {
                \\    return .{ .current = first };
                \\}
                \\
            );
        }
    }
}

fn mapFieldInit(ctype: []const u8, cinit: []const u8) []const u8 {
    if (std.mem.eql(u8, ctype, "WGPUBool") and std.mem.eql(u8, cinit, "0")) return "false";
    if (std.mem.eql(u8, ctype, "WGPUStringView") and std.mem.startsWith(u8, cinit, "@import")) return "\"\"";
    if (std.mem.eql(u8, cinit, "null")) return "null";
    if (std.mem.startsWith(u8, cinit, "@import")) return ".{}";
    return cinit;
}

// ---------------------------------------------------------------------------
// Handles + Functions output (combined)
// ---------------------------------------------------------------------------

fn writeHandlesAndFuncs(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    try buf.appendSlice("const c = @import(\"c_wgpu_native\");\nconst types = @import(\"types.zig\");\n\n");

    // Build a map: handle zig name → list of function names
    var handle_funcs = std.StringHashMapUnmanaged(std.ArrayListUnmanaged([]const u8)){};
    defer {
        var it = handle_funcs.iterator();
        while (it.next()) |e| e.value_ptr.*.deinit(mapping.gpa);
        handle_funcs.deinit(mapping.gpa);
    }

    var standalone_funcs: std.ArrayListUnmanaged([]const u8) = .empty;
    defer standalone_funcs.deinit(mapping.gpa);

    var fn_iter = mapping.fn_decls.iterator();
    while (fn_iter.next()) |fn_entry| {
        const fn_decl = fn_entry.value_ptr.*;
        const fn_name = fn_entry.key_ptr.*;

        // Classify: if first param is a handle, it's a method
        const is_method = if (fn_decl.params.items.len > 0) blk: {
            break :blk fn_decl.params.items[0].kind == .handle;
        } else false;

        if (is_method) {
            const first_param = fn_decl.params.items[0];
            const type_slice = mapping.ast.getNodeSource(first_param.type);
            const hzname = typeSliceToHandleName(type_slice);

            const gop = try handle_funcs.getOrPut(mapping.gpa, hzname);
            if (!gop.found_existing) {
                gop.value_ptr.* = .empty;
            }
            try gop.value_ptr.*.append(mapping.gpa, fn_name);
        } else {
            try standalone_funcs.append(mapping.gpa, fn_name);
        }
    }

    // Write handles with methods (in declaration order via premap)
    for (mapping.handle_names.items) |hname| {
        _ = mapping.handle_decls.get(hname) orelse continue;
        const hzname = zigHandleName(hname);

        try buf.print("pub const {s} = struct {{\n", .{hzname});
        try buf.appendSlice("    ptr: *anyopaque,\n\n");

        // Write init from raw ptr
        try buf.print("    pub fn fromPtr(ptr: *anyopaque) {s} {{\n", .{hzname});
        try buf.print("        return .{{ .ptr = ptr }};\n", .{});
        try buf.appendSlice("    }\n\n");

        // Write methods
        if (handle_funcs.getPtr(hzname)) |funcs_ptr| {
            for (funcs_ptr.*.items) |fn_name| {
                const fn_decl = mapping.fn_decls.get(fn_name) orelse continue;
                if (fn_decl.params.items.len == 0) continue;
                try writeHandleMethod(buf, mapping, fn_decl, hzname);
            }
        }

        try buf.appendSlice("};\n\n");
    }

    // Write standalone functions
    for (standalone_funcs.items) |fn_name| {
        const fn_decl = mapping.fn_decls.get(fn_name) orelse continue;
        try writeStandaloneFunc(buf, mapping, fn_decl);
    }

    // Future/waitAny helper
    try buf.appendSlice(
        \\/// Wait for one or more futures to complete.
        \\/// Returns the number of completed futures, or an error on timeout.
        \\pub fn waitAny(instance: Instance, futures: []c.WGPUFutureWaitInfo, timeout_ns: u64) !usize {
        \\    const status = c.wgpuInstanceWaitAny(@ptrCast(instance.ptr), futures.len, futures.ptr, timeout_ns);
        \\    if (status == c.WGPUWaitStatus_Success) return futures.len;
        \\    if (status == c.WGPUWaitStatus_TimedOut) return error.Timeout;
        \\    return error.Unexpected;
        \\}
        \\
    );
}

fn typeSliceToHandleName(type_slice: []const u8) []const u8 {
    var s = type_slice;
    if (std.mem.startsWith(u8, s, "?*")) s = s[2..];
    if (std.mem.startsWith(u8, s, "struct_")) s = s["struct_".len..];
    if (std.mem.startsWith(u8, s, "WGPU")) s = s["WGPU".len..];
    if (std.mem.endsWith(u8, s, "Impl")) s = s[0 .. s.len - "Impl".len];
    return s;
}

fn stripCPtrPrefix(ctype: []const u8) []const u8 {
    if (std.mem.startsWith(u8, ctype, "[*c]const ")) return ctype["[*c]const ".len..];
    if (std.mem.startsWith(u8, ctype, "[*c]")) return ctype["[*c]".len..];
    return ctype;
}

fn writeHandleMethod(buf: *std.array_list.Managed(u8), mapping: *Mapping, fn_decl: *Mapping.FnDecl, hzname: []const u8) !void {
    var name_buf: [128]u8 = undefined;
    const after_wgpu = stripWgpuFunc(fn_decl.name);
    const method = if (std.mem.startsWith(u8, after_wgpu, hzname))
        after_wgpu[hzname.len..]
    else
        after_wgpu;
    const zname = lowerFirst(method, &name_buf);

    // Skip C refcounting methods — not for public API
    if (std.mem.eql(u8, zname, "addRef") or std.mem.eql(u8, zname, "release")) return;

    var ret_buf: [256]u8 = undefined;
    const ret_slice = if (fn_decl.return_type.unwrap()) |rt|
        mapping.ast.getNodeSource(rt)
    else
        "void";
    const ret_type = mapCTypeRef(ret_slice, &ret_buf);
    const returns_void = std.mem.eql(u8, ret_type, "void");
    const returns_status = std.mem.eql(u8, ret_slice, "WGPUStatus");

    // When WGPUStatus with out-param, return !OutType instead of !void
    var actual_ret_type: []const u8 = ret_type;
    var actual_ret_buf: [256]u8 = undefined;
    const has_out_param = returns_status and fn_decl.params.items.len > 1;
    if (has_out_param) {
        const out_param = fn_decl.params.items[1];
        const otype = mapping.ast.getNodeSource(out_param.type);
        var inner_buf: [256]u8 = undefined;
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "!{s}", .{mapCTypeRef(stripCPtrPrefix(otype), &inner_buf)}) catch unreachable;
    }

    // Write signature
    try buf.print("    pub fn {s}(self: {s}", .{ zname, hzname });
    const sig_start = if (has_out_param) @as(usize, 2) else @as(usize, 1);
    for (fn_decl.params.items[sig_start..]) |*param| {
        var pb: [256]u8 = undefined;
        const ptype = mapping.ast.getNodeSource(param.type);
        const zt = mapCTypeRef(ptype, &pb);
        try buf.print(", {s}: {s}", .{ param.name, zt });
    }
    try buf.print(") {s} {{\n", .{actual_ret_type});

    // Generate body
    if (has_out_param) {
        // Status return with out-param: allocate out struct, check status
        const out_param = fn_decl.params.items[1];
        var ob: [256]u8 = undefined;
        const otype = mapping.ast.getNodeSource(out_param.type);
        const zot = mapCTypeRef(stripCPtrPrefix(otype), &ob);
        try buf.print("        var result: {s} = undefined;\n", .{zot});
        try buf.print("        const status = c.{s}(@ptrCast(self.ptr), &result", .{fn_decl.name});
        for (fn_decl.params.items[2..]) |*param| {
            try buf.print(", {s}", .{param.name});
        }
        try buf.appendSlice(");\n");
        try buf.appendSlice("        if (status != 1) return error.Unexpected;\n");
        try buf.appendSlice("        return result;\n");
    } else if (returns_status) {
        // Status return, no out param
        try buf.print("        const status = c.{s}(@ptrCast(self.ptr)", .{fn_decl.name});
        for (fn_decl.params.items[1..]) |*param| {
            try buf.print(", {s}", .{param.name});
        }
        try buf.appendSlice(");\n");
        try buf.appendSlice("        if (status != 1) return error.Unexpected;\n");
    } else if (returns_void) {
        try buf.print("        c.{s}(@ptrCast(self.ptr)", .{fn_decl.name});
        for (fn_decl.params.items[1..]) |*param| {
            try buf.print(", {s}", .{param.name});
        }
        try buf.appendSlice(");\n");
    } else {
        const is_handle_ret = fn_decl.return_kind == .handle;
        if (is_handle_ret) {
            try buf.print("        const result = c.{s}(@ptrCast(self.ptr)", .{fn_decl.name});
            for (fn_decl.params.items[1..]) |*param| {
                try buf.print(", {s}", .{param.name});
            }
            try buf.appendSlice(");\n");
            try buf.appendSlice("        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };\n");
        } else {
            try buf.print("        return c.{s}(@ptrCast(self.ptr)", .{fn_decl.name});
            for (fn_decl.params.items[1..]) |*param| {
                try buf.print(", {s}", .{param.name});
            }
            try buf.appendSlice(");\n");
        }
    }

    try buf.appendSlice("    }\n\n");
}

fn writeStandaloneFunc(buf: *std.array_list.Managed(u8), mapping: *Mapping, fn_decl: *Mapping.FnDecl) !void {
    var name_buf: [128]u8 = undefined;
    const zname = lowerFirst(stripWgpuFunc(fn_decl.name), &name_buf);

    var ret_buf: [256]u8 = undefined;
    const ret_slice = if (fn_decl.return_type.unwrap()) |rt|
        mapping.ast.getNodeSource(rt)
    else
        "void";
    const ret_type = mapCTypeRef(ret_slice, &ret_buf);
    const returns_void = std.mem.eql(u8, ret_type, "void");
    const returns_status = std.mem.eql(u8, ret_slice, "WGPUStatus");
    const is_handle_ret = fn_decl.return_kind == .handle;

    // When WGPUStatus with out-param, return !OutType instead of !void
    var actual_ret_type: []const u8 = ret_type;
    var actual_ret_buf: [256]u8 = undefined;
    const has_out_param = returns_status and fn_decl.params.items.len > 0;
    if (has_out_param) {
        const first_param = fn_decl.params.items[0];
        const otype = mapping.ast.getNodeSource(first_param.type);
        var inner_buf: [256]u8 = undefined;
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "!{s}", .{mapCTypeRef(stripCPtrPrefix(otype), &inner_buf)}) catch unreachable;
    }

    // When returning a handle, use the handle type name directly (defined in same file)
    if (is_handle_ret) {
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}", .{typeSliceToHandleName(ret_slice)}) catch unreachable;
    }

    try buf.print("pub fn {s}(", .{zname});
    const sig_start: usize = if (has_out_param) 1 else 0;
    for (fn_decl.params.items[sig_start..], 0..) |*param, i| {
        if (i > 0) try buf.appendSlice(", ");
        var pb: [256]u8 = undefined;
        const ptype = mapping.ast.getNodeSource(param.type);
        const zt = mapCTypeRef(ptype, &pb);
        try buf.print("{s}: {s}", .{ param.name, zt });
    }
    try buf.print(") {s} {{\n", .{actual_ret_type});

    if (has_out_param) {
        const first_param = fn_decl.params.items[0];
        var ob: [256]u8 = undefined;
        const otype = mapping.ast.getNodeSource(first_param.type);
        const zot = mapCTypeRef(stripCPtrPrefix(otype), &ob);
        try buf.print("        var result: {s} = undefined;\n", .{zot});
        try buf.print("        const status = c.{s}(&result", .{fn_decl.name});
        for (fn_decl.params.items[1..]) |*param| {
            try buf.print(", {s}", .{param.name});
        }
        try buf.appendSlice(");\n");
        try buf.appendSlice("        if (status != 1) return error.Unexpected;\n");
        try buf.appendSlice("        return result;\n");
    } else if (returns_status) {
        try buf.print("        const status = c.{s}()", .{fn_decl.name});
        try buf.appendSlice(";\n");
        try buf.appendSlice("        if (status != 1) return error.Unexpected;\n");
    } else if (returns_void) {
        try buf.print("        c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try buf.print("{s}", .{param.name});
        }
        try buf.appendSlice(");\n");
    } else if (is_handle_ret) {
        try buf.print("        const result = c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try buf.print("{s}", .{param.name});
        }
        try buf.appendSlice(");\n");
        try buf.appendSlice("        return .{ .ptr = @ptrCast(result orelse return error.Unexpected) };\n");
    } else {
        try buf.print("        return c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try buf.print("{s}", .{param.name});
        }
        try buf.appendSlice(");\n");
    }

    try buf.appendSlice("}\n\n");
}

// ---------------------------------------------------------------------------
// Callbacks output
// ---------------------------------------------------------------------------

fn writeCallbacks(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    if (mapping.callback_decls.count() == 0) return;

    try buf.appendSlice("const std = @import(\"std\");\nconst c = @import(\"c_wgpu_native\");\nconst types = @import(\"types.zig\");\nconst handles = @import(\"handles.zig\");\n\n");

    var cb_iter = mapping.callback_decls.iterator();
    while (cb_iter.next()) |entry| {
        const cb_decl = entry.value_ptr.*;
        try writeCallbackTrampoline(buf, mapping, cb_decl);
    }
}

fn writeCallbackTrampoline(buf: *std.array_list.Managed(u8), mapping: *Mapping, cb_decl: *Mapping.CallbackDecl) !void {
    _ = mapping;

    var name_buf: [256]u8 = undefined;
    const zname = lowerFirst(stripWgpu(cb_decl.name), &name_buf);

    var ctx_count: u32 = 0;
    for (cb_decl.params.items) |*p| {
        if (p.is_userdata) ctx_count += 1;
    }

    // Signature: pub fn fooCallback(comptime C1: type, ctx1: *C1, comptime cb: fn(*C1, ...) void) CallbackInfo
    try buf.print("pub fn {s}(", .{zname});
    for (0..ctx_count) |i| {
        try buf.print("comptime C{d}: type, ", .{i + 1});
    }
    for (0..ctx_count) |i| {
        try buf.print("ctx{d}: *C{d}, ", .{ i + 1, i + 1 });
    }
    try buf.appendSlice("comptime cb: fn (");

    // Comptime cb params: context types + converted non-ud types
    for (0..ctx_count) |i| {
        try buf.print("*C{d}, ", .{i + 1});
    }
    var prev_non_ud = false;
    for (cb_decl.params.items) |*p| {
        if (p.is_userdata) continue;
        if (prev_non_ud) try buf.appendSlice(", ");
        var inner_buf: [256]u8 = undefined;
        try buf.print("{s}", .{mapCallbackZigType(p.type, &inner_buf)});
        prev_non_ud = true;
    }
    try buf.appendSlice(") void,\n");

    // Return type
    try buf.print(") c.{s}Info {{\n", .{cb_decl.name});

    // Trampoline
    try buf.appendSlice("    const Trampoline = struct {\n");
    try buf.appendSlice("        fn call(");
    for (cb_decl.params.items, 0..) |*p, j| {
        if (j > 0) try buf.appendSlice(", ");
        var tbuf: [256]u8 = undefined;
        try buf.print("{s}: {s}", .{ p.name, mapCTypeRef(p.type, &tbuf) });
    }
    try buf.appendSlice(") callconv(.c) void {\n");

    // Cast userdata
    var ud_i: u32 = 0;
    for (cb_decl.params.items) |*p| {
        if (p.is_userdata) {
            try buf.print("            const c{d}: *C{d} = @ptrCast(@alignCast({s}));\n", .{ ud_i + 1, ud_i + 1, p.name });
            ud_i += 1;
        }
    }

    // Call user callback
    try buf.appendSlice("            cb(");
    for (0..ctx_count) |i| {
        try buf.print("c{d}, ", .{i + 1});
    }
    prev_non_ud = false;
    for (cb_decl.params.items) |*p| {
        if (p.is_userdata) continue;
        if (prev_non_ud) try buf.appendSlice(", ");
        var expr_buf: [256]u8 = undefined;
        try buf.appendSlice(mapCbExpr(p, &expr_buf));
        prev_non_ud = true;
    }
    try buf.appendSlice(");\n");

    try buf.appendSlice("        }\n");
    try buf.appendSlice("    };\n\n");

    // Return CallbackInfo struct: callback = trampoline, userdata = context pointers
    try buf.appendSlice("    return .{\n");
    try buf.appendSlice("        .callback = &Trampoline.call,\n");
    for (0..ctx_count) |i| {
        var ud_j: u32 = 0;
        for (cb_decl.params.items) |*p| {
            if (p.is_userdata) {
                if (ud_j == i) {
                    try buf.print("        .{s} = @ptrCast(ctx{d}),\n", .{ p.name, i + 1 });
                }
                ud_j += 1;
            }
        }
    }
    try buf.appendSlice("    };\n");
    try buf.appendSlice("}\n\n");
}

fn mapCallbackZigType(ctype: []const u8, buf: []u8) []const u8 {
    if (std.mem.eql(u8, ctype, "WGPUStringView")) return "[:0]const u8";
    if (std.mem.startsWith(u8, ctype, "WGPU") and std.mem.endsWith(u8, ctype, "Status")) {
        return std.fmt.bufPrint(buf, "types.{s}", .{stripWgpu(ctype)}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "WGPU")) {
        return std.fmt.bufPrint(buf, "c.{s}", .{ctype}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "struct_")) {
        return std.fmt.bufPrint(buf, "c.{s}", .{ctype}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "[*c]const ")) {
        const inner = ctype["[*c]const ".len..];
        var inner_buf: [128]u8 = undefined;
        const zig_inner = mapCallbackZigType(inner, &inner_buf);
        return std.fmt.bufPrint(buf, "?*const {s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "[*c]")) {
        const inner = ctype["[*c]".len..];
        var inner_buf: [128]u8 = undefined;
        const zig_inner = mapCallbackZigType(inner, &inner_buf);
        return std.fmt.bufPrint(buf, "?*{s}", .{zig_inner}) catch unreachable;
    }
    return ctype;
}

fn mapCbExpr(param: *Mapping.CallbackParam, buf: []u8) []const u8 {
    if (std.mem.eql(u8, param.type, "WGPUStringView")) {
        return std.fmt.bufPrint(buf, "{s}.data[0..{s}.length :0]", .{ param.name, param.name }) catch unreachable;
    }
    if (std.mem.startsWith(u8, param.type, "WGPU") and std.mem.endsWith(u8, param.type, "Status")) {
        return std.fmt.bufPrint(buf, "@enumFromInt({s})", .{param.name}) catch unreachable;
    }
    return param.name;
}

// ---------------------------------------------------------------------------
// Root output
// ---------------------------------------------------------------------------

fn writeRoot(buf: *std.array_list.Managed(u8)) !void {
    try buf.appendSlice(
        \\pub const types = @import("types.zig");
        \\pub const handles = @import("handles.zig");
        \\pub const callbacks = @import("callbacks.zig");
        \\pub const c = @import("c_wgpu_native");
        \\
    );
}
