const conf_tokens = @cImport({
    @cInclude("stddef.h");
    @cInclude("conf-tokens.h");
});

const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

// Helper function to encapsulate common test logic
fn test_directive(input: []const u8, expected_value: c_uint) !void {
    const result = conf_tokens.config_directive_find(input.ptr, input.len);
    const actual_value = result.*.value;

    expectEqual(actual_value, expected_value) catch {
        std.debug.print("Test Failed!", .{});
        unreachable;
    };
    std.debug.print("Passed!\n", .{});
}

fn test_neg_directive(input: []const u8) !void {
    const result = conf_tokens.config_directive_find(input.ptr, input.len);

    expect(result == 0) catch {
        std.debug.print("Test Failed!", .{});
        unreachable;
    };
    std.debug.print("Passed!\n", .{});
}

// Positive Tests
test "Test 'allow' directive" {
    const input: []const u8 = "allow";
    const expected_type: c_uint = @intCast(conf_tokens.CD_allow);
    try test_directive(input, expected_type);
}

test "Test 'ALLOW' directive" {
    const input: []const u8 = "ALLOW";
    const expected_type: c_uint = @intCast(conf_tokens.CD_allow);
    try test_directive(input, expected_type);
}

test "Test 'deny' directive" {
    const input: []const u8 = "deny";
    const expected_type = conf_tokens.CD_deny;
    try test_directive(input, expected_type);
}

test "Test 'port' directive" {
    const input: []const u8 = "port";
    const expected_type = conf_tokens.CD_port;
    try test_directive(input, expected_type);
}

test "Test empty string" {
    const input: []const u8 = "";
    const expected_type = conf_tokens.CD_NIL;
    try test_directive(input, expected_type);
}

// Negative Tests
test "Test invalid directive 'foo'" {
    const input: []const u8 = "foo";

    try test_neg_directive(input);
}

test "Test whitespace-only string" {
    const input: []const u8 = "  ";
    try test_neg_directive(input);
}

test "Test directive with extra spaces" {
    const input: []const u8 = " allow ";
    try test_neg_directive(input);
}

test "Test misspell 'Allow' as 'allo'" {
    const input: []const u8 = "allo";
    try test_neg_directive(input);
}
