const std = @import("std");
const Mapping = @import("Mapping.zig");
const Common = @import("OutputCommon.zig");

pub fn writeTypes(buf: *std.array_list.Managed(u8), mapping: *Mapping) !void {
    try buf.appendSlice("const c = @import(\"c_wgpu_native\");\nconst std = @import(\"std\");\nconst handles = @import(\"handles.zig\");\nconst types = @This();\n\n");
    try buf.appendSlice(
        \\inline fn asC(comptime C: type, value: anytype) C {
        \\    var out: C = std.mem.zeroes(C);
        \\    const v = value;
        \\    @memcpy(std.mem.asBytes(&out), std.mem.asBytes(&v));
        \\    return out;
        \\}
        \\
        \\
    );
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
        var sorted_vals: std.ArrayList(struct { name: []const u8, value: i64 }) = .empty;
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
        
        var has_zero = false;
        for (sorted_vals.items) |sv| {
            if (sv.value == 0) has_zero = true;
        }

        const is_status = std.mem.endsWith(u8, cname, "Status");
        var success_sv_i: ?usize = null; // It's most likely 1 tho
        if (is_status) {
            var v_one_sv_i: ?usize = null;
            for (sorted_vals.items, 0..) |sv, i| {
                if (sv.value == 1) v_one_sv_i = i;
                if (Common.indexOfIgnoreCase(sv.name, "success")) |_| {
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

        try buf.print("pub const {s} = enum(u32) {{\n", .{zname});
        if (!has_zero) {
            // The C enum has no zero value, so emit a Zig-side tag for the C INIT default.
            try buf.appendSlice("    /// Zig-side default because the C enum has no zero.\n    @\"undefined\" = 0,\n");
        }
        for (sorted_vals.items) |sv| {
            var buf1: [128]u8 = undefined;
            var buf2: [128]u8 = undefined;
            const vname = try Common.escapeName(Common.zigValueName(sv.name, &buf1), &buf2);
            try buf.print("    {s} = {d},\n", .{ vname, sv.value });
        }
        if (is_status) {
            try buf.print("    pub fn toError(self: {s}) {s}Error!void {{\n        return switch (self) {{\n", .{ zname, zname });
            if (!has_zero) {
                // The synthetic tag can only be observed as a default.
                try buf.appendSlice("            .@\"undefined\" => unreachable,\n");
            }
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
        var sorted_vals: std.ArrayList(SortedVal) = .empty;
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
        var deduped: std.ArrayList(SortedVal) = .empty;
        defer deduped.deinit(mapping.gpa);
        for (sorted_vals.items) |sv| {
            if (deduped.items.len == 0 or deduped.items[deduped.items.len - 1].bit != sv.bit) {
                try deduped.append(mapping.gpa, sv);
            }
        }

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
            \\    pub fn bitOr(self: @This(), other: @This()) @This() {{
            \\        return @bitCast(@as({s}, @bitCast(self)) | @as({s}, @bitCast(other)));
            \\    }}
            \\
            \\    pub fn bitAnd(self: @This(), other: @This()) @This() {{
            \\        return @bitCast(@as({s}, @bitCast(self)) & @as({s}, @bitCast(other)));
            \\    }}
            \\
            \\    pub fn bitXor(self: @This(), other: @This()) @This() {{
            \\        return @bitCast(@as({s}, @bitCast(self)) ^ @as({s}, @bitCast(other)));
            \\    }}
            \\
        , .{ backing, backing, backing, backing, backing, backing, backing });
        try buf.appendSlice("};\n\n");

        // Composite/preset flag constants (sorted by name)
        if (decl.composites.count() > 0) {
            const SortedComp = struct { name: []const u8, init_text: []const u8 };
            var sorted_comps: std.ArrayList(SortedComp) = .empty;
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
                const cut_prefix = std.mem.cutPrefix(u8, comp.init_text, "@bitCast(");
                const cut_suffix = if (cut_prefix) |s| std.mem.cutSuffix(u8, s, ")") else null;
                try buf.print("pub const {s}_{s}: {s} = @bitCast(@as(u64, @intCast({s})));\n", .{ zname, vname, zname, cut_suffix orelse comp.init_text });
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
            var init_buf: [256]u8 = undefined;
            var name_buf: [128]u8 = undefined;
            const fname = Common.zigFieldName(f.name, &name_buf);
            const type_slice = mapping.ast.getNodeSource(f.type);
            const fi = Common.fieldInit(mapping, type_slice, null, &type_buf, &init_buf);
            if (decl.kind == .@"union") {
                // extern union fields cannot carry initializers
                try buf.print("    {s}: {s},\n", .{ fname, fi.ztype });
                continue;
            }
            const cinit: ?[]const u8 = if (f.init != .none) mapping.ast.getNodeSource(f.init.unwrap().?) else null;
            const fi2 = Common.fieldInit(mapping, type_slice, cinit, &type_buf, &init_buf);
            if (std.mem.eql(u8, fi2.zinit, "undefined")) {
                std.log.err("types.{s}.{s}: no deterministic default for C type '{s}'", .{ zname, fname, type_slice });
                return error.UndefinedDefault;
            }
            try buf.print("    {s}: {s} = {s},\n", .{ fname, fi2.ztype, fi2.zinit });
        }

        try writeSliceSetters(buf, mapping, decl, zname, "");

        try writeDeinit(buf, mapping, sname, zname);

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

/// Find the `wgpu<Type>FreeMembers(WGPU<Type>)` C entry point for a struct, if
/// the header declares one.
fn findFreeMembersFn(mapping: *Mapping, struct_c_name: []const u8) ?[]const u8 {
    var it = mapping.fn_decls.iterator();
    while (it.next()) |entry| {
        const fn_decl = entry.value_ptr.*;
        if (!std.mem.endsWith(u8, fn_decl.name, "FreeMembers")) continue;
        const ret_slice = if (fn_decl.return_type.unwrap()) |rt| mapping.ast.getNodeSource(rt) else "void";
        if (!std.mem.eql(u8, ret_slice, "void")) continue;
        if (fn_decl.params.items.len != 1) continue;
        const param = fn_decl.params.items[0];
        if (param.kind != .data_struct) continue;
        const ctype = mapping.ast.getNodeSource(param.type);
        if (std.mem.eql(u8, ctype, struct_c_name)) return fn_decl.name;
    }
    return null;
}

fn writeDeinit(buf: *std.array_list.Managed(u8), mapping: *Mapping, sname: []const u8, zname: []const u8) !void {
    const free_fn = findFreeMembersFn(mapping, sname) orelse return;
    if (mapping.unimplemented.contains(free_fn)) {
        try buf.print(
            \\    /// Stubbed by wgpu-native: calling this is a compile error.
            \\    pub inline fn deinit(self: {s}) void {{
            \\        _ = self;
            \\        @compileError("{s} is stubbed by wgpu-native; use wgpu.c.{s} for the raw extern (aborts at runtime)");
            \\    }}
            \\
            \\
        , .{ zname, free_fn, free_fn });
        return;
    }
    try buf.print(
        \\    /// Releases the payload allocated by `c.{s}`.
        \\    pub fn deinit(self: {s}) void {{
        \\        c.{s}(asC(c.{s}, self));
        \\    }}
        \\
        \\
    , .{ free_fn, zname, free_fn, sname });
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

fn snakeToPascal(s: []const u8, buf: *[160]u8) []const u8 {
    var out: usize = 0;
    var upper = true;
    for (s) |ch| {
        if (ch == '_') {
            upper = true;
            continue;
        }
        if (out >= buf.len) break;
        buf[out] = if (upper) std.ascii.toUpper(ch) else ch;
        out += 1;
        upper = false;
    }
    return buf[0..out];
}

/// Emits a setter that fills a count field and its pointer field from a slice.
pub fn writeSliceSetters(buf: *std.array_list.Managed(u8), mapping: *Mapping, decl: *Mapping.StructDecl, zname: []const u8, qualifier: []const u8) !void {
    const fields = decl.fields.items;
    if (fields.len < 2) return;
    var i: usize = 0;
    while (i + 1 < fields.len) : (i += 1) {
        var count_field = fields[i];
        var ptr_field = fields[i + 1];

        // C structs put the pair in either order: "count, pointer" in the
        // WebGPU schema, "pointer, count" in some wgpu-native extras.
        const first_ctype = mapping.ast.getNodeSource(count_field.type);
        const second_ctype = mapping.ast.getNodeSource(ptr_field.type);
        if (Common.isCountCType(first_ctype) and std.mem.startsWith(u8, second_ctype, "[*c]")) {
            // count before pointer
        } else if (std.mem.startsWith(u8, first_ctype, "[*c]") and Common.isCountCType(second_ctype)) {
            count_field = fields[i + 1];
            ptr_field = fields[i];
        } else continue;
        if (!Common.isCountParamName(count_field.name)) continue;
        if (std.mem.eql(u8, ptr_field.name, "nextInChain") or
            std.mem.eql(u8, ptr_field.name, "chain")) continue;

        const ptr_ctype = mapping.ast.getNodeSource(ptr_field.type);

        var type_buf: [256]u8 = undefined;
        const mapped = Common.mapTypeName(ptr_ctype, &type_buf, mapping);
        const elem = if (std.mem.startsWith(u8, mapped, "[*c]const "))
            mapped["[*c]const ".len..]
        else if (std.mem.startsWith(u8, mapped, "[*c]"))
            mapped["[*c]".len..]
        else
            continue;

        var ptr_name_buf: [128]u8 = undefined;
        const ptr_name = Common.zigFieldName(ptr_field.name, &ptr_name_buf);
        var count_name_buf: [128]u8 = undefined;
        const count_name = Common.zigFieldName(count_field.name, &count_name_buf);
        var pascal_buf: [160]u8 = undefined;
        const pascal = snakeToPascal(ptr_name, &pascal_buf);

        const elem_qualified = if (qualifier.len > 0 and std.mem.indexOfScalar(u8, elem, '.') == null)
            try std.fmt.allocPrint(mapping.arena, "{s}{s}", .{ qualifier, elem })
        else
            elem;

        try buf.print("    pub fn set{s}(self: *{s}, items: []const {s}) void {{\n", .{ pascal, zname, elem_qualified });
        try buf.print("        self.{s} = @intCast(items.len);\n", .{count_name});
        try buf.print("        self.{s} = items.ptr;\n", .{ptr_name});
        try buf.appendSlice("    }\n\n");
        i += 1;
    }
}

