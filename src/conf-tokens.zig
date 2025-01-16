const conf_tokens = @cImport({
    @cInclude("stddef.h");
    @cInclude("conf-tokens.h");
});

const std = @import("std");
const expect = std.testing.expect;

test "Test1" {
    std.debug.print("Test 1:\n", .{});
    const input: []const u8 = "allow";
    const expected_type = conf_tokens.CD_allow;

    // Call the function you are testing
    const result = conf_tokens.config_directive_find(input.ptr, input.len);

    try expect(result.*.value == expected_type);
}
