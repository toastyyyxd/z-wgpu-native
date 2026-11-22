const std = @import("std");
const Mapping = @import("Mapping.zig");
const Common = @import("OutputCommon.zig");
const Sync = @import("OutputSync.zig");

pub fn writeHandlesAndFuncs(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    try buf.appendSlice("const std = @import(\"std\");\nconst c = @import(\"c_wgpu_native\");\nconst types = @import(\"types.zig\");\n\n");
    try buf.appendSlice(
        \\// Zig 0.17 removed @bitCast for extern structs, so layouts are copied bytewise.
        \\// tests/abi.zig checks the layout.
        \\inline fn asC(comptime C: type, value: anytype) C {
        \\    var out: C = undefined;
        \\    var v = value;
        \\    @memcpy(@import("std").mem.asBytes(&out), @import("std").mem.asBytes(&v));
        \\    return out;
        \\}
        \\
        \\
    );

    try writeUnimplementedList(buf, mapping);

    var sync_decls = try Sync.discover(mapping);
    defer sync_decls.deinit(mapping.gpa);
    try Sync.writePrelude(buf, mapping, sync_decls.items);

    // Map each handle name to its methods.
    var handle_funcs = std.StringHashMapUnmanaged(std.ArrayList([]const u8)){};
    defer {
        var it = handle_funcs.iterator();
        while (it.next()) |e| e.value_ptr.*.deinit(mapping.gpa);
        handle_funcs.deinit(mapping.gpa);
    }

    var standalone_funcs: std.ArrayList([]const u8) = .empty;
    defer standalone_funcs.deinit(mapping.gpa);

    var fn_iter = mapping.fn_decls.iterator();
    while (fn_iter.next()) |fn_entry| {
        const fn_decl = fn_entry.value_ptr.*;
        const fn_name = fn_entry.key_ptr.*;

        // A function is a method when its first parameter is a handle.
        const is_method = if (fn_decl.params.items.len > 0) blk: {
            break :blk fn_decl.params.items[0].kind == .handle;
        } else false;

        if (is_method) {
            const first_param = fn_decl.params.items[0];
            const type_slice = mapping.ast.getNodeSource(first_param.type);
            const hzname = Common.typeSliceToHandleName(type_slice);

            const gop = try handle_funcs.getOrPut(mapping.gpa, hzname);
            if (!gop.found_existing) {
                gop.value_ptr.* = .empty;
            }
            try gop.value_ptr.*.append(mapping.gpa, fn_name);
        } else {
            try standalone_funcs.append(mapping.gpa, fn_name);
        }
    }

    // Write handles and methods in premap order.
    for (mapping.handle_names.items) |hname| {
        _ = mapping.handle_decls.get(hname) orelse continue;
        const hzname = Common.zigHandleName(hname);

        try buf.print("pub const {s} = opaque {{\n", .{hzname});

        // Write init from raw ptr
        try buf.print("    pub fn fromPtr(ptr: *anyopaque) *{s} {{\n", .{hzname});
        try buf.appendSlice("        return @ptrCast(ptr);\n");
        try buf.appendSlice("    }\n\n");

        // Write methods
        if (handle_funcs.getPtr(hzname)) |funcs_ptr| {
            for (funcs_ptr.*.items) |fn_name| {
                const fn_decl = mapping.fn_decls.get(fn_name) orelse continue;
                if (fn_decl.params.items.len == 0) continue;
                try writeAbortDoc(buf, mapping, fn_name, "    ");
                try writeHandleMethod(buf, mapping, fn_decl, hzname);
            }
        }

        try Sync.writeMethodsFor(buf, sync_decls.items, hzname);
        try writeStaticConstructor(buf, mapping, hzname);
        try buf.appendSlice("};\n\n");
    }

    // Write standalone functions
    for (standalone_funcs.items) |fn_name| {
        const fn_decl = mapping.fn_decls.get(fn_name) orelse continue;
        try writeAbortDoc(buf, mapping, fn_name, "");
        try writeStandaloneFunc(buf, mapping, fn_decl);
    }
}

