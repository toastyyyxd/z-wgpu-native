const std = @import("std");
const Mapping = @import("Mapping.zig");
const Common = @import("OutputCommon.zig");

pub fn writeHandlesAndFuncs(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    try buf.appendSlice("const c = @import(\"c_wgpu_native\");\nconst types = @import(\"types.zig\");\n\n");

    // Build a map: handle zig name -> list of function names
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

    // Write handles with methods (in declaration order via premap)
    for (mapping.handle_names.items) |hname| {
        _ = mapping.handle_decls.get(hname) orelse continue;
        const hzname = Common.zigHandleName(hname);

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

        // Emit Optional{Handle}: 8-byte extern struct for nullable handle fields
        try buf.print("pub const Optional{s} = extern struct {{\n", .{hzname});
        try buf.appendSlice("    ptr: ?*anyopaque,\n\n");
        try buf.print("    pub fn wrap(handle: {s}) Optional{s} {{\n", .{ hzname, hzname });
        try buf.appendSlice("        return .{ .ptr = handle.ptr };\n");
        try buf.appendSlice("    }\n\n");
        try buf.print("    pub fn none() Optional{s} {{\n", .{hzname});
        try buf.appendSlice("        return .{ .ptr = null };\n");
        try buf.appendSlice("    }\n\n");
        try buf.print("    pub fn isSome(self: Optional{s}) bool {{\n", .{hzname});
        try buf.appendSlice("        return self.ptr != null;\n");
        try buf.appendSlice("    }\n\n");
        try buf.print("    pub fn isNull(self: Optional{s}) bool {{\n", .{hzname});
        try buf.appendSlice("        return self.ptr == null;\n");
        try buf.appendSlice("    }\n\n");
        try buf.print("    pub fn get(self: Optional{s}) ?{s} {{\n", .{ hzname, hzname });
        try buf.appendSlice("        if (self.ptr) |p| return .{ .ptr = p };\n");
        try buf.appendSlice("        return null;\n");
        try buf.appendSlice("    }\n\n");
        try buf.print("    pub fn unwrap(self: Optional{s}) {s} {{\n", .{ hzname, hzname });
        try buf.appendSlice("        return .{ .ptr = self.ptr.? };\n");
        try buf.appendSlice("    }\n");
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
        \\pub fn waitAny(instance: Instance, futures: []types.FutureWaitInfo, timeout_ns: u64) !usize {
        \\    const status = c.wgpuInstanceWaitAny(@ptrCast(instance.ptr), futures.len, @ptrCast(futures.ptr), timeout_ns);
        \\    if (status == c.WGPUWaitStatus_Success) return futures.len;
        \\    if (status == c.WGPUWaitStatus_TimedOut) return error.Timeout;
        \\    return error.Unexpected;
        \\}
        \\
    );
}

