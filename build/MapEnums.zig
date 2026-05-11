const std = @import("std");
const Ast = std.zig.Ast;
const Mapping = @import("Mapping.zig");

pub fn discover(mapping: *Mapping) !void {
    for (mapping.ast.rootDecls()) |root_node| {
        const var_decl = mapping.ast.fullVarDecl(root_node) orelse continue;
        const name_token = var_decl.ast.mut_token + 1;
        const name = mapping.ast.tokenSlice(name_token);
        if (!std.mem.startsWith(u8, name, "enum_")) continue;

        const enum_name = name["enum_".len..];
        const enum_decl = try mapping.arena.create(Mapping.EnumDecl);
        enum_decl.* = .{
            .node = root_node,
            .type = var_decl.ast.init_node.unwrap() orelse continue,
        };
        try mapping.enum_decls.put(mapping.gpa, enum_name, enum_decl);
        try mapping.decls.put(mapping.gpa, root_node, .{ .@"enum" = enum_decl });
    }
}

pub fn generate(mapping: *Mapping) !void {
    var enum_iter = mapping.enum_decls.iterator();
    while (enum_iter.next()) |entry| {
        const enum_name = entry.key_ptr.*;
        const enum_decl = entry.value_ptr.*;

        for (mapping.ast.rootDecls()) |root_node| {
            const var_decl = mapping.ast.fullVarDecl(root_node) orelse continue;
            const name_token = var_decl.ast.mut_token + 1;
            const name = mapping.ast.tokenSlice(name_token);

            if (name.len <= enum_name.len + 1) continue;
            if (!std.mem.startsWith(u8, name, enum_name)) continue;
            if (name[enum_name.len] != '_') continue;

            const value_name = name[enum_name.len + 1 ..];
            const init_text = mapping.ast.getNodeSource(var_decl.ast.init_node.unwrap().?);
            if (std.mem.eql(u8, init_text, "2147483647")) continue;

            const field_decl = try mapping.arena.create(Mapping.FieldDecl);
            field_decl.* = .{
                .node = root_node,
                .type = enum_decl.type,
                .init = var_decl.ast.init_node,
            };
            try enum_decl.values.put(mapping.gpa, value_name, field_decl);
            try mapping.decls.put(mapping.gpa, root_node, .{ .field = field_decl });
        }
    }
}
