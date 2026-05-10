const std = @import("std");
const Mapping = @import("Mapping.zig");
const Common = @import("OutputCommon.zig");

pub fn writeTypes(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    try buf.appendSlice("const c = @import(\"c_wgpu_native\");\nconst std = @import(\"std\");\nconst handles = @import(\"handles.zig\");\nconst types = @This();\n\n");
    try writeEnums(buf, mapping);
    try writeFlags(buf, mapping);
    try writeStructs(buf, mapping);
}

fn writeEnums(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    var enum_iter = mapping.enum_decls.iterator();
    while (enum_iter.next()) |entry| {
        const cname = entry.key_ptr.*;
        const decl = entry.value_ptr.*;
        if (decl.values.count() == 0) continue;

        const zname = Common.zigEnumName(cname);

        var val_iter = decl.values.iterator();
        // Skip enums with only Force32 (shouldn't happen, but safety)
        var has_real: bool = false;
        while (val_iter.next()) |val| {
            if (!std.mem.eql(u8, val.key_ptr.*, "Force32")) has_real = true;
        }
        if (!has_real) continue;

        try buf.print("pub const {s} = enum(c_uint) {{\n", .{zname});

        // Collect values for sorting
        var sorted_vals: std.ArrayListUnmanaged(struct { name: []const u8, value: i64 }) = .empty;
        defer sorted_vals.deinit(mapping.gpa);

        val_iter = decl.values.iterator();
        while (val_iter.next()) |val| {
            const field_decl = val.value_ptr.*;
            const init_slice = mapping.ast.getNodeSource(field_decl.init.unwrap().?);
            const int_val = std.fmt.parseInt(i64, init_slice, 10) catch continue;
            try sorted_vals.append(mapping.gpa, .{ .name = val.key_ptr.*, .value = int_val });
        }

        std.sort.insertion(
            @TypeOf(sorted_vals.items[0]),
            sorted_vals.items,
            {},
            struct {
                fn lessThan(_: void, a: @TypeOf(sorted_vals.items[0]), b: @TypeOf(sorted_vals.items[0])) bool {
                    return a.value < b.value;
                }
            }.lessThan,
        );

        for (sorted_vals.items) |sv| {
            var name_buf: [128]u8 = undefined;
            const vname = Common.zigValueName(sv.name, &name_buf);
            if (Common.isZigKeyword(vname)) {
                try buf.print("    @\"{s}\" = {d},\n", .{ vname, sv.value });
            } else {
                try buf.print("    {s} = {d},\n", .{ vname, sv.value });
            }
        }

        try buf.appendSlice("};\n\n");
    }
}

