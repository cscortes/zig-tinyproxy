const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "tinyproxy.exe",
        .target = b.host,
    });

    exe.addIncludePath(b.path("src"));

    // If you have multiple C source files:
    exe.addCSourceFiles(.{ .files = &.{ "src/main.c", "src/acl.c", "src/anonymous.c", "src/base64.c", "src/basicauth.c", "src/buffer.c", "src/child.c", "src/conf-tokens.c", "src/conf.c", "src/connect-ports.c", "src/conns.c", "src/daemon.c", "src/filter.c", "src/heap.c", "src/hostspec.c", "src/hsearch.c", "src/html-error.c", "src/http-message.c", "src/log.c", "src/loop.c", "src/mypoll.c", "src/network.c", "src/orderedmap.c", "src/reqs.c", "src/reverse-proxy.c", "src/sblist.c", "src/sock.c", "src/stats.c", "src/text.c", "src/transparent-proxy.c", "src/upstream.c", "src/utils.c" } });

    // Add any necessary libraries or dependencies here
    exe.linkSystemLibrary("c"); // Assuming TinyProxy uses standard C library
    b.installArtifact(exe);
}
