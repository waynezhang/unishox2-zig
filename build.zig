const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const c_unishox2 = b.dependency("unishox2", .{
        .target = target,
        .optimize = optimize,
    });

    const lib = b.addStaticLibrary(.{
        .name = "unishox2-zig",
        .root_source_file = b.path("src/unishox2.zig"),
        .target = target,
        .optimize = optimize,
    });
    lib.addCSourceFiles(.{
        .root = c_unishox2.path(""),
        .files = &.{"unishox2.c"},
    });
    lib.installHeadersDirectory(c_unishox2.path(""), "", .{
        .include_extensions = &.{"unishox2.h"},
    });

    const mod = b.addModule("unishox2", .{
        .root_source_file = b.path("src/unishox2.zig"),
    });
    mod.addIncludePath(c_unishox2.path(""));

    b.installArtifact(lib);

    const lib_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/unishox2.zig"),
        .target = target,
        .optimize = optimize,
    });
    lib_unit_tests.linkLibrary(lib);

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
}
