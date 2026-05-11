const std = @import("std");
const Ast = std.zig.Ast;

pub const FieldDecl = struct {
    node: Ast.Node.Index,
    type: Ast.Node.Index,
    init: Ast.Node.OptionalIndex,
};

pub const EnumDecl = struct {
    node: Ast.Node.Index,
    type: Ast.Node.Index,
    values: std.StringHashMapUnmanaged(*FieldDecl) = .empty,
};

pub const FlagsDecl = struct {
    node: Ast.Node.Index,
    values: std.StringHashMapUnmanaged(*FieldDecl) = .empty,
    composites: std.StringHashMapUnmanaged(*FieldDecl) = .empty,
    has_force32: bool = false,
};

pub const StructField = struct {
    name: []const u8,
    type: Ast.Node.Index,
    init: Ast.Node.OptionalIndex,
};

pub const ContainerKind = enum { @"struct", @"union" };

pub const StructDecl = struct {
    node: Ast.Node.Index,
    fields: std.ArrayListUnmanaged(StructField) = .empty,
    kind: ContainerKind = .@"struct",
};

pub const FnRef = struct {
    name: []const u8,
    node: Ast.Node.Index,
};

pub const FnParam = struct {
    name: []const u8,
    type: Ast.Node.Index,
    kind: FnParamKind = .unknown,
};

pub const FnParamKind = enum {
    unknown,
    handle,      // WGPUAdapter, WGPUBuffer, etc.
    data_struct, // [*c]WGPUBufferDescriptor, etc.
    string,      // WGPUStringView
    bool_c,      // WGPUBool
    flags,       // WGPUBufferUsage, etc.
    enum_c,      // WGPUStatus, etc.
    primitive,   // usize, u32, u64, f32
    pointer,     // [*c]const u32, ?*const anyopaque, etc.
};

pub const FnDecl = struct {
    node: Ast.Node.Index,
    name: []const u8,
    params: std.ArrayListUnmanaged(FnParam) = .empty,
    return_type: Ast.Node.OptionalIndex,
    return_kind: FnReturnKind = .void,
};

pub const FnReturnKind = enum {
    void,
    handle,
    data_struct,
    string,
    bool_c,
    flags,
    enum_c,
    status,      // WGPUStatus specifically; maps to error union
    future,      // WGPUFuture
    primitive,
    pointer,
};

pub const HandleDecl = struct {
    node: Ast.Node.Index,
    methods: std.ArrayListUnmanaged(FnRef) = .empty,
};

pub const CallbackParam = struct {
    name: []const u8,
    type: []const u8,
    is_userdata: bool,
};

pub const CallbackDecl = struct {
    node: Ast.Node.Index,
    name: []const u8,
    params: std.ArrayListUnmanaged(CallbackParam) = .empty,
    userdata_count: u2 = 0,
};

pub const Decl = union(enum) {
    @"enum": *EnumDecl,
    flags: *FlagsDecl,
    strct: *StructDecl,
    handle: *HandleDecl,
    field: *FieldDecl,
};

arena: std.mem.Allocator,
gpa: std.mem.Allocator,
ast: *Ast,

symbols: std.StringHashMapUnmanaged(Ast.Node.Index) = .empty,
decls: std.AutoHashMapUnmanaged(Ast.Node.Index, Decl) = .empty,

enum_names: std.ArrayListUnmanaged([]const u8) = .empty,
struct_names: std.ArrayListUnmanaged([]const u8) = .empty,
flag_names: std.ArrayListUnmanaged([]const u8) = .empty,
handle_names: std.ArrayListUnmanaged([]const u8) = .empty,

enum_decls: std.StringHashMapUnmanaged(*EnumDecl) = .empty,
struct_decls: std.StringHashMapUnmanaged(*StructDecl) = .empty,
flag_decls: std.StringHashMapUnmanaged(*FlagsDecl) = .empty,
handle_decls: std.StringHashMapUnmanaged(*HandleDecl) = .empty,
fn_decls: std.StringHashMapUnmanaged(*FnDecl) = .empty,
callback_decls: std.StringHashMapUnmanaged(*CallbackDecl) = .empty,

pub fn init(gpa: std.mem.Allocator, arena: std.mem.Allocator, ast: *Ast) !*@This() {
    const self = try arena.create(@This());
    self.* = .{
        .arena = arena,
        .gpa = gpa,
        .ast = ast,
    };
    return self;
}

pub fn deinit(self: *@This()) void {
    // Clean up inner collections within each decl
    {
        var it = self.enum_decls.iterator();
        while (it.next()) |e| e.value_ptr.*.values.deinit(self.gpa);
    }
    {
        var it = self.flag_decls.iterator();
        while (it.next()) |e| {
            e.value_ptr.*.values.deinit(self.gpa);
            e.value_ptr.*.composites.deinit(self.gpa);
        }
    }
    {
        var it = self.struct_decls.iterator();
        while (it.next()) |e| e.value_ptr.*.fields.deinit(self.gpa);
    }
    {
        var it = self.handle_decls.iterator();
        while (it.next()) |e| e.value_ptr.*.methods.deinit(self.gpa);
    }
    {
        var it = self.fn_decls.iterator();
        while (it.next()) |e| e.value_ptr.*.params.deinit(self.gpa);
    }
    {
        var it = self.callback_decls.iterator();
        while (it.next()) |e| e.value_ptr.*.params.deinit(self.gpa);
    }

    self.symbols.deinit(self.gpa);
    self.decls.deinit(self.gpa);
    self.enum_names.deinit(self.gpa);
    self.struct_names.deinit(self.gpa);
    self.flag_names.deinit(self.gpa);
    self.handle_names.deinit(self.gpa);
    self.enum_decls.deinit(self.gpa);
    self.struct_decls.deinit(self.gpa);
    self.flag_decls.deinit(self.gpa);
    self.handle_decls.deinit(self.gpa);
    self.fn_decls.deinit(self.gpa);
    self.callback_decls.deinit(self.gpa);
}

pub fn premap(self: *@This()) !void {
    for (self.ast.rootDecls()) |node_idx| {
        const var_decl = self.ast.fullVarDecl(node_idx) orelse continue;
        const name_token = var_decl.ast.mut_token + 1;
        const name = self.ast.tokenSlice(name_token);

        try self.symbols.put(self.gpa, name, node_idx);

        if (std.mem.startsWith(u8, name, "enum_")) {
            try self.enum_names.append(self.gpa, name["enum_".len..]);
            continue;
        }

        if (std.mem.startsWith(u8, name, "struct_")) {
            if (var_decl.ast.init_node.unwrap()) |init_node| {
                const first_slice = self.ast.tokenSlice(self.ast.firstToken(init_node));
                if (std.mem.eql(u8, first_slice, "opaque")) {
                    try self.handle_names.append(self.gpa, name["struct_".len..]);
                    continue;
                }
            }
            try self.struct_names.append(self.gpa, name["struct_".len..]);
            continue;
        }

        if (std.mem.startsWith(u8, name, "union_")) {
            try self.struct_names.append(self.gpa, name["union_".len..]);
            continue;
        }

        if (var_decl.ast.init_node.unwrap()) |init_node| {
            if (self.ast.nodeTag(init_node) == .identifier) {
                const init_slice = self.ast.tokenSlice(self.ast.firstToken(init_node));
                if (std.mem.eql(u8, init_slice, "WGPUFlags")) {
                    try self.flag_names.append(self.gpa, name);
                    continue;
                }
            }
        }
    }
}