/// Emits the sorted C names that abort.
fn writeUnimplementedList(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    var names: std.ArrayList([]const u8) = .empty;
    defer names.deinit(mapping.gpa);
    var it = mapping.unimplemented.keyIterator();
    while (it.next()) |name| try names.append(mapping.gpa, name.*);
    std.mem.sort([]const u8, names.items, {}, struct {
        fn lessThan(_: void, a: []const u8, b: []const u8) bool {
            return std.mem.order(u8, a, b) == .lt;
        }
    }.lessThan);

    try buf.appendSlice(
        \\/// Stubbed by wgpu-native. Sorted by C name.
        \\pub const unimplemented_entry_points: []const []const u8 = &.{
        \\
    );
    for (names.items) |name| {
        try buf.print("    \"{s}\",\n", .{name});
    }
    try buf.appendSlice("};\n\n");
}

fn writeAbortDoc(buf: *std.array_list.Managed(u8), mapping: *Mapping, fn_name: []const u8, indent: []const u8) !void {
    if (!mapping.unimplemented.contains(fn_name)) return;
    try buf.appendSlice(indent);
    try buf.appendSlice("/// Stubbed by wgpu-native: calling this is a compile error.\n");
    try buf.appendSlice(indent);
    try buf.print("/// Use `wgpu.c.{s}` for the raw extern, which aborts at runtime.\n", .{fn_name});
}

/// Emits the body of a stubbed entry point. Stubs are `inline fn`, so the body
/// is only analyzed when the method is called; referencing the type does not
/// trigger the compile error.
fn writeStubBody(
    buf: *std.array_list.Managed(u8),
    fn_decl: *Mapping.FnDecl,
    out_param_idx: ?usize,
    indent: []const u8,
    has_receiver: bool,
) !void {
    if (has_receiver) try buf.print("{s}_ = self;\n", .{indent});
    for (fn_decl.params.items, 0..) |param, i| {
        if (has_receiver and i == 0) continue;
        if (out_param_idx != null and i == out_param_idx.?) continue;
        try buf.print("{s}_ = {s};\n", .{ indent, param.name });
    }
    try buf.print("{s}@compileError(\"{s} is stubbed by wgpu-native; use wgpu.c.{s} for the raw extern (aborts at runtime)\");\n", .{ indent, fn_decl.name, fn_decl.name });
}


/// Emits `Handle.create` for `wgpuCreate<Handle>`. The free function stays.
fn writeStaticConstructor(buf: *std.array_list.Managed(u8), mapping: *Mapping, hzname: []const u8) !void {
    var name_buf: [160]u8 = undefined;
    const ctor_name = std.fmt.bufPrint(&name_buf, "wgpuCreate{s}", .{hzname}) catch return;
    const fn_decl = mapping.fn_decls.get(ctor_name) orelse return;

    const ret_slice = if (fn_decl.return_type.unwrap()) |rt| mapping.ast.getNodeSource(rt) else return;
    const ret_nullable = Common.returnNullability(mapping, fn_decl.name, fn_decl.params.items.len);
    const optional_ptr = if (ret_nullable orelse true) "?" else "";
    var ret_buf: [256]u8 = undefined;
    const ret_type = std.fmt.bufPrint(&ret_buf, "{s}*{s}", .{ optional_ptr, Common.typeSliceToHandleName(ret_slice) }) catch return;

    try buf.print("    pub fn create(", .{});
    var sig_sep = false;
    for (fn_decl.params.items, 0..) |*param, i| {
        if (sig_sep) try buf.appendSlice(", ");
        sig_sep = true;
        var pb: [256]u8 = undefined;
        const ptype = mapping.ast.getNodeSource(param.type);
        const zt = if (param.kind == .data_struct and Common.hasPtrPrefix(ptype) and !std.mem.endsWith(u8, ptype, "CallbackInfo")) blk: {
            var inner: [256]u8 = undefined;
            const c_ref = Common.mapCTypeRef(ptype, &inner, mapping, true);
            break :blk Common.mapCRefToTypesRef(c_ref, &pb);
        } else Common.mapCTypeRef(ptype, &pb, mapping, true);
        const nullable = if (param.kind == .handle or (param.kind == .data_struct and Common.hasPtrPrefix(ptype)))
            Common.paramNullability(mapping, fn_decl.name, fn_decl.params.items.len, i)
        else
            null;
        var nb: [256]u8 = undefined;
        try buf.print("{s}: {s}", .{ param.name, Common.applyPointerNullability(zt, nullable, &nb) });
    }
    try buf.print(") {s} {{\n", .{ret_type});

    try buf.print("        const result = c.{s}(", .{fn_decl.name});
    for (fn_decl.params.items, 0..) |*param, i| {
        if (i > 0) try buf.appendSlice(", ");
        try Common.writeParamExpr(buf, param, mapping);
    }
    try buf.appendSlice(");\n");
    if (ret_nullable) |nullable| {
        if (!nullable) {
            try buf.appendSlice("        return @ptrCast(result.?);\n");
        } else {
            try buf.appendSlice("        if (result) |r| return @ptrCast(r) else return null;\n");
        }
    } else {
        try buf.appendSlice("        if (result) |r| return @ptrCast(r) else return null;\n");
    }
    try buf.appendSlice("    }\n\n");
}

const SlicePair = struct { count_index: usize, ptr_index: usize };

const ParamInfo = struct {
    name: []const u8,
    ctype: []const u8,
    kind: Mapping.FnParamKind,
};

/// Returns true when the parameter name ends in "Count".
pub fn isCountParamName(name: []const u8) bool {
    return Common.isCountParamName(name);
}

/// Returns true when a count parameter is followed by a pointer parameter.
pub fn findSlicePairs(params: []const ParamInfo, pairs: []SlicePair) usize {
    var n: usize = 0;
    var i: usize = 0;
    while (i + 1 < params.len) : (i += 1) {
        const count = params[i];
        if (!isCountParamName(count.name)) continue;
        if (count.kind != .primitive) continue;
        if (!Common.isCountCType(count.ctype)) continue;
        const ptr = params[i + 1];
        if (!std.mem.startsWith(u8, ptr.ctype, "[*c]") and
            !std.mem.startsWith(u8, ptr.ctype, "?*")) continue;
        if (n < pairs.len) pairs[n] = .{ .count_index = i, .ptr_index = i + 1 };
        n += 1;
        i += 1; // the pointer is consumed by the pair
    }
    return n;
}

/// Returns the mapped type of a parameter and applies WGPU_NULLABLE.
fn paramZigType(
    mapping: *Mapping,
    fn_decl: *Mapping.FnDecl,
    param: *Mapping.FnParam,
    c_index: usize,
    type_buf: *[256]u8,
    nullable_buf: *[256]u8,
) []const u8 {
    const ptype = mapping.ast.getNodeSource(param.type);
    const zt = if (param.kind == .data_struct and Common.hasPtrPrefix(ptype) and !std.mem.endsWith(u8, ptype, "CallbackInfo")) blk: {
        var inner: [256]u8 = undefined;
        const c_ref = Common.mapCTypeRef(ptype, &inner, mapping, true);
        break :blk Common.mapCRefToTypesRef(c_ref, type_buf);
    } else Common.mapCTypeRef(ptype, type_buf, mapping, true);
    const nullable = if (param.kind == .handle or (param.kind == .data_struct and Common.hasPtrPrefix(ptype)))
        Common.paramNullability(mapping, fn_decl.name, fn_decl.params.items.len, c_index)
    else
        null;
    return Common.applyPointerNullability(zt, nullable, nullable_buf);
}

/// Returns the slice type for a mapped pointer type.
fn sliceTypeFromPointer(mapped: []const u8, buf: []u8) ?[]const u8 {
    var is_const = false;
    var rest: []const u8 = undefined;
    if (std.mem.startsWith(u8, mapped, "[*c]const ")) {
        is_const = true;
        rest = mapped["[*c]const ".len..];
    } else if (std.mem.startsWith(u8, mapped, "[*c]")) {
        rest = mapped["[*c]".len..];
    } else if (std.mem.startsWith(u8, mapped, "?*const ")) {
        is_const = true;
        rest = mapped["?*const ".len..];
    } else if (std.mem.startsWith(u8, mapped, "?*")) {
        rest = mapped["?*".len..];
    } else if (std.mem.startsWith(u8, mapped, "*const ")) {
        is_const = true;
        rest = mapped["*const ".len..];
    } else if (std.mem.startsWith(u8, mapped, "*")) {
        rest = mapped[1..];
    } else return null;
    // Handle slice elements are non-optional.
    if (std.mem.startsWith(u8, rest, "?")) rest = rest[1..];
    return std.fmt.bufPrint(buf, "[]{s}{s}", .{ if (is_const) "const " else "", rest }) catch null;
}

fn writeHandleMethod(buf: *std.array_list.Managed(u8), mapping: *Mapping, fn_decl: *Mapping.FnDecl, hzname: []const u8) !void {
    if (mapping.unimplemented.contains(fn_decl.name)) {
        try writeHandleMethodImpl(buf, mapping, fn_decl, hzname, false, true);
        return;
    }
    var infos_buf: [16]ParamInfo = undefined;
    const params = fn_decl.params.items;
    const emitted = params[1..];
    if (emitted.len > infos_buf.len) return writeHandleMethodImpl(buf, mapping, fn_decl, hzname, false, false);
    for (emitted, 0..) |*param, i| {
        infos_buf[i] = .{
            .name = param.name,
            .ctype = mapping.ast.getNodeSource(param.type),
            .kind = param.kind,
        };
    }
    var pairs_buf: [8]SlicePair = undefined;
    const pair_count = findSlicePairs(infos_buf[0..emitted.len], &pairs_buf);
    if (pair_count == 0) {
        try writeHandleMethodImpl(buf, mapping, fn_decl, hzname, false, false);
        return;
    }
    try writeSliceWrapper(buf, mapping, fn_decl, hzname, pairs_buf[0..pair_count]);
    try writeAbortDoc(buf, mapping, fn_decl.name, "    ");
    try writeHandleMethodImpl(buf, mapping, fn_decl, hzname, true, false);
}

/// Emits the slice method, which forwards to the Raw method.
fn writeSliceWrapper(
    buf: *std.array_list.Managed(u8),
    mapping: *Mapping,
    fn_decl: *Mapping.FnDecl,
    hzname: []const u8,
    pairs: []const SlicePair,
) !void {
    var name_buf: [128]u8 = undefined;
    const after_wgpu = Common.stripWgpuFunc(fn_decl.name);
    const method = if (std.mem.startsWith(u8, after_wgpu, hzname))
        after_wgpu[hzname.len..]
    else
        after_wgpu;
    const zname = Common.lowerFirst(method, &name_buf);

    // Return analysis matches the Raw method.
    const params = fn_decl.params.items;
    var ret_buf: [256]u8 = undefined;
    const ret_slice = if (fn_decl.return_type.unwrap()) |rt| mapping.ast.getNodeSource(rt) else "void";
    const ret_type = Common.mapCTypeRef(ret_slice, &ret_buf, mapping, true);
    const returns_void = std.mem.eql(u8, ret_type, "void");
    const returns_status = std.mem.endsWith(u8, ret_slice, "Status");
    const is_handle_ret = fn_decl.return_kind == .handle;
    const ret_nullable = Common.returnNullability(mapping, fn_decl.name, params.len);
    var status_buf: [256]u8 = undefined;
    const status_type = if (returns_status) blk: {
        const base_name = if (std.mem.startsWith(u8, ret_slice, "WGPU")) ret_slice[4..] else ret_slice;
        break :blk std.fmt.bufPrint(&status_buf, "types.{s}", .{base_name}) catch unreachable;
    } else "";

    var actual_ret_type: []const u8 = ret_type;
    var actual_ret_buf: [512]u8 = undefined;
    var out_param_idx: ?usize = null;
    if (returns_status and params.len > 1) {
        var idx = params.len;
        while (idx > 1) {
            idx -= 1;
            if (params[idx].kind == .data_struct) {
                out_param_idx = idx;
                break;
            }
        }
    }
    if (out_param_idx) |opi| {
        if (opi > 1) {
            const prev = params[opi - 1];
            const prev_type = mapping.ast.getNodeSource(prev.type);
            if (prev.kind == .primitive and Common.isCountCType(prev_type)) out_param_idx = null;
        }
    }
    if (out_param_idx) |opi| {
        const out_param = params[opi];
        const otype = mapping.ast.getNodeSource(out_param.type);
        var inner_buf: [256]u8 = undefined;
        const mapped_otype = Common.mapCTypeRef(Common.stripCPtrPrefix(otype), &inner_buf, mapping, true);
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}Error!{s}", .{ status_type, mapped_otype }) catch unreachable;
    } else if (returns_status) {
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}Error!void", .{status_type}) catch unreachable;
    } else if (is_handle_ret) {
        const optional_ptr = if (ret_nullable orelse true) "?" else "";
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}*{s}", .{ optional_ptr, Common.typeSliceToHandleName(ret_slice) }) catch unreachable;
    } else {
        const ret_maybe_converted = !returns_void and !returns_status;
        if (ret_maybe_converted) {
            var rt_buf: [256]u8 = undefined;
            const converted = Common.mapCRefToTypesRef(actual_ret_type, &rt_buf);
            if (!std.mem.eql(u8, converted, actual_ret_type)) {
                actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}", .{converted}) catch actual_ret_type;
            }
        }
    }

    // Skip the count and turn the pointer into a slice.
    try buf.print("    pub fn {s}(self: *{s}", .{ zname, hzname });
    for (params[1..], 0..) |*param, rel| {
        const c_index = rel + 1;
        if (out_param_idx != null and c_index == out_param_idx.?) continue;
        if (isPairCount(pairs, rel)) continue;
        if (isPairPointer(pairs, rel)) {
            var type_buf: [256]u8 = undefined;
            var nullable_buf: [256]u8 = undefined;
            const mapped = paramZigType(mapping, fn_decl, param, c_index, &type_buf, &nullable_buf);
            var slice_buf: [256]u8 = undefined;
            const slice_type = sliceTypeFromPointer(mapped, &slice_buf) orelse mapped;
            try buf.print(", {s}: {s}", .{ param.name, slice_type });
        } else {
            var type_buf: [256]u8 = undefined;
            var nullable_buf: [256]u8 = undefined;
            const zt = paramZigType(mapping, fn_decl, param, c_index, &type_buf, &nullable_buf);
            try buf.print(", {s}: {s}", .{ param.name, zt });
        }
    }
    try buf.print(") {s} {{\n", .{actual_ret_type});

    // Forward to the Raw method.
    try buf.appendSlice(if (returns_void) "        " else "        return ");
    try buf.print("self.{s}Raw(", .{zname});
    var first = true;
    for (params[1..], 0..) |*param, rel| {
        const c_index = rel + 1;
        if (out_param_idx != null and c_index == out_param_idx.?) continue;
        if (!first) try buf.appendSlice(", ");
        first = false;
        if (isPairCount(pairs, rel)) {
            const ptr_name = params[rel + 2].name;
            try buf.print("@intCast({s}.len)", .{ptr_name});
        } else if (isPairPointer(pairs, rel)) {
            var type_buf: [256]u8 = undefined;
            var nullable_buf: [256]u8 = undefined;
            const mapped = paramZigType(mapping, fn_decl, param, c_index, &type_buf, &nullable_buf);
            if (std.mem.startsWith(u8, mapped, "?*")) {
                try buf.print("(if ({s}.len == 0) null else @ptrCast({s}.ptr))", .{ param.name, param.name });
            } else {
                try buf.print("@ptrCast({s}.ptr)", .{param.name});
            }
        } else {
            try buf.appendSlice(param.name);
        }
    }
    try buf.appendSlice(");\n    }\n\n");
}

