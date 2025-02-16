const std = @import("std");
const c = @cImport({
    @cInclude("unishox2.h");
});

pub fn compress(in: []const u8, out: []u8) usize {
    const len = c.unishox2_compress_simple(in.ptr, @as(c_int, @intCast(in.len)), out.ptr);
    return @as(usize, @intCast(len));
}

pub fn decompress(in: []const u8, out: []u8) usize {
    const len = c.unishox2_decompress_simple(in.ptr, @as(c_int, @intCast(in.len)), out.ptr);
    return @as(usize, @intCast(len));
}

test "main" {
    const origin = "こんにちは";

    var compress_buf = [_]u8{0} ** 1024;
    const compress_len = compress(origin, &compress_buf);

    var decompress_buf = [_]u8{0} ** 1024;
    const decompress_len = decompress(compress_buf[0..compress_len], &decompress_buf);

    try std.testing.expect(compress_len < decompress_len);
    try std.testing.expect(std.mem.eql(u8, origin, decompress_buf[0..decompress_len]));
}
