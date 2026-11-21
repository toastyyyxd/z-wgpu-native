const std = @import("std");
const Mapping = @import("Mapping.zig");

// ---------------------------------------------------------------------------
// Name helpers
// ---------------------------------------------------------------------------

pub fn stripWgpu(name: []const u8) []const u8 {
    if (std.mem.startsWith(u8, name, "WGPU")) return name[4..];
    return name;
}

pub fn stripWgpuFunc(name: []const u8) []const u8 {
    if (std.mem.startsWith(u8, name, "wgpu")) return name[4..];
    return name;
}

pub fn lowerFirst(s: []const u8, buf: []u8) []u8 {
    if (s.len == 0) return buf[0..0];
    @memcpy(buf[0..s.len], s);
    if (buf[0] >= 'A' and buf[0] <= 'Z') {
        buf[0] += ('a' - 'A');
    }
    return buf[0..s.len];
}

pub fn snakeCase(input: []const u8, buf: []u8) []u8 {
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

pub fn upperFirst(s: []const u8, buf: []u8) []u8 {
    if (s.len == 0) return buf[0..0];
    @memcpy(buf[0..s.len], s);
    buf[0] = std.ascii.toUpper(buf[0]);
    return buf[0..s.len];
}

pub fn zigStructName(name: []const u8) []const u8 {
    var n = name;
    if (std.mem.startsWith(u8, n, "struct_")) n = n["struct_".len..];
    if (std.mem.startsWith(u8, n, "WGPU")) n = n["WGPU".len..];
    if (std.mem.endsWith(u8, n, "Impl")) n = n[0 .. n.len - "Impl".len];
    return n;
}

pub fn zigUnionName(name: []const u8) []const u8 {
    var n = name;
    if (std.mem.startsWith(u8, n, "union_")) n = n["union_".len..];
    return n;
}

pub fn zigHandleName(name: []const u8) []const u8 {
    return zigStructName(name);
}

pub fn zigEnumName(name: []const u8) []const u8 {
    return stripWgpu(name);
}

pub fn zigFlagsName(name: []const u8) []const u8 {
    return stripWgpu(name);
}

pub fn zigFieldName(name: []const u8, buf: []u8) []u8 {
    return snakeCase(name, buf);
}

pub fn zigValueName(name: []const u8, buf: []u8) []u8 {
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

pub fn isZigKeyword(name: []const u8) bool {
    const keywords = [_][]const u8{
        "null",    "error",   "undefined", "true",  "false",
        "void",    "type",    "anytype",   "anyframe",
        "comptime","inline",  "noalias",   "noinline",
        "export",  "extern",  "packed",    "opaque",  "bitpack",
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

pub fn escapeName(name: []const u8, buf: []u8) ![]u8 {
    if (isZigKeyword(name)) return try std.fmt.bufPrint(buf, "@\"{s}\"", .{ name });
    @memcpy(buf[0..name.len], name);
    return buf[0..name.len];
}

pub fn parseIntValue(s: []const u8) ?u64 {
    if (std.mem.startsWith(u8, s, "0x") or std.mem.startsWith(u8, s, "0X")) {
        if (s.len > 2) return std.fmt.parseInt(u64, s[2..], 16) catch null;
        return null;
    }
    if (std.mem.startsWith(u8, s, "0b") or std.mem.startsWith(u8, s, "0B")) {
        if (s.len > 2) return std.fmt.parseInt(u64, s[2..], 2) catch null;
        return null;
    }
    if (std.mem.startsWith(u8, s, "0o") or std.mem.startsWith(u8, s, "0O")) {
        if (s.len > 2) return std.fmt.parseInt(u64, s[2..], 8) catch null;
        return null;
    }
    if (s.len > 0 and s[0] >= '0' and s[0] <= '9') {
        return std.fmt.parseInt(u64, s, 10) catch null;
    }
    return null;
}

// ---------------------------------------------------------------------------
// C type -> Zig type name mapping
// ---------------------------------------------------------------------------

pub fn isCallbackType(ctype: []const u8) bool {
    // CallbackInfo types are structs, so only function-pointer typedefs stay in c.*.
    return std.mem.endsWith(u8, ctype, "Callback") or
        std.mem.endsWith(u8, ctype, "Proc") or
        std.mem.startsWith(u8, ctype, "WGPUProc");
}

pub fn isHandleLikeType(ctype: []const u8, mapping: *Mapping) bool {
    if (!std.mem.startsWith(u8, ctype, "WGPU")) return false;
    const stripped = stripWgpu(ctype);
    var buf: [256]u8 = undefined;
    const impl = std.fmt.bufPrint(&buf, "WGPU{s}Impl", .{stripped}) catch return false;
    return mapping.handle_decls.contains(impl);
}

pub fn mapTypeName(ctype: []const u8, buf: []u8, mapping: *Mapping) []const u8 {
    if (std.mem.startsWith(u8, ctype, "[*c]const ")) {
        const inner = ctype["[*c]const ".len..];
        var inner_buf: [256]u8 = undefined;
        const zig_inner = mapTypeName(inner, &inner_buf, mapping);
        if (isHandleLikeType(inner, mapping)) {
            return std.fmt.bufPrint(buf, "[*c]const {s}", .{zig_inner}) catch unreachable;
        }
        return std.fmt.bufPrint(buf, "[*c]const {s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "[*c]")) {
        const inner = ctype["[*c]".len..];
        var inner_buf: [256]u8 = undefined;
        const zig_inner = mapTypeName(inner, &inner_buf, mapping);
        if (isHandleLikeType(inner, mapping)) {
            return std.fmt.bufPrint(buf, "[*c]{s}", .{zig_inner}) catch unreachable;
        }
        return std.fmt.bufPrint(buf, "[*c]{s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "?*")) {
        const inner = ctype["?*".len..];
        var inner_buf: [256]u8 = undefined;
        const zig_inner = mapTypeName(inner, &inner_buf, mapping);
        return std.fmt.bufPrint(buf, "?*{s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.eql(u8, ctype, "WGPUBool")) return "u32";
    if (std.mem.eql(u8, ctype, "WGPUFlags")) return "u64";
    if (std.mem.eql(u8, ctype, "void")) return "void";
    if (std.mem.startsWith(u8, ctype, "WGPU")) {
        if (isCallbackType(ctype)) {
            return std.fmt.bufPrint(buf, "c.{s}", .{ctype}) catch unreachable;
        }
        if (isHandleLikeType(ctype, mapping)) {
            return std.fmt.bufPrint(buf, "?*handles.{s}", .{zigHandleName(ctype)}) catch unreachable;
        }
        if (mapping.struct_decls.contains(ctype)) {
            return zigStructName(ctype);
        }
        if (mapping.typedef_decls.contains(ctype)) {
            return stripWgpu(ctype);
        }
        return stripWgpu(ctype);
    }
    if (std.mem.startsWith(u8, ctype, "struct_")) return zigStructName(ctype);
    if (std.mem.startsWith(u8, ctype, "union_")) return zigUnionName(ctype);
    return ctype;
}

/// Maps a C type to its raw C type. When wrap_handles is set, handles become wrapper types. Trampolines pass false.
pub fn mapCTypeRef(ctype: []const u8, buf: []u8, mapping: *Mapping, wrap_handles: bool) []const u8 {
    if (std.mem.startsWith(u8, ctype, "[*c]const ")) {
        const inner = ctype["[*c]const ".len..];
        var inner_buf: [256]u8 = undefined;
        const inner_wrap = wrap_handles and isHandleLikeType(inner, mapping);
        const zig_inner = mapCTypeRef(inner, &inner_buf, mapping, inner_wrap);
        if (isHandleLikeType(inner, mapping)) {
            return std.fmt.bufPrint(buf, "[*c]const {s}", .{zig_inner}) catch unreachable;
        }
        return std.fmt.bufPrint(buf, "[*c]const {s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "[*c]")) {
        const inner = ctype["[*c]".len..];
        var inner_buf: [256]u8 = undefined;
        const inner_wrap = wrap_handles and isHandleLikeType(inner, mapping);
        const zig_inner = mapCTypeRef(inner, &inner_buf, mapping, inner_wrap);
        if (isHandleLikeType(inner, mapping)) {
            return std.fmt.bufPrint(buf, "[*c]{s}", .{zig_inner}) catch unreachable;
        }
        return std.fmt.bufPrint(buf, "[*c]{s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "?*")) {
        const inner = ctype["?*".len..];
        var inner_buf: [256]u8 = undefined;
        const inner_wrap = wrap_handles and isHandleLikeType(inner, mapping);
        const zig_inner = mapCTypeRef(inner, &inner_buf, mapping, inner_wrap);
        if (isHandleLikeType(inner, mapping)) return zig_inner; // already `?*Handle`
        return std.fmt.bufPrint(buf, "?*{s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.eql(u8, ctype, "WGPUBool")) return if (wrap_handles) "bool" else "u32";
    if (std.mem.eql(u8, ctype, "WGPUFlags")) return "u64";
    if (std.mem.eql(u8, ctype, "void")) return "void";
    if (std.mem.eql(u8, ctype, "WGPUStatus")) return "!void";
    if (std.mem.startsWith(u8, ctype, "WGPU") and wrap_handles and isHandleLikeType(ctype, mapping)) {
        return std.fmt.bufPrint(buf, "?*{s}", .{zigHandleName(ctype)}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "WGPU") and wrap_handles and (mapping.enum_decls.contains(ctype) or mapping.flag_decls.contains(ctype))) {
        return std.fmt.bufPrint(buf, "types.{s}", .{stripWgpu(ctype)}) catch unreachable;
    }
    if ((std.mem.startsWith(u8, ctype, "WGPU") or std.mem.startsWith(u8, ctype, "struct_")) and wrap_handles and mapping.struct_decls.contains(ctype)) {
        return std.fmt.bufPrint(buf, "types.{s}", .{zigStructName(ctype)}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "WGPU") or std.mem.startsWith(u8, ctype, "struct_")) {
        return std.fmt.bufPrint(buf, "c.{s}", .{ctype}) catch unreachable;
    }
    return ctype;
}

/// Rewrites a raw c type reference to the matching types.zig reference.
pub fn mapCRefToTypesRef(c_ref: []const u8, buf: []u8) []const u8 {
    if (std.mem.indexOf(u8, c_ref, "c.WGPU")) |pos| {
        const before = c_ref[0..pos];
        const after = c_ref[pos + 2 ..];
        return std.fmt.bufPrint(buf, "{s}types.{s}", .{ before, stripWgpu(after) }) catch unreachable;
    }
    if (std.mem.indexOf(u8, c_ref, "c.struct_WGPU")) |pos| {
        const before = c_ref[0..pos];
        const after = c_ref[pos + 2 ..];
        return std.fmt.bufPrint(buf, "{s}types.{s}", .{ before, zigStructName(after) }) catch unreachable;
    }
    return c_ref;
}

pub fn hasPtrPrefix(ctype: []const u8) bool {
    return std.mem.startsWith(u8, ctype, "?*") or
        std.mem.startsWith(u8, ctype, "[*c]");
}

/// Returns true for C element-count types such as usize, size_t and u32.
pub fn isCountCType(ctype: []const u8) bool {
    return std.mem.eql(u8, ctype, "usize") or
        std.mem.eql(u8, ctype, "size_t") or
        std.mem.eql(u8, ctype, "u32");
}

/// Returns true when the parameter name ends in "Count".
pub fn isCountParamName(name: []const u8) bool {
    return std.mem.endsWith(u8, name, "Count");
}

/// Returns true when there is a count-and-pointer pair in the given parameter range.
pub fn hasSlicePair(mapping: *Mapping, fn_decl: *Mapping.FnDecl, start: usize, end: usize) bool {
    if (end < start + 2) return false;
    var i = start;
    while (i + 1 < end) : (i += 1) {
        const count = fn_decl.params.items[i];
        if (!isCountParamName(count.name)) continue;
        if (count.kind != .primitive) continue;
        if (!isCountCType(mapping.ast.getNodeSource(count.type))) continue;
        const ptr_type = mapping.ast.getNodeSource(fn_decl.params.items[i + 1].type);
        if (!std.mem.startsWith(u8, ptr_type, "[*c]") and
            !std.mem.startsWith(u8, ptr_type, "?*")) continue;
        return true;
    }
    return false;
}

/// Returns the WGPU_NULLABLE flag for this parameter, or null when it is unknown.
pub fn paramNullability(mapping: *Mapping, fn_name: []const u8, param_count: usize, c_index: usize) ?bool {
    const info = lookupNullability(mapping, fn_name, param_count) orelse return null;
    if (c_index >= info.params.len) return null;
    return info.params[c_index];
}

/// Returns the WGPU_NULLABLE flag for the return, or null when it is unknown.
pub fn returnNullability(mapping: *Mapping, fn_name: []const u8, param_count: usize) ?bool {
    const info = lookupNullability(mapping, fn_name, param_count) orelse return null;
    return info.returns;
}

fn lookupNullability(mapping: *Mapping, fn_name: []const u8, param_count: usize) ?*Mapping.FnNullability {
    const info = mapping.fn_nullability.getPtr(fn_name) orelse return null;
    // Parameter counts must line up with the AST.
    if (info.params.len != param_count) return null;
    return info;
}

/// Narrows a pointer type when it is not nullable.
pub fn applyPointerNullability(base: []const u8, nullable: ?bool, buf: []u8) []const u8 {
    const is_nullable = nullable orelse return base;
    if (std.mem.startsWith(u8, base, "[*c]const ")) {
        return std.fmt.bufPrint(buf, "{s}{s}", .{
            if (is_nullable) "?*const " else "*const ",
            base["[*c]const ".len..],
        }) catch base;
    }
    if (std.mem.startsWith(u8, base, "[*c]")) {
        return std.fmt.bufPrint(buf, "{s}{s}", .{
            if (is_nullable) "?*" else "*",
            base["[*c]".len..],
        }) catch base;
    }
    if (std.mem.startsWith(u8, base, "?*")) {
        if (is_nullable) return base;
        return std.fmt.bufPrint(buf, "*{s}", .{base["?*".len..]}) catch base;
    }
    if (std.mem.startsWith(u8, base, "*")) {
        if (!is_nullable) return base;
        return std.fmt.bufPrint(buf, "?*{s}", .{base[1..]}) catch base;
    }
    return base;
}

pub fn writeParamExpr(buf: *std.array_list.Managed(u8), param: *Mapping.FnParam, mapping: *Mapping) !void {
    const ptype = mapping.ast.getNodeSource(param.type);
    if (param.kind == .data_struct and hasPtrPrefix(ptype)) {
        try buf.print("@ptrCast({s})", .{param.name});
    } else if (param.kind == .handle) {
        try buf.print("@ptrCast({s})", .{param.name});
    } else if (param.kind == .pointer) {
        try buf.print("@ptrCast({s})", .{param.name});
    } else if (param.kind == .string) {
        try buf.print("asC(c.{s}, {s})", .{ ptype, param.name });
    } else if (param.kind == .data_struct) {
        try buf.print("asC(c.{s}, {s})", .{ ptype, param.name });
    } else if (param.kind == .bool_c) {
        try buf.print("@intFromBool({s})", .{param.name});
    } else if (param.kind == .enum_c) {
        try buf.print("@intFromEnum({s})", .{param.name});
    } else if (param.kind == .flags) {
        try buf.print("asC(c.{s}, {s})", .{ ptype, param.name });
    } else {
        try buf.print("{s}", .{param.name});
    }
}

pub fn typeSliceToHandleName(type_slice: []const u8) []const u8 {
    var s = type_slice;
    if (std.mem.startsWith(u8, s, "?*")) s = s[2..];
    if (std.mem.startsWith(u8, s, "struct_")) s = s["struct_".len..];
    if (std.mem.startsWith(u8, s, "WGPU")) s = s["WGPU".len..];
    if (std.mem.endsWith(u8, s, "Impl")) s = s[0 .. s.len - "Impl".len];
    return s;
}

pub fn stripCPtrPrefix(ctype: []const u8) []const u8 {
    if (std.mem.startsWith(u8, ctype, "[*c]const ")) return ctype["[*c]const ".len..];
    if (std.mem.startsWith(u8, ctype, "[*c]")) return ctype["[*c]".len..];
    return ctype;
}

/// std.ascii dropped indexOfIgnoreCase in 0.18, so codegen keeps its own copy.
pub fn indexOfIgnoreCase(haystack: []const u8, needle: []const u8) ?usize {
    if (needle.len == 0) return 0;
    if (needle.len > haystack.len) return null;
    var i: usize = 0;
    while (i + needle.len <= haystack.len) : (i += 1) {
        if (std.ascii.eqlIgnoreCase(haystack[i..][0..needle.len], needle)) return i;
    }
    return null;
}

pub const FieldInit = struct {
    ztype: []const u8,
    /// Initializer text. This is never "undefined" because codegen rejects that.
    zinit: []const u8,
};

/// Returns the zero-valued C tag or the synthetic @"undefined". Returns null when the type is not a generated enum.
fn enumDefaultInit(mapping: *Mapping, ctype: []const u8, init_buf: []u8) ?[]const u8 {
    const enum_decl = mapping.enum_decls.get(ctype) orelse return null;

    var val_iter = enum_decl.values.iterator();
    while (val_iter.next()) |val| {
        const init_text = mapping.ast.getNodeSource(val.value_ptr.*.init.unwrap().?);
        if (!std.mem.eql(u8, init_text, "0")) continue;
        var vn_buf: [128]u8 = undefined;
        const vname = zigValueName(val.key_ptr.*, &vn_buf);
        if (isZigKeyword(vname)) return std.fmt.bufPrint(init_buf, ".@\"{s}\"", .{vname}) catch null;
        return std.fmt.bufPrint(init_buf, ".{s}", .{vname}) catch null;
    }

    // No C value is zero, so use the synthetic tag.
    return std.fmt.bufPrint(init_buf, ".@\"undefined\"", .{}) catch null;
}

/// Maps a C struct field to its Zig type and initializer.
pub fn fieldInit(mapping: *Mapping, ctype: []const u8, cinit: ?[]const u8, type_buf: []u8, init_buf: []u8) FieldInit {
    const ztype = mapTypeName(ctype, type_buf, mapping);
    const init = cinit orelse return .{ .ztype = ztype, .zinit = "undefined" };
    const mapped = mapFieldInit(ctype, init, mapping);

    if (std.mem.eql(u8, mapped, "null")) return .{ .ztype = ztype, .zinit = "null" };

    if (std.mem.eql(u8, mapped, ".{}")) {
        if (std.mem.startsWith(u8, ctype, "union_")) {
            const zi = std.fmt.bufPrint(init_buf, "std.mem.zeroes({s})", .{ztype}) catch "undefined";
            return .{ .ztype = ztype, .zinit = zi };
        }
        if (enumDefaultInit(mapping, ctype, init_buf)) |zi| {
            return .{ .ztype = ztype, .zinit = zi };
        }
        if (mapping.struct_decls.contains(ctype)) {
            // Every struct field has a default now, so {} zeroes the struct.
            return .{ .ztype = ztype, .zinit = ".{}" };
        }
        return .{ .ztype = ztype, .zinit = "undefined" };
    }

    if (std.mem.eql(u8, mapped, "0") and mapping.flag_decls.get(ctype) != null) {
        return .{ .ztype = ztype, .zinit = ".{}" };
    }

    return .{ .ztype = ztype, .zinit = mapped };
}

pub fn mapFieldInit(ctype: []const u8, cinit: []const u8, mapping: *Mapping) []const u8 {
    if (std.mem.eql(u8, ctype, "WGPUBool") and std.mem.eql(u8, cinit, "0")) return "0";
    if (std.mem.eql(u8, ctype, "WGPUStringView") and std.mem.startsWith(u8, cinit, "@import")) return ".{ .data = null, .length = std.math.maxInt(usize) }";
    if (std.mem.eql(u8, cinit, "null") and isHandleLikeType(ctype, mapping)) return "null";
    if (std.mem.eql(u8, cinit, "null")) return "null";
    if (std.mem.startsWith(u8, cinit, "@import")) return ".{}";
    return cinit;
}
