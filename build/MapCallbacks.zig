const std = @import("std");
const Ast = std.zig.Ast;
const Mapping = @import("Mapping.zig");

pub fn discover(mapping: *Mapping) !void {
    for (mapping.ast.rootDecls()) |root_node| {
        const var_decl = mapping.ast.fullVarDecl(root_node) orelse continue;
        const name_token = var_decl.ast.mut_token + 1;
        const name = mapping.ast.tokenSlice(name_token);

        // Look for callback typedefs: WGPU*Callback = ?*const fn (...) callconv(.c) void;
        if (!std.mem.endsWith(u8, name, "Callback")) continue;

        const init_node = var_decl.ast.init_node.unwrap() orelse continue;
        const init_text = mapping.ast.getNodeSource(init_node);
        if (!std.mem.startsWith(u8, init_text, "?*const fn (")) continue;

        // Parse params from the init text
        const paren_open = std.mem.indexOfScalar(u8, init_text, '(') orelse continue;
        const paren_close = std.mem.indexOfScalarPos(u8, init_text, paren_open, ')') orelse continue;
        const params_text = init_text[paren_open + 1 .. paren_close];

        const cb_decl = try mapping.arena.create(Mapping.CallbackDecl);
        cb_decl.* = .{
            .node = root_node,
            .name = name,
        };

        // Parse individual params
        var userdata_count: u2 = 0;
        if (params_text.len > 0) {
            var remaining = params_text;
            while (remaining.len > 0) {
                // Find next comma at paren-depth 0 (handles arbitrary nesting)
                var comma_idx: ?usize = null;
                var depth: u32 = 0;
                for (remaining, 0..) |c, i| {
                    switch (c) {
                        '(' => depth += 1,
                        ')' => depth -|= 1,
                        ',' => if (depth == 0) { comma_idx = i; break; },
                        else => {},
                    }
                }
                const param_text = if (comma_idx) |ci| remaining[0..ci] else remaining;
                const trimmed = std.mem.trim(u8, param_text, " ");

                const colon_idx = std.mem.indexOfScalar(u8, trimmed, ':') orelse break;
                const pname = std.mem.trim(u8, trimmed[0..colon_idx], " ");

                var ptype = std.mem.trim(u8, trimmed[colon_idx + 1 ..], " ");
                // Remove trailing comma if any
                if (std.mem.endsWith(u8, ptype, ",")) {
                    ptype = ptype[0 .. ptype.len - 1];
                }

                const is_ud = std.mem.startsWith(u8, pname, "userdata");
                if (is_ud) userdata_count += 1;

                // Copy to arena
                const name_copy = try mapping.arena.dupe(u8, pname);
                const type_copy = try mapping.arena.dupe(u8, ptype);

                try cb_decl.params.append(mapping.gpa, .{
                    .name = name_copy,
                    .type = type_copy,
                    .is_userdata = is_ud,
                });

                if (comma_idx) |ci| {
                    remaining = remaining[ci + 1 ..];
                } else {
                    break;
                }
            }
        }

        cb_decl.userdata_count = userdata_count;
        try mapping.callback_decls.put(mapping.gpa, name, cb_decl);
    }
}

pub fn generate(_: *Mapping) !void {
    // Matching happens during codegen output
}
