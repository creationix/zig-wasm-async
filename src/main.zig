fn CSlice(comptime T: type) type {
    return extern struct {
        ptr: [*]const T,
        len: usize,

        pub fn fromSlice(slice: []const T) CSlice(T) {
            return .{ .ptr = slice.ptr, .len = slice.len };
        }

        pub fn toSlice(self: CSlice(T)) []const T {
            return self.ptr[0..self.len];
        }
    };
}

// Actual implementation lives in JS
extern fn doGet(url: CSlice(u8), frame*@Frame(fetch)) void;
export fn onGet(result: CSlice(u8), , frame*@Frame(fetch)) void {

}
fn fetch(url: *const []u8) void {

}

extern fn _slowAdd(a: u32, b: u32, frame: *@Frame(slowAdd)) void;

var addResult: u32 = 0;

export fn onSlowAdd(frame: *@Frame(slowAdd), result: u32) void {
    addResult = result;
    resume frame;
}

fn slowAdd(a: u32, b: u32) u32 {
    _slowAdd(a, b, @frame());
    suspend;
    return addResult;
}

extern fn print(val: u32) void;

const extras = [_]u32{ 100, 200, 300 };

fn realMain(a: u32) void {
    for (extras) |b| {
        print(a);
        print(b);
        print(slowAdd(a, b));
    }
}

var mainFrame1: @Frame(realMain) = undefined;
var mainFrame2: @Frame(realMain) = undefined;

export fn main(cb) void {
    mainFrame1 = async realMain(1);
    mainFrame2 = async realMain(10);
}
