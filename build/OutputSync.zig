const std = @import("std");
const Ast = std.zig.Ast;
const Mapping = @import("Mapping.zig");
const Common = @import("OutputCommon.zig");

/// Generated sync wrapper for one WGPUFuture function.
pub const SyncDecl = struct {
    fn_name: []const u8,
    method: []const u8,
    sync_name: []const u8,
    result_type: []const u8,
    ctx_type: []const u8,
    receiver: []const u8,
    needs_instance: bool,
    needs_device: bool,
    uses_instance: bool,
    has_message: bool,
    status_zig: []const u8,
    out_field: ?[]const u8,
    out_handle: ?[]const u8,
    callback_info_zig: []const u8,
    trampoline: []const u8,
    params: []Param,
    cb_params: []CbParam,
    /// Use the *Raw method when the async method takes slices.
    use_raw_call: bool = false,
};

pub const Param = struct {
    name: []const u8,
    zig_type: []const u8,
};

pub const ParamKind = enum { status, handle, message };

pub const CbParam = struct {
    name: []const u8,
    c_type: []const u8,
    kind: ParamKind,
};

fn isHandleType(mapping: *Mapping, name: []const u8) bool {
    if (mapping.handle_decls.contains(name)) return true;
    if (std.mem.startsWith(u8, name, "WGPU")) {
        var buf: [256]u8 = undefined;
        const impl = std.fmt.bufPrint(&buf, "{s}Impl", .{name}) catch return false;
        return mapping.handle_decls.contains(impl);
    }
    return false;
}

fn isIdentChar(c: u8) bool {
    return std.ascii.isAlphanumeric(c) or c == '_';
}

/// Returns the last identifier of a C type, so "[*c]const WGPUAdapter" becomes "WGPUAdapter".
fn bareName(source: []const u8) []const u8 {
    var end = source.len;
    while (end > 0 and !isIdentChar(source[end - 1])) end -= 1;
    var start = end;
    while (start > 0 and isIdentChar(source[start - 1])) start -= 1;
    return source[start..end];
}

