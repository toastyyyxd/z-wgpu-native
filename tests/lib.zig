const std = @import("std");
const z = @import("z_wgpu_native");

test "NativeDisplayHandle zero-init" {
    const dh: z.types.NativeDisplayHandle = .{};
    try std.testing.expectEqual(@as(u32, 0), @intFromEnum(dh.type));
}

test "StringView roundtrip" {
    const original = "hello wgpu";
    const sv = z.types.StringView.fromSlice(original);
    const back = sv.toSlice();
    try std.testing.expect(std.mem.eql(u8, original, back));
}

test "packed struct bitCast roundtrip" {
    const mode: z.types.MapMode = .{ .read = true, .write = false };
    const u: u64 = @bitCast(mode);
    const mode2: z.types.MapMode = @bitCast(u);
    try std.testing.expect(mode2.read);
    try std.testing.expect(!mode2.write);
}

test "ChainedIterator empty chain" {
    const head: z.types.ChainedStruct = .{ .next = null };
    var iter = z.types.chainedIterator(&head);
    const first = iter.next();
    try std.testing.expect(first != null);
    try std.testing.expect(iter.next() == null);
}
