const std = @import("std");

pub fn addFastNoiseLite(
    b: *std.Build,
    target: std.zig.CrossTarget,
    optimize: std.builtin.OptimizeMode,
) *std.Build.CompileStep {
    const fnl = b.addStaticLibrary(.{
        .name = "FastNoiseLite",
        .target = target,
        .optimize = optimize,
    });

    fnl.linkLibC();
    fnl.addIncludePath(.{ .path = srcdir ++ "src" });
    fnl.addCSourceFiles(
        &.{
            srcdir ++ "/src/FastNoiseLite.c",
        },
        &.{
            "-std=c99",
            "-fno-sanitize=undefined",
        },
    );

    return fnl;
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = addFastNoiseLite(b, target, optimize);

    b.installArtifact(lib);
}

const srcdir = struct {
    fn getSrcDir() []const u8 {
        return std.fs.path.dirname(@src().file).?;
    }
}.getSrcDir();
