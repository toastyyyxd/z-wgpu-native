const std = @import("std");
const Mapping = @import("Mapping.zig");
const Common = @import("OutputCommon.zig");

pub fn writeCallbacks(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    if (mapping.callback_decls.count() == 0) return;

    try buf.appendSlice("const std = @import(\"std\");\nconst c = @import(\"c_wgpu_native\");\nconst types = @import(\"types.zig\");\nconst handles = @import(\"handles.zig\");\n\n");

    var cb_iter = mapping.callback_decls.iterator();
    while (cb_iter.next()) |entry| {
        const cb_decl = entry.value_ptr.*;

        var info_name_buf: [256]u8 = undefined;
        const info_name = std.fmt.bufPrint(&info_name_buf, "{s}Info", .{cb_decl.name}) catch unreachable;

        if (!mapping.struct_decls.contains(info_name)) {
            std.log.warn("codegen: skipping '{s}', no matching '{s}' struct in schema", .{ cb_decl.name, info_name });
            continue;
        }

        try writeCallbackTrampoline(buf, mapping, cb_decl);
    }
}

fn writeCallbackTrampoline(buf: *std.array_list.Managed(u8), mapping: *Mapping, cb_decl: *Mapping.CallbackDecl) !void {

    var name_buf: [256]u8 = undefined;
    const zname = Common.lowerFirst(Common.stripWgpu(cb_decl.name), &name_buf);

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
        try buf.print("{s}", .{mapCallbackZigType(p.type, &inner_buf, mapping)});
        prev_non_ud = true;
    }
    try buf.appendSlice(") void,\n");

    // Return type
    var cb_info_struct_buf: [256]u8 = undefined;
    const cb_info_struct_name = std.fmt.bufPrint(&cb_info_struct_buf, "{s}Info", .{cb_decl.name}) catch unreachable;
    var cb_info_ret_buf: [256]u8 = undefined;
    const cb_info_ret_type = Common.mapCTypeRef(cb_info_struct_name, &cb_info_ret_buf, mapping, true);
    try buf.print(") {s} {{\n", .{cb_info_ret_type});

    // Trampoline
    try buf.appendSlice("    const Trampoline = struct {\n");
    try buf.appendSlice("        fn call(");
    for (cb_decl.params.items, 0..) |*p, j| {
        if (j > 0) try buf.appendSlice(", ");
        var tbuf: [256]u8 = undefined;
        try buf.print("{s}: {s}", .{ p.name, Common.mapCTypeRef(p.type, &tbuf, mapping, false) });
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
        try buf.appendSlice(mapCbExpr(p, &expr_buf, mapping));
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

fn mapCallbackZigType(ctype: []const u8, buf: []u8, mapping: *Mapping) []const u8 {
    if (std.mem.eql(u8, ctype, "WGPUStringView")) return "[]const u8";
    if (std.mem.startsWith(u8, ctype, "WGPU") and (mapping.enum_decls.contains(ctype) or mapping.flag_decls.contains(ctype))) {
        return std.fmt.bufPrint(buf, "types.{s}", .{Common.stripWgpu(ctype)}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "WGPU") and Common.isHandleLikeType(ctype, mapping)) {
        return std.fmt.bufPrint(buf, "handles.{s}", .{Common.zigHandleName(ctype)}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "WGPU") and mapping.struct_decls.contains(ctype)) {
        return std.fmt.bufPrint(buf, "types.{s}", .{Common.zigStructName(ctype)}) catch unreachable;
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
        const zig_inner = mapCallbackZigType(inner, &inner_buf, mapping);
        return std.fmt.bufPrint(buf, "?*const {s}", .{zig_inner}) catch unreachable;
    }
    if (std.mem.startsWith(u8, ctype, "[*c]")) {
        const inner = ctype["[*c]".len..];
        var inner_buf: [128]u8 = undefined;
        const zig_inner = mapCallbackZigType(inner, &inner_buf, mapping);
        return std.fmt.bufPrint(buf, "?*const {s}", .{zig_inner}) catch unreachable;
    }
    return ctype;
}

fn mapCbExpr(param: *Mapping.CallbackParam, buf: []u8, mapping: *Mapping) []const u8 {
    if (std.mem.eql(u8, param.type, "WGPUStringView")) {
        return std.fmt.bufPrint(buf, "if ({s}.data) |d| d[0..{s}.length] else \"\"", .{ param.name, param.name }) catch unreachable;
    }
    if (std.mem.startsWith(u8, param.type, "WGPU") and (mapping.enum_decls.contains(param.type) or mapping.flag_decls.contains(param.type))) {
        return std.fmt.bufPrint(buf, "@enumFromInt({s})", .{param.name}) catch unreachable;
    }
    if (std.mem.startsWith(u8, param.type, "WGPU") and Common.isHandleLikeType(param.type, mapping)) {
        const hname = Common.zigHandleName(param.type);
        return std.fmt.bufPrint(buf, "handles.{s}.fromPtr(@ptrCast({s}))", .{ hname, param.name }) catch unreachable;
    }
    return param.name;
}
