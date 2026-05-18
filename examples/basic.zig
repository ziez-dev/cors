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

    try app.listen("0.0.0.0:3000");
}
