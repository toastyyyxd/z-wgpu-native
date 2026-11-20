const std = @import("std");
const z = @import("z_wgpu_native");

fn cType(comptime zig_name: [:0]const u8) ?type {
    const c_name = "WGPU" ++ zig_name;
    if (@hasDecl(z.c, c_name)) return @field(z.c, c_name);
    return null;
}

fn cEnumValue(comptime zig_enum_name: [:0]const u8, comptime field_name: [:0]const u8) ?u32 {
    const c_name = "WGPU" ++ zig_enum_name ++ "_" ++ field_name;
    if (@hasDecl(z.c, c_name)) return @as(u32, @intCast(@field(z.c, c_name)));
    return null;
}

fn canonical(comptime name: [:0]const u8) [:0]const u8 {
    comptime var buf: [256]u8 = undefined;
    comptime var j: usize = 0;
    for (name) |c| {
        if (c == '_') continue;
        buf[j] = std.ascii.toLower(c);
        j += 1;
    }
    buf[j] = 0;
    return buf[0..j :0];
}

fn cFieldOffset(comptime ct: type, comptime zig_field: [:0]const u8) ?comptime_int {
    const canon = canonical(zig_field);
    const info = @typeInfo(ct).@"struct";
    inline for (info.field_names) |cf_name| {
        if (std.mem.eql(u8, canon, canonical(cf_name))) return @offsetOf(ct, cf_name);
    }
    return null;
}

fn verifyEnum(comptime T: type, comptime name: [:0]const u8, failures: *u32) void {
    const info = @typeInfo(T).@"enum";
    if (info.tag_type != u32) {
        std.log.err("types.{s}: tag_type {s}, expected u32", .{ name, @typeName(info.tag_type) });
        failures.* += 1;
    }
    if (@sizeOf(T) != @sizeOf(c_uint)) {
        std.log.err("types.{s}: size {} != {}", .{ name, @sizeOf(T), @sizeOf(c_uint) });
        failures.* += 1;
    }
    if (@alignOf(T) != @alignOf(c_uint)) {
        std.log.err("types.{s}: alignment {} != {}", .{ name, @alignOf(T), @alignOf(c_uint) });
        failures.* += 1;
    }
    inline for (info.field_names, info.field_values) |f_name, f_value| {
        _ = @as(c_uint, @intCast(f_value));
        if (cEnumValue(name, f_name)) |c_val| {
            if (@intFromEnum(@field(T, f_name)) != c_val) {
                std.log.err("types.{s}.{s}: value {} != c.WGPU{s}_{s} ({})", .{ name, f_name, @intFromEnum(@field(T, f_name)), name, f_name, c_val });
                failures.* += 1;
            }
        }
    }
}

fn verifyPackedStruct(comptime T: type, comptime name: [:0]const u8, failures: *u32) void {
    const info = @typeInfo(T).@"struct";
    if (@bitSizeOf(T) != 64) {
        std.log.err("types.{s}: bit size {} != 64", .{ name, @bitSizeOf(T) });
        failures.* += 1;
    }
    if (@sizeOf(T) != @sizeOf(u64)) {
        std.log.err("types.{s}: size {} != {}", .{ name, @sizeOf(T), @sizeOf(u64) });
        failures.* += 1;
    }
    if (@alignOf(T) != @alignOf(u64)) {
        std.log.err("types.{s}: alignment {} != {}", .{ name, @alignOf(T), @alignOf(u64) });
        failures.* += 1;
    }
    if (info.backing_integer != u64) {
        std.log.err("types.{s}: backing integer is not u64", .{name});
        failures.* += 1;
    }
    inline for (info.field_names, info.field_types) |f_name, FType| {
        if (!std.mem.startsWith(u8, f_name, "_")) {
            if (FType != bool) {
                std.log.err("types.{s}.{s}: flag field type {s} != bool", .{ name, f_name, @typeName(FType) });
                failures.* += 1;
            }
        }
    }
}

fn verifyExternStruct(comptime T: type, comptime name: [:0]const u8, failures: *u32) void {
    if (@sizeOf(T) == 0) {
        std.log.err("types.{s}: zero size extern struct", .{name});
        failures.* += 1;
    }
    if (cType(name)) |ct| {
        if (@sizeOf(T) != @sizeOf(ct)) {
            std.log.err("types.{s}: size {} != c.WGPU{s} size {}", .{ name, @sizeOf(T), name, @sizeOf(ct) });
            failures.* += 1;
        }
        if (@alignOf(T) != @alignOf(ct)) {
            std.log.err("types.{s}: alignment {} != c.WGPU{s} alignment {}", .{ name, @alignOf(T), name, @alignOf(ct) });
            failures.* += 1;
        }
        if (@typeInfo(ct) == .@"struct" and std.meta.containerLayout(ct) != .@"packed") {
            inline for (@typeInfo(T).@"struct".field_names) |f_name| {
                if (cFieldOffset(ct, f_name)) |c_off| {
                    if (@offsetOf(T, f_name) != c_off) {
                        std.log.err("types.{s}.{s}: offset {} != c.WGPU{s}.{s} offset {}", .{ name, f_name, @offsetOf(T, f_name), name, f_name, c_off });
                        failures.* += 1;
                    }
                }
            }
        }
    }
    const info = @typeInfo(T).@"struct";
    inline for (info.field_names, info.field_types) |f_name, FType| {
        const fi = @typeInfo(FType);
        if (fi == .pointer and fi.pointer.size == .slice) {
            std.log.err("types.{s}.{s}: Zig slice field, not C ABI compatible", .{ name, f_name });
            failures.* += 1;
        }
        if (fi == .@"struct" and std.meta.containerLayout(FType) == .auto) {
            std.log.err("types.{s}.{s}: auto-layout struct field, not C ABI compatible", .{ name, f_name });
            failures.* += 1;
        }
    }
}

