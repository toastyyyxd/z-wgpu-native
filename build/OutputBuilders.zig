const std = @import("std");
const Mapping = @import("Mapping.zig");
const OutputTypes = @import("OutputTypes.zig");
const Common = @import("OutputCommon.zig");

/// Builders for chained structs. The builder owns the parent and chain structs,
/// so descriptor() wires up next_in_chain. Keep it alive for the create call.
pub fn writeBuilders(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    try buf.appendSlice("const std = @import(\"std\");\nconst c = @import(\"c_wgpu_native\");\nconst types = @import(\"types.zig\");\nconst handles = @import(\"handles.zig\");\n\n");

    for (mapping.builder_pairs.items) |pair| {
        const parent_decl = mapping.struct_decls.get(pair.parent_c) orelse continue;
        const child_decl = mapping.struct_decls.get(pair.child_c) orelse continue;
        const parent_zig = Common.zigStructName(pair.parent_c);
        const child_zig = Common.zigStructName(pair.child_c);
        const name = try std.fmt.allocPrint(mapping.arena, "{s}With{s}", .{ parent_zig, child_zig });

        try buf.print("pub const {s} = struct {{\n", .{name});

        // Merge parent fields (minus next_in_chain) with child fields (minus chain).
        // Field types and defaults come from types.zig.
        try writeFields(buf, mapping, parent_decl, "nextInChain", parent_zig);
        try writeFields(buf, mapping, child_decl, "chain", child_zig);

        try buf.print("    _chain: types.{s} = undefined,\n", .{child_zig});
        try buf.print("    _desc: types.{s} = undefined,\n\n", .{parent_zig});

        try buf.print("    pub fn descriptor(self: *@This()) *const types.{s} {{\n", .{parent_zig});
        try buf.print("        self._chain = .{{ .chain = .{{ .s_type = @enumFromInt(c.{s}) }}", .{pair.s_type_const});
        try writeAssignments(buf, mapping, child_decl, "chain");
        try buf.appendSlice(" };\n");
        try buf.appendSlice("        self._desc = .{ .next_in_chain = @ptrCast(&self._chain.chain)");
        try writeAssignments(buf, mapping, parent_decl, "nextInChain");
        try buf.appendSlice(" };\n");
        try buf.appendSlice("        return &self._desc;\n");
        try buf.appendSlice("    }\n\n");

        // Copy the parent/child slice setters so builder fields can be filled
        // from slices rather than raw count + pointer.
        try OutputTypes.writeSliceSetters(buf, mapping, parent_decl, name, "types.");
        try OutputTypes.writeSliceSetters(buf, mapping, child_decl, name, "types.");
        try buf.appendSlice("};\n\n");
    }
}

fn writeFields(buf: *std.array_list.Managed(u8), mapping: *Mapping, decl: *Mapping.StructDecl, skip: []const u8, owner_zig: []const u8) !void {
    for (decl.fields.items) |f| {
        if (std.mem.eql(u8, f.name, skip)) continue;
        var name_buf: [128]u8 = undefined;
        const fname = Common.zigFieldName(f.name, &name_buf);
        try buf.print(
            "    {s}: @TypeOf((types.{s}{{}}).{s}) = (types.{s}{{}}).{s},\n",
            .{ fname, owner_zig, fname, owner_zig, fname },
        );
    }
    _ = mapping;
}

fn writeAssignments(buf: *std.array_list.Managed(u8), mapping: *Mapping, decl: *Mapping.StructDecl, skip: []const u8) !void {
    for (decl.fields.items) |f| {
        if (std.mem.eql(u8, f.name, skip)) continue;
        var name_buf: [128]u8 = undefined;
        const fname = Common.zigFieldName(f.name, &name_buf);
        try buf.print(", .{s} = self.{s}", .{ fname, fname });
    }
    _ = mapping;
}
