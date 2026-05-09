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
        if (!std.mem.eql(u8, first_slice, "opaque")) continue;

        const handle_name = name["struct_".len..];
        const handle_decl = try mapping.arena.create(Mapping.HandleDecl);
        handle_decl.* = .{ .node = root_node };
        try mapping.handle_decls.put(mapping.gpa, handle_name, handle_decl);
        try mapping.decls.put(mapping.gpa, root_node, .{ .handle = handle_decl });
    }
}

pub fn generate(mapping: *Mapping) !void {
    var handle_iter = mapping.handle_decls.iterator();
    while (handle_iter.next()) |entry| {
        const handle_decl = entry.value_ptr.*;

        const var_decl = mapping.ast.fullVarDecl(handle_decl.node) orelse continue;
        const init_node = var_decl.ast.init_node.unwrap() orelse continue;

        var buffer: [2]Ast.Node.Index = undefined;
        const container = mapping.ast.fullContainerDecl(&buffer, init_node) orelse continue;
        for (container.ast.members) |member_node| {
            const member_decl = mapping.ast.fullVarDecl(member_node) orelse continue;
            const member_name_token = member_decl.ast.mut_token + 1;
            const member_name = mapping.ast.tokenSlice(member_name_token);

            const fn_ref = Mapping.FnRef{
                .name = member_name,
                .node = member_node,
            };
            try handle_decl.methods.append(mapping.gpa, fn_ref);
        }
    }
}
