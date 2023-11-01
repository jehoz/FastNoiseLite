const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "FastNoiseLite",
        .target = target,
        .optimize = optimize,
    });

    lib.addIncludePath(.{ .path = "src" });
    lib.addCSourceFile(.{ .file = "src/FastNoiseLite.c", .flags = &.{ "-std=c99", "-fno-sanitize=undefined" } });

    b.installArtifact(lib);
}
