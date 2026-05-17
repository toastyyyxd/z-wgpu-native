const std = @import("std");
const Mapping = @import("Mapping.zig");
const Common = @import("OutputCommon.zig");

pub fn writeTypes(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    try buf.appendSlice("const c = @import(\"c_wgpu_native\");\nconst std = @import(\"std\");\nconst handles = @import(\"handles.zig\");\nconst types = @This();\n\n");
    try writeEnums(buf, mapping);
    try writeFlags(buf, mapping);
    try writeStructs(buf, mapping);
    try writeTypedefs(buf, mapping);
}

fn writeEnums(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    var enum_iter = mapping.enum_decls.iterator();
    while (enum_iter.next()) |entry| {
        const cname = entry.key_ptr.*;
        if (!std.mem.startsWith(u8, cname, "WGPU") and
            !std.mem.startsWith(u8, cname, "wgpu") and
            !std.mem.startsWith(u8, cname, "unnamed_")) continue;
        const decl = entry.value_ptr.*;
        if (decl.values.count() == 0) continue;

        const zname = Common.zigEnumName(cname);

        var val_iter = decl.values.iterator();

        // Collect values for sorting
        var sorted_vals: std.ArrayListUnmanaged(struct { name: []const u8, value: i64 }) = .empty;
        defer sorted_vals.deinit(mapping.gpa);

        val_iter = decl.values.iterator();
        while (val_iter.next()) |val| {
            const field_decl = val.value_ptr.*;
            const init_slice = mapping.ast.getNodeSource(field_decl.init.unwrap().?);
            const int_val = Common.parseIntValue(init_slice) orelse continue;
            try sorted_vals.append(mapping.gpa, .{ .name = val.key_ptr.*, .value = @as(i64, @intCast(int_val)) });
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
        
        const is_status = std.mem.endsWith(u8, cname, "Status");
        var success_sv_i: ?usize = null; // It's most likely 1 tho
        if (is_status) {
            var v_one_sv_i: ?usize = null;
            for (sorted_vals.items, 0..) |sv, i| {
                if (sv.value == 1) v_one_sv_i = i;
                if (std.ascii.indexOfIgnoreCase(sv.name, "success")) |_| {
                    success_sv_i = i;
                    break; // This is already sorted
                }
            }
            if (success_sv_i == null and v_one_sv_i != null) success_sv_i = v_one_sv_i.?;
            // if there's somehow no v=1 and no "success" key, warn and put everything in
            if (success_sv_i == null) std.log.warn("warning: codegen: no success or v=1 key in status enum '{s}'", .{ cname });
            try buf.print("pub const {s}Error = error{{\n", .{zname});
            for (sorted_vals.items, 0..) |sv, i| {
                if (i == success_sv_i) continue;
                var buf1: [128]u8 = undefined;
                var buf2: [128]u8 = undefined;
                const vname = try Common.escapeName(Common.upperFirst(sv.name, &buf1), &buf2);
                try buf.print("    {s},\n", .{ vname });
            }
            try buf.appendSlice("};\n\n");
        }

        try buf.print("pub const {s} = enum(c_uint) {{\n", .{zname});
        for (sorted_vals.items) |sv| {
            var buf1: [128]u8 = undefined;
            var buf2: [128]u8 = undefined;
            const vname = try Common.escapeName(Common.zigValueName(sv.name, &buf1), &buf2);
            try buf.print("    {s} = {d},\n", .{ vname, sv.value });
        }
        if (is_status) {
            try buf.print("    pub fn toError(self: {s}) {s}Error!void {{\n        return switch (self) {{\n", .{ zname, zname });
            for (sorted_vals.items, 0..) |sv, i| {
                var buf1: [128]u8 = undefined;
                var buf2: [128]u8 = undefined;
                var buf3: [128]u8 = undefined;
                const vname = try Common.escapeName(Common.zigValueName(sv.name, &buf1), &buf2);
                const ename = try Common.escapeName(Common.upperFirst(sv.name, &buf1), &buf3);
                try buf.print("            .{s} => return", .{ vname });
                if (i != success_sv_i) try buf.print(" {s}Error.{s}", .{ zname, ename });
                try buf.appendSlice(",\n");
            }
            try buf.appendSlice("        };\n    }\n");
            try buf.print("    pub fn fromError(err: {s}Error) {s} {{\n        return switch (err) {{\n", .{ zname, zname });
            for (sorted_vals.items, 0..) |sv, i| {
                if (i == success_sv_i) continue;
                var buf1: [128]u8 = undefined;
                var buf2: [128]u8 = undefined;
                var buf3: [128]u8 = undefined;
                const vname = try Common.escapeName(Common.zigValueName(sv.name, &buf1), &buf2);
                const ename = try Common.escapeName(Common.upperFirst(sv.name, &buf1), &buf3);
                try buf.print("            {s}Error.{s} => return .{s},\n", .{ zname, ename, vname });
            }
            try buf.appendSlice("        };\n    }\n");
        }
        try buf.appendSlice("};\n\n");
    }
}

fn writeFlags(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    var flag_iter = mapping.flag_decls.iterator();
    while (flag_iter.next()) |entry| {
        const cname = entry.key_ptr.*;
        if (!std.mem.startsWith(u8, cname, "WGPU") and
            !std.mem.startsWith(u8, cname, "wgpu") and
            !std.mem.startsWith(u8, cname, "unnamed_")) continue;
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

        // Backing is always u64; all WGPU flags are uint64_t.
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

fn parseFlagBit(init_text: []const u8) u8 {
    if (std.mem.startsWith(u8, init_text, "@bitCast")) {
        const shift_pos = std.mem.indexOf(u8, init_text, "<<") orelse return 0;
        const after = init_text[shift_pos + 2..];
        var i: usize = 0;
        while (i < after.len and !std.ascii.isDigit(after[i])) : (i += 1) {}
        if (i < after.len) {
            const start = i;
            i += 1;
            while (i < after.len and std.ascii.isDigit(after[i])) : (i += 1) {}
            return std.fmt.parseInt(u8, after[start..i], 10) catch 0;
        }
        return 0;
    }
    if (Common.parseIntValue(init_text)) |v| {
        if (v == 0) return 0;
        return @intCast(@ctz(v));
    }
    return 0;
}

fn writeStructs(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    for (mapping.struct_names.items) |sname| {
        if (!std.mem.startsWith(u8, sname, "WGPU") and
            !std.mem.startsWith(u8, sname, "wgpu") and
            !std.mem.startsWith(u8, sname, "unnamed_")) continue;
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
                \\pub fn toSlice(sv: StringView) ?[]const u8 {
                \\    const ptr: [*]const u8 = @ptrCast(sv.data orelse return null);
                \\    if (sv.length == std.math.maxInt(usize)) {
                \\        return std.mem.span(@as([*:0]const u8, @ptrCast(ptr)));
                \\    } else {
                \\        return ptr[0..sv.length];
                \\    }
                \\}
                \\
                \\pub fn fromSlice(slice: []const u8) StringView {
                \\    return .{ .data = @ptrCast(slice.ptr), .length = slice.len };
                \\}
                \\
                \\pub fn fromZStr(slice: [:0]const u8) StringView {
                \\    return .{ .data = @ptrCast(slice.ptr), .length = std.math.maxInt(usize) };
                \\}
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

fn writeTypedefs(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    var iter = mapping.typedef_decls.iterator();
    while (iter.next()) |entry| {
        const cname = entry.key_ptr.*;
        const decl = entry.value_ptr.*;
        const zname = Common.stripWgpu(cname);
        try buf.print("pub const {s} = {s};\n\n", .{ zname, decl.c_type });
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
