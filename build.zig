const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Define library code for tinyproxy
    const lib = b.addStaticLibrary(.{
        .name = "tinyproxy",
        .target = target,
        .optimize = optimize,
    });

    lib.addIncludePath(b.path("src"));
    lib.linkSystemLibrary("c");
    lib.addCSourceFiles(.{ .root = b.path("src"), .files = &.{ "acl.c", "anonymous.c", "base64.c", "basicauth.c", "buffer.c", "child.c", "conf-tokens.c", "conf.c", "connect-ports.c", "conns.c", "daemon.c", "filter.c", "heap.c", "hostspec.c", "hsearch.c", "html-error.c", "http-message.c", "log.c", "loop.c", "mypoll.c", "network.c", "orderedmap.c", "reqs.c", "reverse-proxy.c", "sblist.c", "sock.c", "stats.c", "text.c", "transparent-proxy.c", "upstream.c", "utils.c" } });
    b.installArtifact(lib);

    // Define the main executable
    const exe = b.addExecutable(.{ .name = "tinyproxy.exe", .target = b.host, .optimize = optimize });

    // Add include path to header files
    exe.addIncludePath(b.path("src"));
    exe.addCSourceFiles(.{ .root = b.path("src"), .files = &.{"main.c"} });
    exe.linkSystemLibrary("c");
    exe.linkLibrary(lib);

    // create executable file
    b.installArtifact(exe);

    // Add unit tests
    const exe_unit_tests = b.addTest(.{
        .name = "tester.exe",
        .root_source_file = b.path("src/conf-tokens.zig"),
        .target = target,
        .optimize = optimize,
    });

    exe_unit_tests.linkSystemLibrary("c");
    exe_unit_tests.linkLibrary(lib);
    exe_unit_tests.addIncludePath(b.path("src"));

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    const test_step = b.step("unit", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