/// Finds WGPUFuture functions and their callback infos.
pub fn discover(mapping: *Mapping) !std.ArrayList(SyncDecl) {
    var out: std.ArrayList(SyncDecl) = .empty;

    var fn_iter = mapping.fn_decls.iterator();
    while (fn_iter.next()) |entry| {
        const fn_decl = entry.value_ptr.*;

        const ret_node = fn_decl.return_type.unwrap() orelse continue;
        if (!std.mem.eql(u8, mapping.ast.getNodeSource(ret_node), "WGPUFuture")) continue;

        // Find the trailing callback-info parameter.
        var cb_idx: ?usize = null;
        var i = fn_decl.params.items.len;
        while (i > 0) {
            i -= 1;
            const pt = mapping.ast.getNodeSource(fn_decl.params.items[i].type);
            if (std.mem.endsWith(u8, bareName(pt), "CallbackInfo")) {
                cb_idx = i;
                break;
            }
        }
        const cb_param_idx = cb_idx orelse {
            std.log.warn("sync: {s} returns a future but has no callback-info parameter", .{fn_decl.name});
            continue;
        };

        const cbi_name = bareName(mapping.ast.getNodeSource(fn_decl.params.items[cb_param_idx].type));
        const cbi_struct = mapping.struct_decls.get(cbi_name) orelse {
            std.log.warn("sync: no struct decl for {s}", .{cbi_name});
            continue;
        };

        var cb_typename: ?[]const u8 = null;
        for (cbi_struct.fields.items) |field| {
            if (std.mem.eql(u8, field.name, "callback")) {
                cb_typename = bareName(mapping.ast.getNodeSource(field.type));
            }
        }
        const cb_type = cb_typename orelse {
            std.log.warn("sync: {s} has no callback field", .{cbi_name});
            continue;
        };
        const cb_decl = mapping.callback_decls.get(cb_type) orelse {
            std.log.warn("sync: no callback decl for {s}", .{cb_type});
            continue;
        };

        if (mapping.unimplemented.contains(fn_decl.name)) {
            std.log.warn("sync: skipping {s} (unimplemented in wgpu-native)", .{fn_decl.name});
            continue;
        }

        if (fn_decl.params.items.len == 0 or fn_decl.params.items[0].kind != .handle) continue;
        const receiver_c = bareName(mapping.ast.getNodeSource(fn_decl.params.items[0].type));
        const receiver = Common.zigHandleName(receiver_c);

        // Same method name as the handle methods.
        var name_buf: [128]u8 = undefined;
        const after_wgpu = Common.stripWgpuFunc(fn_decl.name);
        const method_rest = if (std.mem.startsWith(u8, after_wgpu, receiver))
            after_wgpu[receiver.len..]
        else
            after_wgpu;
        const method = try mapping.arena.dupe(u8, Common.lowerFirst(method_rest, &name_buf));

        const base = if (std.mem.endsWith(u8, method, "Async"))
            method[0 .. method.len - "Async".len]
        else
            method;
        const sync_name = try std.fmt.allocPrint(mapping.arena, "{s}Sync", .{base});
        var cb_params: std.ArrayList(CbParam) = .empty;
        var status_c: ?[]const u8 = null;
        var out_field: ?[]const u8 = null;
        var out_handle: ?[]const u8 = null;
        var has_message = false;
        var unsupported = false;

        for (cb_decl.params.items) |cp| {
            const tname = bareName(cp.type);
            if (std.mem.startsWith(u8, cp.name, "userdata")) continue;

            if (std.mem.eql(u8, tname, "WGPUStringView")) {
                has_message = true;
                try cb_params.append(mapping.arena, .{
                    .name = try mapping.arena.dupe(u8, cp.name),
                    .c_type = "c.WGPUStringView",
                    .kind = .message,
                });
                continue;
            }
            if (std.mem.endsWith(u8, tname, "Status") and mapping.enum_decls.contains(tname)) {
                status_c = try mapping.arena.dupe(u8, tname);
                try cb_params.append(mapping.arena, .{
                    .name = try mapping.arena.dupe(u8, cp.name),
                    .c_type = try std.fmt.allocPrint(mapping.arena, "c.{s}", .{tname}),
                    .kind = .status,
                });
                continue;
            }
            if (isHandleType(mapping, tname)) {
                out_field = try mapping.arena.dupe(u8, cp.name);
                out_handle = Common.zigHandleName(tname);
                try cb_params.append(mapping.arena, .{
                    .name = try mapping.arena.dupe(u8, cp.name),
                    .c_type = try std.fmt.allocPrint(mapping.arena, "c.{s}", .{tname}),
                    .kind = .handle,
                });
                continue;
            }

            unsupported = true;
            break;
        }

        if (unsupported or status_c == null) {
            std.log.warn("sync: skipping {s} (callback payload is not status/handle/message)", .{fn_decl.name});
            continue;
        }

        // Parameters forwarded to the async method.
        var params: std.ArrayList(Param) = .empty;
        for (fn_decl.params.items[1..], 0..) |param, pi| {
            if (pi + 1 == cb_param_idx) continue;
            const ptype = mapping.ast.getNodeSource(param.type);
            var pb: [256]u8 = undefined;
            const zt = if (param.kind == .data_struct and Common.hasPtrPrefix(ptype) and !std.mem.endsWith(u8, ptype, "CallbackInfo")) blk: {
                var inner: [256]u8 = undefined;
                const c_ref = Common.mapCTypeRef(ptype, &inner, mapping, true);
                break :blk Common.mapCRefToTypesRef(c_ref, &pb);
            } else Common.mapCTypeRef(ptype, &pb, mapping, true);
            const nullable = if (param.kind == .handle or (param.kind == .data_struct and Common.hasPtrPrefix(ptype)))
                Common.paramNullability(mapping, fn_decl.name, fn_decl.params.items.len, pi + 1)
            else
                null;
            var nb: [256]u8 = undefined;
            const zt_final = Common.applyPointerNullability(zt, nullable, &nb);
            try params.append(mapping.arena, .{
                .name = try mapping.arena.dupe(u8, param.name),
                .zig_type = try mapping.arena.dupe(u8, zt_final),
            });
        }

        try out.append(mapping.gpa, .{
            .fn_name = fn_decl.name,
            .method = method,
            .sync_name = sync_name,
            .result_type = try std.fmt.allocPrint(mapping.arena, "{s}Result", .{capitalized(mapping, base)}),
            .ctx_type = try std.fmt.allocPrint(mapping.arena, "{s}SyncCtx", .{capitalized(mapping, base)}),
            .receiver = receiver,
            // Instance and Adapter spin processEvents, while Buffer, Queue and Device wait on poll(true).
            .uses_instance = !std.mem.eql(u8, receiver, "Device") and
                !std.mem.eql(u8, receiver, "Buffer") and !std.mem.eql(u8, receiver, "Queue"),
            .needs_instance = !std.mem.eql(u8, receiver, "Instance") and
                !std.mem.eql(u8, receiver, "Device") and
                !std.mem.eql(u8, receiver, "Buffer") and !std.mem.eql(u8, receiver, "Queue"),
            .needs_device = std.mem.eql(u8, receiver, "Buffer") or std.mem.eql(u8, receiver, "Queue"),
            .has_message = has_message,
            .status_zig = try std.fmt.allocPrint(mapping.arena, "types.{s}", .{status_c.?[4..]}),
            .out_field = out_field,
            .out_handle = out_handle,
            .callback_info_zig = try std.fmt.allocPrint(mapping.arena, "types.{s}", .{cbi_name[4..]}),
            .trampoline = try std.fmt.allocPrint(mapping.arena, "{s}SyncTrampoline", .{base}),
            .use_raw_call = Common.hasSlicePair(mapping, fn_decl, 1, fn_decl.params.items.len),
            .params = try params.toOwnedSlice(mapping.arena),
            .cb_params = try cb_params.toOwnedSlice(mapping.arena),
        });
    }

    return out;
}

