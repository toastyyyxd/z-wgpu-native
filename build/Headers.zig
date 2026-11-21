//! Pulls WGPU_NULLABLE out of the vendor headers, where translate-c drops it.
//! Only exported declarations are inspected. Struct fields keep their C pointer types.
const std = @import("std");

pub const FnNullability = struct {
    /// Whether each parameter is nullable.
    params: []bool,
    /// Whether the return value is nullable.
    returns: bool,
};

/// Strips comments but keeps newlines. The result is allocated in the arena.
fn stripComments(arena: std.mem.Allocator, source: []const u8) ![]const u8 {
    var out: std.ArrayList(u8) = .empty;
    try out.ensureTotalCapacity(arena, source.len);

    const State = enum { code, line_comment, block_comment };
    var state: State = .code;
    var i: usize = 0;
    while (i < source.len) {
        const c = source[i];
        switch (state) {
            .code => {
                if (c == '/' and i + 1 < source.len and source[i + 1] == '/') {
                    state = .line_comment;
                    i += 2;
                } else if (c == '/' and i + 1 < source.len and source[i + 1] == '*') {
                    state = .block_comment;
                    i += 2;
                } else {
                    try out.append(arena, c);
                    i += 1;
                }
            },
            .line_comment => {
                if (c == '\n') {
                    try out.append(arena, '\n');
                    state = .code;
                }
                i += 1;
            },
            .block_comment => {
                if (c == '*' and i + 1 < source.len and source[i + 1] == '/') {
                    state = .code;
                    i += 2;
                } else {
                    if (c == '\n') try out.append(arena, '\n');
                    i += 1;
                }
            },
        }
    }
    return out.items;
}

fn isIdentChar(c: u8) bool {
    return std.ascii.isAlphanumeric(c) or c == '_';
}

/// Finds `wgpuName(` on a declaration line. Typedefs are skipped.
fn findDeclaration(line: []const u8) ?struct {
    name_start: usize,
    name_end: usize,
    open_paren: usize,
} {
    if (std.mem.startsWith(u8, line, "typedef")) return null;
    if (line.len == 0 or line[0] == '#') return null;

    var search: usize = 0;
    while (std.mem.indexOfPos(u8, line, search, "wgpu")) |idx| {
        search = idx + 4;
        const after = idx + "wgpu".len;
        if (after >= line.len or !std.ascii.isUpper(line[after])) continue;

        var name_end = after;
        while (name_end < line.len and isIdentChar(line[name_end])) name_end += 1;

        var open = name_end;
        while (open < line.len and std.ascii.isWhitespace(line[open])) open += 1;
        if (open >= line.len or line[open] != '(') continue;

        return .{ .name_start = idx, .name_end = name_end, .open_paren = open };
    }
    return null;
}

/// Split params on top-level commas.
fn splitParams(arena: std.mem.Allocator, text: []const u8) ![]const []const u8 {
    var params: std.ArrayList([]const u8) = .empty;
    const trimmed = std.mem.trim(u8, text, " \t\r\n");
    if (trimmed.len == 0 or std.mem.eql(u8, trimmed, "void")) return params.items;

    var depth: usize = 0;
    var start: usize = 0;
    var i: usize = 0;
    while (i < text.len) : (i += 1) {
        switch (text[i]) {
            '(', '[' => depth += 1,
            ')', ']' => depth -|= 1,
            ',' => if (depth == 0) {
                try params.append(arena, std.mem.trim(u8, text[start..i], " \t\r\n"));
                start = i + 1;
            },
            else => {},
        }
    }
    try params.append(arena, std.mem.trim(u8, text[start..], " \t\r\n"));
    return params.items;
}

