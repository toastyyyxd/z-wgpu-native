const std = @import("std");
const Io = std.Io;
const Dir = std.Io.Dir;
const path = std.fs.path;
const File = std.Io.File;
const Reader = std.Io.Reader;
const Writer = std.Io.Writer;
const eql = std.mem.eql;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    
    const args = (try init.minimal.args.toSlice(init.arena.allocator()))[1..];
    if (args.len != 2) return error.IncorrectArguments;
    
    const root_bindings = if (path.isAbsolute(args[0]))
        try Dir.openFileAbsolute(io, args[0], .{
            .mode = .read_only,
            .allow_directory = false,
        })
    else 
        try Dir.openFile(Dir.cwd(), io, args[0], .{
            .mode = .read_only,
            .allow_directory = false,
        });
    
    const output_dir = if (path.isAbsolute(args[1]))
        try Dir.openDirAbsolute(io, args[1], .{})
    else
        try Dir.openDir(Dir.cwd(), io, args[1], .{});

    try process(init, root_bindings, output_dir);
}

fn process(init: std.process.Init, root_bindings: File, output_dir: Dir) !void {
    root_bindings.lock(init.io, .shared) catch return error.LockFailed;
    const root_bindings_stat = try root_bindings.stat(init.io);
    const root_bindings_content = try init.gpa.allocSentinel(u8, root_bindings_stat.size, 0);
    defer init.gpa.free(root_bindings_content);
    const root_bindings_read = try root_bindings.readPositionalAll(init.io, root_bindings_content, 0);
    if (root_bindings_read != root_bindings_stat.size) return error.UnexpectedReadSize;

    var ast = try std.zig.Ast.parse(init.gpa, root_bindings_content, .zig);
    defer ast.deinit(init.gpa);
    for (ast.rootDecls()) |decl_i| {
        const node = ast.nodes.get(@intFromEnum(decl_i));
        std.debug.print("{any} {any}\n", .{ node, node.data });
    }

    _ = output_dir;
}
