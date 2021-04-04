usingnamespace @import("std").builtin;
/// Deprecated
pub const arch = Target.current.cpu.arch;
/// Deprecated
pub const endian = Target.current.cpu.arch.endian();
pub const output_mode = OutputMode.Obj;
pub const link_mode = LinkMode.Static;
pub const is_test = false;
pub const single_threaded = true;
pub const abi = Abi.musl;
pub const cpu: Cpu = Cpu{
    .arch = .wasm32,
    .model = &Target.wasm.cpu.generic,
    .features = Target.wasm.featureSet(&[_]Target.wasm.Feature{
    }),
};
pub const os = Os{
    .tag = .freestanding,
    .version_range = .{ .none = {} }
};
pub const object_format = ObjectFormat.wasm;
pub const mode = Mode.ReleaseSmall;
pub const link_libc = false;
pub const link_libcpp = false;
pub const have_error_return_tracing = false;
pub const valgrind_support = false;
pub const position_independent_code = false;
pub const strip_debug_info = true;
pub const code_model = CodeModel.default;