fn capitalized(mapping: *Mapping, s: []const u8) []const u8 {
    if (s.len == 0) return s;
    const dup = mapping.arena.dupe(u8, s) catch return s;
    dup[0] = std.ascii.toUpper(dup[0]);
    return dup;
}

/// Emits result structs and trampolines before the handle types.
pub fn writePrelude(buf: *std.array_list.Managed(u8), mapping: *Mapping, decls: []const SyncDecl) !void {
    _ = mapping;
    for (decls) |decl| {
        try buf.print(
            \\pub const {s} = struct {{
            \\    status: {s} = undefined,
            \\
        , .{ decl.result_type, decl.status_zig });
        if (decl.out_field) |field| {
            try buf.print("    {s}: ?*{s} = null,\n", .{ field, decl.out_handle.? });
        }
        if (decl.has_message) {
            try buf.appendSlice(
                \\    message_buf: [512]u8 = undefined,
                \\    message_len: usize = 0,
                \\
                \\    pub fn message(self: *const @This()) []const u8 {
                \\        return self.message_buf[0..self.message_len];
                \\    }
                \\
            );
        }
        try buf.appendSlice("};\n\n");

        // Per-call completion state.
        try buf.print("const {s} = struct {{ response: {s} = .{{}}, done: bool = false }};\n\n", .{ decl.ctx_type, decl.result_type });

        // The trampoline signature follows the callback typedef.
        try buf.print("fn {s}(", .{decl.trampoline});
        for (decl.cb_params, 0..) |p, i| {
            if (i > 0) try buf.appendSlice(", ");
            try buf.print("{s}: {s}", .{ p.name, p.c_type });
        }
        try buf.appendSlice(", userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {\n");
        try buf.appendSlice("    _ = userdata2;\n");
        try buf.print("    const ctx: *{s} = @ptrCast(@alignCast(userdata1));\n", .{decl.ctx_type});
        for (decl.cb_params) |p| {
            switch (p.kind) {
                .status => try buf.print("    ctx.response.status = @enumFromInt({s});\n", .{p.name}),
                .handle => try buf.print(
                    "    ctx.response.{s} = if ({s}) |h| {s}.fromPtr(@ptrCast(h)) else null;\n",
                    .{ decl.out_field.?, p.name, decl.out_handle.? },
                ),
                .message => {
                    if (!decl.has_message) continue;
                    try buf.print(
                        \\    if ({s}.data) |d| {{
                        \\        const n = @min({s}.length, ctx.response.message_buf.len);
                        \\        @memcpy(ctx.response.message_buf[0..n], d[0..n]);
                        \\        ctx.response.message_len = n;
                        \\    }}
                        \\
                    , .{ p.name, p.name });
                },
            }
        }
        try buf.appendSlice("    ctx.done = true;\n}\n\n");
    }
}

/// Emits the *Sync methods for one handle type.
pub fn writeMethodsFor(buf: *std.array_list.Managed(u8), decls: []const SyncDecl, hzname: []const u8) !void {
    for (decls) |decl| {
        if (!std.mem.eql(u8, decl.receiver, hzname)) continue;

        // Don't shadow a forwarded parameter.
        var has_instance_param = false;
        for (decl.params) |p| {
            if (std.mem.eql(u8, p.name, "instance")) has_instance_param = true;
        }
        const instance_name = if (has_instance_param) "wait_instance" else "instance";

        try buf.print("    pub fn {s}(self: *{s}, io: std.Io", .{ decl.sync_name, hzname });
        if (decl.needs_device) try buf.appendSlice(", device: *Device");
        if (decl.needs_instance) try buf.print(", {s}: *Instance", .{instance_name});
        for (decl.params) |p| {
            try buf.print(", {s}: {s}", .{ p.name, p.zig_type });
        }
        try buf.print(") types.WaitStatusError!{s} {{\n", .{decl.result_type});

        try buf.print("        var ctx: {s} = .{{}};\n", .{decl.ctx_type});
        try buf.print("        const future = self.{s}{s}(", .{ decl.method, if (decl.use_raw_call) "Raw" else "" });
        var first_arg = true;
        for (decl.params) |p| {
            if (!first_arg) try buf.appendSlice(", ");
            try buf.appendSlice(p.name);
            first_arg = false;
        }
        if (!first_arg) try buf.appendSlice(", ");
        try buf.print(
            "{s}{{ .mode = .allow_process_events, .callback = &{s}, .userdata1 = @ptrCast(&ctx) }});\n",
            .{ decl.callback_info_zig, decl.trampoline },
        );
        try buf.appendSlice("        _ = future;\n");
        const instance_expr = if (decl.needs_instance) instance_name else "self";
        if (decl.uses_instance) {
            try buf.appendSlice("        var spins: u32 = 0;\n");
            try buf.appendSlice("        while (!ctx.done) {\n");
            try buf.print("            {s}.processEvents();\n", .{instance_expr});
            try buf.appendSlice("            if (ctx.done) break;\n");
            try buf.appendSlice("            if (spins < 16) {\n                spins += 1;\n                continue;\n            }\n");
            try buf.appendSlice("            std.Io.sleep(io, std.Io.Duration.fromMilliseconds(1), .awake) catch {};\n");
            try buf.appendSlice("        }\n");
        } else {
            const device_expr = if (decl.needs_device) "device" else "self";
            try buf.appendSlice("        while (!ctx.done) {\n");
            try buf.print("            _ = {s}.poll(true, null);\n", .{device_expr});
            try buf.appendSlice("            if (ctx.done) break;\n");
            try buf.appendSlice("            std.Io.sleep(io, std.Io.Duration.fromMilliseconds(1), .awake) catch {};\n");
            try buf.appendSlice("        }\n");
        }
        try buf.appendSlice("        return ctx.response;\n");
        try buf.appendSlice("    }\n\n");
    }
}
