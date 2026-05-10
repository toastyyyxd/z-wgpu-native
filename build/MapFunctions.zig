const std = @import("std");
const Ast = std.zig.Ast;
const Mapping = @import("Mapping.zig");

pub fn discover(mapping: *Mapping) !void {
    for (mapping.ast.rootDecls()) |root_node| {
        var fn_buffer: [1]Ast.Node.Index = undefined;
        const fn_proto = mapping.ast.fullFnProto(&fn_buffer, root_node) orelse continue;

        const name_token = fn_proto.name_token orelse continue;
        const name = mapping.ast.tokenSlice(name_token);
        if (!std.mem.startsWith(u8, name, "wgpu")) continue;

        const fn_decl = try mapping.arena.create(Mapping.FnDecl);
        fn_decl.* = .{
            .node = root_node,
            .name = name,
            .return_type = fn_proto.ast.return_type,
        };

        for (fn_proto.ast.params) |param_node| {
            const type_expr = param_node;
            var tok_i: i64 = @intCast(mapping.ast.firstToken(type_expr));
            if (tok_i > 0) tok_i -= 1;
            var param_name_token: ?Ast.TokenIndex = null;
            while (tok_i > 0) : (tok_i -= 1) {
                switch (mapping.ast.tokenTag(@intCast(tok_i))) {
                    .colon => continue,
                    .identifier => {
                        param_name_token = @intCast(tok_i);
                        break;
                    },
                    .keyword_comptime, .keyword_noalias, .doc_comment => continue,
                    else => break,
                }
            }
            const param_name = if (param_name_token) |pt|
                mapping.ast.tokenSlice(pt)
            else
                "unnamed";

            try fn_decl.params.append(mapping.gpa, .{
                .name = param_name,
                .type = type_expr,
            });
        }

        try mapping.fn_decls.put(mapping.gpa, name, fn_decl);
    }
}

pub fn generate(mapping: *Mapping) !void {
    var fn_iter = mapping.fn_decls.iterator();
    while (fn_iter.next()) |entry| {
        const fn_decl = entry.value_ptr.*;

        for (fn_decl.params.items) |*param| {
            param.kind = resolveTypeKind(mapping, param.type);
        }

        fn_decl.return_kind = if (fn_decl.return_type.unwrap()) |rt|
            resolveReturnKind(mapping, rt)
        else
            .void;
    }
}

fn resolveTypeKind(mapping: *Mapping, type_node: Ast.Node.Index) Mapping.FnParamKind {
    _ = &type_node;
    var pname_buf: [256]u8 = undefined;
    while (true) {
        switch (mapping.ast.nodeTag(type_node)) {
            .identifier => {
                const type_name = mapping.ast.tokenSlice(mapping.ast.firstToken(type_node));
                if (mapping.handle_decls.contains(removePtrPrefix(type_name))) return .handle;
                if (std.mem.startsWith(u8, type_name, "WGPU") and
                mapping.handle_decls.contains(std.fmt.bufPrint(&pname_buf, "{s}Impl", .{type_name}) catch unreachable)) return .handle;
                if (mapping.struct_decls.contains(removePtrPrefix(type_name))) return .data_struct;
                if (mapping.flag_decls.contains(type_name)) return .flags;
                if (mapping.enum_decls.contains(removePtrPrefix(type_name))) return .enum_c;
                if (std.mem.eql(u8, type_name, "WGPUStringView")) return .string;
                if (std.mem.eql(u8, type_name, "WGPUBool")) return .bool_c;
                if (std.mem.eql(u8, type_name, "WGPUFlags")) return .flags;
                if (std.mem.startsWith(u8, type_name, "WGPU")) return .unknown;
                return .primitive;
            },
            .ptr_type, .ptr_type_bit_range, .ptr_type_aligned, .ptr_type_sentinel, .optional_type => {
                // Follow pointer/optional chain, but if the innermost is a handle, return .pointer
                var n = type_node;
                while (true) {
                    switch (mapping.ast.nodeTag(n)) {
                        .identifier => {
                            const tname = mapping.ast.tokenSlice(mapping.ast.firstToken(n));
                            if (mapping.handle_decls.contains(removePtrPrefix(tname))) return .pointer;
                            if (std.mem.startsWith(u8, tname, "WGPU") and
                                mapping.handle_decls.contains(std.fmt.bufPrint(&pname_buf, "{s}Impl", .{tname}) catch unreachable)) return .pointer;
                            if (mapping.struct_decls.contains(removePtrPrefix(tname))) return .data_struct;
                            return .unknown;
                        },
                        .ptr_type, .ptr_type_bit_range => n = mapping.ast.nodeData(n).extra_and_node[1],
                        .ptr_type_aligned, .ptr_type_sentinel => n = mapping.ast.nodeData(n).opt_node_and_node[1],
                        .optional_type => n = mapping.ast.nodeData(n).node,
                        else => return .unknown,
                    }
                }
            },
            else => return .unknown,
        }
    }
}

fn resolveReturnKind(mapping: *Mapping, return_node: Ast.Node.Index) Mapping.FnReturnKind {
    var rname_buf: [256]u8 = undefined;
    switch (mapping.ast.nodeTag(return_node)) {
        .identifier => {
            const type_name = mapping.ast.tokenSlice(mapping.ast.firstToken(return_node));
            if (mapping.handle_decls.contains(removePtrPrefix(type_name))) return .handle;
            if (std.mem.startsWith(u8, type_name, "WGPU") and
                mapping.handle_decls.contains(std.fmt.bufPrint(&rname_buf, "{s}Impl", .{type_name}) catch unreachable)) return .handle;
            if (mapping.struct_decls.contains(removePtrPrefix(type_name))) return .data_struct;
            if (mapping.flag_decls.contains(type_name)) return .flags;
            if (mapping.enum_decls.contains(removePtrPrefix(type_name))) return .enum_c;
            if (std.mem.eql(u8, type_name, "WGPUStatus")) return .status;
            if (std.mem.eql(u8, type_name, "WGPUFuture")) return .future;
            if (std.mem.eql(u8, type_name, "WGPUStringView")) return .string;
            if (std.mem.eql(u8, type_name, "WGPUBool")) return .bool_c;
            if (std.mem.eql(u8, type_name, "WGPUFlags")) return .flags;
            if (std.mem.startsWith(u8, type_name, "WGPU")) return .enum_c;
            return .primitive;
        },
        .ptr_type,
        .ptr_type_aligned,
        .ptr_type_sentinel,
        .ptr_type_bit_range,
        .optional_type,
        => return .pointer,
        else => return .primitive,
    }
}

fn removePtrPrefix(name: []const u8) []const u8 {
    // Trim "?*" prefix from type names like "?*struct_WGPUAdapterImpl"
    const trimmed_struct = if (std.mem.startsWith(u8, name, "struct_")) name else blk: {
        const n = if (std.mem.startsWith(u8, name, "?*")) name[2..] else name;
        break :blk if (std.mem.startsWith(u8, n, "struct_")) n else name;
    };
    if (std.mem.startsWith(u8, trimmed_struct, "struct_")) return trimmed_struct["struct_".len..];
    if (std.mem.startsWith(u8, trimmed_struct, "enum_")) return trimmed_struct["enum_".len..];
    return trimmed_struct;
}
