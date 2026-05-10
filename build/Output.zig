const std = @import("std");
const Io = std.Io;
const Mapping = @import("Mapping.zig");
const OutputTypes = @import("OutputTypes.zig");
const OutputHandles = @import("OutputHandles.zig");
const OutputCallbacks = @import("OutputCallbacks.zig");

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

    try OutputTypes.writeTypes(&buf, mapping);
    try writeFile(src_dir, io, "types.zig", buf.items);
    buf.clearRetainingCapacity();

    try OutputHandles.writeHandlesAndFuncs(&buf, mapping);
    try writeFile(src_dir, io, "handles.zig", buf.items);
    buf.clearRetainingCapacity();

    try OutputCallbacks.writeCallbacks(&buf, mapping);
    try writeFile(src_dir, io, "callbacks.zig", buf.items);
    buf.clearRetainingCapacity();

    try writeRoot(&buf);
    try writeFile(src_dir, io, "root.zig", buf.items);
}

fn writeRoot(buf: *std.array_list.Managed(u8)) !void {
    try buf.appendSlice(
        \\pub const types = @import("types.zig");
        \\pub const handles = @import("handles.zig");
        \\pub const callbacks = @import("callbacks.zig");
        \\pub const c = @import("c_wgpu_native");
        \\
    );
}
