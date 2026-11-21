const std = @import("std");
const Io = std.Io;
const Mapping = @import("Mapping.zig");
const OutputTypes = @import("OutputTypes.zig");
const OutputHandles = @import("OutputHandles.zig");
const OutputCallbacks = @import("OutputCallbacks.zig");
const OutputBuilders = @import("OutputBuilders.zig");

fn openOrCreateDir(parent: Io.Dir, io: Io, sub_path: []const u8) !Io.Dir {
    return Io.Dir.openDir(parent, io, sub_path, .{}) catch |err| switch (err) {
        error.NotDir, error.FileNotFound => {
            try Io.Dir.createDir(parent, io, sub_path, .default_dir);
            return Io.Dir.openDir(parent, io, sub_path, .{});
        },
        else => return err,
    };
}

fn writeFile(dir: Io.Dir, io: Io, name: []const u8, content: []const u8) !void {
    const file = try Io.Dir.createFile(dir, io, name, .{});
    try Io.File.writePositionalAll(file, io, content, 0);
    Io.File.close(file, io);
}

pub fn writeOutput(io: Io, gpa: std.mem.Allocator, mapping: *Mapping, out_path: []const u8) !void {
    const cwd = Io.Dir.cwd();
    const src_dir = try openOrCreateDir(cwd, io, out_path);
    defer Io.Dir.close(src_dir, io);

    var buf: std.array_list.Managed(u8) = .init(gpa);
    defer buf.deinit();

    var root: std.array_list.Managed(u8) = .init(gpa);
    defer root.deinit();
    try writeRootHeader(&root);

    var aliases = std.StringHashMap(void).init(gpa);
    defer aliases.deinit();
    for ([_][]const u8{ "types", "handles", "callbacks", "builders", "c" }) |name| {
        try aliases.put(name, {});
    }

    try OutputTypes.writeTypes(&buf, mapping);
    // No undefined defaults. C INIT macros zero every field, and reading undefined over FFI is UB.
    if (std.mem.indexOf(u8, buf.items, "= undefined") != null) {
        std.log.err("generated types.zig still contains an `= undefined` field default", .{});
        return error.UndefinedDefault;
    }
    try writeFile(src_dir, io, "types.zig", buf.items);
    try appendAliases(&root, &aliases, "types", buf.items);
    buf.clearRetainingCapacity();

    try OutputHandles.writeHandlesAndFuncs(&buf, mapping);
    try writeFile(src_dir, io, "handles.zig", buf.items);
    try appendAliases(&root, &aliases, "handles", buf.items);
    buf.clearRetainingCapacity();

    try OutputCallbacks.writeCallbacks(&buf, mapping);
    try writeFile(src_dir, io, "callbacks.zig", buf.items);
    try appendAliases(&root, &aliases, "callbacks", buf.items);
    buf.clearRetainingCapacity();

    try OutputBuilders.writeBuilders(&buf, mapping);
    try writeFile(src_dir, io, "builders.zig", buf.items);
    try appendAliases(&root, &aliases, "builders", buf.items);
    buf.clearRetainingCapacity();

    try writeFile(src_dir, io, "root.zig", root.items);
}

/// Re-export public declarations at the root so call sites can write
/// `wgpu.DeviceDescriptor` instead of `wgpu.types.DeviceDescriptor`.
fn appendAliases(
    root: *std.array_list.Managed(u8),
    seen: *std.StringHashMap(void),
    module: []const u8,
    source: []const u8,
) !void {
    var lines = std.mem.splitScalar(u8, source, '\n');
    while (lines.next()) |line| {
        const name = declarationName(line) orelse continue;
        if (seen.get(name) != null) {
            std.log.err("duplicate root alias: {s} (from {s})", .{ name, module });
            return error.DuplicateRootAlias;
        }
        try seen.put(name, {});
        try root.print("pub const {s} = {s}.{s};\n", .{ name, module, name });
    }
}

fn declarationName(line: []const u8) ?[]const u8 {
    const rest = if (std.mem.startsWith(u8, line, "pub const "))
        line["pub const ".len..]
    else if (std.mem.startsWith(u8, line, "pub fn "))
        line["pub fn ".len..]
    else
        return null;

    var end: usize = 0;
    while (end < rest.len) : (end += 1) {
        if (rest[end] == ' ' or rest[end] == '=' or rest[end] == ':' or rest[end] == '(') break;
    }
    if (end == 0) return null;
    return rest[0..end];
}

fn writeRootHeader(buf: *std.array_list.Managed(u8)) !void {
    try buf.appendSlice(
        \\pub const types = @import("types.zig");
        \\pub const handles = @import("handles.zig");
        \\pub const callbacks = @import("callbacks.zig");
        \\pub const builders = @import("builders.zig");
        \\pub const c = @import("c_wgpu_native");
        \\
    );
}