fn writeFlags(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    var flag_iter = mapping.flag_decls.iterator();
    while (flag_iter.next()) |entry| {
        const cname = entry.key_ptr.*;
        const decl = entry.value_ptr.*;
        if (decl.values.count() == 0) continue;

        const zname = Common.zigFlagsName(cname);

        // Collect sorted values
        const SortedVal = struct { name: []const u8, bit: u8 };
        var sorted_vals: std.ArrayListUnmanaged(SortedVal) = .empty;
        defer sorted_vals.deinit(mapping.gpa);

        var val_iter = decl.values.iterator();
        while (val_iter.next()) |val| {
            const field_decl = val.value_ptr.*;
            const init_text = mapping.ast.getNodeSource(field_decl.init.unwrap().?);
            const bit_pos = parseFlagBit(init_text);
            try sorted_vals.append(mapping.gpa, .{ .name = val.key_ptr.*, .bit = bit_pos });
        }

        // Sort by bit position
        std.sort.insertion(SortedVal, sorted_vals.items, {}, struct {
            fn lt(_: void, a: SortedVal, b: SortedVal) bool { return a.bit < b.bit; }
        }.lt);

        // Deduplicate by bit position (keep first occurrence)
        var deduped: std.ArrayListUnmanaged(SortedVal) = .empty;
        defer deduped.deinit(mapping.gpa);
        for (sorted_vals.items) |sv| {
            if (deduped.items.len == 0 or deduped.items[deduped.items.len - 1].bit != sv.bit) {
                try deduped.append(mapping.gpa, sv);
            }
        }

        // Backing is always u64 — all WGPU flags are uint64_t.
        // has_force32 only guarantees minimum 32-bit width, never shrinks from u64.
        const backing = "u64";
        const backing_bits: u8 = 64;

        try buf.print("pub const {s} = packed struct({s}) {{\n", .{ zname, backing });

        var current_bit: u8 = 0;
        for (deduped.items) |sv| {
            if (sv.bit > current_bit) {
                const gap = sv.bit - current_bit;
                try buf.print("    _: u{d} = 0,\n", .{gap});
                current_bit = sv.bit;
            }
            var name_buf: [128]u8 = undefined;
            const vname = Common.zigValueName(sv.name, &name_buf);
            if (Common.isZigKeyword(vname)) {
                try buf.print("    @\"{s}\": bool = false,\n", .{vname});
            } else {
                try buf.print("    {s}: bool = false,\n", .{vname});
            }
            current_bit += 1;
        }
        const final_pad = backing_bits - current_bit;
        if (final_pad > 0) {
            try buf.print("    __: u{d} = 0,\n", .{final_pad});
        }

        try buf.print(
            \\    comptime {{ std.debug.assert(@bitSizeOf(@This()) == @bitSizeOf({s})); }}
            \\
        , .{backing});
        try buf.appendSlice("};\n\n");

        // Composite/preset flag constants (sorted by name)
        if (decl.composites.count() > 0) {
            const SortedComp = struct { name: []const u8, init_text: []const u8 };
            var sorted_comps: std.ArrayListUnmanaged(SortedComp) = .empty;
            defer sorted_comps.deinit(mapping.gpa);

            var comp_iter = decl.composites.iterator();
            while (comp_iter.next()) |comp| {
                const field_decl = comp.value_ptr.*;
                const init_text = mapping.ast.getNodeSource(field_decl.init.unwrap().?);
                try sorted_comps.append(mapping.gpa, .{ .name = comp.key_ptr.*, .init_text = init_text });
            }

            std.sort.insertion(SortedComp, sorted_comps.items, {}, struct {
                fn lt(_: void, a: SortedComp, b: SortedComp) bool {
                    return std.ascii.orderIgnoreCase(a.name, b.name) == .lt;
                }
            }.lt);

            for (sorted_comps.items) |comp| {
                var name_buf: [128]u8 = undefined;
                const vname = Common.zigValueName(comp.name, &name_buf);
                try buf.print("pub const {s}_{s}: {s} = @bitCast(@as(u64, {s}));\n", .{ zname, vname, zname, comp.init_text });
            }
            try buf.appendSlice("\n");
        }
    }
}

fn isSimpleInt(s: []const u8) bool {
    for (s) |c| {
        if (c < '0' or c > '9') return false;
    }
    return s.len > 0;
}

fn parseFlagBit(init_text: []const u8) u8 {
    if (std.mem.startsWith(u8, init_text, "@bitCast")) {
        const marker = "@intCast(@as(c_int, ";
        if (std.mem.indexOf(u8, init_text, marker)) |start| {
            const after = init_text[start + marker.len ..];
            const end = std.mem.indexOfScalar(u8, after, ')') orelse return 0;
            return std.fmt.parseInt(u8, after[0..end], 10) catch 0;
        }
        return 0;
    }
    if (isSimpleInt(init_text)) {
        const v = std.fmt.parseInt(u64, init_text, 10) catch return 0;
        if (v == 0) return 0;
        return @intCast(@ctz(v));
    }
    return 0;
}

