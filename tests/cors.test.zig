const std = @import("std");
const cors = @import("ziez_cors");

test "CorsConfig defaults" {
    const config = cors.CorsConfig{};
    try std.testing.expect(config.credentials == false);
    try std.testing.expect(config.max_age == null);
    try std.testing.expect(config.methods.len == 6);
    try std.testing.expect(config.allowed_headers.len == 3);
}

test "middleware returns valid Middleware" {
    const mw = cors.middleware(.{});
    try std.testing.expect(mw.ptr != null);
    try std.testing.expect(mw.deinit_fn != null);
}