/// Maps function names to their nullability. Keys and params come from the arena, and the map itself uses gpa.
pub fn parse(
    gpa: std.mem.Allocator,
    arena: std.mem.Allocator,
    source: []const u8,
) !std.StringHashMapUnmanaged(FnNullability) {
    var result: std.StringHashMapUnmanaged(FnNullability) = .empty;

    const stripped = try stripComments(arena, source);
    var lines = std.mem.splitScalar(u8, stripped, '\n');
    while (lines.next()) |raw_line| {
        const line = std.mem.trim(u8, raw_line, " \t\r");
        const decl = findDeclaration(line) orelse continue;

        // Skip macro definitions and fragments.
        if (!std.mem.endsWith(u8, line, ";")) continue;

        // Find the closing paren.
        var depth: usize = 0;
        var close: ?usize = null;
        var i = decl.open_paren;
        while (i < line.len) : (i += 1) {
            if (line[i] == '(') depth += 1;
            if (line[i] == ')') {
                depth -= 1;
                if (depth == 0) {
                    close = i;
                    break;
                }
            }
        }
        const params_end = close orelse continue;

        const name = line[decl.name_start..decl.name_end];
        const params_text = line[decl.open_paren + 1 .. params_end];
        const param_texts = try splitParams(arena, params_text);
        const params = try arena.alloc(bool, param_texts.len);
        for (param_texts, 0..) |text, p_idx| {
            params[p_idx] = std.mem.indexOf(u8, text, "WGPU_NULLABLE") != null;
        }

        const prefix = line[0..decl.name_start];
        const key = try arena.dupe(u8, name);
        try result.put(gpa, key, .{
            .params = params,
            .returns = std.mem.indexOf(u8, prefix, "WGPU_NULLABLE") != null,
        });
    }

    return result;
}

test "parses nullable params and returns" {
    var arena_state = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    const source =
        \\#define WGPU_NULLABLE
        \\typedef WGPUInstance (*WGPUProcCreateInstance)(WGPU_NULLABLE WGPUInstanceDescriptor const * descriptor) WGPU_FUNCTION_ATTRIBUTE;
        \\WGPU_EXPORT WGPUInstance wgpuCreateInstance(WGPU_NULLABLE WGPUInstanceDescriptor const * descriptor) WGPU_FUNCTION_ATTRIBUTE;
        \\WGPU_EXPORT WGPU_NULLABLE WGPUBuffer wgpuDeviceCreateBuffer(WGPUDevice device, WGPUBufferDescriptor const * descriptor) WGPU_FUNCTION_ATTRIBUTE;
        \\    size_t wgpuInstanceEnumerateAdapters(WGPUInstance instance, WGPU_NULLABLE WGPUInstanceEnumerateAdapterOptions const *options, WGPUAdapter *adapters);
        \\    WGPUBool wgpuDevicePoll(WGPUDevice device, WGPUBool wait, WGPU_NULLABLE WGPUSubmissionIndex const *submissionIndex);
        \\WGPU_EXPORT void wgpuDeviceDestroy(WGPUDevice device) WGPU_FUNCTION_ATTRIBUTE;
    ;

    var parsed = try parse(std.testing.allocator, arena, source);
    defer parsed.deinit(std.testing.allocator);

    // A typedef line is not a declaration.
    try std.testing.expect(!parsed.contains("WGPUProcCreateInstance"));

    const create = parsed.get("wgpuCreateInstance").?;
    try std.testing.expect(create.params.len == 1);
    try std.testing.expect(create.params[0]);
    try std.testing.expect(!create.returns);

    const buffer = parsed.get("wgpuDeviceCreateBuffer").?;
    try std.testing.expect(buffer.params.len == 2);
    try std.testing.expect(!buffer.params[0]);
    try std.testing.expect(!buffer.params[1]);
    try std.testing.expect(buffer.returns);

    const enumerate = parsed.get("wgpuInstanceEnumerateAdapters").?;
    try std.testing.expect(enumerate.params.len == 3);
    try std.testing.expect(!enumerate.params[0]);
    try std.testing.expect(enumerate.params[1]);
    try std.testing.expect(!enumerate.params[2]);

    const poll = parsed.get("wgpuDevicePoll").?;
    try std.testing.expect(poll.params.len == 3);
    try std.testing.expect(poll.params[2]);

    const destroy = parsed.get("wgpuDeviceDestroy").?;
    try std.testing.expectEqual(@as(usize, 1), destroy.params.len);
    try std.testing.expect(!destroy.returns);
}