fn writeStructs(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    for (mapping.struct_names.items) |sname| {
        const decl = mapping.struct_decls.get(sname) orelse continue;
        if (decl.fields.items.len == 0) continue;

        const zname = Common.zigStructName(sname);
        const container_kw: []const u8 = switch (decl.kind) {
            .@"struct" => "struct",
            .@"union" => "union",
        };

        try buf.print("pub const {s} = extern {s} {{\n", .{ zname, container_kw });

        for (decl.fields.items) |f| {
            var type_buf: [256]u8 = undefined;
            var name_buf: [128]u8 = undefined;
            const fname = Common.zigFieldName(f.name, &name_buf);
            const type_slice = mapping.ast.getNodeSource(f.type);
            const ztype = Common.mapTypeName(type_slice, &type_buf, mapping);

            if (f.init != .none) {
                const init_slice = mapping.ast.getNodeSource(f.init.unwrap().?);
                const mapped_init = mapFieldInit(type_slice, init_slice, mapping);
                var nullable_type_buf: [256]u8 = undefined;
                const final_ztype = if (std.mem.eql(u8, mapped_init, "null") and Common.isHandleLikeType(type_slice, mapping) and std.mem.startsWith(u8, ztype, "handles.Optional")) blk: {
                    break :blk ztype; // already optional via Optional{Handle}
                } else if (std.mem.eql(u8, mapped_init, "null") and Common.isHandleLikeType(type_slice, mapping)) blk: {
                    break :blk std.fmt.bufPrint(&nullable_type_buf, "?{s}", .{ztype}) catch unreachable;
                } else ztype;
                const zinit = if (std.mem.eql(u8, mapped_init, ".{}")) blk: {
                    if (std.mem.startsWith(u8, type_slice, "union_")) {
                        var zb: [256]u8 = undefined;
                        break :blk std.fmt.bufPrint(&zb, "std.mem.zeroes({s})", .{ztype}) catch unreachable;
                    }
                    if (mapping.enum_decls.get(type_slice)) |enum_decl| {
                        var val_iter = enum_decl.values.iterator();
                        while (val_iter.next()) |val| {
                            const init_text = mapping.ast.getNodeSource(val.value_ptr.*.init.unwrap().?);
                            if (std.mem.eql(u8, init_text, "0")) {
                                var vn_buf: [128]u8 = undefined;
                                const vname = Common.zigValueName(val.key_ptr.*, &vn_buf);
                                var ei_buf: [256]u8 = undefined;
                                if (Common.isZigKeyword(vname)) {
                                    break :blk std.fmt.bufPrint(&ei_buf, ".@\"{s}\"", .{vname}) catch unreachable;
                                } else {
                                    break :blk std.fmt.bufPrint(&ei_buf, ".{s}", .{vname}) catch unreachable;
                                }
                            }
                        }
                    }
                    break :blk @as([]const u8, "undefined");
                } else if (std.mem.eql(u8, mapped_init, "0") and mapping.flag_decls.get(type_slice) != null) @as([]const u8, ".{}")
                else mapped_init;
                try buf.print("    {s}: {s} = {s},\n", .{ fname, final_ztype, zinit });
            } else {
                try buf.print("    {s}: {s},\n", .{ fname, ztype });
            }
        }

        // Inject StringView helpers inside the struct body
        if (std.mem.eql(u8, zname, "StringView")) {
            try buf.appendSlice(
                \\
                \\    pub fn toSlice(sv: StringView) [:0]const u8 {
                \\        const ptr: [*]const u8 = @ptrCast(sv.data orelse return "");
                \\        return ptr[0..sv.length :0];
                \\    }
                \\
                \\    pub fn fromSlice(slice: [:0]const u8) StringView {
                \\        return .{ .data = @ptrCast(slice.ptr), .length = slice.len };
                \\    }
                \\
            );
        }

        try buf.appendSlice("};\n\n");

        // Inject ChainedStruct iterator (only once for ChainedStruct, not ChainedStructOut)
        if (std.mem.eql(u8, zname, "ChainedStruct")) {
            try buf.appendSlice(
                \\pub const ChainedIterator = struct {
                \\    current: ?*const ChainedStruct,
                \\
                \\    pub fn next(self: *ChainedIterator) ?*const ChainedStruct {
                \\        const cur = self.current orelse return null;
                \\        self.current = cur.next;
                \\        return cur;
                \\    }
                \\};
                \\
                \\pub fn chainedIterator(first: ?*const ChainedStruct) ChainedIterator {
                \\    return .{ .current = first };
                \\}
                \\
            );
        }
    }
}

fn mapFieldInit(ctype: []const u8, cinit: []const u8, mapping: *Mapping) []const u8 {
    if (std.mem.eql(u8, ctype, "WGPUBool") and std.mem.eql(u8, cinit, "0")) return "0";
    if (std.mem.eql(u8, ctype, "WGPUStringView") and std.mem.startsWith(u8, cinit, "@import")) return ".{ .data = null, .length = std.math.maxInt(usize) }";
    if (std.mem.eql(u8, cinit, "null") and Common.isHandleLikeType(ctype, mapping)) return ".{ .ptr = null }";
    if (std.mem.eql(u8, cinit, "null")) return "null";
    if (std.mem.startsWith(u8, cinit, "@import")) return ".{}";
    return cinit;
}