fn verifyExternUnion(comptime T: type, comptime name: [:0]const u8, failures: *u32) void {
    if (@sizeOf(T) == 0) {
        std.log.err("types.{s}: zero size extern union", .{name});
        failures.* += 1;
    }
    const info = @typeInfo(T).@"union";
    inline for (info.field_names, info.field_types) |f_name, FType| {
        const fi = @typeInfo(FType);
        if (fi != .@"struct" or std.meta.containerLayout(FType) == .auto) {
            std.log.err("types.{s}.{s}: union variant is not an extern struct", .{ name, f_name });
            failures.* += 1;
        }
    }
}

test "abi types.zig" {
    @setEvalBranchQuota(200_000);
    const mod_decls = comptime std.meta.declarations(z.types);
    var failures: u32 = 0;
    var enums: u32 = 0;
    var bitpack_count: u32 = 0;
    var externs: u32 = 0;
    var unions: u32 = 0;
    var skipped: u32 = 0;

    inline for (mod_decls) |decl_name| {
        const raw = @field(z.types, decl_name);
        if (@TypeOf(raw) != type) {
            skipped += 1;
            continue;
        }
        const T: type = raw;
        switch (@typeInfo(T)) {
            .@"enum" => {
                enums += 1;
                verifyEnum(T, decl_name, &failures);
            },
            .@"struct" => switch (comptime std.meta.containerLayout(T)) {
                .@"extern" => {
                    externs += 1;
                    verifyExternStruct(T, decl_name, &failures);
                },
                .@"packed" => {
                    bitpack_count += 1;
                    verifyPackedStruct(T, decl_name, &failures);
                },
                else => skipped += 1,
            },
            .@"union" => if (comptime std.meta.containerLayout(T) == .@"extern") {
                unions += 1;
                verifyExternUnion(T, decl_name, &failures);
            } else {
                skipped += 1;
            },
            else => skipped += 1,
        }
    }

    const total = enums + bitpack_count + externs + unions;
    std.log.info("ABI types.zig: {d}/{d} passed ({d} enums, {d} bitpack, {d} extern, {d} unions, {d} skipped)", .{ total - failures, total, enums, bitpack_count, externs, unions, skipped });
    try std.testing.expectEqual(@as(u32, 0), failures);
}

test "abi handles.zig Optional*" {
    @setEvalBranchQuota(20000);
    const mod_decls = comptime std.meta.declarations(z.handles);
    var failures: u32 = 0;
    var count: u32 = 0;

    inline for (mod_decls) |decl_name| {
        comptime if (!std.mem.startsWith(u8, decl_name, "Optional")) continue;
        const raw = @field(z.handles, decl_name);
        if (@TypeOf(raw) != type) continue;
        const T: type = raw;
        const info = @typeInfo(T);
        if (info != .@"struct" or info.@"struct".layout != .@"extern") continue;
        count += 1;
        const fields = info.@"struct";
        if (fields.field_names.len != 1) {
            std.log.err("handles.{s}: expected 1 field, found {d}", .{ decl_name, fields.field_names.len });
            failures += 1;
        }
        if (!std.mem.eql(u8, fields.field_names[0], "ptr")) {
            std.log.err("handles.{s}.{s}: field name expected 'ptr'", .{ decl_name, fields.field_names[0] });
            failures += 1;
        }
        if (fields.field_types[0] != ?*anyopaque) {
            std.log.err("handles.{s}.ptr: type {s} != ?*anyopaque", .{ decl_name, @typeName(fields.field_types[0]) });
            failures += 1;
        }
        if (@sizeOf(T) != @sizeOf(?*anyopaque)) {
            std.log.err("handles.{s}: size {} != {}", .{ decl_name, @sizeOf(T), @sizeOf(?*anyopaque) });
            failures += 1;
        }
    }

    std.log.info("ABI handles.zig Optional*: {d}/{d} passed", .{ count - failures, count });
    try std.testing.expectEqual(@as(u32, 0), failures);
}
