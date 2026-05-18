# ziez-cors

CORS middleware with origin whitelist/predicate for [ziez](https://github.com/ziez-dev/ziez).

## Requirements

- Zig 0.16.0+

## Installation

In `build.zig.zon`:

```zig
.dependencies = .{
    .ziez = .{
        .url = "https://github.com/ziez-dev/ziez/archive/refs/tags/v0.0.1.tar.gz",
        .hash = "ziez-0.0.1-zH20Gh1jAwADi2a_88hnfVHclInMW1YPLF_y7SS7CJ5Y",
    },
    .@"ziez-cors" = .{
        .url = "https://github.com/ziez-dev/cors/archive/refs/tags/v0.0.1.tar.gz",
        .hash = "1220b1fe03d61a1cc83ee28e918e1a2e4f0e0d6d1e23844e0c0e28194a8bbbe9d2e8",
    },
},
```

In `build.zig`:

```zig
const cors_dep = b.dependency("ziez-cors", .{
    .target = target,
    .optimize = optimize,
});
exe_mod.addImport("ziez_cors", cors_dep.module("ziez-cors"));
```

## Quick Start

```zig
const std = @import("std");
const ziez = @import("ziez");
const cors = @import("ziez_cors");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();


    var app = ziez.init(allocator);
    defer app.deinit();

    app.use(cors.middleware(.{
        .origins = .{ .list = &.{"https://myapp.com"} },
        .credentials = true,
    }));

    app.get("/", struct {
        fn h(_: *ziez.Request, res: *ziez.Response) !void {
            res.json(.{ .message = "Hello with CORS!" });
        }
    }.h);

    try app.listen( "0.0.0.0:3000");
}
```

## Configuration

**CorsConfig:**

| Option | Type | Default | Description |
|---|---|---|---|
| `origins` | `CorsOrigins` | `.any` | Allowed origins (`.any`, `.list`, `.predicate`) |
| `methods` | `[]const HttpMethod` | GET, POST, PUT, DELETE, PATCH, OPTIONS | Allowed HTTP methods |
| `allowed_headers` | `[]const []const u8` | Content-Type, Authorization, X-Request-ID | Allowed request headers |
| `exposed_headers` | `[]const []const u8` | `&.{}` | Headers exposed to the client |
| `credentials` | `bool` | `false` | Allow credentials (cookies, auth) |
| `max_age` | `?u32` | `null` | Preflight cache duration (seconds) |

## License

MIT
