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
    return std.mem.endsWith(u8, ctype, "Callback") or
        std.mem.endsWith(u8, ctype, "Proc") or
        std.mem.endsWith(u8, ctype, "CallbackInfo") or
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
            return std.fmt.bufPrint(buf, "handles.Optional{s}", .{zigHandleName(ctype)}) catch unreachable;
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

/// Map a C type to its raw C reference (from c_wgpu_native module)
/// When wrap_handles=true (method signatures), handle types -> wrapper names.
/// When wrap_handles=false (trampoline C ABI), handle types stay as c.WGPU*.
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
        return std.fmt.bufPrint(buf, "?*{s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.eql(u8, ctype, "WGPUBool")) return "u32";
    if (std.mem.eql(u8, ctype, "WGPUFlags")) return "u64";
    if (std.mem.eql(u8, ctype, "void")) return "void";
    if (std.mem.eql(u8, ctype, "WGPUStatus")) return "!void";
    if (std.mem.startsWith(u8, ctype, "WGPU") and wrap_handles and isHandleLikeType(ctype, mapping)) {
        return zigHandleName(ctype);
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

/// Convert a C type reference like "?*const c.WGPUInstanceDescriptor"
/// to its wrapper types equivalent "?*const types.InstanceDescriptor"
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

pub fn writeParamExpr(buf: *std.array_list.Managed(u8), param: *Mapping.FnParam, mapping: *Mapping) !void {
    const ptype = mapping.ast.getNodeSource(param.type);
    if (param.kind == .data_struct and hasPtrPrefix(ptype)) {
        try buf.print("@ptrCast({s})", .{param.name});
    } else if (param.kind == .handle) {
        try buf.print("@ptrCast({s}.ptr)", .{param.name});
    } else if (param.kind == .pointer) {
        try buf.print("@ptrCast({s})", .{param.name});
    } else if (param.kind == .string) {
        try buf.print("@bitCast({s})", .{param.name});
    } else if (param.kind == .data_struct) {
        try buf.print("@bitCast({s})", .{param.name});
    } else if (param.kind == .enum_c) {
        try buf.print("@intFromEnum({s})", .{param.name});
    } else if (param.kind == .flags) {
        try buf.print("@bitCast({s})", .{param.name});
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
