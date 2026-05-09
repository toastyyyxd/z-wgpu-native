const std = @import("std");
const Ast = std.zig.Ast;
const Mapping = @import("Mapping.zig");

pub fn discover(mapping: *Mapping) !void {
    for (mapping.ast.rootDecls()) |root_node| {
        const var_decl = mapping.ast.fullVarDecl(root_node) orelse continue;
        const name_token = var_decl.ast.mut_token + 1;
        const name = mapping.ast.tokenSlice(name_token);
        if (!std.mem.startsWith(u8, name, "struct_")) continue;

        const init_node = var_decl.ast.init_node.unwrap() orelse continue;
        const first_slice = mapping.ast.tokenSlice(mapping.ast.firstToken(init_node));
        if (std.mem.eql(u8, first_slice, "opaque")) continue;
        if (!std.mem.eql(u8, first_slice, "extern")) continue;

        const struct_name = name["struct_".len..];
        const struct_decl = try mapping.arena.create(Mapping.StructDecl);
        struct_decl.* = .{ .node = root_node };
        try mapping.struct_decls.put(mapping.gpa, struct_name, struct_decl);
        try mapping.decls.put(mapping.gpa, root_node, .{ .strct = struct_decl });
    }
}

pub fn generate(mapping: *Mapping) !void {
    var struct_iter = mapping.struct_decls.iterator();
    while (struct_iter.next()) |entry| {
        const struct_decl = entry.value_ptr.*;

        const var_decl = mapping.ast.fullVarDecl(struct_decl.node) orelse continue;
        const init_node = var_decl.ast.init_node.unwrap() orelse continue;

        var buffer: [2]Ast.Node.Index = undefined;
        const container = mapping.ast.fullContainerDecl(&buffer, init_node) orelse continue;
        for (container.ast.members) |field_node| {
            const field = mapping.ast.fullContainerField(field_node) orelse continue;
            const field_name = mapping.ast.tokenSlice(field.ast.main_token);
            const f = Mapping.StructField{
                .name = field_name,
                .type = field.ast.type_expr.unwrap() orelse continue,
                .init = field.ast.value_expr,
            };
            try struct_decl.fields.append(mapping.gpa, f);
        }
    }
}