fn isPairCount(pairs: []const SlicePair, rel_index: usize) bool {
    for (pairs) |pair| if (pair.count_index == rel_index) return true;
    return false;
}

fn isPairPointer(pairs: []const SlicePair, rel_index: usize) bool {
    for (pairs) |pair| if (pair.ptr_index == rel_index) return true;
    return false;
}

fn writeHandleMethodImpl(buf: *std.array_list.Managed(u8), mapping: *Mapping, fn_decl: *Mapping.FnDecl, hzname: []const u8, raw: bool, stub: bool) !void {
    var name_buf: [128]u8 = undefined;
    const after_wgpu = Common.stripWgpuFunc(fn_decl.name);
    const method = if (std.mem.startsWith(u8, after_wgpu, hzname))
        after_wgpu[hzname.len..]
    else
        after_wgpu;
    const zname_base = Common.lowerFirst(method, &name_buf);
    var raw_name_buf: [144]u8 = undefined;
    const zname = if (raw)
        std.fmt.bufPrint(&raw_name_buf, "{s}Raw", .{zname_base}) catch zname_base
    else
        zname_base;

    var ret_buf: [256]u8 = undefined;
    const ret_slice = if (fn_decl.return_type.unwrap()) |rt|
        mapping.ast.getNodeSource(rt)
    else
        "void";
    const ret_type = Common.mapCTypeRef(ret_slice, &ret_buf, mapping, true);
    const returns_void = std.mem.eql(u8, ret_type, "void");
    const returns_status = std.mem.endsWith(u8, ret_slice, "Status");
    const is_handle_ret = fn_decl.return_kind == .handle;
    const ret_nullable = Common.returnNullability(mapping, fn_decl.name, fn_decl.params.items.len);

    // Build the enum name from the C type slice. WGPUMapAsyncStatus becomes types.MapAsyncStatus.
    var status_types_buf: [256]u8 = undefined;
    const status_type = if (returns_status) blk: {
        const base_name = if (std.mem.startsWith(u8, ret_slice, "WGPU"))
            ret_slice[4..]
        else
            ret_slice;
        break :blk std.fmt.bufPrint(&status_types_buf, "types.{s}", .{base_name}) catch unreachable;
    } else "";

    // A status with an out-param returns an error union of the out type.
    var actual_ret_type: []const u8 = ret_type;
    var actual_ret_buf: [256]u8 = undefined;
    var out_param_idx: ?usize = null;
    if (returns_status and fn_decl.params.items.len > 1) {
        var idx = fn_decl.params.items.len;
        while (idx > 1) {
            idx -= 1;
            if (fn_decl.params.items[idx].kind == .data_struct) {
                out_param_idx = idx;
                break;
            }
        }
    }
    // A count before a data_struct means the pointer is an input slice. It is not an out-param.
    if (out_param_idx) |opi| {
        if (opi > 1) {
            const prev = fn_decl.params.items[opi - 1];
            const prev_type = mapping.ast.getNodeSource(prev.type);
            if (prev.kind == .primitive and Common.isCountCType(prev_type)) {
                out_param_idx = null;
            }
        }
    }

    if (out_param_idx) |opi| {
        const out_param = fn_decl.params.items[opi];
        const otype = mapping.ast.getNodeSource(out_param.type);
        var inner_buf: [256]u8 = undefined;
        const mapped_otype = Common.mapCTypeRef(Common.stripCPtrPrefix(otype), &inner_buf, mapping, true);
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}Error!{s}", .{status_type, mapped_otype}) catch unreachable;
    } else if (returns_status) {
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}Error!void", .{status_type}) catch unreachable;
    } else if (is_handle_ret) {
        // The handle type is defined in this file.
        const optional_ptr = if (ret_nullable orelse true) "?" else "";
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}*{s}", .{ optional_ptr, Common.typeSliceToHandleName(ret_slice) }) catch unreachable;
    }

    // Struct returns are converted. WGPUFuture becomes types.Future.
    const ret_maybe_converted = !is_handle_ret and !returns_void and !returns_status and out_param_idx == null;
    var ret_type_converted = false;
    if (ret_maybe_converted) {
        var rt_buf: [256]u8 = undefined;
        const converted = Common.mapCRefToTypesRef(actual_ret_type, &rt_buf);
        if (!std.mem.eql(u8, converted, actual_ret_type)) {
            actual_ret_type = converted;
            ret_type_converted = true;
        }
    }
    if (ret_maybe_converted and !ret_type_converted and std.mem.startsWith(u8, actual_ret_type, "types.")) {
        ret_type_converted = true;
    }

    // Write signature
    try buf.print("    pub {s}fn {s}(self: *{s}", .{ if (stub) "inline " else "", zname, hzname });
    for (fn_decl.params.items[1..], 0..) |*param, i| {
        if (out_param_idx != null and i + 1 == out_param_idx.?) continue;
        var pb: [256]u8 = undefined;
        const ptype = mapping.ast.getNodeSource(param.type);
        const zt = if (param.kind == .data_struct and Common.hasPtrPrefix(mapping.ast.getNodeSource(param.type)) and !std.mem.endsWith(u8, ptype, "CallbackInfo")) blk: {
            var inner: [256]u8 = undefined;
            const c_ref = Common.mapCTypeRef(ptype, &inner, mapping, true);
            break :blk Common.mapCRefToTypesRef(c_ref, &pb);
        } else Common.mapCTypeRef(ptype, &pb, mapping, true);
        const nullable = if (param.kind == .handle or (param.kind == .data_struct and Common.hasPtrPrefix(ptype)))
            Common.paramNullability(mapping, fn_decl.name, fn_decl.params.items.len, i + 1)
        else
            null;
        var nb: [256]u8 = undefined;
        try buf.print(", {s}: {s}", .{ param.name, Common.applyPointerNullability(zt, nullable, &nb) });
    }
    try buf.print(") {s} {{\n", .{actual_ret_type});

    if (stub) {
        try writeStubBody(buf, fn_decl, out_param_idx, "        ", true);
        try buf.appendSlice("    }\n\n");
        return;
    }

    // Generate body
    if (out_param_idx) |opi| {
        // For a status with an out-param, allocate the out struct.
        const out_param = fn_decl.params.items[opi];
        var ob: [256]u8 = undefined;
        const otype = mapping.ast.getNodeSource(out_param.type);
        const zot = Common.mapCTypeRef(Common.stripCPtrPrefix(otype), &ob, mapping, true);
        try buf.print("        var result: {s} = .{{}};\n", .{zot});
        try buf.print("        const status = c.{s}(@ptrCast(self)", .{fn_decl.name});
        for (fn_decl.params.items[1..], 0..) |*param, i| {
            try buf.appendSlice(", ");
            if (i + 1 == opi) {
                try buf.appendSlice("@ptrCast(&result)");
            } else {
                try Common.writeParamExpr(buf, param, mapping);
            }
        }
        try buf.appendSlice(");\n");
        try buf.print("        try @as({s}, @enumFromInt(status)).toError();\n", .{status_type});
        try buf.appendSlice("        return result;\n");
    } else if (returns_status) {
        // Status return without an out-param.
        try buf.print("        const status = c.{s}(@ptrCast(self)", .{fn_decl.name});
        for (fn_decl.params.items[1..]) |*param| {
            try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
        try buf.print("        try @as({s}, @enumFromInt(status)).toError();\n", .{status_type});
    } else if (returns_void) {
        try buf.print("        c.{s}(@ptrCast(self)", .{fn_decl.name});
        for (fn_decl.params.items[1..]) |*param| {
            try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
    } else if (fn_decl.return_kind == .bool_c) {
        try buf.print("        return c.{s}(@ptrCast(self)", .{fn_decl.name});
        for (fn_decl.params.items[1..]) |*param| {
            try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(") != 0;\n");
    } else {
        if (is_handle_ret) {
            try buf.print("        const result = c.{s}(@ptrCast(self)", .{fn_decl.name});
            for (fn_decl.params.items[1..]) |*param| {
                try buf.appendSlice(", ");
                try Common.writeParamExpr(buf, param, mapping);
            }
            try buf.appendSlice(");\n");
            if (ret_nullable) |nullable| {
                if (!nullable) {
                    try buf.appendSlice("        return @ptrCast(result.?);\n");
                } else {
                    try buf.appendSlice("        if (result) |r| return @ptrCast(r) else return null;\n");
                }
            } else {
                try buf.appendSlice("        if (result) |r| return @ptrCast(r) else return null;\n");
            }
        } else {
            if (ret_type_converted) {
                try buf.print("        const result = c.{s}(@ptrCast(self)", .{fn_decl.name});
                for (fn_decl.params.items[1..]) |*param| {
                    try buf.appendSlice(", ");
                    try Common.writeParamExpr(buf, param, mapping);
                }
                try buf.appendSlice(");\n");
                if (fn_decl.return_kind == .enum_c) {
                    try buf.appendSlice("        return @enumFromInt(result);\n");
                } else {
                    try buf.print("        return asC({s}, result);\n", .{actual_ret_type});
                }
            } else {
                try buf.print("        return c.{s}(@ptrCast(self)", .{fn_decl.name});
                for (fn_decl.params.items[1..]) |*param| {
                    try buf.appendSlice(", ");
                    try Common.writeParamExpr(buf, param, mapping);
                }
                try buf.appendSlice(");\n");
            }
        }
    }

    try buf.appendSlice("    }\n\n");
}

/// Returns X for `wgpuCreate<X>` when the handle type is `WGPU<X>Impl`. Returns null otherwise.
fn constructorHandleName(mapping: *Mapping, fn_name: []const u8, buf: *[128]u8) ?[]const u8 {
    const prefix = "wgpuCreate";
    if (!std.mem.startsWith(u8, fn_name, prefix)) return null;
    const handle_suffix = fn_name[prefix.len..];
    if (handle_suffix.len == 0) return null;
    const c_name = std.fmt.bufPrint(buf, "WGPU{s}Impl", .{handle_suffix}) catch return null;
    if (!mapping.handle_decls.contains(c_name)) return null;
    return Common.zigHandleName(c_name);
}

fn writeStandaloneFunc(buf: *std.array_list.Managed(u8), mapping: *Mapping, fn_decl: *Mapping.FnDecl) !void {
    var name_buf: [128]u8 = undefined;
    const zname = Common.lowerFirst(Common.stripWgpuFunc(fn_decl.name), &name_buf);

    var ret_buf: [256]u8 = undefined;
    const ret_slice = if (fn_decl.return_type.unwrap()) |rt|
        mapping.ast.getNodeSource(rt)
    else
        "void";
    const ret_type = Common.mapCTypeRef(ret_slice, &ret_buf, mapping, true);
    const returns_void = std.mem.eql(u8, ret_type, "void");
    const returns_status = std.mem.endsWith(u8, ret_slice, "Status");
    const is_handle_ret = fn_decl.return_kind == .handle;
    const ret_nullable = Common.returnNullability(mapping, fn_decl.name, fn_decl.params.items.len);

    // Build the enum name from the C type slice. WGPUMapAsyncStatus becomes types.MapAsyncStatus.
    var status_types_buf: [256]u8 = undefined;
    const status_type = if (returns_status) blk: {
        const base_name = if (std.mem.startsWith(u8, ret_slice, "WGPU"))
            ret_slice[4..]
        else
            ret_slice;
        break :blk std.fmt.bufPrint(&status_types_buf, "types.{s}", .{base_name}) catch unreachable;
    } else "";

    // A status with an out-param returns an error union of the out type.
    var actual_ret_type: []const u8 = ret_type;
    var actual_ret_buf: [256]u8 = undefined;
    var standalone_out_param_idx: ?usize = null;
    if (returns_status and fn_decl.params.items.len > 0) {
        var idx = fn_decl.params.items.len;
        while (idx > 0) {
            idx -= 1;
            if (fn_decl.params.items[idx].kind == .data_struct) {
                standalone_out_param_idx = idx;
                break;
            }
        }
    }
    if (standalone_out_param_idx) |opi| {
        if (opi > 0) {
            const prev = fn_decl.params.items[opi - 1];
            const prev_type = mapping.ast.getNodeSource(prev.type);
            if (prev.kind == .primitive and Common.isCountCType(prev_type)) {
                standalone_out_param_idx = null;
            }
        }
    }

    if (standalone_out_param_idx) |opi| {
        const first_param = fn_decl.params.items[opi];
        const otype = mapping.ast.getNodeSource(first_param.type);
        var inner_buf: [256]u8 = undefined;
        const mapped_otype_s = Common.mapCTypeRef(Common.stripCPtrPrefix(otype), &inner_buf, mapping, true);

        var zot_buf: [256]u8 = undefined;
        const zot = Common.mapCRefToTypesRef(mapped_otype_s, &zot_buf);
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}Error!{s}", .{status_type, zot}) catch unreachable;
    } else if (returns_status) {
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}Error!void", .{status_type}) catch unreachable;
    } else if (is_handle_ret) {
        // handle type is defined in this file
        const optional_ptr = if (ret_nullable orelse true) "?" else "";
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "{s}*{s}", .{ optional_ptr, Common.typeSliceToHandleName(ret_slice) }) catch unreachable;
    }

    const standalone_ret_converted = !is_handle_ret and !returns_void and !returns_status and standalone_out_param_idx == null and std.mem.startsWith(u8, actual_ret_type, "types.");

    try buf.print("pub {s}fn {s}(", .{ if (mapping.unimplemented.contains(fn_decl.name)) "inline " else "", zname });
    var sig_sep = false;
    for (fn_decl.params.items, 0..) |*param, i| {
        if (standalone_out_param_idx != null and i == standalone_out_param_idx.?) continue;
        if (sig_sep) try buf.appendSlice(", ");
        sig_sep = true;
        var pb: [256]u8 = undefined;
        const ptype = mapping.ast.getNodeSource(param.type);
        const zt = if (param.kind == .data_struct and Common.hasPtrPrefix(mapping.ast.getNodeSource(param.type)) and !std.mem.endsWith(u8, ptype, "CallbackInfo")) blk: {
            var inner: [256]u8 = undefined;
            const c_ref = Common.mapCTypeRef(ptype, &inner, mapping, true);
            break :blk Common.mapCRefToTypesRef(c_ref, &pb);
        } else Common.mapCTypeRef(ptype, &pb, mapping, true);
        const nullable = if (param.kind == .handle or (param.kind == .data_struct and Common.hasPtrPrefix(ptype)))
            Common.paramNullability(mapping, fn_decl.name, fn_decl.params.items.len, i)
        else
            null;
        var nb: [256]u8 = undefined;
        try buf.print("{s}: {s}", .{ param.name, Common.applyPointerNullability(zt, nullable, &nb) });
    }
    try buf.print(") {s} {{\n", .{actual_ret_type});

    if (mapping.unimplemented.contains(fn_decl.name)) {
        try writeStubBody(buf, fn_decl, standalone_out_param_idx, "    ", false);
        try buf.appendSlice("}\n\n");
        return;
    }

    var ctor_name_buf: [128]u8 = undefined;
    if (constructorHandleName(mapping, fn_decl.name, &ctor_name_buf)) |handle_name| {
        try buf.print("    return {s}.create(", .{handle_name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try buf.appendSlice(param.name);
        }
        try buf.appendSlice(");\n}\n\n");
        return;
    }

    if (standalone_out_param_idx) |opi| {
        const first_param = fn_decl.params.items[opi];
        var ob: [256]u8 = undefined;
        const otype = mapping.ast.getNodeSource(first_param.type);
        const zot_raw = Common.mapCTypeRef(Common.stripCPtrPrefix(otype), &ob, mapping, true);
        var zot_buf: [256]u8 = undefined;
        const zot = Common.mapCRefToTypesRef(zot_raw, &zot_buf);
        try buf.print("    var result: {s} = .{{}};\n", .{zot});
        try buf.print("    const status = c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            if (i == opi) {
                try buf.appendSlice("@ptrCast(&result)");
            } else {
                try Common.writeParamExpr(buf, param, mapping);
            }
        }
        try buf.appendSlice(");\n");
        try buf.print("    try @as({s}, @enumFromInt(status)).toError();\n", .{status_type});
        try buf.appendSlice("    return result;\n");
    } else if (returns_status) {
        try buf.print("    const status = c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
        try buf.print("    try @as({s}, @enumFromInt(status)).toError();\n", .{status_type});
    } else if (returns_void) {
        try buf.print("    c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
    } else if (is_handle_ret) {
        try buf.print("    const result = c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
        if (ret_nullable) |nullable| {
            if (!nullable) {
                try buf.appendSlice("    return @ptrCast(result.?);\n");
            } else {
                try buf.appendSlice("    if (result) |r| return @ptrCast(r) else return null;\n");
            }
        } else {
            try buf.appendSlice("    if (result) |r| return @ptrCast(r) else return null;\n");
        }
    } else if (fn_decl.return_kind == .bool_c) {
        try buf.print("    return c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(") != 0;\n");
    } else if (standalone_ret_converted) {
        try buf.print("    const result = c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
        if (fn_decl.return_kind == .enum_c) {
            try buf.appendSlice("    return @enumFromInt(result);\n");
        } else {
            try buf.print("    return asC({s}, result);\n", .{actual_ret_type});
        }
    } else {
        try buf.print("    return c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
    }

    try buf.appendSlice("}\n\n");
}

test "detects count+pointer slice pairs structurally" {
    const params = [_]ParamInfo{
        .{ .name = "commandCount", .ctype = "usize", .kind = .primitive },
        .{ .name = "commands", .ctype = "[*c]const ?*struct_WGPUCommandBuffer", .kind = .pointer },
        .{ .name = "futureCount", .ctype = "usize", .kind = .primitive },
        .{ .name = "futures", .ctype = "?*struct_WGPUFutureWaitInfo", .kind = .data_struct },
        .{ .name = "dynamicOffsetCount", .ctype = "usize", .kind = .primitive },
        .{ .name = "dynamicOffsets", .ctype = "[*c]const u32", .kind = .pointer },
        // This is not a count parameter.
        .{ .name = "size", .ctype = "usize", .kind = .primitive },
        .{ .name = "data", .ctype = "[*c]const anyopaque", .kind = .pointer },
    };
    var pairs: [8]SlicePair = undefined;
    try std.testing.expectEqual(@as(usize, 3), findSlicePairs(&params, &pairs));
    try std.testing.expectEqual(@as(usize, 0), pairs[0].count_index);
    try std.testing.expectEqual(@as(usize, 1), pairs[0].ptr_index);
    try std.testing.expectEqual(@as(usize, 3), pairs[1].ptr_index);
    try std.testing.expectEqual(@as(usize, 5), pairs[2].ptr_index);

    try std.testing.expect(isCountParamName("commandCount"));
    try std.testing.expect(!isCountParamName("count"));
    try std.testing.expect(!isCountParamName("dynamicOffsets"));
}
