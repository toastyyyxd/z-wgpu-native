const std = @import("std");
const Ast = std.zig.Ast;
const Mapping = @import("Mapping.zig");

pub fn discover(mapping: *Mapping) !void {
    for (mapping.ast.rootDecls()) |root_node| {
        const var_decl = mapping.ast.fullVarDecl(root_node) orelse continue;
        const init_node = var_decl.ast.init_node.unwrap() orelse continue;
        if (mapping.ast.nodeTag(init_node) != .identifier) continue;
        const init_slice = mapping.ast.tokenSlice(mapping.ast.firstToken(init_node));
        if (!std.mem.eql(u8, init_slice, "WGPUFlags")) continue;

        const name_token = var_decl.ast.mut_token + 1;
        const name = mapping.ast.tokenSlice(name_token);
        const flags_decl = try mapping.arena.create(Mapping.FlagsDecl);
        flags_decl.* = .{ .node = root_node };
        try mapping.flag_decls.put(mapping.gpa, name, flags_decl);
        try mapping.decls.put(mapping.gpa, root_node, .{ .flags = flags_decl });
    }
}

pub fn generate(mapping: *Mapping) !void {
    var flags_iter = mapping.flag_decls.iterator();
    while (flags_iter.next()) |entry| {
        const flags_name = entry.key_ptr.*;
        const flags_decl = entry.value_ptr.*;

        for (mapping.ast.rootDecls()) |root_node| {
            const var_decl = mapping.ast.fullVarDecl(root_node) orelse continue;
            const type_node = var_decl.ast.type_node.unwrap() orelse continue;
            if (mapping.ast.nodeTag(type_node) != .identifier) continue;
            const type_name = mapping.ast.tokenSlice(mapping.ast.firstToken(type_node));
            if (!std.mem.eql(u8, type_name, flags_name)) continue;

            const name_token = var_decl.ast.mut_token + 1;
            const name = mapping.ast.tokenSlice(name_token);

            if (name.len <= flags_name.len + 1) continue;
            if (!std.mem.startsWith(u8, name, flags_name)) continue;
            if (name[flags_name.len] != '_') continue;

            const value_name = name[flags_name.len + 1 ..];
            if (std.mem.eql(u8, value_name, "Force32")) {
                flags_decl.has_force32 = true;
                continue;
            }
            if (std.mem.eql(u8, value_name, "None")) continue;

            const init_text = mapping.ast.getNodeSource(var_decl.ast.init_node.unwrap().?);
            if (std.mem.eql(u8, init_text, "0")) continue;

            const field_decl = try mapping.arena.create(Mapping.FieldDecl);
            field_decl.* = .{
                .node = root_node,
                .type = var_decl.ast.type_node.unwrap().?,
                .init = var_decl.ast.init_node,
            };

            // Classify as composite (multi-bit preset) or single-bit value
            if (std.mem.startsWith(u8, init_text, "@bitCast")) {
                if (std.mem.indexOfScalar(u8, init_text, '|') != null) {
                    // Multi-bit composite (OR of multiple bits)
                    try flags_decl.composites.put(mapping.gpa, value_name, field_decl);
                } else {
                    // Single-bit — treat as regular value for packed struct field
                    try flags_decl.values.put(mapping.gpa, value_name, field_decl);
                }
            } else if (isSimpleInt(init_text)) {
                try flags_decl.values.put(mapping.gpa, value_name, field_decl);
            } else {
                try flags_decl.composites.put(mapping.gpa, value_name, field_decl);
            }
            try mapping.decls.put(mapping.gpa, root_node, .{ .field = field_decl });
        }
    }
}

fn isSimpleInt(s: []const u8) bool {
    for (s) |c| {
        if (c < '0' or c > '9') return false;
    }
    return s.len > 0;
}
