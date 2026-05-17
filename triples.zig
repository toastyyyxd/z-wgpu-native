const std = @import("std");
const Allocator = std.mem.Allocator;
const Target = std.Target;

// triples quadruples blablabla why the fuck can't they just use a format

fn parseCommonComponents(target: Target) !struct {
    arch_name: []const u8,
    vendor: []const u8,
    os_name: []const u8,
    env: []const u8,
} {
    const arch = target.cpu.arch;
    const os_tag = target.os.tag;
    const abi = target.abi;

    const arch_name = @tagName(arch);

    const vendor = switch (os_tag) {
        .linux, .freestanding => "unknown",
        .windows => "pc",
        .macos, .ios, .tvos, .watchos => "apple",
        else => return error.UnsupportedTriple,
    };

    const os_name = switch (os_tag) {
        .linux => "linux",
        .windows => "windows",
        .macos => "darwin",
        else => return error.UnsupportedTriple,
    };

    const env = switch (os_tag) {
        .linux => switch (abi) {
            .android => "android",
            .gnu => "gnu",
            .musl => "musl",
            else => return error.UnsupportedTriple,
        },
        .windows => switch (abi) {
            .msvc => "msvc",
            .gnu => "gnullvm", // we're using gnullvm for windows
            else => return error.UnsupportedTriple,
        },
        else => "",
    };

    return .{
        .arch_name = arch_name,
        .vendor = vendor,
        .os_name = os_name,
        .env = env,
    };
}

pub fn rust(allocator: Allocator, target: Target) ![]u8 {
    const comps = try parseCommonComponents(target);

    if (target.os.tag == .linux and target.abi == .android) {
        const arch_name = switch (target.cpu.arch) {
            .arm => "armv7",
            else => @tagName(target.cpu.arch),
        };
        const env = switch (target.cpu.arch) {
            .arm => "androideabi",
            else => "android",
        };
        return std.fmt.allocPrint(allocator, "{s}-linux-{s}", .{ arch_name, env });
    }

    if (target.os.tag == .macos) {
        return std.fmt.allocPrint(allocator, "{s}-{s}-{s}", .{ comps.arch_name, comps.vendor, comps.os_name });
    }

    if (comps.env.len == 0) {
        return std.fmt.allocPrint(allocator, "{s}-{s}-{s}", .{ comps.arch_name, comps.vendor, comps.os_name });
    }

    return std.fmt.allocPrint(allocator, "{s}-{s}-{s}-{s}", .{ comps.arch_name, comps.vendor, comps.os_name, comps.env });
}

pub fn clang(allocator: Allocator, target: Target) ![]u8 {
    var comps = try parseCommonComponents(target);

    if (target.cpu.arch == .aarch64 and target.os.tag == .macos) {
        comps.arch_name = "arm64";
    }

    if (target.os.tag == .macos) {
        return std.fmt.allocPrint(allocator, "{s}-{s}-{s}", .{ comps.arch_name, comps.vendor, comps.os_name });
    }

    if (comps.env.len == 0) {
        return std.fmt.allocPrint(allocator, "{s}-{s}-{s}", .{ comps.arch_name, comps.vendor, comps.os_name });
    }

    return std.fmt.allocPrint(allocator, "{s}-{s}-{s}-{s}", .{ comps.arch_name, comps.vendor, comps.os_name, comps.env });
}
