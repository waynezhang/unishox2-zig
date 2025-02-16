# unishox2-zig
Zig binding of Unishox2

## Setup

### Fetch dependency

```zig
zig fetch --save "git+https://github.com/waynezhang/unishox2-zig"
```

### Add to `build.zig`

```zig
const unishox2 = b.dependency("unishox2-zig", .{
    .target = target,
    .optimize = optimize,
});
const mod = unishox2.module("unishox2");
exe.linkLibrary(btree_zig.artifact("unishox2-zig"));
```

## Usage

```zig
const origin = "こんにちは";

var compress_buf = [_]u8{0} ** 1024;
const compress_len = compress(origin, &compress_buf);

var decompress_buf = [_]u8{0} ** 1024;
const decompress_len = decompress(compress_buf[0..compress_len], &decompress_buf);
```
