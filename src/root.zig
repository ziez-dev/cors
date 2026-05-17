const std = @import("std");
const ziez = @import("ziez");
const cors = @import("cors.zig");

pub const CorsConfig = cors.CorsConfig;
pub const CorsOrigins = cors.CorsOrigins;
pub const OriginPredicate = cors.OriginPredicate;

/// Returns a configured Middleware that can be passed to `app.use()`.
pub fn middleware(config: CorsConfig) ziez.Middleware {
    return cors.asMiddleware(config);
}

/// Convenience: registers CORS middleware on the app in one call.
pub fn setup(app: *ziez.App, config: CorsConfig) void {
    app.use(middleware(config));
}
