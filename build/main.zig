const std = @import("std");
const Io = std.Io;
const Dir = std.Io.Dir;
const path = std.fs.path;
const File = std.Io.File;
const Reader = std.Io.Reader;
const Writer = std.Io.Writer;
const Ast = std.zig.Ast;
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
    for (ast.rootDecls()) |node_Idx| {
        try parseNode(init.io, &ast, node_Idx);
    }

    _ = output_dir;
}

fn parseNode(init: std.process.Init, ast: *std.zig.Ast, node_idx: std.zig.Ast.Node) !void {
    if (try parseVarDecl(init, ast, node_idx)) return;
}

// Keys have to be slices, values can just be node indexes,
// since different node indexes resolving to the same thing won't resolve in a map.

const FlagsDefinition = struct {
    backing_type: Definition,
    flags: std.StringArrayHashMapUnmanaged(Definition),
};
const EnumDefinition = struct {
    backing_type: Definition,
    values: std.StringArrayHashMapUnmanaged(Definition),
};

const Definition = union(enum) {
    direct: Ast.Node.Index,
    alias: []const u8,
    flags: FlagsDefinition,
    @"enum": EnumDefinition,
};

const Declaration = struct {
    name: []const u8,
    definition: Definition,
};

const Mapping = struct {
    arena: std.mem.Allocator,
    map: *std.StringArrayHashMapUnmanaged(Declaration),
};

const ParseUnit = struct {
    ast: *Ast,
    mapping: *Mapping,
    node_idx: Ast.Node.Index,
};

fn caseVarDecl(ctx: ParseUnit) !void {
    const could_be_var_decl = ctx.ast.fullVarDecl(ctx.node_idx);
    const decl = if (could_be_var_decl) |vd| vd else return false;
    
    const name_token = ctx.ast.tokenSlice(decl.ast.mut_token + 1);
    const is_enum = std.mem.startsWith(u8, name_token, "enum_");

    const is_flags, const is_alias, const is_direct = if (decl.ast.init_node.unwrap()) |ni| blk: {
        if (ctx.ast.nodeTag(ni) != .identifier) break :blk .{ false, false, true };
        const node_token = ctx.ast.tokenSlice(ctx.ast.firstToken(ni));
        if (std.mem.eql(node_token, "WGPUFlags")) break :blk .{ true, false, false };
        if (ctx.mapping.map.contains(node_token)) break :blk .{ false, true, false };
        break :blk .{ false, false, true };
    } else .{ false, false, false };
    
    if (is_enum) try parseEnumDecl(ctx)
    else if (is_flags) try parseFlagsDecl(ctx)
    else if (is_alias) try parseAliasDecl(ctx)
    else if (is_direct) try parseDirectDecl(ctx)
    else try handleUnknownDecl(ctx);
}

fn parseEnumDecl(ctx: ParseUnit) !void {
    ctx.
}
