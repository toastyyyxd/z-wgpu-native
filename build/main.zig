const std = @import("std");
const Io = std.Io;
const Mapping = @import("Mapping.zig");
const MapEnums = @import("MapEnums.zig");
const MapFlags = @import("MapFlags.zig");
const MapStructs = @import("MapStructs.zig");
const MapHandles = @import("MapHandles.zig");
const MapFunctions = @import("MapFunctions.zig");
const MapCallbacks = @import("MapCallbacks.zig");
const Output = @import("Output.zig");

pub fn main(init: std.process.Init) !void {
    const args = (try init.minimal.args.toSlice(init.arena.allocator()))[1..];
    if (args.len != 2) return error.IncorrectArguments;

    const root_bindings = try openFile(init.io, args[0]);
    const content = try readFileAll(init.gpa, init.io, root_bindings);
    defer init.gpa.free(content);

    var ast = try std.zig.Ast.parse(init.gpa, content, .zig);
    defer ast.deinit(init.gpa);

    const mapping = try Mapping.init(init.gpa, init.arena.allocator(), &ast);
    defer mapping.deinit();

    try mapping.premap();
    try MapEnums.discover(mapping);
    try MapEnums.generate(mapping);
    try MapFlags.discover(mapping);
    try MapFlags.generate(mapping);
    try MapStructs.discover(mapping);
    try MapStructs.generate(mapping);
    try MapHandles.discover(mapping);
    try MapHandles.generate(mapping);
    try MapFunctions.discover(mapping);
    try MapFunctions.generate(mapping);
    try MapCallbacks.discover(mapping);
    try MapCallbacks.generate(mapping);

    try Output.writeOutput(init.io, init.gpa, mapping, args[1]);
}

fn openFile(io: Io, file_path: []const u8) !Io.File {
    if (std.fs.path.isAbsolute(file_path)) {
        return Io.Dir.openFileAbsolute(io, file_path, .{});
    } else {
        const cwd = Io.Dir.cwd();
        return Io.Dir.openFile(cwd, io, file_path, .{});
    }
}

fn readFileAll(gpa: std.mem.Allocator, io: Io, file: Io.File) ![:0]u8 {
    const stat = try Io.File.stat(file, io);
    const buf = try gpa.allocSentinel(u8, stat.size, 0);
    const read = try Io.File.readPositionalAll(file, io, buf, 0);
    if (read != stat.size) return error.UnexpectedReadSize;
    return buf;
}