fn writeHandleMethod(buf: *std.array_list.Managed(u8), mapping: *Mapping, fn_decl: *Mapping.FnDecl, hzname: []const u8) !void {
    var name_buf: [128]u8 = undefined;
    const after_wgpu = Common.stripWgpuFunc(fn_decl.name);
    const method = if (std.mem.startsWith(u8, after_wgpu, hzname))
        after_wgpu[hzname.len..]
    else
        after_wgpu;
    const zname = Common.lowerFirst(method, &name_buf);

    // Skip C refcounting methods: not for public API
    if (std.mem.endsWith(u8, fn_decl.name, "AddRef") or std.mem.endsWith(u8, fn_decl.name, "Release")) return;

    var ret_buf: [256]u8 = undefined;
    const ret_slice = if (fn_decl.return_type.unwrap()) |rt|
        mapping.ast.getNodeSource(rt)
    else
        "void";
    const ret_type = Common.mapCTypeRef(ret_slice, &ret_buf, mapping, true);
    const returns_void = std.mem.eql(u8, ret_type, "void");
    const returns_status = std.mem.eql(u8, ret_slice, "WGPUStatus");
    const is_handle_ret = fn_decl.return_kind == .handle;

    // When WGPUStatus with out-param, return !OutType instead of !void
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
    if (out_param_idx) |opi| {
        const out_param = fn_decl.params.items[opi];
        const otype = mapping.ast.getNodeSource(out_param.type);
        var inner_buf: [256]u8 = undefined;
        const mapped_otype = Common.mapCTypeRef(Common.stripCPtrPrefix(otype), &inner_buf, mapping, true);
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "!{s}", .{mapped_otype}) catch unreachable;
    }

    // When returning a handle, use the handle type name directly (defined in handles.zig)
    if (is_handle_ret) {
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "!{s}", .{Common.typeSliceToHandleName(ret_slice)}) catch unreachable;
    }

    // For non-handle struct returns (e.g. c.WGPUFuture -> types.Future)
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
    try buf.print("    pub fn {s}(self: {s}", .{ zname, hzname });
    for (fn_decl.params.items[1..], 0..) |*param, i| {
        if (out_param_idx != null and i + 1 == out_param_idx.?) continue;
        var pb: [256]u8 = undefined;
        const ptype = mapping.ast.getNodeSource(param.type);
        const zt = if (param.kind == .data_struct and Common.hasPtrPrefix(mapping.ast.getNodeSource(param.type)) and !std.mem.endsWith(u8, ptype, "CallbackInfo")) blk: {
            var inner: [256]u8 = undefined;
            const c_ref = Common.mapCTypeRef(ptype, &inner, mapping, true);
            break :blk Common.mapCRefToTypesRef(c_ref, &pb);
        } else Common.mapCTypeRef(ptype, &pb, mapping, true);
        try buf.print(", {s}: {s}", .{ param.name, zt });
    }
    try buf.print(") {s} {{\n", .{actual_ret_type});

    // Generate body
    if (out_param_idx) |opi| {
        // Status return with out-param: allocate out struct, check status
        const out_param = fn_decl.params.items[opi];
        var ob: [256]u8 = undefined;
        const otype = mapping.ast.getNodeSource(out_param.type);
        const zot = Common.mapCTypeRef(Common.stripCPtrPrefix(otype), &ob, mapping, true);
        try buf.print("        var result: {s} = undefined;\n", .{zot});
        try buf.print("        const status = c.{s}(@ptrCast(self.ptr)", .{fn_decl.name});
        for (fn_decl.params.items[1..], 0..) |*param, i| {
            try buf.appendSlice(", ");
            if (i + 1 == opi) {
                try buf.appendSlice("@ptrCast(&result)");
            } else {
                try Common.writeParamExpr(buf, param, mapping);
            }
        }
        try buf.appendSlice(");\n");
        try buf.appendSlice("        if (status != 1) return error.Unexpected;\n");
        try buf.appendSlice("        return result;\n");
    } else if (returns_status) {
        // Status return, no out param
        try buf.print("        const status = c.{s}(@ptrCast(self.ptr)", .{fn_decl.name});
        for (fn_decl.params.items[1..]) |*param| {
            try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
        try buf.appendSlice("        if (status != 1) return error.Unexpected;\n");
    } else if (returns_void) {
        try buf.print("        c.{s}(@ptrCast(self.ptr)", .{fn_decl.name});
        for (fn_decl.params.items[1..]) |*param| {
            try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
    } else {
        if (is_handle_ret) {
            try buf.print("        const result = c.{s}(@ptrCast(self.ptr)", .{fn_decl.name});
            for (fn_decl.params.items[1..]) |*param| {
                try buf.appendSlice(", ");
                try Common.writeParamExpr(buf, param, mapping);
            }
            try buf.appendSlice(");\n");
            try buf.appendSlice("        return .{ .ptr = @ptrCast(result.?) };\n");
        } else {
            if (ret_type_converted) {
                try buf.print("        const result = c.{s}(@ptrCast(self.ptr)", .{fn_decl.name});
                for (fn_decl.params.items[1..]) |*param| {
                    try buf.appendSlice(", ");
                    try Common.writeParamExpr(buf, param, mapping);
                }
                try buf.appendSlice(");\n");
                try buf.appendSlice("        return @bitCast(result);\n");
            } else {
                try buf.print("        return c.{s}(@ptrCast(self.ptr)", .{fn_decl.name});
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
    const returns_status = std.mem.eql(u8, ret_slice, "WGPUStatus");
    const is_handle_ret = fn_decl.return_kind == .handle;

    // When WGPUStatus with out-param, return !OutType instead of !void
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
        const first_param = fn_decl.params.items[opi];
        const otype = mapping.ast.getNodeSource(first_param.type);
        var inner_buf: [256]u8 = undefined;
        const mapped_otype_s = Common.mapCTypeRef(Common.stripCPtrPrefix(otype), &inner_buf, mapping, true);
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "!{s}", .{mapped_otype_s}) catch unreachable;
    }

    // When returning a handle, use the handle type name directly (defined in same file)
    if (is_handle_ret) {
        actual_ret_type = std.fmt.bufPrint(&actual_ret_buf, "!{s}", .{Common.typeSliceToHandleName(ret_slice)}) catch unreachable;
    }

    const standalone_ret_converted = !is_handle_ret and !returns_void and !returns_status and standalone_out_param_idx == null and std.mem.startsWith(u8, actual_ret_type, "types.");

    try buf.print("pub fn {s}(", .{zname});
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
        try buf.print("{s}: {s}", .{ param.name, zt });
    }
    try buf.print(") {s} {{\n", .{actual_ret_type});

    if (standalone_out_param_idx) |opi| {
        const first_param = fn_decl.params.items[opi];
        var ob: [256]u8 = undefined;
        const otype = mapping.ast.getNodeSource(first_param.type);
        const zot_raw = Common.mapCTypeRef(Common.stripCPtrPrefix(otype), &ob, mapping, true);
        var zot_buf: [256]u8 = undefined;
        const zot = Common.mapCRefToTypesRef(zot_raw, &zot_buf);
        try buf.print("        var result: {s} = undefined;\n", .{zot});
        try buf.print("        const status = c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            if (i == opi) {
                try buf.appendSlice("&result");
            } else {
                try Common.writeParamExpr(buf, param, mapping);
            }
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
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
    } else if (is_handle_ret) {
        try buf.print("        const result = c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
        try buf.appendSlice("        return .{ .ptr = @ptrCast(result.?) };\n");
    } else if (standalone_ret_converted) {
        try buf.print("        const result = c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
        try buf.appendSlice("        return @bitCast(result);\n");
    } else {
        try buf.print("        return c.{s}(", .{fn_decl.name});
        for (fn_decl.params.items, 0..) |*param, i| {
            if (i > 0) try buf.appendSlice(", ");
            try Common.writeParamExpr(buf, param, mapping);
        }
        try buf.appendSlice(");\n");
    }

    try buf.appendSlice("}\n\n");
}
