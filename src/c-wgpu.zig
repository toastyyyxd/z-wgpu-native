const __root = @This();
pub const __builtin = @import("std").zig.c_translation.builtins;
pub const __helpers = @import("std").zig.c_translation.helpers;
pub const __u_char = u8;
pub const __u_short = c_ushort;
pub const __u_int = c_uint;
pub const __u_long = c_ulong;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_long;
pub const __uint64_t = c_ulong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __quad_t = c_long;
pub const __u_quad_t = c_ulong;
pub const __intmax_t = c_long;
pub const __uintmax_t = c_ulong;
pub const __dev_t = c_ulong;
pub const __uid_t = c_uint;
pub const __gid_t = c_uint;
pub const __ino_t = c_ulong;
pub const __ino64_t = c_ulong;
pub const __mode_t = c_uint;
pub const __nlink_t = c_ulong;
pub const __off_t = c_long;
pub const __off64_t = c_long;
pub const __pid_t = c_int;
pub const __fsid_t = extern struct {
    __val: [2]c_int = @import("std").mem.zeroes([2]c_int),
};
pub const __clock_t = c_long;
pub const __rlim_t = c_ulong;
pub const __rlim64_t = c_ulong;
pub const __id_t = c_uint;
pub const __time_t = c_long;
pub const __useconds_t = c_uint;
pub const __suseconds_t = c_long;
pub const __suseconds64_t = c_long;
pub const __daddr_t = c_int;
pub const __key_t = c_int;
pub const __clockid_t = c_int;
pub const __timer_t = ?*anyopaque;
pub const __blksize_t = c_long;
pub const __blkcnt_t = c_long;
pub const __blkcnt64_t = c_long;
pub const __fsblkcnt_t = c_ulong;
pub const __fsblkcnt64_t = c_ulong;
pub const __fsfilcnt_t = c_ulong;
pub const __fsfilcnt64_t = c_ulong;
pub const __fsword_t = c_long;
pub const __ssize_t = c_long;
pub const __syscall_slong_t = c_long;
pub const __syscall_ulong_t = c_ulong;
pub const __loff_t = __off64_t;
pub const __caddr_t = [*c]u8;
pub const __intptr_t = c_long;
pub const __socklen_t = c_uint;
pub const __sig_atomic_t = c_int;
pub const int_least8_t = __int_least8_t;
pub const int_least16_t = __int_least16_t;
pub const int_least32_t = __int_least32_t;
pub const int_least64_t = __int_least64_t;
pub const uint_least8_t = __uint_least8_t;
pub const uint_least16_t = __uint_least16_t;
pub const uint_least32_t = __uint_least32_t;
pub const uint_least64_t = __uint_least64_t;
pub const int_fast8_t = i8;
pub const int_fast16_t = c_long;
pub const int_fast32_t = c_long;
pub const int_fast64_t = c_long;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = c_ulong;
pub const uint_fast32_t = c_ulong;
pub const uint_fast64_t = c_ulong;
pub const intmax_t = __intmax_t;
pub const uintmax_t = __uintmax_t;
pub const ptrdiff_t = c_long;
pub const wchar_t = c_int;
pub const max_align_t = extern struct {
    __aro_max_align_ll: c_longlong = 0,
    __aro_max_align_ld: c_longdouble = 0,
};
pub const float_t = f32;
pub const double_t = f64;
pub extern fn __fpclassify(__value: f64) c_int;
pub extern fn __signbit(__value: f64) c_int;
pub extern fn __isinf(__value: f64) c_int;
pub extern fn __finite(__value: f64) c_int;
pub extern fn __isnan(__value: f64) c_int;
pub extern fn __iseqsig(__x: f64, __y: f64) c_int;
pub extern fn __issignaling(__value: f64) c_int;
pub extern fn acos(__x: f64) f64;
pub extern fn __acos(__x: f64) f64;
pub extern fn asin(__x: f64) f64;
pub extern fn __asin(__x: f64) f64;
pub extern fn atan(__x: f64) f64;
pub extern fn __atan(__x: f64) f64;
pub extern fn atan2(__y: f64, __x: f64) f64;
pub extern fn __atan2(__y: f64, __x: f64) f64;
pub extern fn cos(__x: f64) f64;
pub extern fn __cos(__x: f64) f64;
pub extern fn sin(__x: f64) f64;
pub extern fn __sin(__x: f64) f64;
pub extern fn tan(__x: f64) f64;
pub extern fn __tan(__x: f64) f64;
pub extern fn cosh(__x: f64) f64;
pub extern fn __cosh(__x: f64) f64;
pub extern fn sinh(__x: f64) f64;
pub extern fn __sinh(__x: f64) f64;
pub extern fn tanh(__x: f64) f64;
pub extern fn __tanh(__x: f64) f64;
pub extern fn acosh(__x: f64) f64;
pub extern fn __acosh(__x: f64) f64;
pub extern fn asinh(__x: f64) f64;
pub extern fn __asinh(__x: f64) f64;
pub extern fn atanh(__x: f64) f64;
pub extern fn __atanh(__x: f64) f64;
pub extern fn exp(__x: f64) f64;
pub extern fn __exp(__x: f64) f64;
pub extern fn frexp(__x: f64, __exponent: [*c]c_int) f64;
pub extern fn __frexp(__x: f64, __exponent: [*c]c_int) f64;
pub extern fn ldexp(__x: f64, __exponent: c_int) f64;
pub extern fn __ldexp(__x: f64, __exponent: c_int) f64;
pub extern fn log(__x: f64) f64;
pub extern fn __log(__x: f64) f64;
pub extern fn log10(__x: f64) f64;
pub extern fn __log10(__x: f64) f64;
pub extern fn modf(__x: f64, __iptr: [*c]f64) f64;
pub extern fn __modf(__x: f64, __iptr: [*c]f64) f64;
pub extern fn expm1(__x: f64) f64;
pub extern fn __expm1(__x: f64) f64;
pub extern fn log1p(__x: f64) f64;
pub extern fn __log1p(__x: f64) f64;
pub extern fn logb(__x: f64) f64;
pub extern fn __logb(__x: f64) f64;
pub extern fn exp2(__x: f64) f64;
pub extern fn __exp2(__x: f64) f64;
pub extern fn log2(__x: f64) f64;
pub extern fn __log2(__x: f64) f64;
pub extern fn pow(__x: f64, __y: f64) f64;
pub extern fn __pow(__x: f64, __y: f64) f64;
pub extern fn sqrt(__x: f64) f64;
pub extern fn __sqrt(__x: f64) f64;
pub extern fn hypot(__x: f64, __y: f64) f64;
pub extern fn __hypot(__x: f64, __y: f64) f64;
pub extern fn cbrt(__x: f64) f64;
pub extern fn __cbrt(__x: f64) f64;
pub extern fn ceil(__x: f64) f64;
pub extern fn fabs(__x: f64) f64;
pub extern fn floor(__x: f64) f64;
pub extern fn fmod(__x: f64, __y: f64) f64;
pub extern fn __fmod(__x: f64, __y: f64) f64;
pub extern fn isinf(__value: f64) c_int;
pub extern fn finite(__value: f64) c_int;
pub extern fn drem(__x: f64, __y: f64) f64;
pub extern fn __drem(__x: f64, __y: f64) f64;
pub extern fn significand(__x: f64) f64;
pub extern fn __significand(__x: f64) f64;
pub extern fn copysign(__x: f64, __y: f64) f64;
pub extern fn nan(__tagb: [*c]const u8) f64;
pub extern fn __nan(__tagb: [*c]const u8) f64;
pub extern fn isnan(__value: f64) c_int;
pub extern fn j0(f64) f64;
pub extern fn __j0(f64) f64;
pub extern fn j1(f64) f64;
pub extern fn __j1(f64) f64;
pub extern fn jn(c_int, f64) f64;
pub extern fn __jn(c_int, f64) f64;
pub extern fn y0(f64) f64;
pub extern fn __y0(f64) f64;
pub extern fn y1(f64) f64;
pub extern fn __y1(f64) f64;
pub extern fn yn(c_int, f64) f64;
pub extern fn __yn(c_int, f64) f64;
pub extern fn erf(f64) f64;
pub extern fn __erf(f64) f64;
pub extern fn erfc(f64) f64;
pub extern fn __erfc(f64) f64;
pub extern fn lgamma(f64) f64;
pub extern fn __lgamma(f64) f64;
pub extern fn tgamma(f64) f64;
pub extern fn __tgamma(f64) f64;
pub extern fn gamma(f64) f64;
pub extern fn __gamma(f64) f64;
pub extern fn lgamma_r(f64, __signgamp: [*c]c_int) f64;
pub extern fn __lgamma_r(f64, __signgamp: [*c]c_int) f64;
pub extern fn rint(__x: f64) f64;
pub extern fn __rint(__x: f64) f64;
pub extern fn nextafter(__x: f64, __y: f64) f64;
pub extern fn __nextafter(__x: f64, __y: f64) f64;
pub extern fn nexttoward(__x: f64, __y: c_longdouble) f64;
pub extern fn __nexttoward(__x: f64, __y: c_longdouble) f64;
pub extern fn remainder(__x: f64, __y: f64) f64;
pub extern fn __remainder(__x: f64, __y: f64) f64;
pub extern fn scalbn(__x: f64, __n: c_int) f64;
pub extern fn __scalbn(__x: f64, __n: c_int) f64;
pub extern fn ilogb(__x: f64) c_int;
pub extern fn __ilogb(__x: f64) c_int;
pub extern fn scalbln(__x: f64, __n: c_long) f64;
pub extern fn __scalbln(__x: f64, __n: c_long) f64;
pub extern fn nearbyint(__x: f64) f64;
pub extern fn __nearbyint(__x: f64) f64;
pub extern fn round(__x: f64) f64;
pub extern fn trunc(__x: f64) f64;
pub extern fn remquo(__x: f64, __y: f64, __quo: [*c]c_int) f64;
pub extern fn __remquo(__x: f64, __y: f64, __quo: [*c]c_int) f64;
pub extern fn lrint(__x: f64) c_long;
pub extern fn __lrint(__x: f64) c_long;
pub extern fn llrint(__x: f64) c_longlong;
pub extern fn __llrint(__x: f64) c_longlong;
pub extern fn lround(__x: f64) c_long;
pub extern fn __lround(__x: f64) c_long;
pub extern fn llround(__x: f64) c_longlong;
pub extern fn __llround(__x: f64) c_longlong;
pub extern fn fdim(__x: f64, __y: f64) f64;
pub extern fn __fdim(__x: f64, __y: f64) f64;
pub extern fn fmax(__x: f64, __y: f64) f64;
pub extern fn fmin(__x: f64, __y: f64) f64;
pub extern fn fma(__x: f64, __y: f64, __z: f64) f64;
pub extern fn __fma(__x: f64, __y: f64, __z: f64) f64;
pub extern fn scalb(__x: f64, __n: f64) f64;
pub extern fn __scalb(__x: f64, __n: f64) f64;
pub extern fn __fpclassifyf(__value: f32) c_int;
pub extern fn __signbitf(__value: f32) c_int;
pub extern fn __isinff(__value: f32) c_int;
pub extern fn __finitef(__value: f32) c_int;
pub extern fn __isnanf(__value: f32) c_int;
pub extern fn __iseqsigf(__x: f32, __y: f32) c_int;
pub extern fn __issignalingf(__value: f32) c_int;
pub extern fn acosf(__x: f32) f32;
pub extern fn __acosf(__x: f32) f32;
pub extern fn asinf(__x: f32) f32;
pub extern fn __asinf(__x: f32) f32;
pub extern fn atanf(__x: f32) f32;
pub extern fn __atanf(__x: f32) f32;
pub extern fn atan2f(__y: f32, __x: f32) f32;
pub extern fn __atan2f(__y: f32, __x: f32) f32;
pub extern fn cosf(__x: f32) f32;
pub extern fn __cosf(__x: f32) f32;
pub extern fn sinf(__x: f32) f32;
pub extern fn __sinf(__x: f32) f32;
pub extern fn tanf(__x: f32) f32;
pub extern fn __tanf(__x: f32) f32;
pub extern fn coshf(__x: f32) f32;
pub extern fn __coshf(__x: f32) f32;
pub extern fn sinhf(__x: f32) f32;
pub extern fn __sinhf(__x: f32) f32;
pub extern fn tanhf(__x: f32) f32;
pub extern fn __tanhf(__x: f32) f32;
pub extern fn acoshf(__x: f32) f32;
pub extern fn __acoshf(__x: f32) f32;
pub extern fn asinhf(__x: f32) f32;
pub extern fn __asinhf(__x: f32) f32;
pub extern fn atanhf(__x: f32) f32;
pub extern fn __atanhf(__x: f32) f32;
pub extern fn expf(__x: f32) f32;
pub extern fn __expf(__x: f32) f32;
pub extern fn frexpf(__x: f32, __exponent: [*c]c_int) f32;
pub extern fn __frexpf(__x: f32, __exponent: [*c]c_int) f32;
pub extern fn ldexpf(__x: f32, __exponent: c_int) f32;
pub extern fn __ldexpf(__x: f32, __exponent: c_int) f32;
pub extern fn logf(__x: f32) f32;
pub extern fn __logf(__x: f32) f32;
pub extern fn log10f(__x: f32) f32;
pub extern fn __log10f(__x: f32) f32;
pub extern fn modff(__x: f32, __iptr: [*c]f32) f32;
pub extern fn __modff(__x: f32, __iptr: [*c]f32) f32;
pub extern fn expm1f(__x: f32) f32;
pub extern fn __expm1f(__x: f32) f32;
pub extern fn log1pf(__x: f32) f32;
pub extern fn __log1pf(__x: f32) f32;
pub extern fn logbf(__x: f32) f32;
pub extern fn __logbf(__x: f32) f32;
pub extern fn exp2f(__x: f32) f32;
pub extern fn __exp2f(__x: f32) f32;
pub extern fn log2f(__x: f32) f32;
pub extern fn __log2f(__x: f32) f32;
pub extern fn powf(__x: f32, __y: f32) f32;
pub extern fn __powf(__x: f32, __y: f32) f32;
pub extern fn sqrtf(__x: f32) f32;
pub extern fn __sqrtf(__x: f32) f32;
pub extern fn hypotf(__x: f32, __y: f32) f32;
pub extern fn __hypotf(__x: f32, __y: f32) f32;
pub extern fn cbrtf(__x: f32) f32;
pub extern fn __cbrtf(__x: f32) f32;
pub extern fn ceilf(__x: f32) f32;
pub extern fn fabsf(__x: f32) f32;
pub extern fn floorf(__x: f32) f32;
pub extern fn fmodf(__x: f32, __y: f32) f32;
pub extern fn __fmodf(__x: f32, __y: f32) f32;
pub extern fn isinff(__value: f32) c_int;
pub extern fn finitef(__value: f32) c_int;
pub extern fn dremf(__x: f32, __y: f32) f32;
pub extern fn __dremf(__x: f32, __y: f32) f32;
pub extern fn significandf(__x: f32) f32;
pub extern fn __significandf(__x: f32) f32;
pub extern fn copysignf(__x: f32, __y: f32) f32;
pub extern fn nanf(__tagb: [*c]const u8) f32;
pub extern fn __nanf(__tagb: [*c]const u8) f32;
pub extern fn isnanf(__value: f32) c_int;
pub extern fn j0f(f32) f32;
pub extern fn __j0f(f32) f32;
pub extern fn j1f(f32) f32;
pub extern fn __j1f(f32) f32;
pub extern fn jnf(c_int, f32) f32;
pub extern fn __jnf(c_int, f32) f32;
pub extern fn y0f(f32) f32;
pub extern fn __y0f(f32) f32;
pub extern fn y1f(f32) f32;
pub extern fn __y1f(f32) f32;
pub extern fn ynf(c_int, f32) f32;
pub extern fn __ynf(c_int, f32) f32;
pub extern fn erff(f32) f32;
pub extern fn __erff(f32) f32;
pub extern fn erfcf(f32) f32;
pub extern fn __erfcf(f32) f32;
pub extern fn lgammaf(f32) f32;
pub extern fn __lgammaf(f32) f32;
pub extern fn tgammaf(f32) f32;
pub extern fn __tgammaf(f32) f32;
pub extern fn gammaf(f32) f32;
pub extern fn __gammaf(f32) f32;
pub extern fn lgammaf_r(f32, __signgamp: [*c]c_int) f32;
pub extern fn __lgammaf_r(f32, __signgamp: [*c]c_int) f32;
pub extern fn rintf(__x: f32) f32;
pub extern fn __rintf(__x: f32) f32;
pub extern fn nextafterf(__x: f32, __y: f32) f32;
pub extern fn __nextafterf(__x: f32, __y: f32) f32;
pub extern fn nexttowardf(__x: f32, __y: c_longdouble) f32;
pub extern fn __nexttowardf(__x: f32, __y: c_longdouble) f32;
pub extern fn remainderf(__x: f32, __y: f32) f32;
pub extern fn __remainderf(__x: f32, __y: f32) f32;
pub extern fn scalbnf(__x: f32, __n: c_int) f32;
pub extern fn __scalbnf(__x: f32, __n: c_int) f32;
pub extern fn ilogbf(__x: f32) c_int;
pub extern fn __ilogbf(__x: f32) c_int;
pub extern fn scalblnf(__x: f32, __n: c_long) f32;
pub extern fn __scalblnf(__x: f32, __n: c_long) f32;
pub extern fn nearbyintf(__x: f32) f32;
pub extern fn __nearbyintf(__x: f32) f32;
pub extern fn roundf(__x: f32) f32;
pub extern fn truncf(__x: f32) f32;
pub extern fn remquof(__x: f32, __y: f32, __quo: [*c]c_int) f32;
pub extern fn __remquof(__x: f32, __y: f32, __quo: [*c]c_int) f32;
pub extern fn lrintf(__x: f32) c_long;
pub extern fn __lrintf(__x: f32) c_long;
pub extern fn llrintf(__x: f32) c_longlong;
pub extern fn __llrintf(__x: f32) c_longlong;
pub extern fn lroundf(__x: f32) c_long;
pub extern fn __lroundf(__x: f32) c_long;
pub extern fn llroundf(__x: f32) c_longlong;
pub extern fn __llroundf(__x: f32) c_longlong;
pub extern fn fdimf(__x: f32, __y: f32) f32;
pub extern fn __fdimf(__x: f32, __y: f32) f32;
pub extern fn fmaxf(__x: f32, __y: f32) f32;
pub extern fn fminf(__x: f32, __y: f32) f32;
pub extern fn fmaf(__x: f32, __y: f32, __z: f32) f32;
pub extern fn __fmaf(__x: f32, __y: f32, __z: f32) f32;
pub extern fn scalbf(__x: f32, __n: f32) f32;
pub extern fn __scalbf(__x: f32, __n: f32) f32;
pub extern fn __fpclassifyl(__value: c_longdouble) c_int;
pub extern fn __signbitl(__value: c_longdouble) c_int;
pub extern fn __isinfl(__value: c_longdouble) c_int;
pub extern fn __finitel(__value: c_longdouble) c_int;
pub extern fn __isnanl(__value: c_longdouble) c_int;
pub extern fn __iseqsigl(__x: c_longdouble, __y: c_longdouble) c_int;
pub extern fn __issignalingl(__value: c_longdouble) c_int;
pub extern fn acosl(__x: c_longdouble) c_longdouble;
pub extern fn __acosl(__x: c_longdouble) c_longdouble;
pub extern fn asinl(__x: c_longdouble) c_longdouble;
pub extern fn __asinl(__x: c_longdouble) c_longdouble;
pub extern fn atanl(__x: c_longdouble) c_longdouble;
pub extern fn __atanl(__x: c_longdouble) c_longdouble;
pub extern fn atan2l(__y: c_longdouble, __x: c_longdouble) c_longdouble;
pub extern fn __atan2l(__y: c_longdouble, __x: c_longdouble) c_longdouble;
pub extern fn cosl(__x: c_longdouble) c_longdouble;
pub extern fn __cosl(__x: c_longdouble) c_longdouble;
pub extern fn sinl(__x: c_longdouble) c_longdouble;
pub extern fn __sinl(__x: c_longdouble) c_longdouble;
pub extern fn tanl(__x: c_longdouble) c_longdouble;
pub extern fn __tanl(__x: c_longdouble) c_longdouble;
pub extern fn coshl(__x: c_longdouble) c_longdouble;
pub extern fn __coshl(__x: c_longdouble) c_longdouble;
pub extern fn sinhl(__x: c_longdouble) c_longdouble;
pub extern fn __sinhl(__x: c_longdouble) c_longdouble;
pub extern fn tanhl(__x: c_longdouble) c_longdouble;
pub extern fn __tanhl(__x: c_longdouble) c_longdouble;
pub extern fn acoshl(__x: c_longdouble) c_longdouble;
pub extern fn __acoshl(__x: c_longdouble) c_longdouble;
pub extern fn asinhl(__x: c_longdouble) c_longdouble;
pub extern fn __asinhl(__x: c_longdouble) c_longdouble;
pub extern fn atanhl(__x: c_longdouble) c_longdouble;
pub extern fn __atanhl(__x: c_longdouble) c_longdouble;
pub extern fn expl(__x: c_longdouble) c_longdouble;
pub extern fn __expl(__x: c_longdouble) c_longdouble;
pub extern fn frexpl(__x: c_longdouble, __exponent: [*c]c_int) c_longdouble;
pub extern fn __frexpl(__x: c_longdouble, __exponent: [*c]c_int) c_longdouble;
pub extern fn ldexpl(__x: c_longdouble, __exponent: c_int) c_longdouble;
pub extern fn __ldexpl(__x: c_longdouble, __exponent: c_int) c_longdouble;
pub extern fn logl(__x: c_longdouble) c_longdouble;
pub extern fn __logl(__x: c_longdouble) c_longdouble;
pub extern fn log10l(__x: c_longdouble) c_longdouble;
pub extern fn __log10l(__x: c_longdouble) c_longdouble;
pub extern fn modfl(__x: c_longdouble, __iptr: [*c]c_longdouble) c_longdouble;
pub extern fn __modfl(__x: c_longdouble, __iptr: [*c]c_longdouble) c_longdouble;
pub extern fn expm1l(__x: c_longdouble) c_longdouble;
pub extern fn __expm1l(__x: c_longdouble) c_longdouble;
pub extern fn log1pl(__x: c_longdouble) c_longdouble;
pub extern fn __log1pl(__x: c_longdouble) c_longdouble;
pub extern fn logbl(__x: c_longdouble) c_longdouble;
pub extern fn __logbl(__x: c_longdouble) c_longdouble;
pub extern fn exp2l(__x: c_longdouble) c_longdouble;
pub extern fn __exp2l(__x: c_longdouble) c_longdouble;
pub extern fn log2l(__x: c_longdouble) c_longdouble;
pub extern fn __log2l(__x: c_longdouble) c_longdouble;
pub extern fn powl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn __powl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn sqrtl(__x: c_longdouble) c_longdouble;
pub extern fn __sqrtl(__x: c_longdouble) c_longdouble;
pub extern fn hypotl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn __hypotl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn cbrtl(__x: c_longdouble) c_longdouble;
pub extern fn __cbrtl(__x: c_longdouble) c_longdouble;
pub extern fn ceill(__x: c_longdouble) c_longdouble;
pub extern fn fabsl(__x: c_longdouble) c_longdouble;
pub extern fn floorl(__x: c_longdouble) c_longdouble;
pub extern fn fmodl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn __fmodl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn isinfl(__value: c_longdouble) c_int;
pub extern fn finitel(__value: c_longdouble) c_int;
pub extern fn dreml(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn __dreml(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn significandl(__x: c_longdouble) c_longdouble;
pub extern fn __significandl(__x: c_longdouble) c_longdouble;
pub extern fn copysignl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn nanl(__tagb: [*c]const u8) c_longdouble;
pub extern fn __nanl(__tagb: [*c]const u8) c_longdouble;
pub extern fn isnanl(__value: c_longdouble) c_int;
pub extern fn j0l(c_longdouble) c_longdouble;
pub extern fn __j0l(c_longdouble) c_longdouble;
pub extern fn j1l(c_longdouble) c_longdouble;
pub extern fn __j1l(c_longdouble) c_longdouble;
pub extern fn jnl(c_int, c_longdouble) c_longdouble;
pub extern fn __jnl(c_int, c_longdouble) c_longdouble;
pub extern fn y0l(c_longdouble) c_longdouble;
pub extern fn __y0l(c_longdouble) c_longdouble;
pub extern fn y1l(c_longdouble) c_longdouble;
pub extern fn __y1l(c_longdouble) c_longdouble;
pub extern fn ynl(c_int, c_longdouble) c_longdouble;
pub extern fn __ynl(c_int, c_longdouble) c_longdouble;
pub extern fn erfl(c_longdouble) c_longdouble;
pub extern fn __erfl(c_longdouble) c_longdouble;
pub extern fn erfcl(c_longdouble) c_longdouble;
pub extern fn __erfcl(c_longdouble) c_longdouble;
pub extern fn lgammal(c_longdouble) c_longdouble;
pub extern fn __lgammal(c_longdouble) c_longdouble;
pub extern fn tgammal(c_longdouble) c_longdouble;
pub extern fn __tgammal(c_longdouble) c_longdouble;
pub extern fn gammal(c_longdouble) c_longdouble;
pub extern fn __gammal(c_longdouble) c_longdouble;
pub extern fn lgammal_r(c_longdouble, __signgamp: [*c]c_int) c_longdouble;
pub extern fn __lgammal_r(c_longdouble, __signgamp: [*c]c_int) c_longdouble;
pub extern fn rintl(__x: c_longdouble) c_longdouble;
pub extern fn __rintl(__x: c_longdouble) c_longdouble;
pub extern fn nextafterl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn __nextafterl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn nexttowardl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn __nexttowardl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn remainderl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn __remainderl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn scalbnl(__x: c_longdouble, __n: c_int) c_longdouble;
pub extern fn __scalbnl(__x: c_longdouble, __n: c_int) c_longdouble;
pub extern fn ilogbl(__x: c_longdouble) c_int;
pub extern fn __ilogbl(__x: c_longdouble) c_int;
pub extern fn scalblnl(__x: c_longdouble, __n: c_long) c_longdouble;
pub extern fn __scalblnl(__x: c_longdouble, __n: c_long) c_longdouble;
pub extern fn nearbyintl(__x: c_longdouble) c_longdouble;
pub extern fn __nearbyintl(__x: c_longdouble) c_longdouble;
pub extern fn roundl(__x: c_longdouble) c_longdouble;
pub extern fn truncl(__x: c_longdouble) c_longdouble;
pub extern fn remquol(__x: c_longdouble, __y: c_longdouble, __quo: [*c]c_int) c_longdouble;
pub extern fn __remquol(__x: c_longdouble, __y: c_longdouble, __quo: [*c]c_int) c_longdouble;
pub extern fn lrintl(__x: c_longdouble) c_long;
pub extern fn __lrintl(__x: c_longdouble) c_long;
pub extern fn llrintl(__x: c_longdouble) c_longlong;
pub extern fn __llrintl(__x: c_longdouble) c_longlong;
pub extern fn lroundl(__x: c_longdouble) c_long;
pub extern fn __lroundl(__x: c_longdouble) c_long;
pub extern fn llroundl(__x: c_longdouble) c_longlong;
pub extern fn __llroundl(__x: c_longdouble) c_longlong;
pub extern fn fdiml(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn __fdiml(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn fmaxl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn fminl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn fmal(__x: c_longdouble, __y: c_longdouble, __z: c_longdouble) c_longdouble;
pub extern fn __fmal(__x: c_longdouble, __y: c_longdouble, __z: c_longdouble) c_longdouble;
pub extern fn scalbl(__x: c_longdouble, __n: c_longdouble) c_longdouble;
pub extern fn __scalbl(__x: c_longdouble, __n: c_longdouble) c_longdouble;
pub extern fn __fpclassifyf128(__value: f128) c_int;
pub extern fn __signbitf128(__value: f128) c_int;
pub extern fn __isinff128(__value: f128) c_int;
pub extern fn __finitef128(__value: f128) c_int;
pub extern fn __isnanf128(__value: f128) c_int;
pub extern fn __iseqsigf128(__x: f128, __y: f128) c_int;
pub extern fn __issignalingf128(__value: f128) c_int;
pub extern var signgam: c_int;
pub const FP_NAN: c_int = 0;
pub const FP_INFINITE: c_int = 1;
pub const FP_ZERO: c_int = 2;
pub const FP_SUBNORMAL: c_int = 3;
pub const FP_NORMAL: c_int = 4;
const enum_unnamed_1 = c_uint;
pub const struct_WGPUStringView = extern struct {
    data: [*c]const u8 = null,
    length: usize = 0,
    pub const wgpuGetProcAddress = __root.wgpuGetProcAddress;
};
pub const WGPUStringView = struct_WGPUStringView;
pub const WGPUFlags = u64;
pub const WGPUBool = u32;
pub const struct_WGPUAdapterImpl = opaque {
    pub const wgpuAdapterGetFeatures = __root.wgpuAdapterGetFeatures;
    pub const wgpuAdapterGetInfo = __root.wgpuAdapterGetInfo;
    pub const wgpuAdapterGetLimits = __root.wgpuAdapterGetLimits;
    pub const wgpuAdapterHasFeature = __root.wgpuAdapterHasFeature;
    pub const wgpuAdapterRequestDevice = __root.wgpuAdapterRequestDevice;
    pub const wgpuAdapterAddRef = __root.wgpuAdapterAddRef;
    pub const wgpuAdapterRelease = __root.wgpuAdapterRelease;
};
pub const WGPUAdapter = ?*struct_WGPUAdapterImpl;
pub const struct_WGPUBindGroupImpl = opaque {
    pub const wgpuBindGroupSetLabel = __root.wgpuBindGroupSetLabel;
    pub const wgpuBindGroupAddRef = __root.wgpuBindGroupAddRef;
    pub const wgpuBindGroupRelease = __root.wgpuBindGroupRelease;
};
pub const WGPUBindGroup = ?*struct_WGPUBindGroupImpl;
pub const struct_WGPUBindGroupLayoutImpl = opaque {
    pub const wgpuBindGroupLayoutSetLabel = __root.wgpuBindGroupLayoutSetLabel;
    pub const wgpuBindGroupLayoutAddRef = __root.wgpuBindGroupLayoutAddRef;
    pub const wgpuBindGroupLayoutRelease = __root.wgpuBindGroupLayoutRelease;
};
pub const WGPUBindGroupLayout = ?*struct_WGPUBindGroupLayoutImpl;
pub const struct_WGPUBufferImpl = opaque {
    pub const wgpuBufferDestroy = __root.wgpuBufferDestroy;
    pub const wgpuBufferGetConstMappedRange = __root.wgpuBufferGetConstMappedRange;
    pub const wgpuBufferGetMappedRange = __root.wgpuBufferGetMappedRange;
    pub const wgpuBufferGetMapState = __root.wgpuBufferGetMapState;
    pub const wgpuBufferGetSize = __root.wgpuBufferGetSize;
    pub const wgpuBufferGetUsage = __root.wgpuBufferGetUsage;
    pub const wgpuBufferMapAsync = __root.wgpuBufferMapAsync;
    pub const wgpuBufferReadMappedRange = __root.wgpuBufferReadMappedRange;
    pub const wgpuBufferSetLabel = __root.wgpuBufferSetLabel;
    pub const wgpuBufferUnmap = __root.wgpuBufferUnmap;
    pub const wgpuBufferWriteMappedRange = __root.wgpuBufferWriteMappedRange;
    pub const wgpuBufferAddRef = __root.wgpuBufferAddRef;
    pub const wgpuBufferRelease = __root.wgpuBufferRelease;
};
pub const WGPUBuffer = ?*struct_WGPUBufferImpl;
pub const struct_WGPUCommandBufferImpl = opaque {
    pub const wgpuCommandBufferSetLabel = __root.wgpuCommandBufferSetLabel;
    pub const wgpuCommandBufferAddRef = __root.wgpuCommandBufferAddRef;
    pub const wgpuCommandBufferRelease = __root.wgpuCommandBufferRelease;
};
pub const WGPUCommandBuffer = ?*struct_WGPUCommandBufferImpl;
pub const struct_WGPUCommandEncoderImpl = opaque {
    pub const wgpuCommandEncoderBeginComputePass = __root.wgpuCommandEncoderBeginComputePass;
    pub const wgpuCommandEncoderBeginRenderPass = __root.wgpuCommandEncoderBeginRenderPass;
    pub const wgpuCommandEncoderClearBuffer = __root.wgpuCommandEncoderClearBuffer;
    pub const wgpuCommandEncoderCopyBufferToBuffer = __root.wgpuCommandEncoderCopyBufferToBuffer;
    pub const wgpuCommandEncoderCopyBufferToTexture = __root.wgpuCommandEncoderCopyBufferToTexture;
    pub const wgpuCommandEncoderCopyTextureToBuffer = __root.wgpuCommandEncoderCopyTextureToBuffer;
    pub const wgpuCommandEncoderCopyTextureToTexture = __root.wgpuCommandEncoderCopyTextureToTexture;
    pub const wgpuCommandEncoderFinish = __root.wgpuCommandEncoderFinish;
    pub const wgpuCommandEncoderInsertDebugMarker = __root.wgpuCommandEncoderInsertDebugMarker;
    pub const wgpuCommandEncoderPopDebugGroup = __root.wgpuCommandEncoderPopDebugGroup;
    pub const wgpuCommandEncoderPushDebugGroup = __root.wgpuCommandEncoderPushDebugGroup;
    pub const wgpuCommandEncoderResolveQuerySet = __root.wgpuCommandEncoderResolveQuerySet;
    pub const wgpuCommandEncoderSetLabel = __root.wgpuCommandEncoderSetLabel;
    pub const wgpuCommandEncoderWriteTimestamp = __root.wgpuCommandEncoderWriteTimestamp;
    pub const wgpuCommandEncoderAddRef = __root.wgpuCommandEncoderAddRef;
    pub const wgpuCommandEncoderRelease = __root.wgpuCommandEncoderRelease;
    pub const wgpuCommandEncoderClearTexture = __root.wgpuCommandEncoderClearTexture;
};
pub const WGPUCommandEncoder = ?*struct_WGPUCommandEncoderImpl;
pub const struct_WGPUComputePassEncoderImpl = opaque {
    pub const wgpuComputePassEncoderDispatchWorkgroups = __root.wgpuComputePassEncoderDispatchWorkgroups;
    pub const wgpuComputePassEncoderDispatchWorkgroupsIndirect = __root.wgpuComputePassEncoderDispatchWorkgroupsIndirect;
    pub const wgpuComputePassEncoderEnd = __root.wgpuComputePassEncoderEnd;
    pub const wgpuComputePassEncoderInsertDebugMarker = __root.wgpuComputePassEncoderInsertDebugMarker;
    pub const wgpuComputePassEncoderPopDebugGroup = __root.wgpuComputePassEncoderPopDebugGroup;
    pub const wgpuComputePassEncoderPushDebugGroup = __root.wgpuComputePassEncoderPushDebugGroup;
    pub const wgpuComputePassEncoderSetBindGroup = __root.wgpuComputePassEncoderSetBindGroup;
    pub const wgpuComputePassEncoderSetLabel = __root.wgpuComputePassEncoderSetLabel;
    pub const wgpuComputePassEncoderSetPipeline = __root.wgpuComputePassEncoderSetPipeline;
    pub const wgpuComputePassEncoderAddRef = __root.wgpuComputePassEncoderAddRef;
    pub const wgpuComputePassEncoderRelease = __root.wgpuComputePassEncoderRelease;
    pub const wgpuComputePassEncoderSetImmediates = __root.wgpuComputePassEncoderSetImmediates;
    pub const wgpuComputePassEncoderBeginPipelineStatisticsQuery = __root.wgpuComputePassEncoderBeginPipelineStatisticsQuery;
    pub const wgpuComputePassEncoderEndPipelineStatisticsQuery = __root.wgpuComputePassEncoderEndPipelineStatisticsQuery;
    pub const wgpuComputePassEncoderWriteTimestamp = __root.wgpuComputePassEncoderWriteTimestamp;
};
pub const WGPUComputePassEncoder = ?*struct_WGPUComputePassEncoderImpl;
pub const struct_WGPUComputePipelineImpl = opaque {
    pub const wgpuComputePipelineGetBindGroupLayout = __root.wgpuComputePipelineGetBindGroupLayout;
    pub const wgpuComputePipelineSetLabel = __root.wgpuComputePipelineSetLabel;
    pub const wgpuComputePipelineAddRef = __root.wgpuComputePipelineAddRef;
    pub const wgpuComputePipelineRelease = __root.wgpuComputePipelineRelease;
};
pub const WGPUComputePipeline = ?*struct_WGPUComputePipelineImpl;
pub const struct_WGPUDeviceImpl = opaque {
    pub const wgpuDeviceCreateBindGroup = __root.wgpuDeviceCreateBindGroup;
    pub const wgpuDeviceCreateBindGroupLayout = __root.wgpuDeviceCreateBindGroupLayout;
    pub const wgpuDeviceCreateBuffer = __root.wgpuDeviceCreateBuffer;
    pub const wgpuDeviceCreateCommandEncoder = __root.wgpuDeviceCreateCommandEncoder;
    pub const wgpuDeviceCreateComputePipeline = __root.wgpuDeviceCreateComputePipeline;
    pub const wgpuDeviceCreateComputePipelineAsync = __root.wgpuDeviceCreateComputePipelineAsync;
    pub const wgpuDeviceCreatePipelineLayout = __root.wgpuDeviceCreatePipelineLayout;
    pub const wgpuDeviceCreateQuerySet = __root.wgpuDeviceCreateQuerySet;
    pub const wgpuDeviceCreateRenderBundleEncoder = __root.wgpuDeviceCreateRenderBundleEncoder;
    pub const wgpuDeviceCreateRenderPipeline = __root.wgpuDeviceCreateRenderPipeline;
    pub const wgpuDeviceCreateRenderPipelineAsync = __root.wgpuDeviceCreateRenderPipelineAsync;
    pub const wgpuDeviceCreateSampler = __root.wgpuDeviceCreateSampler;
    pub const wgpuDeviceCreateShaderModule = __root.wgpuDeviceCreateShaderModule;
    pub const wgpuDeviceCreateTexture = __root.wgpuDeviceCreateTexture;
    pub const wgpuDeviceDestroy = __root.wgpuDeviceDestroy;
    pub const wgpuDeviceGetAdapterInfo = __root.wgpuDeviceGetAdapterInfo;
    pub const wgpuDeviceGetFeatures = __root.wgpuDeviceGetFeatures;
    pub const wgpuDeviceGetLimits = __root.wgpuDeviceGetLimits;
    pub const wgpuDeviceGetLostFuture = __root.wgpuDeviceGetLostFuture;
    pub const wgpuDeviceGetQueue = __root.wgpuDeviceGetQueue;
    pub const wgpuDeviceHasFeature = __root.wgpuDeviceHasFeature;
    pub const wgpuDevicePopErrorScope = __root.wgpuDevicePopErrorScope;
    pub const wgpuDevicePushErrorScope = __root.wgpuDevicePushErrorScope;
    pub const wgpuDeviceSetLabel = __root.wgpuDeviceSetLabel;
    pub const wgpuDeviceAddRef = __root.wgpuDeviceAddRef;
    pub const wgpuDeviceRelease = __root.wgpuDeviceRelease;
    pub const wgpuDevicePoll = __root.wgpuDevicePoll;
    pub const wgpuDeviceCreateShaderModuleSpirV = __root.wgpuDeviceCreateShaderModuleSpirV;
    pub const wgpuDeviceGetNativeMetalDevice = __root.wgpuDeviceGetNativeMetalDevice;
    pub const wgpuDeviceStartGraphicsDebuggerCapture = __root.wgpuDeviceStartGraphicsDebuggerCapture;
    pub const wgpuDeviceStopGraphicsDebuggerCapture = __root.wgpuDeviceStopGraphicsDebuggerCapture;
};
pub const WGPUDevice = ?*struct_WGPUDeviceImpl;
pub const struct_WGPUExternalTextureImpl = opaque {
    pub const wgpuExternalTextureSetLabel = __root.wgpuExternalTextureSetLabel;
    pub const wgpuExternalTextureAddRef = __root.wgpuExternalTextureAddRef;
    pub const wgpuExternalTextureRelease = __root.wgpuExternalTextureRelease;
};
pub const WGPUExternalTexture = ?*struct_WGPUExternalTextureImpl;
pub const struct_WGPUInstanceImpl = opaque {
    pub const wgpuInstanceCreateSurface = __root.wgpuInstanceCreateSurface;
    pub const wgpuInstanceGetWGSLLanguageFeatures = __root.wgpuInstanceGetWGSLLanguageFeatures;
    pub const wgpuInstanceHasWGSLLanguageFeature = __root.wgpuInstanceHasWGSLLanguageFeature;
    pub const wgpuInstanceProcessEvents = __root.wgpuInstanceProcessEvents;
    pub const wgpuInstanceRequestAdapter = __root.wgpuInstanceRequestAdapter;
    pub const wgpuInstanceWaitAny = __root.wgpuInstanceWaitAny;
    pub const wgpuInstanceAddRef = __root.wgpuInstanceAddRef;
    pub const wgpuInstanceRelease = __root.wgpuInstanceRelease;
    pub const wgpuGenerateReport = __root.wgpuGenerateReport;
    pub const wgpuInstanceEnumerateAdapters = __root.wgpuInstanceEnumerateAdapters;
};
pub const WGPUInstance = ?*struct_WGPUInstanceImpl;
pub const struct_WGPUPipelineLayoutImpl = opaque {
    pub const wgpuPipelineLayoutSetLabel = __root.wgpuPipelineLayoutSetLabel;
    pub const wgpuPipelineLayoutAddRef = __root.wgpuPipelineLayoutAddRef;
    pub const wgpuPipelineLayoutRelease = __root.wgpuPipelineLayoutRelease;
};
pub const WGPUPipelineLayout = ?*struct_WGPUPipelineLayoutImpl;
pub const struct_WGPUQuerySetImpl = opaque {
    pub const wgpuQuerySetDestroy = __root.wgpuQuerySetDestroy;
    pub const wgpuQuerySetGetCount = __root.wgpuQuerySetGetCount;
    pub const wgpuQuerySetGetType = __root.wgpuQuerySetGetType;
    pub const wgpuQuerySetSetLabel = __root.wgpuQuerySetSetLabel;
    pub const wgpuQuerySetAddRef = __root.wgpuQuerySetAddRef;
    pub const wgpuQuerySetRelease = __root.wgpuQuerySetRelease;
};
pub const WGPUQuerySet = ?*struct_WGPUQuerySetImpl;
pub const struct_WGPUQueueImpl = opaque {
    pub const wgpuQueueOnSubmittedWorkDone = __root.wgpuQueueOnSubmittedWorkDone;
    pub const wgpuQueueSetLabel = __root.wgpuQueueSetLabel;
    pub const wgpuQueueSubmit = __root.wgpuQueueSubmit;
    pub const wgpuQueueWriteBuffer = __root.wgpuQueueWriteBuffer;
    pub const wgpuQueueWriteTexture = __root.wgpuQueueWriteTexture;
    pub const wgpuQueueAddRef = __root.wgpuQueueAddRef;
    pub const wgpuQueueRelease = __root.wgpuQueueRelease;
    pub const wgpuQueueSubmitForIndex = __root.wgpuQueueSubmitForIndex;
    pub const wgpuQueueGetTimestampPeriod = __root.wgpuQueueGetTimestampPeriod;
    pub const wgpuQueueGetNativeMetalCommandQueue = __root.wgpuQueueGetNativeMetalCommandQueue;
};
pub const WGPUQueue = ?*struct_WGPUQueueImpl;
pub const struct_WGPURenderBundleImpl = opaque {
    pub const wgpuRenderBundleSetLabel = __root.wgpuRenderBundleSetLabel;
    pub const wgpuRenderBundleAddRef = __root.wgpuRenderBundleAddRef;
    pub const wgpuRenderBundleRelease = __root.wgpuRenderBundleRelease;
};
pub const WGPURenderBundle = ?*struct_WGPURenderBundleImpl;
pub const struct_WGPURenderBundleEncoderImpl = opaque {
    pub const wgpuRenderBundleEncoderDraw = __root.wgpuRenderBundleEncoderDraw;
    pub const wgpuRenderBundleEncoderDrawIndexed = __root.wgpuRenderBundleEncoderDrawIndexed;
    pub const wgpuRenderBundleEncoderDrawIndexedIndirect = __root.wgpuRenderBundleEncoderDrawIndexedIndirect;
    pub const wgpuRenderBundleEncoderDrawIndirect = __root.wgpuRenderBundleEncoderDrawIndirect;
    pub const wgpuRenderBundleEncoderFinish = __root.wgpuRenderBundleEncoderFinish;
    pub const wgpuRenderBundleEncoderInsertDebugMarker = __root.wgpuRenderBundleEncoderInsertDebugMarker;
    pub const wgpuRenderBundleEncoderPopDebugGroup = __root.wgpuRenderBundleEncoderPopDebugGroup;
    pub const wgpuRenderBundleEncoderPushDebugGroup = __root.wgpuRenderBundleEncoderPushDebugGroup;
    pub const wgpuRenderBundleEncoderSetBindGroup = __root.wgpuRenderBundleEncoderSetBindGroup;
    pub const wgpuRenderBundleEncoderSetIndexBuffer = __root.wgpuRenderBundleEncoderSetIndexBuffer;
    pub const wgpuRenderBundleEncoderSetLabel = __root.wgpuRenderBundleEncoderSetLabel;
    pub const wgpuRenderBundleEncoderSetPipeline = __root.wgpuRenderBundleEncoderSetPipeline;
    pub const wgpuRenderBundleEncoderSetVertexBuffer = __root.wgpuRenderBundleEncoderSetVertexBuffer;
    pub const wgpuRenderBundleEncoderAddRef = __root.wgpuRenderBundleEncoderAddRef;
    pub const wgpuRenderBundleEncoderRelease = __root.wgpuRenderBundleEncoderRelease;
    pub const wgpuRenderBundleEncoderSetImmediates = __root.wgpuRenderBundleEncoderSetImmediates;
};
pub const WGPURenderBundleEncoder = ?*struct_WGPURenderBundleEncoderImpl;
pub const struct_WGPURenderPassEncoderImpl = opaque {
    pub const wgpuRenderPassEncoderBeginOcclusionQuery = __root.wgpuRenderPassEncoderBeginOcclusionQuery;
    pub const wgpuRenderPassEncoderDraw = __root.wgpuRenderPassEncoderDraw;
    pub const wgpuRenderPassEncoderDrawIndexed = __root.wgpuRenderPassEncoderDrawIndexed;
    pub const wgpuRenderPassEncoderDrawIndexedIndirect = __root.wgpuRenderPassEncoderDrawIndexedIndirect;
    pub const wgpuRenderPassEncoderDrawIndirect = __root.wgpuRenderPassEncoderDrawIndirect;
    pub const wgpuRenderPassEncoderEnd = __root.wgpuRenderPassEncoderEnd;
    pub const wgpuRenderPassEncoderEndOcclusionQuery = __root.wgpuRenderPassEncoderEndOcclusionQuery;
    pub const wgpuRenderPassEncoderExecuteBundles = __root.wgpuRenderPassEncoderExecuteBundles;
    pub const wgpuRenderPassEncoderInsertDebugMarker = __root.wgpuRenderPassEncoderInsertDebugMarker;
    pub const wgpuRenderPassEncoderPopDebugGroup = __root.wgpuRenderPassEncoderPopDebugGroup;
    pub const wgpuRenderPassEncoderPushDebugGroup = __root.wgpuRenderPassEncoderPushDebugGroup;
    pub const wgpuRenderPassEncoderSetBindGroup = __root.wgpuRenderPassEncoderSetBindGroup;
    pub const wgpuRenderPassEncoderSetBlendConstant = __root.wgpuRenderPassEncoderSetBlendConstant;
    pub const wgpuRenderPassEncoderSetIndexBuffer = __root.wgpuRenderPassEncoderSetIndexBuffer;
    pub const wgpuRenderPassEncoderSetLabel = __root.wgpuRenderPassEncoderSetLabel;
    pub const wgpuRenderPassEncoderSetPipeline = __root.wgpuRenderPassEncoderSetPipeline;
    pub const wgpuRenderPassEncoderSetScissorRect = __root.wgpuRenderPassEncoderSetScissorRect;
    pub const wgpuRenderPassEncoderSetStencilReference = __root.wgpuRenderPassEncoderSetStencilReference;
    pub const wgpuRenderPassEncoderSetVertexBuffer = __root.wgpuRenderPassEncoderSetVertexBuffer;
    pub const wgpuRenderPassEncoderSetViewport = __root.wgpuRenderPassEncoderSetViewport;
    pub const wgpuRenderPassEncoderAddRef = __root.wgpuRenderPassEncoderAddRef;
    pub const wgpuRenderPassEncoderRelease = __root.wgpuRenderPassEncoderRelease;
    pub const wgpuRenderPassEncoderSetImmediates = __root.wgpuRenderPassEncoderSetImmediates;
    pub const wgpuRenderPassEncoderMultiDrawIndirect = __root.wgpuRenderPassEncoderMultiDrawIndirect;
    pub const wgpuRenderPassEncoderMultiDrawIndexedIndirect = __root.wgpuRenderPassEncoderMultiDrawIndexedIndirect;
    pub const wgpuRenderPassEncoderMultiDrawIndirectCount = __root.wgpuRenderPassEncoderMultiDrawIndirectCount;
    pub const wgpuRenderPassEncoderMultiDrawIndexedIndirectCount = __root.wgpuRenderPassEncoderMultiDrawIndexedIndirectCount;
    pub const wgpuRenderPassEncoderBeginPipelineStatisticsQuery = __root.wgpuRenderPassEncoderBeginPipelineStatisticsQuery;
    pub const wgpuRenderPassEncoderEndPipelineStatisticsQuery = __root.wgpuRenderPassEncoderEndPipelineStatisticsQuery;
    pub const wgpuRenderPassEncoderWriteTimestamp = __root.wgpuRenderPassEncoderWriteTimestamp;
};
pub const WGPURenderPassEncoder = ?*struct_WGPURenderPassEncoderImpl;
pub const struct_WGPURenderPipelineImpl = opaque {
    pub const wgpuRenderPipelineGetBindGroupLayout = __root.wgpuRenderPipelineGetBindGroupLayout;
    pub const wgpuRenderPipelineSetLabel = __root.wgpuRenderPipelineSetLabel;
    pub const wgpuRenderPipelineAddRef = __root.wgpuRenderPipelineAddRef;
    pub const wgpuRenderPipelineRelease = __root.wgpuRenderPipelineRelease;
};
pub const WGPURenderPipeline = ?*struct_WGPURenderPipelineImpl;
pub const struct_WGPUSamplerImpl = opaque {
    pub const wgpuSamplerSetLabel = __root.wgpuSamplerSetLabel;
    pub const wgpuSamplerAddRef = __root.wgpuSamplerAddRef;
    pub const wgpuSamplerRelease = __root.wgpuSamplerRelease;
};
pub const WGPUSampler = ?*struct_WGPUSamplerImpl;
pub const struct_WGPUShaderModuleImpl = opaque {
    pub const wgpuShaderModuleGetCompilationInfo = __root.wgpuShaderModuleGetCompilationInfo;
    pub const wgpuShaderModuleSetLabel = __root.wgpuShaderModuleSetLabel;
    pub const wgpuShaderModuleAddRef = __root.wgpuShaderModuleAddRef;
    pub const wgpuShaderModuleRelease = __root.wgpuShaderModuleRelease;
};
pub const WGPUShaderModule = ?*struct_WGPUShaderModuleImpl;
pub const struct_WGPUSurfaceImpl = opaque {
    pub const wgpuSurfaceConfigure = __root.wgpuSurfaceConfigure;
    pub const wgpuSurfaceGetCapabilities = __root.wgpuSurfaceGetCapabilities;
    pub const wgpuSurfaceGetCurrentTexture = __root.wgpuSurfaceGetCurrentTexture;
    pub const wgpuSurfacePresent = __root.wgpuSurfacePresent;
    pub const wgpuSurfaceSetLabel = __root.wgpuSurfaceSetLabel;
    pub const wgpuSurfaceUnconfigure = __root.wgpuSurfaceUnconfigure;
    pub const wgpuSurfaceAddRef = __root.wgpuSurfaceAddRef;
    pub const wgpuSurfaceRelease = __root.wgpuSurfaceRelease;
};
pub const WGPUSurface = ?*struct_WGPUSurfaceImpl;
pub const struct_WGPUTextureImpl = opaque {
    pub const wgpuTextureCreateView = __root.wgpuTextureCreateView;
    pub const wgpuTextureDestroy = __root.wgpuTextureDestroy;
    pub const wgpuTextureGetDepthOrArrayLayers = __root.wgpuTextureGetDepthOrArrayLayers;
    pub const wgpuTextureGetDimension = __root.wgpuTextureGetDimension;
    pub const wgpuTextureGetFormat = __root.wgpuTextureGetFormat;
    pub const wgpuTextureGetHeight = __root.wgpuTextureGetHeight;
    pub const wgpuTextureGetMipLevelCount = __root.wgpuTextureGetMipLevelCount;
    pub const wgpuTextureGetSampleCount = __root.wgpuTextureGetSampleCount;
    pub const wgpuTextureGetTextureBindingViewDimension = __root.wgpuTextureGetTextureBindingViewDimension;
    pub const wgpuTextureGetUsage = __root.wgpuTextureGetUsage;
    pub const wgpuTextureGetWidth = __root.wgpuTextureGetWidth;
    pub const wgpuTextureSetLabel = __root.wgpuTextureSetLabel;
    pub const wgpuTextureAddRef = __root.wgpuTextureAddRef;
    pub const wgpuTextureRelease = __root.wgpuTextureRelease;
    pub const wgpuTextureGetNativeMetalTexture = __root.wgpuTextureGetNativeMetalTexture;
};
pub const WGPUTexture = ?*struct_WGPUTextureImpl;
pub const struct_WGPUTextureViewImpl = opaque {
    pub const wgpuTextureViewSetLabel = __root.wgpuTextureViewSetLabel;
    pub const wgpuTextureViewAddRef = __root.wgpuTextureViewAddRef;
    pub const wgpuTextureViewRelease = __root.wgpuTextureViewRelease;
};
pub const WGPUTextureView = ?*struct_WGPUTextureViewImpl;
pub const WGPUSType_ShaderSourceSPIRV: c_int = 1;
pub const WGPUSType_ShaderSourceWGSL: c_int = 2;
pub const WGPUSType_RenderPassMaxDrawCount: c_int = 3;
pub const WGPUSType_SurfaceSourceMetalLayer: c_int = 4;
pub const WGPUSType_SurfaceSourceWindowsHWND: c_int = 5;
pub const WGPUSType_SurfaceSourceXlibWindow: c_int = 6;
pub const WGPUSType_SurfaceSourceWaylandSurface: c_int = 7;
pub const WGPUSType_SurfaceSourceAndroidNativeWindow: c_int = 8;
pub const WGPUSType_SurfaceSourceXCBWindow: c_int = 9;
pub const WGPUSType_SurfaceColorManagement: c_int = 10;
pub const WGPUSType_RequestAdapterWebXROptions: c_int = 11;
pub const WGPUSType_TextureComponentSwizzleDescriptor: c_int = 12;
pub const WGPUSType_ExternalTextureBindingLayout: c_int = 13;
pub const WGPUSType_ExternalTextureBindingEntry: c_int = 14;
pub const WGPUSType_CompatibilityModeLimits: c_int = 15;
pub const WGPUSType_TextureBindingViewDimension: c_int = 16;
pub const WGPUSType_Force32: c_int = 2147483647;
pub const enum_WGPUSType = c_uint;
pub const WGPUSType = enum_WGPUSType;
pub const struct_WGPUChainedStruct = extern struct {
    next: [*c]struct_WGPUChainedStruct = null,
    sType: WGPUSType = @import("std").mem.zeroes(WGPUSType),
};
pub const WGPUChainedStruct = struct_WGPUChainedStruct;
pub const WGPUBackendType_Undefined: c_int = 0;
pub const WGPUBackendType_Null: c_int = 1;
pub const WGPUBackendType_WebGPU: c_int = 2;
pub const WGPUBackendType_D3D11: c_int = 3;
pub const WGPUBackendType_D3D12: c_int = 4;
pub const WGPUBackendType_Metal: c_int = 5;
pub const WGPUBackendType_Vulkan: c_int = 6;
pub const WGPUBackendType_OpenGL: c_int = 7;
pub const WGPUBackendType_OpenGLES: c_int = 8;
pub const WGPUBackendType_Force32: c_int = 2147483647;
pub const enum_WGPUBackendType = c_uint;
pub const WGPUBackendType = enum_WGPUBackendType;
pub const WGPUAdapterType_DiscreteGPU: c_int = 1;
pub const WGPUAdapterType_IntegratedGPU: c_int = 2;
pub const WGPUAdapterType_CPU: c_int = 3;
pub const WGPUAdapterType_Unknown: c_int = 4;
pub const WGPUAdapterType_Force32: c_int = 2147483647;
pub const enum_WGPUAdapterType = c_uint;
pub const WGPUAdapterType = enum_WGPUAdapterType;
pub const struct_WGPUAdapterInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    vendor: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    architecture: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    device: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    description: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    backendType: WGPUBackendType = @import("std").mem.zeroes(WGPUBackendType),
    adapterType: WGPUAdapterType = @import("std").mem.zeroes(WGPUAdapterType),
    vendorID: u32 = 0,
    deviceID: u32 = 0,
    subgroupMinSize: u32 = 0,
    subgroupMaxSize: u32 = 0,
    pub const wgpuAdapterInfoFreeMembers = __root.wgpuAdapterInfoFreeMembers;
};
pub const WGPUBlendOperation_Undefined: c_int = 0;
pub const WGPUBlendOperation_Add: c_int = 1;
pub const WGPUBlendOperation_Subtract: c_int = 2;
pub const WGPUBlendOperation_ReverseSubtract: c_int = 3;
pub const WGPUBlendOperation_Min: c_int = 4;
pub const WGPUBlendOperation_Max: c_int = 5;
pub const WGPUBlendOperation_Force32: c_int = 2147483647;
pub const enum_WGPUBlendOperation = c_uint;
pub const WGPUBlendOperation = enum_WGPUBlendOperation;
pub const WGPUBlendFactor_Undefined: c_int = 0;
pub const WGPUBlendFactor_Zero: c_int = 1;
pub const WGPUBlendFactor_One: c_int = 2;
pub const WGPUBlendFactor_Src: c_int = 3;
pub const WGPUBlendFactor_OneMinusSrc: c_int = 4;
pub const WGPUBlendFactor_SrcAlpha: c_int = 5;
pub const WGPUBlendFactor_OneMinusSrcAlpha: c_int = 6;
pub const WGPUBlendFactor_Dst: c_int = 7;
pub const WGPUBlendFactor_OneMinusDst: c_int = 8;
pub const WGPUBlendFactor_DstAlpha: c_int = 9;
pub const WGPUBlendFactor_OneMinusDstAlpha: c_int = 10;
pub const WGPUBlendFactor_SrcAlphaSaturated: c_int = 11;
pub const WGPUBlendFactor_Constant: c_int = 12;
pub const WGPUBlendFactor_OneMinusConstant: c_int = 13;
pub const WGPUBlendFactor_Src1: c_int = 14;
pub const WGPUBlendFactor_OneMinusSrc1: c_int = 15;
pub const WGPUBlendFactor_Src1Alpha: c_int = 16;
pub const WGPUBlendFactor_OneMinusSrc1Alpha: c_int = 17;
pub const WGPUBlendFactor_Force32: c_int = 2147483647;
pub const enum_WGPUBlendFactor = c_uint;
pub const WGPUBlendFactor = enum_WGPUBlendFactor;
pub const struct_WGPUBlendComponent = extern struct {
    operation: WGPUBlendOperation = @import("std").mem.zeroes(WGPUBlendOperation),
    srcFactor: WGPUBlendFactor = @import("std").mem.zeroes(WGPUBlendFactor),
    dstFactor: WGPUBlendFactor = @import("std").mem.zeroes(WGPUBlendFactor),
};
pub const WGPUBufferBindingType_BindingNotUsed: c_int = 0;
pub const WGPUBufferBindingType_Undefined: c_int = 1;
pub const WGPUBufferBindingType_Uniform: c_int = 2;
pub const WGPUBufferBindingType_Storage: c_int = 3;
pub const WGPUBufferBindingType_ReadOnlyStorage: c_int = 4;
pub const WGPUBufferBindingType_Force32: c_int = 2147483647;
pub const enum_WGPUBufferBindingType = c_uint;
pub const WGPUBufferBindingType = enum_WGPUBufferBindingType;
pub const struct_WGPUBufferBindingLayout = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    type: WGPUBufferBindingType = @import("std").mem.zeroes(WGPUBufferBindingType),
    hasDynamicOffset: WGPUBool = 0,
    minBindingSize: u64 = 0,
};
pub const WGPUBufferUsage = WGPUFlags;
pub const struct_WGPUBufferDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    usage: WGPUBufferUsage = 0,
    size: u64 = 0,
    mappedAtCreation: WGPUBool = 0,
};
pub const struct_WGPUColor = extern struct {
    r: f64 = 0,
    g: f64 = 0,
    b: f64 = 0,
    a: f64 = 0,
};
pub const struct_WGPUCommandBufferDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const struct_WGPUCommandEncoderDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const struct_WGPUCompatibilityModeLimits = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    maxStorageBuffersInVertexStage: u32 = 0,
    maxStorageTexturesInVertexStage: u32 = 0,
    maxStorageBuffersInFragmentStage: u32 = 0,
    maxStorageTexturesInFragmentStage: u32 = 0,
};
pub const WGPUCompilationMessageType_Error: c_int = 1;
pub const WGPUCompilationMessageType_Warning: c_int = 2;
pub const WGPUCompilationMessageType_Info: c_int = 3;
pub const WGPUCompilationMessageType_Force32: c_int = 2147483647;
pub const enum_WGPUCompilationMessageType = c_uint;
pub const WGPUCompilationMessageType = enum_WGPUCompilationMessageType;
pub const struct_WGPUCompilationMessage = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    message: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    type: WGPUCompilationMessageType = @import("std").mem.zeroes(WGPUCompilationMessageType),
    lineNum: u64 = 0,
    linePos: u64 = 0,
    offset: u64 = 0,
    length: u64 = 0,
};
pub const struct_WGPUConstantEntry = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    key: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    value: f64 = 0,
};
pub const struct_WGPUExtent3D = extern struct {
    width: u32 = 0,
    height: u32 = 0,
    depthOrArrayLayers: u32 = 0,
};
pub const struct_WGPUExternalTextureBindingEntry = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    externalTexture: WGPUExternalTexture = null,
};
pub const struct_WGPUExternalTextureBindingLayout = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
};
pub const struct_WGPUFuture = extern struct {
    id: u64 = 0,
};
pub const struct_WGPUInstanceLimits = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    timedWaitAnyMaxCount: usize = 0,
    pub const wgpuGetInstanceLimits = __root.wgpuGetInstanceLimits;
};
pub const struct_WGPUMultisampleState = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    count: u32 = 0,
    mask: u32 = 0,
    alphaToCoverageEnabled: WGPUBool = 0,
};
pub const struct_WGPUOrigin3D = extern struct {
    x: u32 = 0,
    y: u32 = 0,
    z: u32 = 0,
};
pub const struct_WGPUPassTimestampWrites = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    querySet: WGPUQuerySet = null,
    beginningOfPassWriteIndex: u32 = 0,
    endOfPassWriteIndex: u32 = 0,
};
pub const struct_WGPUPipelineLayoutDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    bindGroupLayoutCount: usize = 0,
    bindGroupLayouts: [*c]const WGPUBindGroupLayout = null,
    immediateSize: u32 = 0,
};
pub const WGPUPrimitiveTopology_Undefined: c_int = 0;
pub const WGPUPrimitiveTopology_PointList: c_int = 1;
pub const WGPUPrimitiveTopology_LineList: c_int = 2;
pub const WGPUPrimitiveTopology_LineStrip: c_int = 3;
pub const WGPUPrimitiveTopology_TriangleList: c_int = 4;
pub const WGPUPrimitiveTopology_TriangleStrip: c_int = 5;
pub const WGPUPrimitiveTopology_Force32: c_int = 2147483647;
pub const enum_WGPUPrimitiveTopology = c_uint;
pub const WGPUPrimitiveTopology = enum_WGPUPrimitiveTopology;
pub const WGPUIndexFormat_Undefined: c_int = 0;
pub const WGPUIndexFormat_Uint16: c_int = 1;
pub const WGPUIndexFormat_Uint32: c_int = 2;
pub const WGPUIndexFormat_Force32: c_int = 2147483647;
pub const enum_WGPUIndexFormat = c_uint;
pub const WGPUIndexFormat = enum_WGPUIndexFormat;
pub const WGPUFrontFace_Undefined: c_int = 0;
pub const WGPUFrontFace_CCW: c_int = 1;
pub const WGPUFrontFace_CW: c_int = 2;
pub const WGPUFrontFace_Force32: c_int = 2147483647;
pub const enum_WGPUFrontFace = c_uint;
pub const WGPUFrontFace = enum_WGPUFrontFace;
pub const WGPUCullMode_Undefined: c_int = 0;
pub const WGPUCullMode_None: c_int = 1;
pub const WGPUCullMode_Front: c_int = 2;
pub const WGPUCullMode_Back: c_int = 3;
pub const WGPUCullMode_Force32: c_int = 2147483647;
pub const enum_WGPUCullMode = c_uint;
pub const WGPUCullMode = enum_WGPUCullMode;
pub const struct_WGPUPrimitiveState = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    topology: WGPUPrimitiveTopology = @import("std").mem.zeroes(WGPUPrimitiveTopology),
    stripIndexFormat: WGPUIndexFormat = @import("std").mem.zeroes(WGPUIndexFormat),
    frontFace: WGPUFrontFace = @import("std").mem.zeroes(WGPUFrontFace),
    cullMode: WGPUCullMode = @import("std").mem.zeroes(WGPUCullMode),
    unclippedDepth: WGPUBool = 0,
};
pub const WGPUQueryType_Occlusion: c_int = 1;
pub const WGPUQueryType_Timestamp: c_int = 2;
pub const WGPUQueryType_Force32: c_int = 2147483647;
pub const enum_WGPUQueryType = c_uint;
pub const WGPUQueryType = enum_WGPUQueryType;
pub const struct_WGPUQuerySetDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    type: WGPUQueryType = @import("std").mem.zeroes(WGPUQueryType),
    count: u32 = 0,
};
pub const struct_WGPUQueueDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const struct_WGPURenderBundleDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUTextureFormat_Undefined: c_int = 0;
pub const WGPUTextureFormat_R8Unorm: c_int = 1;
pub const WGPUTextureFormat_R8Snorm: c_int = 2;
pub const WGPUTextureFormat_R8Uint: c_int = 3;
pub const WGPUTextureFormat_R8Sint: c_int = 4;
pub const WGPUTextureFormat_R16Unorm: c_int = 5;
pub const WGPUTextureFormat_R16Snorm: c_int = 6;
pub const WGPUTextureFormat_R16Uint: c_int = 7;
pub const WGPUTextureFormat_R16Sint: c_int = 8;
pub const WGPUTextureFormat_R16Float: c_int = 9;
pub const WGPUTextureFormat_RG8Unorm: c_int = 10;
pub const WGPUTextureFormat_RG8Snorm: c_int = 11;
pub const WGPUTextureFormat_RG8Uint: c_int = 12;
pub const WGPUTextureFormat_RG8Sint: c_int = 13;
pub const WGPUTextureFormat_R32Float: c_int = 14;
pub const WGPUTextureFormat_R32Uint: c_int = 15;
pub const WGPUTextureFormat_R32Sint: c_int = 16;
pub const WGPUTextureFormat_RG16Unorm: c_int = 17;
pub const WGPUTextureFormat_RG16Snorm: c_int = 18;
pub const WGPUTextureFormat_RG16Uint: c_int = 19;
pub const WGPUTextureFormat_RG16Sint: c_int = 20;
pub const WGPUTextureFormat_RG16Float: c_int = 21;
pub const WGPUTextureFormat_RGBA8Unorm: c_int = 22;
pub const WGPUTextureFormat_RGBA8UnormSrgb: c_int = 23;
pub const WGPUTextureFormat_RGBA8Snorm: c_int = 24;
pub const WGPUTextureFormat_RGBA8Uint: c_int = 25;
pub const WGPUTextureFormat_RGBA8Sint: c_int = 26;
pub const WGPUTextureFormat_BGRA8Unorm: c_int = 27;
pub const WGPUTextureFormat_BGRA8UnormSrgb: c_int = 28;
pub const WGPUTextureFormat_RGB10A2Uint: c_int = 29;
pub const WGPUTextureFormat_RGB10A2Unorm: c_int = 30;
pub const WGPUTextureFormat_RG11B10Ufloat: c_int = 31;
pub const WGPUTextureFormat_RGB9E5Ufloat: c_int = 32;
pub const WGPUTextureFormat_RG32Float: c_int = 33;
pub const WGPUTextureFormat_RG32Uint: c_int = 34;
pub const WGPUTextureFormat_RG32Sint: c_int = 35;
pub const WGPUTextureFormat_RGBA16Unorm: c_int = 36;
pub const WGPUTextureFormat_RGBA16Snorm: c_int = 37;
pub const WGPUTextureFormat_RGBA16Uint: c_int = 38;
pub const WGPUTextureFormat_RGBA16Sint: c_int = 39;
pub const WGPUTextureFormat_RGBA16Float: c_int = 40;
pub const WGPUTextureFormat_RGBA32Float: c_int = 41;
pub const WGPUTextureFormat_RGBA32Uint: c_int = 42;
pub const WGPUTextureFormat_RGBA32Sint: c_int = 43;
pub const WGPUTextureFormat_Stencil8: c_int = 44;
pub const WGPUTextureFormat_Depth16Unorm: c_int = 45;
pub const WGPUTextureFormat_Depth24Plus: c_int = 46;
pub const WGPUTextureFormat_Depth24PlusStencil8: c_int = 47;
pub const WGPUTextureFormat_Depth32Float: c_int = 48;
pub const WGPUTextureFormat_Depth32FloatStencil8: c_int = 49;
pub const WGPUTextureFormat_BC1RGBAUnorm: c_int = 50;
pub const WGPUTextureFormat_BC1RGBAUnormSrgb: c_int = 51;
pub const WGPUTextureFormat_BC2RGBAUnorm: c_int = 52;
pub const WGPUTextureFormat_BC2RGBAUnormSrgb: c_int = 53;
pub const WGPUTextureFormat_BC3RGBAUnorm: c_int = 54;
pub const WGPUTextureFormat_BC3RGBAUnormSrgb: c_int = 55;
pub const WGPUTextureFormat_BC4RUnorm: c_int = 56;
pub const WGPUTextureFormat_BC4RSnorm: c_int = 57;
pub const WGPUTextureFormat_BC5RGUnorm: c_int = 58;
pub const WGPUTextureFormat_BC5RGSnorm: c_int = 59;
pub const WGPUTextureFormat_BC6HRGBUfloat: c_int = 60;
pub const WGPUTextureFormat_BC6HRGBFloat: c_int = 61;
pub const WGPUTextureFormat_BC7RGBAUnorm: c_int = 62;
pub const WGPUTextureFormat_BC7RGBAUnormSrgb: c_int = 63;
pub const WGPUTextureFormat_ETC2RGB8Unorm: c_int = 64;
pub const WGPUTextureFormat_ETC2RGB8UnormSrgb: c_int = 65;
pub const WGPUTextureFormat_ETC2RGB8A1Unorm: c_int = 66;
pub const WGPUTextureFormat_ETC2RGB8A1UnormSrgb: c_int = 67;
pub const WGPUTextureFormat_ETC2RGBA8Unorm: c_int = 68;
pub const WGPUTextureFormat_ETC2RGBA8UnormSrgb: c_int = 69;
pub const WGPUTextureFormat_EACR11Unorm: c_int = 70;
pub const WGPUTextureFormat_EACR11Snorm: c_int = 71;
pub const WGPUTextureFormat_EACRG11Unorm: c_int = 72;
pub const WGPUTextureFormat_EACRG11Snorm: c_int = 73;
pub const WGPUTextureFormat_ASTC4x4Unorm: c_int = 74;
pub const WGPUTextureFormat_ASTC4x4UnormSrgb: c_int = 75;
pub const WGPUTextureFormat_ASTC5x4Unorm: c_int = 76;
pub const WGPUTextureFormat_ASTC5x4UnormSrgb: c_int = 77;
pub const WGPUTextureFormat_ASTC5x5Unorm: c_int = 78;
pub const WGPUTextureFormat_ASTC5x5UnormSrgb: c_int = 79;
pub const WGPUTextureFormat_ASTC6x5Unorm: c_int = 80;
pub const WGPUTextureFormat_ASTC6x5UnormSrgb: c_int = 81;
pub const WGPUTextureFormat_ASTC6x6Unorm: c_int = 82;
pub const WGPUTextureFormat_ASTC6x6UnormSrgb: c_int = 83;
pub const WGPUTextureFormat_ASTC8x5Unorm: c_int = 84;
pub const WGPUTextureFormat_ASTC8x5UnormSrgb: c_int = 85;
pub const WGPUTextureFormat_ASTC8x6Unorm: c_int = 86;
pub const WGPUTextureFormat_ASTC8x6UnormSrgb: c_int = 87;
pub const WGPUTextureFormat_ASTC8x8Unorm: c_int = 88;
pub const WGPUTextureFormat_ASTC8x8UnormSrgb: c_int = 89;
pub const WGPUTextureFormat_ASTC10x5Unorm: c_int = 90;
pub const WGPUTextureFormat_ASTC10x5UnormSrgb: c_int = 91;
pub const WGPUTextureFormat_ASTC10x6Unorm: c_int = 92;
pub const WGPUTextureFormat_ASTC10x6UnormSrgb: c_int = 93;
pub const WGPUTextureFormat_ASTC10x8Unorm: c_int = 94;
pub const WGPUTextureFormat_ASTC10x8UnormSrgb: c_int = 95;
pub const WGPUTextureFormat_ASTC10x10Unorm: c_int = 96;
pub const WGPUTextureFormat_ASTC10x10UnormSrgb: c_int = 97;
pub const WGPUTextureFormat_ASTC12x10Unorm: c_int = 98;
pub const WGPUTextureFormat_ASTC12x10UnormSrgb: c_int = 99;
pub const WGPUTextureFormat_ASTC12x12Unorm: c_int = 100;
pub const WGPUTextureFormat_ASTC12x12UnormSrgb: c_int = 101;
pub const WGPUTextureFormat_Force32: c_int = 2147483647;
pub const enum_WGPUTextureFormat = c_uint;
pub const WGPUTextureFormat = enum_WGPUTextureFormat;
pub const struct_WGPURenderBundleEncoderDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    colorFormatCount: usize = 0,
    colorFormats: [*c]const WGPUTextureFormat = null,
    depthStencilFormat: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    sampleCount: u32 = 0,
    depthReadOnly: WGPUBool = 0,
    stencilReadOnly: WGPUBool = 0,
};
pub const WGPULoadOp_Undefined: c_int = 0;
pub const WGPULoadOp_Load: c_int = 1;
pub const WGPULoadOp_Clear: c_int = 2;
pub const WGPULoadOp_Force32: c_int = 2147483647;
pub const enum_WGPULoadOp = c_uint;
pub const WGPULoadOp = enum_WGPULoadOp;
pub const WGPUStoreOp_Undefined: c_int = 0;
pub const WGPUStoreOp_Store: c_int = 1;
pub const WGPUStoreOp_Discard: c_int = 2;
pub const WGPUStoreOp_Force32: c_int = 2147483647;
pub const enum_WGPUStoreOp = c_uint;
pub const WGPUStoreOp = enum_WGPUStoreOp;
pub const struct_WGPURenderPassDepthStencilAttachment = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    view: WGPUTextureView = null,
    depthLoadOp: WGPULoadOp = @import("std").mem.zeroes(WGPULoadOp),
    depthStoreOp: WGPUStoreOp = @import("std").mem.zeroes(WGPUStoreOp),
    depthClearValue: f32 = 0,
    depthReadOnly: WGPUBool = 0,
    stencilLoadOp: WGPULoadOp = @import("std").mem.zeroes(WGPULoadOp),
    stencilStoreOp: WGPUStoreOp = @import("std").mem.zeroes(WGPUStoreOp),
    stencilClearValue: u32 = 0,
    stencilReadOnly: WGPUBool = 0,
};
pub const struct_WGPURenderPassMaxDrawCount = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    maxDrawCount: u64 = 0,
};
pub const struct_WGPURequestAdapterWebXROptions = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    xrCompatible: WGPUBool = 0,
};
pub const WGPUSamplerBindingType_BindingNotUsed: c_int = 0;
pub const WGPUSamplerBindingType_Undefined: c_int = 1;
pub const WGPUSamplerBindingType_Filtering: c_int = 2;
pub const WGPUSamplerBindingType_NonFiltering: c_int = 3;
pub const WGPUSamplerBindingType_Comparison: c_int = 4;
pub const WGPUSamplerBindingType_Force32: c_int = 2147483647;
pub const enum_WGPUSamplerBindingType = c_uint;
pub const WGPUSamplerBindingType = enum_WGPUSamplerBindingType;
pub const struct_WGPUSamplerBindingLayout = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    type: WGPUSamplerBindingType = @import("std").mem.zeroes(WGPUSamplerBindingType),
};
pub const WGPUAddressMode_Undefined: c_int = 0;
pub const WGPUAddressMode_ClampToEdge: c_int = 1;
pub const WGPUAddressMode_Repeat: c_int = 2;
pub const WGPUAddressMode_MirrorRepeat: c_int = 3;
pub const WGPUAddressMode_Force32: c_int = 2147483647;
pub const enum_WGPUAddressMode = c_uint;
pub const WGPUAddressMode = enum_WGPUAddressMode;
pub const WGPUFilterMode_Undefined: c_int = 0;
pub const WGPUFilterMode_Nearest: c_int = 1;
pub const WGPUFilterMode_Linear: c_int = 2;
pub const WGPUFilterMode_Force32: c_int = 2147483647;
pub const enum_WGPUFilterMode = c_uint;
pub const WGPUFilterMode = enum_WGPUFilterMode;
pub const WGPUMipmapFilterMode_Undefined: c_int = 0;
pub const WGPUMipmapFilterMode_Nearest: c_int = 1;
pub const WGPUMipmapFilterMode_Linear: c_int = 2;
pub const WGPUMipmapFilterMode_Force32: c_int = 2147483647;
pub const enum_WGPUMipmapFilterMode = c_uint;
pub const WGPUMipmapFilterMode = enum_WGPUMipmapFilterMode;
pub const WGPUCompareFunction_Undefined: c_int = 0;
pub const WGPUCompareFunction_Never: c_int = 1;
pub const WGPUCompareFunction_Less: c_int = 2;
pub const WGPUCompareFunction_Equal: c_int = 3;
pub const WGPUCompareFunction_LessEqual: c_int = 4;
pub const WGPUCompareFunction_Greater: c_int = 5;
pub const WGPUCompareFunction_NotEqual: c_int = 6;
pub const WGPUCompareFunction_GreaterEqual: c_int = 7;
pub const WGPUCompareFunction_Always: c_int = 8;
pub const WGPUCompareFunction_Force32: c_int = 2147483647;
pub const enum_WGPUCompareFunction = c_uint;
pub const WGPUCompareFunction = enum_WGPUCompareFunction;
pub const struct_WGPUSamplerDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    addressModeU: WGPUAddressMode = @import("std").mem.zeroes(WGPUAddressMode),
    addressModeV: WGPUAddressMode = @import("std").mem.zeroes(WGPUAddressMode),
    addressModeW: WGPUAddressMode = @import("std").mem.zeroes(WGPUAddressMode),
    magFilter: WGPUFilterMode = @import("std").mem.zeroes(WGPUFilterMode),
    minFilter: WGPUFilterMode = @import("std").mem.zeroes(WGPUFilterMode),
    mipmapFilter: WGPUMipmapFilterMode = @import("std").mem.zeroes(WGPUMipmapFilterMode),
    lodMinClamp: f32 = 0,
    lodMaxClamp: f32 = 0,
    compare: WGPUCompareFunction = @import("std").mem.zeroes(WGPUCompareFunction),
    maxAnisotropy: u16 = 0,
};
pub const struct_WGPUShaderSourceSPIRV = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    codeSize: u32 = 0,
    code: [*c]const u32 = null,
};
pub const struct_WGPUShaderSourceWGSL = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    code: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUStencilOperation_Undefined: c_int = 0;
pub const WGPUStencilOperation_Keep: c_int = 1;
pub const WGPUStencilOperation_Zero: c_int = 2;
pub const WGPUStencilOperation_Replace: c_int = 3;
pub const WGPUStencilOperation_Invert: c_int = 4;
pub const WGPUStencilOperation_IncrementClamp: c_int = 5;
pub const WGPUStencilOperation_DecrementClamp: c_int = 6;
pub const WGPUStencilOperation_IncrementWrap: c_int = 7;
pub const WGPUStencilOperation_DecrementWrap: c_int = 8;
pub const WGPUStencilOperation_Force32: c_int = 2147483647;
pub const enum_WGPUStencilOperation = c_uint;
pub const WGPUStencilOperation = enum_WGPUStencilOperation;
pub const struct_WGPUStencilFaceState = extern struct {
    compare: WGPUCompareFunction = @import("std").mem.zeroes(WGPUCompareFunction),
    failOp: WGPUStencilOperation = @import("std").mem.zeroes(WGPUStencilOperation),
    depthFailOp: WGPUStencilOperation = @import("std").mem.zeroes(WGPUStencilOperation),
    passOp: WGPUStencilOperation = @import("std").mem.zeroes(WGPUStencilOperation),
};
pub const WGPUStorageTextureAccess_BindingNotUsed: c_int = 0;
pub const WGPUStorageTextureAccess_Undefined: c_int = 1;
pub const WGPUStorageTextureAccess_WriteOnly: c_int = 2;
pub const WGPUStorageTextureAccess_ReadOnly: c_int = 3;
pub const WGPUStorageTextureAccess_ReadWrite: c_int = 4;
pub const WGPUStorageTextureAccess_Force32: c_int = 2147483647;
pub const enum_WGPUStorageTextureAccess = c_uint;
pub const WGPUStorageTextureAccess = enum_WGPUStorageTextureAccess;
pub const WGPUTextureViewDimension_Undefined: c_int = 0;
pub const WGPUTextureViewDimension_1D: c_int = 1;
pub const WGPUTextureViewDimension_2D: c_int = 2;
pub const WGPUTextureViewDimension_2DArray: c_int = 3;
pub const WGPUTextureViewDimension_Cube: c_int = 4;
pub const WGPUTextureViewDimension_CubeArray: c_int = 5;
pub const WGPUTextureViewDimension_3D: c_int = 6;
pub const WGPUTextureViewDimension_Force32: c_int = 2147483647;
pub const enum_WGPUTextureViewDimension = c_uint;
pub const WGPUTextureViewDimension = enum_WGPUTextureViewDimension;
pub const struct_WGPUStorageTextureBindingLayout = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    access: WGPUStorageTextureAccess = @import("std").mem.zeroes(WGPUStorageTextureAccess),
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    viewDimension: WGPUTextureViewDimension = @import("std").mem.zeroes(WGPUTextureViewDimension),
};
pub const WGPUFeatureName_CoreFeaturesAndLimits: c_int = 1;
pub const WGPUFeatureName_DepthClipControl: c_int = 2;
pub const WGPUFeatureName_Depth32FloatStencil8: c_int = 3;
pub const WGPUFeatureName_TextureCompressionBC: c_int = 4;
pub const WGPUFeatureName_TextureCompressionBCSliced3D: c_int = 5;
pub const WGPUFeatureName_TextureCompressionETC2: c_int = 6;
pub const WGPUFeatureName_TextureCompressionASTC: c_int = 7;
pub const WGPUFeatureName_TextureCompressionASTCSliced3D: c_int = 8;
pub const WGPUFeatureName_TimestampQuery: c_int = 9;
pub const WGPUFeatureName_IndirectFirstInstance: c_int = 10;
pub const WGPUFeatureName_ShaderF16: c_int = 11;
pub const WGPUFeatureName_RG11B10UfloatRenderable: c_int = 12;
pub const WGPUFeatureName_BGRA8UnormStorage: c_int = 13;
pub const WGPUFeatureName_Float32Filterable: c_int = 14;
pub const WGPUFeatureName_Float32Blendable: c_int = 15;
pub const WGPUFeatureName_ClipDistances: c_int = 16;
pub const WGPUFeatureName_DualSourceBlending: c_int = 17;
pub const WGPUFeatureName_Subgroups: c_int = 18;
pub const WGPUFeatureName_TextureFormatsTier1: c_int = 19;
pub const WGPUFeatureName_TextureFormatsTier2: c_int = 20;
pub const WGPUFeatureName_PrimitiveIndex: c_int = 21;
pub const WGPUFeatureName_TextureComponentSwizzle: c_int = 22;
pub const WGPUFeatureName_Force32: c_int = 2147483647;
pub const enum_WGPUFeatureName = c_uint;
pub const WGPUFeatureName = enum_WGPUFeatureName;
pub const struct_WGPUSupportedFeatures = extern struct {
    featureCount: usize = 0,
    features: [*c]const WGPUFeatureName = null,
    pub const wgpuSupportedFeaturesFreeMembers = __root.wgpuSupportedFeaturesFreeMembers;
};
pub const WGPUInstanceFeatureName_TimedWaitAny: c_int = 1;
pub const WGPUInstanceFeatureName_ShaderSourceSPIRV: c_int = 2;
pub const WGPUInstanceFeatureName_MultipleDevicesPerAdapter: c_int = 3;
pub const WGPUInstanceFeatureName_Force32: c_int = 2147483647;
pub const enum_WGPUInstanceFeatureName = c_uint;
pub const WGPUInstanceFeatureName = enum_WGPUInstanceFeatureName;
pub const struct_WGPUSupportedInstanceFeatures = extern struct {
    featureCount: usize = 0,
    features: [*c]const WGPUInstanceFeatureName = null,
    pub const wgpuGetInstanceFeatures = __root.wgpuGetInstanceFeatures;
    pub const wgpuSupportedInstanceFeaturesFreeMembers = __root.wgpuSupportedInstanceFeaturesFreeMembers;
};
pub const WGPUWGSLLanguageFeatureName_ReadonlyAndReadwriteStorageTextures: c_int = 1;
pub const WGPUWGSLLanguageFeatureName_Packed4x8IntegerDotProduct: c_int = 2;
pub const WGPUWGSLLanguageFeatureName_UnrestrictedPointerParameters: c_int = 3;
pub const WGPUWGSLLanguageFeatureName_PointerCompositeAccess: c_int = 4;
pub const WGPUWGSLLanguageFeatureName_UniformBufferStandardLayout: c_int = 5;
pub const WGPUWGSLLanguageFeatureName_SubgroupId: c_int = 6;
pub const WGPUWGSLLanguageFeatureName_TextureAndSamplerLet: c_int = 7;
pub const WGPUWGSLLanguageFeatureName_SubgroupUniformity: c_int = 8;
pub const WGPUWGSLLanguageFeatureName_TextureFormatsTier1: c_int = 9;
pub const WGPUWGSLLanguageFeatureName_Force32: c_int = 2147483647;
pub const enum_WGPUWGSLLanguageFeatureName = c_uint;
pub const WGPUWGSLLanguageFeatureName = enum_WGPUWGSLLanguageFeatureName;
pub const struct_WGPUSupportedWGSLLanguageFeatures = extern struct {
    featureCount: usize = 0,
    features: [*c]const WGPUWGSLLanguageFeatureName = null,
    pub const wgpuSupportedWGSLLanguageFeaturesFreeMembers = __root.wgpuSupportedWGSLLanguageFeaturesFreeMembers;
};
pub const WGPUTextureUsage = WGPUFlags;
pub const WGPUPresentMode_Undefined: c_int = 0;
pub const WGPUPresentMode_Fifo: c_int = 1;
pub const WGPUPresentMode_FifoRelaxed: c_int = 2;
pub const WGPUPresentMode_Immediate: c_int = 3;
pub const WGPUPresentMode_Mailbox: c_int = 4;
pub const WGPUPresentMode_Force32: c_int = 2147483647;
pub const enum_WGPUPresentMode = c_uint;
pub const WGPUPresentMode = enum_WGPUPresentMode;
pub const WGPUCompositeAlphaMode_Auto: c_int = 0;
pub const WGPUCompositeAlphaMode_Opaque: c_int = 1;
pub const WGPUCompositeAlphaMode_Premultiplied: c_int = 2;
pub const WGPUCompositeAlphaMode_Unpremultiplied: c_int = 3;
pub const WGPUCompositeAlphaMode_Inherit: c_int = 4;
pub const WGPUCompositeAlphaMode_Force32: c_int = 2147483647;
pub const enum_WGPUCompositeAlphaMode = c_uint;
pub const WGPUCompositeAlphaMode = enum_WGPUCompositeAlphaMode;
pub const struct_WGPUSurfaceCapabilities = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    usages: WGPUTextureUsage = 0,
    formatCount: usize = 0,
    formats: [*c]const WGPUTextureFormat = null,
    presentModeCount: usize = 0,
    presentModes: [*c]const WGPUPresentMode = null,
    alphaModeCount: usize = 0,
    alphaModes: [*c]const WGPUCompositeAlphaMode = null,
    pub const wgpuSurfaceCapabilitiesFreeMembers = __root.wgpuSurfaceCapabilitiesFreeMembers;
};
pub const WGPUPredefinedColorSpace_SRGB: c_int = 1;
pub const WGPUPredefinedColorSpace_DisplayP3: c_int = 2;
pub const WGPUPredefinedColorSpace_Force32: c_int = 2147483647;
pub const enum_WGPUPredefinedColorSpace = c_uint;
pub const WGPUPredefinedColorSpace = enum_WGPUPredefinedColorSpace;
pub const WGPUToneMappingMode_Standard: c_int = 1;
pub const WGPUToneMappingMode_Extended: c_int = 2;
pub const WGPUToneMappingMode_Force32: c_int = 2147483647;
pub const enum_WGPUToneMappingMode = c_uint;
pub const WGPUToneMappingMode = enum_WGPUToneMappingMode;
pub const struct_WGPUSurfaceColorManagement = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    colorSpace: WGPUPredefinedColorSpace = @import("std").mem.zeroes(WGPUPredefinedColorSpace),
    toneMappingMode: WGPUToneMappingMode = @import("std").mem.zeroes(WGPUToneMappingMode),
};
pub const struct_WGPUSurfaceConfiguration = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    device: WGPUDevice = null,
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    usage: WGPUTextureUsage = 0,
    width: u32 = 0,
    height: u32 = 0,
    viewFormatCount: usize = 0,
    viewFormats: [*c]const WGPUTextureFormat = null,
    alphaMode: WGPUCompositeAlphaMode = @import("std").mem.zeroes(WGPUCompositeAlphaMode),
    presentMode: WGPUPresentMode = @import("std").mem.zeroes(WGPUPresentMode),
};
pub const struct_WGPUSurfaceSourceAndroidNativeWindow = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    window: ?*anyopaque = null,
};
pub const struct_WGPUSurfaceSourceMetalLayer = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    layer: ?*anyopaque = null,
};
pub const struct_WGPUSurfaceSourceWaylandSurface = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    display: ?*anyopaque = null,
    surface: ?*anyopaque = null,
};
pub const struct_WGPUSurfaceSourceWindowsHWND = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    hinstance: ?*anyopaque = null,
    hwnd: ?*anyopaque = null,
};
pub const struct_WGPUSurfaceSourceXCBWindow = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    connection: ?*anyopaque = null,
    window: u32 = 0,
};
pub const struct_WGPUSurfaceSourceXlibWindow = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    display: ?*anyopaque = null,
    window: u64 = 0,
};
pub const WGPUSurfaceGetCurrentTextureStatus_SuccessOptimal: c_int = 1;
pub const WGPUSurfaceGetCurrentTextureStatus_SuccessSuboptimal: c_int = 2;
pub const WGPUSurfaceGetCurrentTextureStatus_Timeout: c_int = 3;
pub const WGPUSurfaceGetCurrentTextureStatus_Outdated: c_int = 4;
pub const WGPUSurfaceGetCurrentTextureStatus_Lost: c_int = 5;
pub const WGPUSurfaceGetCurrentTextureStatus_Error: c_int = 6;
pub const WGPUSurfaceGetCurrentTextureStatus_Force32: c_int = 2147483647;
pub const enum_WGPUSurfaceGetCurrentTextureStatus = c_uint;
pub const WGPUSurfaceGetCurrentTextureStatus = enum_WGPUSurfaceGetCurrentTextureStatus;
pub const struct_WGPUSurfaceTexture = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    texture: WGPUTexture = null,
    status: WGPUSurfaceGetCurrentTextureStatus = @import("std").mem.zeroes(WGPUSurfaceGetCurrentTextureStatus),
};
pub const struct_WGPUTexelCopyBufferLayout = extern struct {
    offset: u64 = 0,
    bytesPerRow: u32 = 0,
    rowsPerImage: u32 = 0,
};
pub const WGPUTextureSampleType_BindingNotUsed: c_int = 0;
pub const WGPUTextureSampleType_Undefined: c_int = 1;
pub const WGPUTextureSampleType_Float: c_int = 2;
pub const WGPUTextureSampleType_UnfilterableFloat: c_int = 3;
pub const WGPUTextureSampleType_Depth: c_int = 4;
pub const WGPUTextureSampleType_Sint: c_int = 5;
pub const WGPUTextureSampleType_Uint: c_int = 6;
pub const WGPUTextureSampleType_Force32: c_int = 2147483647;
pub const enum_WGPUTextureSampleType = c_uint;
pub const WGPUTextureSampleType = enum_WGPUTextureSampleType;
pub const struct_WGPUTextureBindingLayout = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    sampleType: WGPUTextureSampleType = @import("std").mem.zeroes(WGPUTextureSampleType),
    viewDimension: WGPUTextureViewDimension = @import("std").mem.zeroes(WGPUTextureViewDimension),
    multisampled: WGPUBool = 0,
};
pub const struct_WGPUTextureBindingViewDimension = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    textureBindingViewDimension: WGPUTextureViewDimension = @import("std").mem.zeroes(WGPUTextureViewDimension),
};
pub const WGPUComponentSwizzle_Undefined: c_int = 0;
pub const WGPUComponentSwizzle_Zero: c_int = 1;
pub const WGPUComponentSwizzle_One: c_int = 2;
pub const WGPUComponentSwizzle_R: c_int = 3;
pub const WGPUComponentSwizzle_G: c_int = 4;
pub const WGPUComponentSwizzle_B: c_int = 5;
pub const WGPUComponentSwizzle_A: c_int = 6;
pub const WGPUComponentSwizzle_Force32: c_int = 2147483647;
pub const enum_WGPUComponentSwizzle = c_uint;
pub const WGPUComponentSwizzle = enum_WGPUComponentSwizzle;
pub const struct_WGPUTextureComponentSwizzle = extern struct {
    r: WGPUComponentSwizzle = @import("std").mem.zeroes(WGPUComponentSwizzle),
    g: WGPUComponentSwizzle = @import("std").mem.zeroes(WGPUComponentSwizzle),
    b: WGPUComponentSwizzle = @import("std").mem.zeroes(WGPUComponentSwizzle),
    a: WGPUComponentSwizzle = @import("std").mem.zeroes(WGPUComponentSwizzle),
};
pub const WGPUVertexFormat_Uint8: c_int = 1;
pub const WGPUVertexFormat_Uint8x2: c_int = 2;
pub const WGPUVertexFormat_Uint8x4: c_int = 3;
pub const WGPUVertexFormat_Sint8: c_int = 4;
pub const WGPUVertexFormat_Sint8x2: c_int = 5;
pub const WGPUVertexFormat_Sint8x4: c_int = 6;
pub const WGPUVertexFormat_Unorm8: c_int = 7;
pub const WGPUVertexFormat_Unorm8x2: c_int = 8;
pub const WGPUVertexFormat_Unorm8x4: c_int = 9;
pub const WGPUVertexFormat_Snorm8: c_int = 10;
pub const WGPUVertexFormat_Snorm8x2: c_int = 11;
pub const WGPUVertexFormat_Snorm8x4: c_int = 12;
pub const WGPUVertexFormat_Uint16: c_int = 13;
pub const WGPUVertexFormat_Uint16x2: c_int = 14;
pub const WGPUVertexFormat_Uint16x4: c_int = 15;
pub const WGPUVertexFormat_Sint16: c_int = 16;
pub const WGPUVertexFormat_Sint16x2: c_int = 17;
pub const WGPUVertexFormat_Sint16x4: c_int = 18;
pub const WGPUVertexFormat_Unorm16: c_int = 19;
pub const WGPUVertexFormat_Unorm16x2: c_int = 20;
pub const WGPUVertexFormat_Unorm16x4: c_int = 21;
pub const WGPUVertexFormat_Snorm16: c_int = 22;
pub const WGPUVertexFormat_Snorm16x2: c_int = 23;
pub const WGPUVertexFormat_Snorm16x4: c_int = 24;
pub const WGPUVertexFormat_Float16: c_int = 25;
pub const WGPUVertexFormat_Float16x2: c_int = 26;
pub const WGPUVertexFormat_Float16x4: c_int = 27;
pub const WGPUVertexFormat_Float32: c_int = 28;
pub const WGPUVertexFormat_Float32x2: c_int = 29;
pub const WGPUVertexFormat_Float32x3: c_int = 30;
pub const WGPUVertexFormat_Float32x4: c_int = 31;
pub const WGPUVertexFormat_Uint32: c_int = 32;
pub const WGPUVertexFormat_Uint32x2: c_int = 33;
pub const WGPUVertexFormat_Uint32x3: c_int = 34;
pub const WGPUVertexFormat_Uint32x4: c_int = 35;
pub const WGPUVertexFormat_Sint32: c_int = 36;
pub const WGPUVertexFormat_Sint32x2: c_int = 37;
pub const WGPUVertexFormat_Sint32x3: c_int = 38;
pub const WGPUVertexFormat_Sint32x4: c_int = 39;
pub const WGPUVertexFormat_Unorm10_10_10_2: c_int = 40;
pub const WGPUVertexFormat_Unorm8x4BGRA: c_int = 41;
pub const WGPUVertexFormat_Force32: c_int = 2147483647;
pub const enum_WGPUVertexFormat = c_uint;
pub const WGPUVertexFormat = enum_WGPUVertexFormat;
pub const struct_WGPUVertexAttribute = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    format: WGPUVertexFormat = @import("std").mem.zeroes(WGPUVertexFormat),
    offset: u64 = 0,
    shaderLocation: u32 = 0,
};
pub const struct_WGPUBindGroupEntry = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    binding: u32 = 0,
    buffer: WGPUBuffer = null,
    offset: u64 = 0,
    size: u64 = 0,
    sampler: WGPUSampler = null,
    textureView: WGPUTextureView = null,
};
pub const WGPUShaderStage = WGPUFlags;
pub const WGPUBufferBindingLayout = struct_WGPUBufferBindingLayout;
pub const WGPUSamplerBindingLayout = struct_WGPUSamplerBindingLayout;
pub const WGPUTextureBindingLayout = struct_WGPUTextureBindingLayout;
pub const WGPUStorageTextureBindingLayout = struct_WGPUStorageTextureBindingLayout;
pub const struct_WGPUBindGroupLayoutEntry = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    binding: u32 = 0,
    visibility: WGPUShaderStage = 0,
    bindingArraySize: u32 = 0,
    buffer: WGPUBufferBindingLayout = @import("std").mem.zeroes(WGPUBufferBindingLayout),
    sampler: WGPUSamplerBindingLayout = @import("std").mem.zeroes(WGPUSamplerBindingLayout),
    texture: WGPUTextureBindingLayout = @import("std").mem.zeroes(WGPUTextureBindingLayout),
    storageTexture: WGPUStorageTextureBindingLayout = @import("std").mem.zeroes(WGPUStorageTextureBindingLayout),
};
pub const WGPUBlendComponent = struct_WGPUBlendComponent;
pub const struct_WGPUBlendState = extern struct {
    color: WGPUBlendComponent = @import("std").mem.zeroes(WGPUBlendComponent),
    alpha: WGPUBlendComponent = @import("std").mem.zeroes(WGPUBlendComponent),
};
pub const WGPUCompilationMessage = struct_WGPUCompilationMessage;
pub const struct_WGPUCompilationInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    messageCount: usize = 0,
    messages: [*c]const WGPUCompilationMessage = null,
};
pub const WGPUPassTimestampWrites = struct_WGPUPassTimestampWrites;
pub const struct_WGPUComputePassDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    timestampWrites: [*c]const WGPUPassTimestampWrites = null,
};
pub const WGPUConstantEntry = struct_WGPUConstantEntry;
pub const struct_WGPUComputeState = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    module: WGPUShaderModule = null,
    entryPoint: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    constantCount: usize = 0,
    constants: [*c]const WGPUConstantEntry = null,
};
pub const WGPUOptionalBool_False: c_int = 0;
pub const WGPUOptionalBool_True: c_int = 1;
pub const WGPUOptionalBool_Undefined: c_int = 2;
pub const WGPUOptionalBool_Force32: c_int = 2147483647;
pub const enum_WGPUOptionalBool = c_uint;
pub const WGPUOptionalBool = enum_WGPUOptionalBool;
pub const WGPUStencilFaceState = struct_WGPUStencilFaceState;
pub const struct_WGPUDepthStencilState = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    depthWriteEnabled: WGPUOptionalBool = @import("std").mem.zeroes(WGPUOptionalBool),
    depthCompare: WGPUCompareFunction = @import("std").mem.zeroes(WGPUCompareFunction),
    stencilFront: WGPUStencilFaceState = @import("std").mem.zeroes(WGPUStencilFaceState),
    stencilBack: WGPUStencilFaceState = @import("std").mem.zeroes(WGPUStencilFaceState),
    stencilReadMask: u32 = 0,
    stencilWriteMask: u32 = 0,
    depthBias: i32 = 0,
    depthBiasSlopeScale: f32 = 0,
    depthBiasClamp: f32 = 0,
};
pub const WGPUFuture = struct_WGPUFuture;
pub const struct_WGPUFutureWaitInfo = extern struct {
    future: WGPUFuture = @import("std").mem.zeroes(WGPUFuture),
    completed: WGPUBool = 0,
};
pub const WGPUInstanceLimits = struct_WGPUInstanceLimits;
pub const struct_WGPUInstanceDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    requiredFeatureCount: usize = 0,
    requiredFeatures: [*c]const WGPUInstanceFeatureName = null,
    requiredLimits: [*c]const WGPUInstanceLimits = null,
    pub const wgpuCreateInstance = __root.wgpuCreateInstance;
};
pub const struct_WGPULimits = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    maxTextureDimension1D: u32 = 0,
    maxTextureDimension2D: u32 = 0,
    maxTextureDimension3D: u32 = 0,
    maxTextureArrayLayers: u32 = 0,
    maxBindGroups: u32 = 0,
    maxBindGroupsPlusVertexBuffers: u32 = 0,
    maxBindingsPerBindGroup: u32 = 0,
    maxDynamicUniformBuffersPerPipelineLayout: u32 = 0,
    maxDynamicStorageBuffersPerPipelineLayout: u32 = 0,
    maxSampledTexturesPerShaderStage: u32 = 0,
    maxSamplersPerShaderStage: u32 = 0,
    maxStorageBuffersPerShaderStage: u32 = 0,
    maxStorageTexturesPerShaderStage: u32 = 0,
    maxUniformBuffersPerShaderStage: u32 = 0,
    maxUniformBufferBindingSize: u64 = 0,
    maxStorageBufferBindingSize: u64 = 0,
    minUniformBufferOffsetAlignment: u32 = 0,
    minStorageBufferOffsetAlignment: u32 = 0,
    maxVertexBuffers: u32 = 0,
    maxBufferSize: u64 = 0,
    maxVertexAttributes: u32 = 0,
    maxVertexBufferArrayStride: u32 = 0,
    maxInterStageShaderVariables: u32 = 0,
    maxColorAttachments: u32 = 0,
    maxColorAttachmentBytesPerSample: u32 = 0,
    maxComputeWorkgroupStorageSize: u32 = 0,
    maxComputeInvocationsPerWorkgroup: u32 = 0,
    maxComputeWorkgroupSizeX: u32 = 0,
    maxComputeWorkgroupSizeY: u32 = 0,
    maxComputeWorkgroupSizeZ: u32 = 0,
    maxComputeWorkgroupsPerDimension: u32 = 0,
    maxImmediateSize: u32 = 0,
};
pub const WGPUColor = struct_WGPUColor;
pub const struct_WGPURenderPassColorAttachment = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    view: WGPUTextureView = null,
    depthSlice: u32 = 0,
    resolveTarget: WGPUTextureView = null,
    loadOp: WGPULoadOp = @import("std").mem.zeroes(WGPULoadOp),
    storeOp: WGPUStoreOp = @import("std").mem.zeroes(WGPUStoreOp),
    clearValue: WGPUColor = @import("std").mem.zeroes(WGPUColor),
};
pub const WGPUFeatureLevel_Undefined: c_int = 0;
pub const WGPUFeatureLevel_Compatibility: c_int = 1;
pub const WGPUFeatureLevel_Core: c_int = 2;
pub const WGPUFeatureLevel_Force32: c_int = 2147483647;
pub const enum_WGPUFeatureLevel = c_uint;
pub const WGPUFeatureLevel = enum_WGPUFeatureLevel;
pub const WGPUPowerPreference_Undefined: c_int = 0;
pub const WGPUPowerPreference_LowPower: c_int = 1;
pub const WGPUPowerPreference_HighPerformance: c_int = 2;
pub const WGPUPowerPreference_Force32: c_int = 2147483647;
pub const enum_WGPUPowerPreference = c_uint;
pub const WGPUPowerPreference = enum_WGPUPowerPreference;
pub const struct_WGPURequestAdapterOptions = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    featureLevel: WGPUFeatureLevel = @import("std").mem.zeroes(WGPUFeatureLevel),
    powerPreference: WGPUPowerPreference = @import("std").mem.zeroes(WGPUPowerPreference),
    forceFallbackAdapter: WGPUBool = 0,
    backendType: WGPUBackendType = @import("std").mem.zeroes(WGPUBackendType),
    compatibleSurface: WGPUSurface = null,
};
pub const struct_WGPUShaderModuleDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const struct_WGPUSurfaceDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUTexelCopyBufferLayout = struct_WGPUTexelCopyBufferLayout;
pub const struct_WGPUTexelCopyBufferInfo = extern struct {
    layout: WGPUTexelCopyBufferLayout = @import("std").mem.zeroes(WGPUTexelCopyBufferLayout),
    buffer: WGPUBuffer = null,
};
pub const WGPUOrigin3D = struct_WGPUOrigin3D;
pub const WGPUTextureAspect_Undefined: c_int = 0;
pub const WGPUTextureAspect_All: c_int = 1;
pub const WGPUTextureAspect_StencilOnly: c_int = 2;
pub const WGPUTextureAspect_DepthOnly: c_int = 3;
pub const WGPUTextureAspect_Force32: c_int = 2147483647;
pub const enum_WGPUTextureAspect = c_uint;
pub const WGPUTextureAspect = enum_WGPUTextureAspect;
pub const struct_WGPUTexelCopyTextureInfo = extern struct {
    texture: WGPUTexture = null,
    mipLevel: u32 = 0,
    origin: WGPUOrigin3D = @import("std").mem.zeroes(WGPUOrigin3D),
    aspect: WGPUTextureAspect = @import("std").mem.zeroes(WGPUTextureAspect),
};
pub const WGPUTextureComponentSwizzle = struct_WGPUTextureComponentSwizzle;
pub const struct_WGPUTextureComponentSwizzleDescriptor = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    swizzle: WGPUTextureComponentSwizzle = @import("std").mem.zeroes(WGPUTextureComponentSwizzle),
};
pub const WGPUTextureDimension_Undefined: c_int = 0;
pub const WGPUTextureDimension_1D: c_int = 1;
pub const WGPUTextureDimension_2D: c_int = 2;
pub const WGPUTextureDimension_3D: c_int = 3;
pub const WGPUTextureDimension_Force32: c_int = 2147483647;
pub const enum_WGPUTextureDimension = c_uint;
pub const WGPUTextureDimension = enum_WGPUTextureDimension;
pub const WGPUExtent3D = struct_WGPUExtent3D;
pub const struct_WGPUTextureDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    usage: WGPUTextureUsage = 0,
    dimension: WGPUTextureDimension = @import("std").mem.zeroes(WGPUTextureDimension),
    size: WGPUExtent3D = @import("std").mem.zeroes(WGPUExtent3D),
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    mipLevelCount: u32 = 0,
    sampleCount: u32 = 0,
    viewFormatCount: usize = 0,
    viewFormats: [*c]const WGPUTextureFormat = null,
};
pub const WGPUVertexStepMode_Undefined: c_int = 0;
pub const WGPUVertexStepMode_Vertex: c_int = 1;
pub const WGPUVertexStepMode_Instance: c_int = 2;
pub const WGPUVertexStepMode_Force32: c_int = 2147483647;
pub const enum_WGPUVertexStepMode = c_uint;
pub const WGPUVertexStepMode = enum_WGPUVertexStepMode;
pub const WGPUVertexAttribute = struct_WGPUVertexAttribute;
pub const struct_WGPUVertexBufferLayout = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    stepMode: WGPUVertexStepMode = @import("std").mem.zeroes(WGPUVertexStepMode),
    arrayStride: u64 = 0,
    attributeCount: usize = 0,
    attributes: [*c]const WGPUVertexAttribute = null,
};
pub const WGPUBindGroupEntry = struct_WGPUBindGroupEntry;
pub const struct_WGPUBindGroupDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    layout: WGPUBindGroupLayout = null,
    entryCount: usize = 0,
    entries: [*c]const WGPUBindGroupEntry = null,
};
pub const WGPUBindGroupLayoutEntry = struct_WGPUBindGroupLayoutEntry;
pub const struct_WGPUBindGroupLayoutDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    entryCount: usize = 0,
    entries: [*c]const WGPUBindGroupLayoutEntry = null,
};
pub const WGPUBlendState = struct_WGPUBlendState;
pub const WGPUColorWriteMask = WGPUFlags;
pub const struct_WGPUColorTargetState = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    blend: [*c]const WGPUBlendState = null,
    writeMask: WGPUColorWriteMask = 0,
};
pub const WGPUComputeState = struct_WGPUComputeState;
pub const struct_WGPUComputePipelineDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    layout: WGPUPipelineLayout = null,
    compute: WGPUComputeState = @import("std").mem.zeroes(WGPUComputeState),
};
pub const WGPULimits = struct_WGPULimits;
pub const WGPUQueueDescriptor = struct_WGPUQueueDescriptor;
pub const WGPUCallbackMode_WaitAnyOnly: c_int = 1;
pub const WGPUCallbackMode_AllowProcessEvents: c_int = 2;
pub const WGPUCallbackMode_AllowSpontaneous: c_int = 3;
pub const WGPUCallbackMode_Force32: c_int = 2147483647;
pub const enum_WGPUCallbackMode = c_uint;
pub const WGPUCallbackMode = enum_WGPUCallbackMode;
pub const WGPUDeviceLostReason_Unknown: c_int = 1;
pub const WGPUDeviceLostReason_Destroyed: c_int = 2;
pub const WGPUDeviceLostReason_CallbackCancelled: c_int = 3;
pub const WGPUDeviceLostReason_FailedCreation: c_int = 4;
pub const WGPUDeviceLostReason_Force32: c_int = 2147483647;
pub const enum_WGPUDeviceLostReason = c_uint;
pub const WGPUDeviceLostReason = enum_WGPUDeviceLostReason;
pub const WGPUDeviceLostCallback = ?*const fn (device: [*c]const WGPUDevice, reason: WGPUDeviceLostReason, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPUDeviceLostCallbackInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUDeviceLostCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUDeviceLostCallbackInfo = struct_WGPUDeviceLostCallbackInfo;
pub const WGPUErrorType_NoError: c_int = 1;
pub const WGPUErrorType_Validation: c_int = 2;
pub const WGPUErrorType_OutOfMemory: c_int = 3;
pub const WGPUErrorType_Internal: c_int = 4;
pub const WGPUErrorType_Unknown: c_int = 5;
pub const WGPUErrorType_Force32: c_int = 2147483647;
pub const enum_WGPUErrorType = c_uint;
pub const WGPUErrorType = enum_WGPUErrorType;
pub const WGPUUncapturedErrorCallback = ?*const fn (device: [*c]const WGPUDevice, @"type": WGPUErrorType, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPUUncapturedErrorCallbackInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    callback: WGPUUncapturedErrorCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUUncapturedErrorCallbackInfo = struct_WGPUUncapturedErrorCallbackInfo;
pub const struct_WGPUDeviceDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    requiredFeatureCount: usize = 0,
    requiredFeatures: [*c]const WGPUFeatureName = null,
    requiredLimits: [*c]const WGPULimits = null,
    defaultQueue: WGPUQueueDescriptor = @import("std").mem.zeroes(WGPUQueueDescriptor),
    deviceLostCallbackInfo: WGPUDeviceLostCallbackInfo = @import("std").mem.zeroes(WGPUDeviceLostCallbackInfo),
    uncapturedErrorCallbackInfo: WGPUUncapturedErrorCallbackInfo = @import("std").mem.zeroes(WGPUUncapturedErrorCallbackInfo),
};
pub const WGPURenderPassColorAttachment = struct_WGPURenderPassColorAttachment;
pub const WGPURenderPassDepthStencilAttachment = struct_WGPURenderPassDepthStencilAttachment;
pub const struct_WGPURenderPassDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    colorAttachmentCount: usize = 0,
    colorAttachments: [*c]const WGPURenderPassColorAttachment = null,
    depthStencilAttachment: [*c]const WGPURenderPassDepthStencilAttachment = null,
    occlusionQuerySet: WGPUQuerySet = null,
    timestampWrites: [*c]const WGPUPassTimestampWrites = null,
};
pub const struct_WGPUTextureViewDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    format: WGPUTextureFormat = @import("std").mem.zeroes(WGPUTextureFormat),
    dimension: WGPUTextureViewDimension = @import("std").mem.zeroes(WGPUTextureViewDimension),
    baseMipLevel: u32 = 0,
    mipLevelCount: u32 = 0,
    baseArrayLayer: u32 = 0,
    arrayLayerCount: u32 = 0,
    aspect: WGPUTextureAspect = @import("std").mem.zeroes(WGPUTextureAspect),
    usage: WGPUTextureUsage = 0,
};
pub const WGPUVertexBufferLayout = struct_WGPUVertexBufferLayout;
pub const struct_WGPUVertexState = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    module: WGPUShaderModule = null,
    entryPoint: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    constantCount: usize = 0,
    constants: [*c]const WGPUConstantEntry = null,
    bufferCount: usize = 0,
    buffers: [*c]const WGPUVertexBufferLayout = null,
};
pub const WGPUColorTargetState = struct_WGPUColorTargetState;
pub const struct_WGPUFragmentState = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    module: WGPUShaderModule = null,
    entryPoint: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    constantCount: usize = 0,
    constants: [*c]const WGPUConstantEntry = null,
    targetCount: usize = 0,
    targets: [*c]const WGPUColorTargetState = null,
};
pub const WGPUVertexState = struct_WGPUVertexState;
pub const WGPUPrimitiveState = struct_WGPUPrimitiveState;
pub const WGPUDepthStencilState = struct_WGPUDepthStencilState;
pub const WGPUMultisampleState = struct_WGPUMultisampleState;
pub const WGPUFragmentState = struct_WGPUFragmentState;
pub const struct_WGPURenderPipelineDescriptor = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    layout: WGPUPipelineLayout = null,
    vertex: WGPUVertexState = @import("std").mem.zeroes(WGPUVertexState),
    primitive: WGPUPrimitiveState = @import("std").mem.zeroes(WGPUPrimitiveState),
    depthStencil: [*c]const WGPUDepthStencilState = null,
    multisample: WGPUMultisampleState = @import("std").mem.zeroes(WGPUMultisampleState),
    fragment: [*c]const WGPUFragmentState = null,
};
pub const WGPUMapAsyncStatus_Success: c_int = 1;
pub const WGPUMapAsyncStatus_CallbackCancelled: c_int = 2;
pub const WGPUMapAsyncStatus_Error: c_int = 3;
pub const WGPUMapAsyncStatus_Aborted: c_int = 4;
pub const WGPUMapAsyncStatus_Force32: c_int = 2147483647;
pub const enum_WGPUMapAsyncStatus = c_uint;
pub const WGPUMapAsyncStatus = enum_WGPUMapAsyncStatus;
pub const WGPUBufferMapCallback = ?*const fn (status: WGPUMapAsyncStatus, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPUBufferMapCallbackInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUBufferMapCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUCompilationInfoRequestStatus_Success: c_int = 1;
pub const WGPUCompilationInfoRequestStatus_CallbackCancelled: c_int = 2;
pub const WGPUCompilationInfoRequestStatus_Force32: c_int = 2147483647;
pub const enum_WGPUCompilationInfoRequestStatus = c_uint;
pub const WGPUCompilationInfoRequestStatus = enum_WGPUCompilationInfoRequestStatus;
pub const WGPUCompilationInfoCallback = ?*const fn (status: WGPUCompilationInfoRequestStatus, compilationInfo: [*c]const struct_WGPUCompilationInfo, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPUCompilationInfoCallbackInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUCompilationInfoCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUCreatePipelineAsyncStatus_Success: c_int = 1;
pub const WGPUCreatePipelineAsyncStatus_CallbackCancelled: c_int = 2;
pub const WGPUCreatePipelineAsyncStatus_ValidationError: c_int = 3;
pub const WGPUCreatePipelineAsyncStatus_InternalError: c_int = 4;
pub const WGPUCreatePipelineAsyncStatus_Force32: c_int = 2147483647;
pub const enum_WGPUCreatePipelineAsyncStatus = c_uint;
pub const WGPUCreatePipelineAsyncStatus = enum_WGPUCreatePipelineAsyncStatus;
pub const WGPUCreateComputePipelineAsyncCallback = ?*const fn (status: WGPUCreatePipelineAsyncStatus, pipeline: WGPUComputePipeline, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPUCreateComputePipelineAsyncCallbackInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUCreateComputePipelineAsyncCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUCreateRenderPipelineAsyncCallback = ?*const fn (status: WGPUCreatePipelineAsyncStatus, pipeline: WGPURenderPipeline, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPUCreateRenderPipelineAsyncCallbackInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUCreateRenderPipelineAsyncCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUPopErrorScopeStatus_Success: c_int = 1;
pub const WGPUPopErrorScopeStatus_CallbackCancelled: c_int = 2;
pub const WGPUPopErrorScopeStatus_Error: c_int = 3;
pub const WGPUPopErrorScopeStatus_Force32: c_int = 2147483647;
pub const enum_WGPUPopErrorScopeStatus = c_uint;
pub const WGPUPopErrorScopeStatus = enum_WGPUPopErrorScopeStatus;
pub const WGPUPopErrorScopeCallback = ?*const fn (status: WGPUPopErrorScopeStatus, @"type": WGPUErrorType, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPUPopErrorScopeCallbackInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUPopErrorScopeCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUQueueWorkDoneStatus_Success: c_int = 1;
pub const WGPUQueueWorkDoneStatus_CallbackCancelled: c_int = 2;
pub const WGPUQueueWorkDoneStatus_Error: c_int = 3;
pub const WGPUQueueWorkDoneStatus_Force32: c_int = 2147483647;
pub const enum_WGPUQueueWorkDoneStatus = c_uint;
pub const WGPUQueueWorkDoneStatus = enum_WGPUQueueWorkDoneStatus;
pub const WGPUQueueWorkDoneCallback = ?*const fn (status: WGPUQueueWorkDoneStatus, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPUQueueWorkDoneCallbackInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPUQueueWorkDoneCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPURequestAdapterStatus_Success: c_int = 1;
pub const WGPURequestAdapterStatus_CallbackCancelled: c_int = 2;
pub const WGPURequestAdapterStatus_Unavailable: c_int = 3;
pub const WGPURequestAdapterStatus_Error: c_int = 4;
pub const WGPURequestAdapterStatus_Force32: c_int = 2147483647;
pub const enum_WGPURequestAdapterStatus = c_uint;
pub const WGPURequestAdapterStatus = enum_WGPURequestAdapterStatus;
pub const WGPURequestAdapterCallback = ?*const fn (status: WGPURequestAdapterStatus, adapter: WGPUAdapter, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPURequestAdapterCallbackInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPURequestAdapterCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPURequestDeviceStatus_Success: c_int = 1;
pub const WGPURequestDeviceStatus_CallbackCancelled: c_int = 2;
pub const WGPURequestDeviceStatus_Error: c_int = 3;
pub const WGPURequestDeviceStatus_Force32: c_int = 2147483647;
pub const enum_WGPURequestDeviceStatus = c_uint;
pub const WGPURequestDeviceStatus = enum_WGPURequestDeviceStatus;
pub const WGPURequestDeviceCallback = ?*const fn (status: WGPURequestDeviceStatus, device: WGPUDevice, message: WGPUStringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const struct_WGPURequestDeviceCallbackInfo = extern struct {
    nextInChain: [*c]WGPUChainedStruct = null,
    mode: WGPUCallbackMode = @import("std").mem.zeroes(WGPUCallbackMode),
    callback: WGPURequestDeviceCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};
pub const WGPUBufferMapState_Unmapped: c_int = 1;
pub const WGPUBufferMapState_Pending: c_int = 2;
pub const WGPUBufferMapState_Mapped: c_int = 3;
pub const WGPUBufferMapState_Force32: c_int = 2147483647;
pub const enum_WGPUBufferMapState = c_uint;
pub const WGPUBufferMapState = enum_WGPUBufferMapState;
pub const WGPUErrorFilter_Validation: c_int = 1;
pub const WGPUErrorFilter_OutOfMemory: c_int = 2;
pub const WGPUErrorFilter_Internal: c_int = 3;
pub const WGPUErrorFilter_Force32: c_int = 2147483647;
pub const enum_WGPUErrorFilter = c_uint;
pub const WGPUErrorFilter = enum_WGPUErrorFilter;
pub const WGPUStatus_Success: c_int = 1;
pub const WGPUStatus_Error: c_int = 2;
pub const WGPUStatus_Force32: c_int = 2147483647;
pub const enum_WGPUStatus = c_uint;
pub const WGPUStatus = enum_WGPUStatus;
pub const WGPUWaitStatus_Success: c_int = 1;
pub const WGPUWaitStatus_TimedOut: c_int = 2;
pub const WGPUWaitStatus_Error: c_int = 3;
pub const WGPUWaitStatus_Force32: c_int = 2147483647;
pub const enum_WGPUWaitStatus = c_uint;
pub const WGPUWaitStatus = enum_WGPUWaitStatus;
pub const WGPUBufferUsage_None: WGPUBufferUsage = 0;
pub const WGPUBufferUsage_MapRead: WGPUBufferUsage = 1;
pub const WGPUBufferUsage_MapWrite: WGPUBufferUsage = 2;
pub const WGPUBufferUsage_CopySrc: WGPUBufferUsage = 4;
pub const WGPUBufferUsage_CopyDst: WGPUBufferUsage = 8;
pub const WGPUBufferUsage_Index: WGPUBufferUsage = 16;
pub const WGPUBufferUsage_Vertex: WGPUBufferUsage = 32;
pub const WGPUBufferUsage_Uniform: WGPUBufferUsage = 64;
pub const WGPUBufferUsage_Storage: WGPUBufferUsage = 128;
pub const WGPUBufferUsage_Indirect: WGPUBufferUsage = 256;
pub const WGPUBufferUsage_QueryResolve: WGPUBufferUsage = 512;
pub const WGPUColorWriteMask_None: WGPUColorWriteMask = 0;
pub const WGPUColorWriteMask_Red: WGPUColorWriteMask = 1;
pub const WGPUColorWriteMask_Green: WGPUColorWriteMask = 2;
pub const WGPUColorWriteMask_Blue: WGPUColorWriteMask = 4;
pub const WGPUColorWriteMask_Alpha: WGPUColorWriteMask = 8;
pub const WGPUColorWriteMask_All: WGPUColorWriteMask = 15;
pub const WGPUMapMode = WGPUFlags;
pub const WGPUMapMode_None: WGPUMapMode = 0;
pub const WGPUMapMode_Read: WGPUMapMode = 1;
pub const WGPUMapMode_Write: WGPUMapMode = 2;
pub const WGPUShaderStage_None: WGPUShaderStage = 0;
pub const WGPUShaderStage_Vertex: WGPUShaderStage = 1;
pub const WGPUShaderStage_Fragment: WGPUShaderStage = 2;
pub const WGPUShaderStage_Compute: WGPUShaderStage = 4;
pub const WGPUTextureUsage_None: WGPUTextureUsage = 0;
pub const WGPUTextureUsage_CopySrc: WGPUTextureUsage = 1;
pub const WGPUTextureUsage_CopyDst: WGPUTextureUsage = 2;
pub const WGPUTextureUsage_TextureBinding: WGPUTextureUsage = 4;
pub const WGPUTextureUsage_StorageBinding: WGPUTextureUsage = 8;
pub const WGPUTextureUsage_RenderAttachment: WGPUTextureUsage = 16;
pub const WGPUTextureUsage_TransientAttachment: WGPUTextureUsage = 32;
pub const WGPUProc = ?*const fn () callconv(.c) void;
pub const WGPUBufferMapCallbackInfo = struct_WGPUBufferMapCallbackInfo;
pub const WGPUCompilationInfoCallbackInfo = struct_WGPUCompilationInfoCallbackInfo;
pub const WGPUCreateComputePipelineAsyncCallbackInfo = struct_WGPUCreateComputePipelineAsyncCallbackInfo;
pub const WGPUCreateRenderPipelineAsyncCallbackInfo = struct_WGPUCreateRenderPipelineAsyncCallbackInfo;
pub const WGPUPopErrorScopeCallbackInfo = struct_WGPUPopErrorScopeCallbackInfo;
pub const WGPUQueueWorkDoneCallbackInfo = struct_WGPUQueueWorkDoneCallbackInfo;
pub const WGPURequestAdapterCallbackInfo = struct_WGPURequestAdapterCallbackInfo;
pub const WGPURequestDeviceCallbackInfo = struct_WGPURequestDeviceCallbackInfo;
pub const WGPUAdapterInfo = struct_WGPUAdapterInfo;
pub const WGPUBufferDescriptor = struct_WGPUBufferDescriptor;
pub const WGPUCommandBufferDescriptor = struct_WGPUCommandBufferDescriptor;
pub const WGPUCommandEncoderDescriptor = struct_WGPUCommandEncoderDescriptor;
pub const WGPUCompatibilityModeLimits = struct_WGPUCompatibilityModeLimits;
pub const WGPUExternalTextureBindingEntry = struct_WGPUExternalTextureBindingEntry;
pub const WGPUExternalTextureBindingLayout = struct_WGPUExternalTextureBindingLayout;
pub const WGPUPipelineLayoutDescriptor = struct_WGPUPipelineLayoutDescriptor;
pub const WGPUQuerySetDescriptor = struct_WGPUQuerySetDescriptor;
pub const WGPURenderBundleDescriptor = struct_WGPURenderBundleDescriptor;
pub const WGPURenderBundleEncoderDescriptor = struct_WGPURenderBundleEncoderDescriptor;
pub const WGPURenderPassMaxDrawCount = struct_WGPURenderPassMaxDrawCount;
pub const WGPURequestAdapterWebXROptions = struct_WGPURequestAdapterWebXROptions;
pub const WGPUSamplerDescriptor = struct_WGPUSamplerDescriptor;
pub const WGPUShaderSourceSPIRV = struct_WGPUShaderSourceSPIRV;
pub const WGPUShaderSourceWGSL = struct_WGPUShaderSourceWGSL;
pub const WGPUSupportedFeatures = struct_WGPUSupportedFeatures;
pub const WGPUSupportedInstanceFeatures = struct_WGPUSupportedInstanceFeatures;
pub const WGPUSupportedWGSLLanguageFeatures = struct_WGPUSupportedWGSLLanguageFeatures;
pub const WGPUSurfaceCapabilities = struct_WGPUSurfaceCapabilities;
pub const WGPUSurfaceColorManagement = struct_WGPUSurfaceColorManagement;
pub const WGPUSurfaceConfiguration = struct_WGPUSurfaceConfiguration;
pub const WGPUSurfaceSourceAndroidNativeWindow = struct_WGPUSurfaceSourceAndroidNativeWindow;
pub const WGPUSurfaceSourceMetalLayer = struct_WGPUSurfaceSourceMetalLayer;
pub const WGPUSurfaceSourceWaylandSurface = struct_WGPUSurfaceSourceWaylandSurface;
pub const WGPUSurfaceSourceWindowsHWND = struct_WGPUSurfaceSourceWindowsHWND;
pub const WGPUSurfaceSourceXCBWindow = struct_WGPUSurfaceSourceXCBWindow;
pub const WGPUSurfaceSourceXlibWindow = struct_WGPUSurfaceSourceXlibWindow;
pub const WGPUSurfaceTexture = struct_WGPUSurfaceTexture;
pub const WGPUTextureBindingViewDimension = struct_WGPUTextureBindingViewDimension;
pub const WGPUCompilationInfo = struct_WGPUCompilationInfo;
pub const WGPUComputePassDescriptor = struct_WGPUComputePassDescriptor;
pub const WGPUFutureWaitInfo = struct_WGPUFutureWaitInfo;
pub const WGPUInstanceDescriptor = struct_WGPUInstanceDescriptor;
pub const WGPURequestAdapterOptions = struct_WGPURequestAdapterOptions;
pub const WGPUShaderModuleDescriptor = struct_WGPUShaderModuleDescriptor;
pub const WGPUSurfaceDescriptor = struct_WGPUSurfaceDescriptor;
pub const WGPUTexelCopyBufferInfo = struct_WGPUTexelCopyBufferInfo;
pub const WGPUTexelCopyTextureInfo = struct_WGPUTexelCopyTextureInfo;
pub const WGPUTextureComponentSwizzleDescriptor = struct_WGPUTextureComponentSwizzleDescriptor;
pub const WGPUTextureDescriptor = struct_WGPUTextureDescriptor;
pub const WGPUBindGroupDescriptor = struct_WGPUBindGroupDescriptor;
pub const WGPUBindGroupLayoutDescriptor = struct_WGPUBindGroupLayoutDescriptor;
pub const WGPUComputePipelineDescriptor = struct_WGPUComputePipelineDescriptor;
pub const WGPUDeviceDescriptor = struct_WGPUDeviceDescriptor;
pub const WGPURenderPassDescriptor = struct_WGPURenderPassDescriptor;
pub const WGPUTextureViewDescriptor = struct_WGPUTextureViewDescriptor;
pub const WGPURenderPipelineDescriptor = struct_WGPURenderPipelineDescriptor;
pub const WGPUProcCreateInstance = ?*const fn (descriptor: [*c]const WGPUInstanceDescriptor) callconv(.c) WGPUInstance;
pub const WGPUProcGetInstanceFeatures = ?*const fn (features: [*c]WGPUSupportedInstanceFeatures) callconv(.c) void;
pub const WGPUProcGetInstanceLimits = ?*const fn (limits: [*c]WGPUInstanceLimits) callconv(.c) WGPUStatus;
pub const WGPUProcHasInstanceFeature = ?*const fn (feature: WGPUInstanceFeatureName) callconv(.c) WGPUBool;
pub const WGPUProcGetProcAddress = ?*const fn (procName: WGPUStringView) callconv(.c) WGPUProc;
pub const WGPUProcAdapterGetFeatures = ?*const fn (adapter: WGPUAdapter, features: [*c]WGPUSupportedFeatures) callconv(.c) void;
pub const WGPUProcAdapterGetInfo = ?*const fn (adapter: WGPUAdapter, info: [*c]WGPUAdapterInfo) callconv(.c) WGPUStatus;
pub const WGPUProcAdapterGetLimits = ?*const fn (adapter: WGPUAdapter, limits: [*c]WGPULimits) callconv(.c) WGPUStatus;
pub const WGPUProcAdapterHasFeature = ?*const fn (adapter: WGPUAdapter, feature: WGPUFeatureName) callconv(.c) WGPUBool;
pub const WGPUProcAdapterRequestDevice = ?*const fn (adapter: WGPUAdapter, descriptor: [*c]const WGPUDeviceDescriptor, callbackInfo: WGPURequestDeviceCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcAdapterAddRef = ?*const fn (adapter: WGPUAdapter) callconv(.c) void;
pub const WGPUProcAdapterRelease = ?*const fn (adapter: WGPUAdapter) callconv(.c) void;
pub const WGPUProcAdapterInfoFreeMembers = ?*const fn (adapterInfo: WGPUAdapterInfo) callconv(.c) void;
pub const WGPUProcBindGroupSetLabel = ?*const fn (bindGroup: WGPUBindGroup, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcBindGroupAddRef = ?*const fn (bindGroup: WGPUBindGroup) callconv(.c) void;
pub const WGPUProcBindGroupRelease = ?*const fn (bindGroup: WGPUBindGroup) callconv(.c) void;
pub const WGPUProcBindGroupLayoutSetLabel = ?*const fn (bindGroupLayout: WGPUBindGroupLayout, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcBindGroupLayoutAddRef = ?*const fn (bindGroupLayout: WGPUBindGroupLayout) callconv(.c) void;
pub const WGPUProcBindGroupLayoutRelease = ?*const fn (bindGroupLayout: WGPUBindGroupLayout) callconv(.c) void;
pub const WGPUProcBufferDestroy = ?*const fn (buffer: WGPUBuffer) callconv(.c) void;
pub const WGPUProcBufferGetConstMappedRange = ?*const fn (buffer: WGPUBuffer, offset: usize, size: usize) callconv(.c) ?*const anyopaque;
pub const WGPUProcBufferGetMappedRange = ?*const fn (buffer: WGPUBuffer, offset: usize, size: usize) callconv(.c) ?*anyopaque;
pub const WGPUProcBufferGetMapState = ?*const fn (buffer: WGPUBuffer) callconv(.c) WGPUBufferMapState;
pub const WGPUProcBufferGetSize = ?*const fn (buffer: WGPUBuffer) callconv(.c) u64;
pub const WGPUProcBufferGetUsage = ?*const fn (buffer: WGPUBuffer) callconv(.c) WGPUBufferUsage;
pub const WGPUProcBufferMapAsync = ?*const fn (buffer: WGPUBuffer, mode: WGPUMapMode, offset: usize, size: usize, callbackInfo: WGPUBufferMapCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcBufferReadMappedRange = ?*const fn (buffer: WGPUBuffer, offset: usize, data: ?*anyopaque, size: usize) callconv(.c) WGPUStatus;
pub const WGPUProcBufferSetLabel = ?*const fn (buffer: WGPUBuffer, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcBufferUnmap = ?*const fn (buffer: WGPUBuffer) callconv(.c) void;
pub const WGPUProcBufferWriteMappedRange = ?*const fn (buffer: WGPUBuffer, offset: usize, data: ?*const anyopaque, size: usize) callconv(.c) WGPUStatus;
pub const WGPUProcBufferAddRef = ?*const fn (buffer: WGPUBuffer) callconv(.c) void;
pub const WGPUProcBufferRelease = ?*const fn (buffer: WGPUBuffer) callconv(.c) void;
pub const WGPUProcCommandBufferSetLabel = ?*const fn (commandBuffer: WGPUCommandBuffer, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcCommandBufferAddRef = ?*const fn (commandBuffer: WGPUCommandBuffer) callconv(.c) void;
pub const WGPUProcCommandBufferRelease = ?*const fn (commandBuffer: WGPUCommandBuffer) callconv(.c) void;
pub const WGPUProcCommandEncoderBeginComputePass = ?*const fn (commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPUComputePassDescriptor) callconv(.c) WGPUComputePassEncoder;
pub const WGPUProcCommandEncoderBeginRenderPass = ?*const fn (commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPURenderPassDescriptor) callconv(.c) WGPURenderPassEncoder;
pub const WGPUProcCommandEncoderClearBuffer = ?*const fn (commandEncoder: WGPUCommandEncoder, buffer: WGPUBuffer, offset: u64, size: u64) callconv(.c) void;
pub const WGPUProcCommandEncoderCopyBufferToBuffer = ?*const fn (commandEncoder: WGPUCommandEncoder, source: WGPUBuffer, sourceOffset: u64, destination: WGPUBuffer, destinationOffset: u64, size: u64) callconv(.c) void;
pub const WGPUProcCommandEncoderCopyBufferToTexture = ?*const fn (commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyBufferInfo, destination: [*c]const WGPUTexelCopyTextureInfo, copySize: [*c]const WGPUExtent3D) callconv(.c) void;
pub const WGPUProcCommandEncoderCopyTextureToBuffer = ?*const fn (commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyTextureInfo, destination: [*c]const WGPUTexelCopyBufferInfo, copySize: [*c]const WGPUExtent3D) callconv(.c) void;
pub const WGPUProcCommandEncoderCopyTextureToTexture = ?*const fn (commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyTextureInfo, destination: [*c]const WGPUTexelCopyTextureInfo, copySize: [*c]const WGPUExtent3D) callconv(.c) void;
pub const WGPUProcCommandEncoderFinish = ?*const fn (commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPUCommandBufferDescriptor) callconv(.c) WGPUCommandBuffer;
pub const WGPUProcCommandEncoderInsertDebugMarker = ?*const fn (commandEncoder: WGPUCommandEncoder, markerLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcCommandEncoderPopDebugGroup = ?*const fn (commandEncoder: WGPUCommandEncoder) callconv(.c) void;
pub const WGPUProcCommandEncoderPushDebugGroup = ?*const fn (commandEncoder: WGPUCommandEncoder, groupLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcCommandEncoderResolveQuerySet = ?*const fn (commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, firstQuery: u32, queryCount: u32, destination: WGPUBuffer, destinationOffset: u64) callconv(.c) void;
pub const WGPUProcCommandEncoderSetLabel = ?*const fn (commandEncoder: WGPUCommandEncoder, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcCommandEncoderWriteTimestamp = ?*const fn (commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, queryIndex: u32) callconv(.c) void;
pub const WGPUProcCommandEncoderAddRef = ?*const fn (commandEncoder: WGPUCommandEncoder) callconv(.c) void;
pub const WGPUProcCommandEncoderRelease = ?*const fn (commandEncoder: WGPUCommandEncoder) callconv(.c) void;
pub const WGPUProcComputePassEncoderDispatchWorkgroups = ?*const fn (computePassEncoder: WGPUComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) callconv(.c) void;
pub const WGPUProcComputePassEncoderDispatchWorkgroupsIndirect = ?*const fn (computePassEncoder: WGPUComputePassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) callconv(.c) void;
pub const WGPUProcComputePassEncoderEnd = ?*const fn (computePassEncoder: WGPUComputePassEncoder) callconv(.c) void;
pub const WGPUProcComputePassEncoderInsertDebugMarker = ?*const fn (computePassEncoder: WGPUComputePassEncoder, markerLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcComputePassEncoderPopDebugGroup = ?*const fn (computePassEncoder: WGPUComputePassEncoder) callconv(.c) void;
pub const WGPUProcComputePassEncoderPushDebugGroup = ?*const fn (computePassEncoder: WGPUComputePassEncoder, groupLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcComputePassEncoderSetBindGroup = ?*const fn (computePassEncoder: WGPUComputePassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) callconv(.c) void;
pub const WGPUProcComputePassEncoderSetLabel = ?*const fn (computePassEncoder: WGPUComputePassEncoder, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcComputePassEncoderSetPipeline = ?*const fn (computePassEncoder: WGPUComputePassEncoder, pipeline: WGPUComputePipeline) callconv(.c) void;
pub const WGPUProcComputePassEncoderAddRef = ?*const fn (computePassEncoder: WGPUComputePassEncoder) callconv(.c) void;
pub const WGPUProcComputePassEncoderRelease = ?*const fn (computePassEncoder: WGPUComputePassEncoder) callconv(.c) void;
pub const WGPUProcComputePipelineGetBindGroupLayout = ?*const fn (computePipeline: WGPUComputePipeline, groupIndex: u32) callconv(.c) WGPUBindGroupLayout;
pub const WGPUProcComputePipelineSetLabel = ?*const fn (computePipeline: WGPUComputePipeline, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcComputePipelineAddRef = ?*const fn (computePipeline: WGPUComputePipeline) callconv(.c) void;
pub const WGPUProcComputePipelineRelease = ?*const fn (computePipeline: WGPUComputePipeline) callconv(.c) void;
pub const WGPUProcDeviceCreateBindGroup = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUBindGroupDescriptor) callconv(.c) WGPUBindGroup;
pub const WGPUProcDeviceCreateBindGroupLayout = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUBindGroupLayoutDescriptor) callconv(.c) WGPUBindGroupLayout;
pub const WGPUProcDeviceCreateBuffer = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUBufferDescriptor) callconv(.c) WGPUBuffer;
pub const WGPUProcDeviceCreateCommandEncoder = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUCommandEncoderDescriptor) callconv(.c) WGPUCommandEncoder;
pub const WGPUProcDeviceCreateComputePipeline = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUComputePipelineDescriptor) callconv(.c) WGPUComputePipeline;
pub const WGPUProcDeviceCreateComputePipelineAsync = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUComputePipelineDescriptor, callbackInfo: WGPUCreateComputePipelineAsyncCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcDeviceCreatePipelineLayout = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUPipelineLayoutDescriptor) callconv(.c) WGPUPipelineLayout;
pub const WGPUProcDeviceCreateQuerySet = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUQuerySetDescriptor) callconv(.c) WGPUQuerySet;
pub const WGPUProcDeviceCreateRenderBundleEncoder = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPURenderBundleEncoderDescriptor) callconv(.c) WGPURenderBundleEncoder;
pub const WGPUProcDeviceCreateRenderPipeline = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPURenderPipelineDescriptor) callconv(.c) WGPURenderPipeline;
pub const WGPUProcDeviceCreateRenderPipelineAsync = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPURenderPipelineDescriptor, callbackInfo: WGPUCreateRenderPipelineAsyncCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcDeviceCreateSampler = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUSamplerDescriptor) callconv(.c) WGPUSampler;
pub const WGPUProcDeviceCreateShaderModule = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUShaderModuleDescriptor) callconv(.c) WGPUShaderModule;
pub const WGPUProcDeviceCreateTexture = ?*const fn (device: WGPUDevice, descriptor: [*c]const WGPUTextureDescriptor) callconv(.c) WGPUTexture;
pub const WGPUProcDeviceDestroy = ?*const fn (device: WGPUDevice) callconv(.c) void;
pub const WGPUProcDeviceGetAdapterInfo = ?*const fn (device: WGPUDevice, adapterInfo: [*c]WGPUAdapterInfo) callconv(.c) WGPUStatus;
pub const WGPUProcDeviceGetFeatures = ?*const fn (device: WGPUDevice, features: [*c]WGPUSupportedFeatures) callconv(.c) void;
pub const WGPUProcDeviceGetLimits = ?*const fn (device: WGPUDevice, limits: [*c]WGPULimits) callconv(.c) WGPUStatus;
pub const WGPUProcDeviceGetLostFuture = ?*const fn (device: WGPUDevice) callconv(.c) WGPUFuture;
pub const WGPUProcDeviceGetQueue = ?*const fn (device: WGPUDevice) callconv(.c) WGPUQueue;
pub const WGPUProcDeviceHasFeature = ?*const fn (device: WGPUDevice, feature: WGPUFeatureName) callconv(.c) WGPUBool;
pub const WGPUProcDevicePopErrorScope = ?*const fn (device: WGPUDevice, callbackInfo: WGPUPopErrorScopeCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcDevicePushErrorScope = ?*const fn (device: WGPUDevice, filter: WGPUErrorFilter) callconv(.c) void;
pub const WGPUProcDeviceSetLabel = ?*const fn (device: WGPUDevice, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcDeviceAddRef = ?*const fn (device: WGPUDevice) callconv(.c) void;
pub const WGPUProcDeviceRelease = ?*const fn (device: WGPUDevice) callconv(.c) void;
pub const WGPUProcExternalTextureSetLabel = ?*const fn (externalTexture: WGPUExternalTexture, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcExternalTextureAddRef = ?*const fn (externalTexture: WGPUExternalTexture) callconv(.c) void;
pub const WGPUProcExternalTextureRelease = ?*const fn (externalTexture: WGPUExternalTexture) callconv(.c) void;
pub const WGPUProcInstanceCreateSurface = ?*const fn (instance: WGPUInstance, descriptor: [*c]const WGPUSurfaceDescriptor) callconv(.c) WGPUSurface;
pub const WGPUProcInstanceGetWGSLLanguageFeatures = ?*const fn (instance: WGPUInstance, features: [*c]WGPUSupportedWGSLLanguageFeatures) callconv(.c) void;
pub const WGPUProcInstanceHasWGSLLanguageFeature = ?*const fn (instance: WGPUInstance, feature: WGPUWGSLLanguageFeatureName) callconv(.c) WGPUBool;
pub const WGPUProcInstanceProcessEvents = ?*const fn (instance: WGPUInstance) callconv(.c) void;
pub const WGPUProcInstanceRequestAdapter = ?*const fn (instance: WGPUInstance, options: [*c]const WGPURequestAdapterOptions, callbackInfo: WGPURequestAdapterCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcInstanceWaitAny = ?*const fn (instance: WGPUInstance, futureCount: usize, futures: [*c]WGPUFutureWaitInfo, timeoutNS: u64) callconv(.c) WGPUWaitStatus;
pub const WGPUProcInstanceAddRef = ?*const fn (instance: WGPUInstance) callconv(.c) void;
pub const WGPUProcInstanceRelease = ?*const fn (instance: WGPUInstance) callconv(.c) void;
pub const WGPUProcPipelineLayoutSetLabel = ?*const fn (pipelineLayout: WGPUPipelineLayout, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcPipelineLayoutAddRef = ?*const fn (pipelineLayout: WGPUPipelineLayout) callconv(.c) void;
pub const WGPUProcPipelineLayoutRelease = ?*const fn (pipelineLayout: WGPUPipelineLayout) callconv(.c) void;
pub const WGPUProcQuerySetDestroy = ?*const fn (querySet: WGPUQuerySet) callconv(.c) void;
pub const WGPUProcQuerySetGetCount = ?*const fn (querySet: WGPUQuerySet) callconv(.c) u32;
pub const WGPUProcQuerySetGetType = ?*const fn (querySet: WGPUQuerySet) callconv(.c) WGPUQueryType;
pub const WGPUProcQuerySetSetLabel = ?*const fn (querySet: WGPUQuerySet, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcQuerySetAddRef = ?*const fn (querySet: WGPUQuerySet) callconv(.c) void;
pub const WGPUProcQuerySetRelease = ?*const fn (querySet: WGPUQuerySet) callconv(.c) void;
pub const WGPUProcQueueOnSubmittedWorkDone = ?*const fn (queue: WGPUQueue, callbackInfo: WGPUQueueWorkDoneCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcQueueSetLabel = ?*const fn (queue: WGPUQueue, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcQueueSubmit = ?*const fn (queue: WGPUQueue, commandCount: usize, commands: [*c]const WGPUCommandBuffer) callconv(.c) void;
pub const WGPUProcQueueWriteBuffer = ?*const fn (queue: WGPUQueue, buffer: WGPUBuffer, bufferOffset: u64, data: ?*const anyopaque, size: usize) callconv(.c) void;
pub const WGPUProcQueueWriteTexture = ?*const fn (queue: WGPUQueue, destination: [*c]const WGPUTexelCopyTextureInfo, data: ?*const anyopaque, dataSize: usize, dataLayout: [*c]const WGPUTexelCopyBufferLayout, writeSize: [*c]const WGPUExtent3D) callconv(.c) void;
pub const WGPUProcQueueAddRef = ?*const fn (queue: WGPUQueue) callconv(.c) void;
pub const WGPUProcQueueRelease = ?*const fn (queue: WGPUQueue) callconv(.c) void;
pub const WGPUProcRenderBundleSetLabel = ?*const fn (renderBundle: WGPURenderBundle, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderBundleAddRef = ?*const fn (renderBundle: WGPURenderBundle) callconv(.c) void;
pub const WGPUProcRenderBundleRelease = ?*const fn (renderBundle: WGPURenderBundle) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderDraw = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderDrawIndexed = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderDrawIndexedIndirect = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderDrawIndirect = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderFinish = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, descriptor: [*c]const WGPURenderBundleDescriptor) callconv(.c) WGPURenderBundle;
pub const WGPUProcRenderBundleEncoderInsertDebugMarker = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, markerLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderPopDebugGroup = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderPushDebugGroup = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, groupLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderSetBindGroup = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderSetIndexBuffer = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderSetLabel = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderSetPipeline = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, pipeline: WGPURenderPipeline) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderSetVertexBuffer = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderAddRef = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder) callconv(.c) void;
pub const WGPUProcRenderBundleEncoderRelease = ?*const fn (renderBundleEncoder: WGPURenderBundleEncoder) callconv(.c) void;
pub const WGPUProcRenderPassEncoderBeginOcclusionQuery = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, queryIndex: u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderDraw = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderDrawIndexed = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderDrawIndexedIndirect = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) callconv(.c) void;
pub const WGPUProcRenderPassEncoderDrawIndirect = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) callconv(.c) void;
pub const WGPUProcRenderPassEncoderEnd = ?*const fn (renderPassEncoder: WGPURenderPassEncoder) callconv(.c) void;
pub const WGPUProcRenderPassEncoderEndOcclusionQuery = ?*const fn (renderPassEncoder: WGPURenderPassEncoder) callconv(.c) void;
pub const WGPUProcRenderPassEncoderExecuteBundles = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, bundleCount: usize, bundles: [*c]const WGPURenderBundle) callconv(.c) void;
pub const WGPUProcRenderPassEncoderInsertDebugMarker = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, markerLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderPassEncoderPopDebugGroup = ?*const fn (renderPassEncoder: WGPURenderPassEncoder) callconv(.c) void;
pub const WGPUProcRenderPassEncoderPushDebugGroup = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, groupLabel: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetBindGroup = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetBlendConstant = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, color: [*c]const WGPUColor) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetIndexBuffer = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetLabel = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetPipeline = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, pipeline: WGPURenderPipeline) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetScissorRect = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, x: u32, y: u32, width: u32, height: u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetStencilReference = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, reference: u32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetVertexBuffer = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) callconv(.c) void;
pub const WGPUProcRenderPassEncoderSetViewport = ?*const fn (renderPassEncoder: WGPURenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) callconv(.c) void;
pub const WGPUProcRenderPassEncoderAddRef = ?*const fn (renderPassEncoder: WGPURenderPassEncoder) callconv(.c) void;
pub const WGPUProcRenderPassEncoderRelease = ?*const fn (renderPassEncoder: WGPURenderPassEncoder) callconv(.c) void;
pub const WGPUProcRenderPipelineGetBindGroupLayout = ?*const fn (renderPipeline: WGPURenderPipeline, groupIndex: u32) callconv(.c) WGPUBindGroupLayout;
pub const WGPUProcRenderPipelineSetLabel = ?*const fn (renderPipeline: WGPURenderPipeline, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcRenderPipelineAddRef = ?*const fn (renderPipeline: WGPURenderPipeline) callconv(.c) void;
pub const WGPUProcRenderPipelineRelease = ?*const fn (renderPipeline: WGPURenderPipeline) callconv(.c) void;
pub const WGPUProcSamplerSetLabel = ?*const fn (sampler: WGPUSampler, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcSamplerAddRef = ?*const fn (sampler: WGPUSampler) callconv(.c) void;
pub const WGPUProcSamplerRelease = ?*const fn (sampler: WGPUSampler) callconv(.c) void;
pub const WGPUProcShaderModuleGetCompilationInfo = ?*const fn (shaderModule: WGPUShaderModule, callbackInfo: WGPUCompilationInfoCallbackInfo) callconv(.c) WGPUFuture;
pub const WGPUProcShaderModuleSetLabel = ?*const fn (shaderModule: WGPUShaderModule, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcShaderModuleAddRef = ?*const fn (shaderModule: WGPUShaderModule) callconv(.c) void;
pub const WGPUProcShaderModuleRelease = ?*const fn (shaderModule: WGPUShaderModule) callconv(.c) void;
pub const WGPUProcSupportedFeaturesFreeMembers = ?*const fn (supportedFeatures: WGPUSupportedFeatures) callconv(.c) void;
pub const WGPUProcSupportedInstanceFeaturesFreeMembers = ?*const fn (supportedInstanceFeatures: WGPUSupportedInstanceFeatures) callconv(.c) void;
pub const WGPUProcSupportedWGSLLanguageFeaturesFreeMembers = ?*const fn (supportedWGSLLanguageFeatures: WGPUSupportedWGSLLanguageFeatures) callconv(.c) void;
pub const WGPUProcSurfaceConfigure = ?*const fn (surface: WGPUSurface, config: [*c]const WGPUSurfaceConfiguration) callconv(.c) void;
pub const WGPUProcSurfaceGetCapabilities = ?*const fn (surface: WGPUSurface, adapter: WGPUAdapter, capabilities: [*c]WGPUSurfaceCapabilities) callconv(.c) WGPUStatus;
pub const WGPUProcSurfaceGetCurrentTexture = ?*const fn (surface: WGPUSurface, surfaceTexture: [*c]WGPUSurfaceTexture) callconv(.c) void;
pub const WGPUProcSurfacePresent = ?*const fn (surface: WGPUSurface) callconv(.c) WGPUStatus;
pub const WGPUProcSurfaceSetLabel = ?*const fn (surface: WGPUSurface, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcSurfaceUnconfigure = ?*const fn (surface: WGPUSurface) callconv(.c) void;
pub const WGPUProcSurfaceAddRef = ?*const fn (surface: WGPUSurface) callconv(.c) void;
pub const WGPUProcSurfaceRelease = ?*const fn (surface: WGPUSurface) callconv(.c) void;
pub const WGPUProcSurfaceCapabilitiesFreeMembers = ?*const fn (surfaceCapabilities: WGPUSurfaceCapabilities) callconv(.c) void;
pub const WGPUProcTextureCreateView = ?*const fn (texture: WGPUTexture, descriptor: [*c]const WGPUTextureViewDescriptor) callconv(.c) WGPUTextureView;
pub const WGPUProcTextureDestroy = ?*const fn (texture: WGPUTexture) callconv(.c) void;
pub const WGPUProcTextureGetDepthOrArrayLayers = ?*const fn (texture: WGPUTexture) callconv(.c) u32;
pub const WGPUProcTextureGetDimension = ?*const fn (texture: WGPUTexture) callconv(.c) WGPUTextureDimension;
pub const WGPUProcTextureGetFormat = ?*const fn (texture: WGPUTexture) callconv(.c) WGPUTextureFormat;
pub const WGPUProcTextureGetHeight = ?*const fn (texture: WGPUTexture) callconv(.c) u32;
pub const WGPUProcTextureGetMipLevelCount = ?*const fn (texture: WGPUTexture) callconv(.c) u32;
pub const WGPUProcTextureGetSampleCount = ?*const fn (texture: WGPUTexture) callconv(.c) u32;
pub const WGPUProcTextureGetTextureBindingViewDimension = ?*const fn (texture: WGPUTexture) callconv(.c) WGPUTextureViewDimension;
pub const WGPUProcTextureGetUsage = ?*const fn (texture: WGPUTexture) callconv(.c) WGPUTextureUsage;
pub const WGPUProcTextureGetWidth = ?*const fn (texture: WGPUTexture) callconv(.c) u32;
pub const WGPUProcTextureSetLabel = ?*const fn (texture: WGPUTexture, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcTextureAddRef = ?*const fn (texture: WGPUTexture) callconv(.c) void;
pub const WGPUProcTextureRelease = ?*const fn (texture: WGPUTexture) callconv(.c) void;
pub const WGPUProcTextureViewSetLabel = ?*const fn (textureView: WGPUTextureView, label: WGPUStringView) callconv(.c) void;
pub const WGPUProcTextureViewAddRef = ?*const fn (textureView: WGPUTextureView) callconv(.c) void;
pub const WGPUProcTextureViewRelease = ?*const fn (textureView: WGPUTextureView) callconv(.c) void;
pub extern fn wgpuCreateInstance(descriptor: [*c]const WGPUInstanceDescriptor) WGPUInstance;
pub extern fn wgpuGetInstanceFeatures(features: [*c]WGPUSupportedInstanceFeatures) void;
pub extern fn wgpuGetInstanceLimits(limits: [*c]WGPUInstanceLimits) WGPUStatus;
pub extern fn wgpuHasInstanceFeature(feature: WGPUInstanceFeatureName) WGPUBool;
pub extern fn wgpuGetProcAddress(procName: WGPUStringView) WGPUProc;
pub extern fn wgpuAdapterGetFeatures(adapter: WGPUAdapter, features: [*c]WGPUSupportedFeatures) void;
pub extern fn wgpuAdapterGetInfo(adapter: WGPUAdapter, info: [*c]WGPUAdapterInfo) WGPUStatus;
pub extern fn wgpuAdapterGetLimits(adapter: WGPUAdapter, limits: [*c]WGPULimits) WGPUStatus;
pub extern fn wgpuAdapterHasFeature(adapter: WGPUAdapter, feature: WGPUFeatureName) WGPUBool;
pub extern fn wgpuAdapterRequestDevice(adapter: WGPUAdapter, descriptor: [*c]const WGPUDeviceDescriptor, callbackInfo: WGPURequestDeviceCallbackInfo) WGPUFuture;
pub extern fn wgpuAdapterAddRef(adapter: WGPUAdapter) void;
pub extern fn wgpuAdapterRelease(adapter: WGPUAdapter) void;
pub extern fn wgpuAdapterInfoFreeMembers(adapterInfo: WGPUAdapterInfo) void;
pub extern fn wgpuBindGroupSetLabel(bindGroup: WGPUBindGroup, label: WGPUStringView) void;
pub extern fn wgpuBindGroupAddRef(bindGroup: WGPUBindGroup) void;
pub extern fn wgpuBindGroupRelease(bindGroup: WGPUBindGroup) void;
pub extern fn wgpuBindGroupLayoutSetLabel(bindGroupLayout: WGPUBindGroupLayout, label: WGPUStringView) void;
pub extern fn wgpuBindGroupLayoutAddRef(bindGroupLayout: WGPUBindGroupLayout) void;
pub extern fn wgpuBindGroupLayoutRelease(bindGroupLayout: WGPUBindGroupLayout) void;
pub extern fn wgpuBufferDestroy(buffer: WGPUBuffer) void;
pub extern fn wgpuBufferGetConstMappedRange(buffer: WGPUBuffer, offset: usize, size: usize) ?*const anyopaque;
pub extern fn wgpuBufferGetMappedRange(buffer: WGPUBuffer, offset: usize, size: usize) ?*anyopaque;
pub extern fn wgpuBufferGetMapState(buffer: WGPUBuffer) WGPUBufferMapState;
pub extern fn wgpuBufferGetSize(buffer: WGPUBuffer) u64;
pub extern fn wgpuBufferGetUsage(buffer: WGPUBuffer) WGPUBufferUsage;
pub extern fn wgpuBufferMapAsync(buffer: WGPUBuffer, mode: WGPUMapMode, offset: usize, size: usize, callbackInfo: WGPUBufferMapCallbackInfo) WGPUFuture;
pub extern fn wgpuBufferReadMappedRange(buffer: WGPUBuffer, offset: usize, data: ?*anyopaque, size: usize) WGPUStatus;
pub extern fn wgpuBufferSetLabel(buffer: WGPUBuffer, label: WGPUStringView) void;
pub extern fn wgpuBufferUnmap(buffer: WGPUBuffer) void;
pub extern fn wgpuBufferWriteMappedRange(buffer: WGPUBuffer, offset: usize, data: ?*const anyopaque, size: usize) WGPUStatus;
pub extern fn wgpuBufferAddRef(buffer: WGPUBuffer) void;
pub extern fn wgpuBufferRelease(buffer: WGPUBuffer) void;
pub extern fn wgpuCommandBufferSetLabel(commandBuffer: WGPUCommandBuffer, label: WGPUStringView) void;
pub extern fn wgpuCommandBufferAddRef(commandBuffer: WGPUCommandBuffer) void;
pub extern fn wgpuCommandBufferRelease(commandBuffer: WGPUCommandBuffer) void;
pub extern fn wgpuCommandEncoderBeginComputePass(commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPUComputePassDescriptor) WGPUComputePassEncoder;
pub extern fn wgpuCommandEncoderBeginRenderPass(commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPURenderPassDescriptor) WGPURenderPassEncoder;
pub extern fn wgpuCommandEncoderClearBuffer(commandEncoder: WGPUCommandEncoder, buffer: WGPUBuffer, offset: u64, size: u64) void;
pub extern fn wgpuCommandEncoderCopyBufferToBuffer(commandEncoder: WGPUCommandEncoder, source: WGPUBuffer, sourceOffset: u64, destination: WGPUBuffer, destinationOffset: u64, size: u64) void;
pub extern fn wgpuCommandEncoderCopyBufferToTexture(commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyBufferInfo, destination: [*c]const WGPUTexelCopyTextureInfo, copySize: [*c]const WGPUExtent3D) void;
pub extern fn wgpuCommandEncoderCopyTextureToBuffer(commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyTextureInfo, destination: [*c]const WGPUTexelCopyBufferInfo, copySize: [*c]const WGPUExtent3D) void;
pub extern fn wgpuCommandEncoderCopyTextureToTexture(commandEncoder: WGPUCommandEncoder, source: [*c]const WGPUTexelCopyTextureInfo, destination: [*c]const WGPUTexelCopyTextureInfo, copySize: [*c]const WGPUExtent3D) void;
pub extern fn wgpuCommandEncoderFinish(commandEncoder: WGPUCommandEncoder, descriptor: [*c]const WGPUCommandBufferDescriptor) WGPUCommandBuffer;
pub extern fn wgpuCommandEncoderInsertDebugMarker(commandEncoder: WGPUCommandEncoder, markerLabel: WGPUStringView) void;
pub extern fn wgpuCommandEncoderPopDebugGroup(commandEncoder: WGPUCommandEncoder) void;
pub extern fn wgpuCommandEncoderPushDebugGroup(commandEncoder: WGPUCommandEncoder, groupLabel: WGPUStringView) void;
pub extern fn wgpuCommandEncoderResolveQuerySet(commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, firstQuery: u32, queryCount: u32, destination: WGPUBuffer, destinationOffset: u64) void;
pub extern fn wgpuCommandEncoderSetLabel(commandEncoder: WGPUCommandEncoder, label: WGPUStringView) void;
pub extern fn wgpuCommandEncoderWriteTimestamp(commandEncoder: WGPUCommandEncoder, querySet: WGPUQuerySet, queryIndex: u32) void;
pub extern fn wgpuCommandEncoderAddRef(commandEncoder: WGPUCommandEncoder) void;
pub extern fn wgpuCommandEncoderRelease(commandEncoder: WGPUCommandEncoder) void;
pub extern fn wgpuComputePassEncoderDispatchWorkgroups(computePassEncoder: WGPUComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) void;
pub extern fn wgpuComputePassEncoderDispatchWorkgroupsIndirect(computePassEncoder: WGPUComputePassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) void;
pub extern fn wgpuComputePassEncoderEnd(computePassEncoder: WGPUComputePassEncoder) void;
pub extern fn wgpuComputePassEncoderInsertDebugMarker(computePassEncoder: WGPUComputePassEncoder, markerLabel: WGPUStringView) void;
pub extern fn wgpuComputePassEncoderPopDebugGroup(computePassEncoder: WGPUComputePassEncoder) void;
pub extern fn wgpuComputePassEncoderPushDebugGroup(computePassEncoder: WGPUComputePassEncoder, groupLabel: WGPUStringView) void;
pub extern fn wgpuComputePassEncoderSetBindGroup(computePassEncoder: WGPUComputePassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) void;
pub extern fn wgpuComputePassEncoderSetLabel(computePassEncoder: WGPUComputePassEncoder, label: WGPUStringView) void;
pub extern fn wgpuComputePassEncoderSetPipeline(computePassEncoder: WGPUComputePassEncoder, pipeline: WGPUComputePipeline) void;
pub extern fn wgpuComputePassEncoderAddRef(computePassEncoder: WGPUComputePassEncoder) void;
pub extern fn wgpuComputePassEncoderRelease(computePassEncoder: WGPUComputePassEncoder) void;
pub extern fn wgpuComputePipelineGetBindGroupLayout(computePipeline: WGPUComputePipeline, groupIndex: u32) WGPUBindGroupLayout;
pub extern fn wgpuComputePipelineSetLabel(computePipeline: WGPUComputePipeline, label: WGPUStringView) void;
pub extern fn wgpuComputePipelineAddRef(computePipeline: WGPUComputePipeline) void;
pub extern fn wgpuComputePipelineRelease(computePipeline: WGPUComputePipeline) void;
pub extern fn wgpuDeviceCreateBindGroup(device: WGPUDevice, descriptor: [*c]const WGPUBindGroupDescriptor) WGPUBindGroup;
pub extern fn wgpuDeviceCreateBindGroupLayout(device: WGPUDevice, descriptor: [*c]const WGPUBindGroupLayoutDescriptor) WGPUBindGroupLayout;
pub extern fn wgpuDeviceCreateBuffer(device: WGPUDevice, descriptor: [*c]const WGPUBufferDescriptor) WGPUBuffer;
pub extern fn wgpuDeviceCreateCommandEncoder(device: WGPUDevice, descriptor: [*c]const WGPUCommandEncoderDescriptor) WGPUCommandEncoder;
pub extern fn wgpuDeviceCreateComputePipeline(device: WGPUDevice, descriptor: [*c]const WGPUComputePipelineDescriptor) WGPUComputePipeline;
pub extern fn wgpuDeviceCreateComputePipelineAsync(device: WGPUDevice, descriptor: [*c]const WGPUComputePipelineDescriptor, callbackInfo: WGPUCreateComputePipelineAsyncCallbackInfo) WGPUFuture;
pub extern fn wgpuDeviceCreatePipelineLayout(device: WGPUDevice, descriptor: [*c]const WGPUPipelineLayoutDescriptor) WGPUPipelineLayout;
pub extern fn wgpuDeviceCreateQuerySet(device: WGPUDevice, descriptor: [*c]const WGPUQuerySetDescriptor) WGPUQuerySet;
pub extern fn wgpuDeviceCreateRenderBundleEncoder(device: WGPUDevice, descriptor: [*c]const WGPURenderBundleEncoderDescriptor) WGPURenderBundleEncoder;
pub extern fn wgpuDeviceCreateRenderPipeline(device: WGPUDevice, descriptor: [*c]const WGPURenderPipelineDescriptor) WGPURenderPipeline;
pub extern fn wgpuDeviceCreateRenderPipelineAsync(device: WGPUDevice, descriptor: [*c]const WGPURenderPipelineDescriptor, callbackInfo: WGPUCreateRenderPipelineAsyncCallbackInfo) WGPUFuture;
pub extern fn wgpuDeviceCreateSampler(device: WGPUDevice, descriptor: [*c]const WGPUSamplerDescriptor) WGPUSampler;
pub extern fn wgpuDeviceCreateShaderModule(device: WGPUDevice, descriptor: [*c]const WGPUShaderModuleDescriptor) WGPUShaderModule;
pub extern fn wgpuDeviceCreateTexture(device: WGPUDevice, descriptor: [*c]const WGPUTextureDescriptor) WGPUTexture;
pub extern fn wgpuDeviceDestroy(device: WGPUDevice) void;
pub extern fn wgpuDeviceGetAdapterInfo(device: WGPUDevice, adapterInfo: [*c]WGPUAdapterInfo) WGPUStatus;
pub extern fn wgpuDeviceGetFeatures(device: WGPUDevice, features: [*c]WGPUSupportedFeatures) void;
pub extern fn wgpuDeviceGetLimits(device: WGPUDevice, limits: [*c]WGPULimits) WGPUStatus;
pub extern fn wgpuDeviceGetLostFuture(device: WGPUDevice) WGPUFuture;
pub extern fn wgpuDeviceGetQueue(device: WGPUDevice) WGPUQueue;
pub extern fn wgpuDeviceHasFeature(device: WGPUDevice, feature: WGPUFeatureName) WGPUBool;
pub extern fn wgpuDevicePopErrorScope(device: WGPUDevice, callbackInfo: WGPUPopErrorScopeCallbackInfo) WGPUFuture;
pub extern fn wgpuDevicePushErrorScope(device: WGPUDevice, filter: WGPUErrorFilter) void;
pub extern fn wgpuDeviceSetLabel(device: WGPUDevice, label: WGPUStringView) void;
pub extern fn wgpuDeviceAddRef(device: WGPUDevice) void;
pub extern fn wgpuDeviceRelease(device: WGPUDevice) void;
pub extern fn wgpuExternalTextureSetLabel(externalTexture: WGPUExternalTexture, label: WGPUStringView) void;
pub extern fn wgpuExternalTextureAddRef(externalTexture: WGPUExternalTexture) void;
pub extern fn wgpuExternalTextureRelease(externalTexture: WGPUExternalTexture) void;
pub extern fn wgpuInstanceCreateSurface(instance: WGPUInstance, descriptor: [*c]const WGPUSurfaceDescriptor) WGPUSurface;
pub extern fn wgpuInstanceGetWGSLLanguageFeatures(instance: WGPUInstance, features: [*c]WGPUSupportedWGSLLanguageFeatures) void;
pub extern fn wgpuInstanceHasWGSLLanguageFeature(instance: WGPUInstance, feature: WGPUWGSLLanguageFeatureName) WGPUBool;
pub extern fn wgpuInstanceProcessEvents(instance: WGPUInstance) void;
pub extern fn wgpuInstanceRequestAdapter(instance: WGPUInstance, options: [*c]const WGPURequestAdapterOptions, callbackInfo: WGPURequestAdapterCallbackInfo) WGPUFuture;
pub extern fn wgpuInstanceWaitAny(instance: WGPUInstance, futureCount: usize, futures: [*c]WGPUFutureWaitInfo, timeoutNS: u64) WGPUWaitStatus;
pub extern fn wgpuInstanceAddRef(instance: WGPUInstance) void;
pub extern fn wgpuInstanceRelease(instance: WGPUInstance) void;
pub extern fn wgpuPipelineLayoutSetLabel(pipelineLayout: WGPUPipelineLayout, label: WGPUStringView) void;
pub extern fn wgpuPipelineLayoutAddRef(pipelineLayout: WGPUPipelineLayout) void;
pub extern fn wgpuPipelineLayoutRelease(pipelineLayout: WGPUPipelineLayout) void;
pub extern fn wgpuQuerySetDestroy(querySet: WGPUQuerySet) void;
pub extern fn wgpuQuerySetGetCount(querySet: WGPUQuerySet) u32;
pub extern fn wgpuQuerySetGetType(querySet: WGPUQuerySet) WGPUQueryType;
pub extern fn wgpuQuerySetSetLabel(querySet: WGPUQuerySet, label: WGPUStringView) void;
pub extern fn wgpuQuerySetAddRef(querySet: WGPUQuerySet) void;
pub extern fn wgpuQuerySetRelease(querySet: WGPUQuerySet) void;
pub extern fn wgpuQueueOnSubmittedWorkDone(queue: WGPUQueue, callbackInfo: WGPUQueueWorkDoneCallbackInfo) WGPUFuture;
pub extern fn wgpuQueueSetLabel(queue: WGPUQueue, label: WGPUStringView) void;
pub extern fn wgpuQueueSubmit(queue: WGPUQueue, commandCount: usize, commands: [*c]const WGPUCommandBuffer) void;
pub extern fn wgpuQueueWriteBuffer(queue: WGPUQueue, buffer: WGPUBuffer, bufferOffset: u64, data: ?*const anyopaque, size: usize) void;
pub extern fn wgpuQueueWriteTexture(queue: WGPUQueue, destination: [*c]const WGPUTexelCopyTextureInfo, data: ?*const anyopaque, dataSize: usize, dataLayout: [*c]const WGPUTexelCopyBufferLayout, writeSize: [*c]const WGPUExtent3D) void;
pub extern fn wgpuQueueAddRef(queue: WGPUQueue) void;
pub extern fn wgpuQueueRelease(queue: WGPUQueue) void;
pub extern fn wgpuRenderBundleSetLabel(renderBundle: WGPURenderBundle, label: WGPUStringView) void;
pub extern fn wgpuRenderBundleAddRef(renderBundle: WGPURenderBundle) void;
pub extern fn wgpuRenderBundleRelease(renderBundle: WGPURenderBundle) void;
pub extern fn wgpuRenderBundleEncoderDraw(renderBundleEncoder: WGPURenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) void;
pub extern fn wgpuRenderBundleEncoderDrawIndexed(renderBundleEncoder: WGPURenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void;
pub extern fn wgpuRenderBundleEncoderDrawIndexedIndirect(renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) void;
pub extern fn wgpuRenderBundleEncoderDrawIndirect(renderBundleEncoder: WGPURenderBundleEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) void;
pub extern fn wgpuRenderBundleEncoderFinish(renderBundleEncoder: WGPURenderBundleEncoder, descriptor: [*c]const WGPURenderBundleDescriptor) WGPURenderBundle;
pub extern fn wgpuRenderBundleEncoderInsertDebugMarker(renderBundleEncoder: WGPURenderBundleEncoder, markerLabel: WGPUStringView) void;
pub extern fn wgpuRenderBundleEncoderPopDebugGroup(renderBundleEncoder: WGPURenderBundleEncoder) void;
pub extern fn wgpuRenderBundleEncoderPushDebugGroup(renderBundleEncoder: WGPURenderBundleEncoder, groupLabel: WGPUStringView) void;
pub extern fn wgpuRenderBundleEncoderSetBindGroup(renderBundleEncoder: WGPURenderBundleEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) void;
pub extern fn wgpuRenderBundleEncoderSetIndexBuffer(renderBundleEncoder: WGPURenderBundleEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) void;
pub extern fn wgpuRenderBundleEncoderSetLabel(renderBundleEncoder: WGPURenderBundleEncoder, label: WGPUStringView) void;
pub extern fn wgpuRenderBundleEncoderSetPipeline(renderBundleEncoder: WGPURenderBundleEncoder, pipeline: WGPURenderPipeline) void;
pub extern fn wgpuRenderBundleEncoderSetVertexBuffer(renderBundleEncoder: WGPURenderBundleEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) void;
pub extern fn wgpuRenderBundleEncoderAddRef(renderBundleEncoder: WGPURenderBundleEncoder) void;
pub extern fn wgpuRenderBundleEncoderRelease(renderBundleEncoder: WGPURenderBundleEncoder) void;
pub extern fn wgpuRenderPassEncoderBeginOcclusionQuery(renderPassEncoder: WGPURenderPassEncoder, queryIndex: u32) void;
pub extern fn wgpuRenderPassEncoderDraw(renderPassEncoder: WGPURenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) void;
pub extern fn wgpuRenderPassEncoderDrawIndexed(renderPassEncoder: WGPURenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void;
pub extern fn wgpuRenderPassEncoderDrawIndexedIndirect(renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) void;
pub extern fn wgpuRenderPassEncoderDrawIndirect(renderPassEncoder: WGPURenderPassEncoder, indirectBuffer: WGPUBuffer, indirectOffset: u64) void;
pub extern fn wgpuRenderPassEncoderEnd(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderEndOcclusionQuery(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderExecuteBundles(renderPassEncoder: WGPURenderPassEncoder, bundleCount: usize, bundles: [*c]const WGPURenderBundle) void;
pub extern fn wgpuRenderPassEncoderInsertDebugMarker(renderPassEncoder: WGPURenderPassEncoder, markerLabel: WGPUStringView) void;
pub extern fn wgpuRenderPassEncoderPopDebugGroup(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderPushDebugGroup(renderPassEncoder: WGPURenderPassEncoder, groupLabel: WGPUStringView) void;
pub extern fn wgpuRenderPassEncoderSetBindGroup(renderPassEncoder: WGPURenderPassEncoder, groupIndex: u32, group: WGPUBindGroup, dynamicOffsetCount: usize, dynamicOffsets: [*c]const u32) void;
pub extern fn wgpuRenderPassEncoderSetBlendConstant(renderPassEncoder: WGPURenderPassEncoder, color: [*c]const WGPUColor) void;
pub extern fn wgpuRenderPassEncoderSetIndexBuffer(renderPassEncoder: WGPURenderPassEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) void;
pub extern fn wgpuRenderPassEncoderSetLabel(renderPassEncoder: WGPURenderPassEncoder, label: WGPUStringView) void;
pub extern fn wgpuRenderPassEncoderSetPipeline(renderPassEncoder: WGPURenderPassEncoder, pipeline: WGPURenderPipeline) void;
pub extern fn wgpuRenderPassEncoderSetScissorRect(renderPassEncoder: WGPURenderPassEncoder, x: u32, y: u32, width: u32, height: u32) void;
pub extern fn wgpuRenderPassEncoderSetStencilReference(renderPassEncoder: WGPURenderPassEncoder, reference: u32) void;
pub extern fn wgpuRenderPassEncoderSetVertexBuffer(renderPassEncoder: WGPURenderPassEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) void;
pub extern fn wgpuRenderPassEncoderSetViewport(renderPassEncoder: WGPURenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) void;
pub extern fn wgpuRenderPassEncoderAddRef(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderRelease(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuRenderPipelineGetBindGroupLayout(renderPipeline: WGPURenderPipeline, groupIndex: u32) WGPUBindGroupLayout;
pub extern fn wgpuRenderPipelineSetLabel(renderPipeline: WGPURenderPipeline, label: WGPUStringView) void;
pub extern fn wgpuRenderPipelineAddRef(renderPipeline: WGPURenderPipeline) void;
pub extern fn wgpuRenderPipelineRelease(renderPipeline: WGPURenderPipeline) void;
pub extern fn wgpuSamplerSetLabel(sampler: WGPUSampler, label: WGPUStringView) void;
pub extern fn wgpuSamplerAddRef(sampler: WGPUSampler) void;
pub extern fn wgpuSamplerRelease(sampler: WGPUSampler) void;
pub extern fn wgpuShaderModuleGetCompilationInfo(shaderModule: WGPUShaderModule, callbackInfo: WGPUCompilationInfoCallbackInfo) WGPUFuture;
pub extern fn wgpuShaderModuleSetLabel(shaderModule: WGPUShaderModule, label: WGPUStringView) void;
pub extern fn wgpuShaderModuleAddRef(shaderModule: WGPUShaderModule) void;
pub extern fn wgpuShaderModuleRelease(shaderModule: WGPUShaderModule) void;
pub extern fn wgpuSupportedFeaturesFreeMembers(supportedFeatures: WGPUSupportedFeatures) void;
pub extern fn wgpuSupportedInstanceFeaturesFreeMembers(supportedInstanceFeatures: WGPUSupportedInstanceFeatures) void;
pub extern fn wgpuSupportedWGSLLanguageFeaturesFreeMembers(supportedWGSLLanguageFeatures: WGPUSupportedWGSLLanguageFeatures) void;
pub extern fn wgpuSurfaceConfigure(surface: WGPUSurface, config: [*c]const WGPUSurfaceConfiguration) void;
pub extern fn wgpuSurfaceGetCapabilities(surface: WGPUSurface, adapter: WGPUAdapter, capabilities: [*c]WGPUSurfaceCapabilities) WGPUStatus;
pub extern fn wgpuSurfaceGetCurrentTexture(surface: WGPUSurface, surfaceTexture: [*c]WGPUSurfaceTexture) void;
pub extern fn wgpuSurfacePresent(surface: WGPUSurface) WGPUStatus;
pub extern fn wgpuSurfaceSetLabel(surface: WGPUSurface, label: WGPUStringView) void;
pub extern fn wgpuSurfaceUnconfigure(surface: WGPUSurface) void;
pub extern fn wgpuSurfaceAddRef(surface: WGPUSurface) void;
pub extern fn wgpuSurfaceRelease(surface: WGPUSurface) void;
pub extern fn wgpuSurfaceCapabilitiesFreeMembers(surfaceCapabilities: WGPUSurfaceCapabilities) void;
pub extern fn wgpuTextureCreateView(texture: WGPUTexture, descriptor: [*c]const WGPUTextureViewDescriptor) WGPUTextureView;
pub extern fn wgpuTextureDestroy(texture: WGPUTexture) void;
pub extern fn wgpuTextureGetDepthOrArrayLayers(texture: WGPUTexture) u32;
pub extern fn wgpuTextureGetDimension(texture: WGPUTexture) WGPUTextureDimension;
pub extern fn wgpuTextureGetFormat(texture: WGPUTexture) WGPUTextureFormat;
pub extern fn wgpuTextureGetHeight(texture: WGPUTexture) u32;
pub extern fn wgpuTextureGetMipLevelCount(texture: WGPUTexture) u32;
pub extern fn wgpuTextureGetSampleCount(texture: WGPUTexture) u32;
pub extern fn wgpuTextureGetTextureBindingViewDimension(texture: WGPUTexture) WGPUTextureViewDimension;
pub extern fn wgpuTextureGetUsage(texture: WGPUTexture) WGPUTextureUsage;
pub extern fn wgpuTextureGetWidth(texture: WGPUTexture) u32;
pub extern fn wgpuTextureSetLabel(texture: WGPUTexture, label: WGPUStringView) void;
pub extern fn wgpuTextureAddRef(texture: WGPUTexture) void;
pub extern fn wgpuTextureRelease(texture: WGPUTexture) void;
pub extern fn wgpuTextureViewSetLabel(textureView: WGPUTextureView, label: WGPUStringView) void;
pub extern fn wgpuTextureViewAddRef(textureView: WGPUTextureView) void;
pub extern fn wgpuTextureViewRelease(textureView: WGPUTextureView) void;
pub const WGPUSType_DeviceExtras: c_int = 196609;
pub const WGPUSType_NativeLimits: c_int = 196610;
pub const WGPUSType_PipelineLayoutExtras: c_int = 196611;
pub const WGPUSType_ShaderSourceGLSL: c_int = 196612;
pub const WGPUSType_InstanceExtras: c_int = 196614;
pub const WGPUSType_BindGroupEntryExtras: c_int = 196615;
pub const WGPUSType_BindGroupLayoutEntryExtras: c_int = 196616;
pub const WGPUSType_QuerySetDescriptorExtras: c_int = 196617;
pub const WGPUSType_SurfaceConfigurationExtras: c_int = 196618;
pub const WGPUSType_SurfaceSourceSwapChainPanel: c_int = 196619;
pub const WGPUSType_PrimitiveStateExtras: c_int = 196620;
pub const WGPUNativeSType_Force32: c_int = 2147483647;
pub const enum_WGPUNativeSType = c_uint;
pub const WGPUNativeSType = enum_WGPUNativeSType;
pub const WGPUSurfaceGetCurrentTextureStatus_Occluded: c_int = 196609;
pub const WGPUNativeSurfaceGetCurrentTextureStatus_Force32: c_int = 2147483647;
pub const enum_WGPUNativeSurfaceGetCurrentTextureStatus = c_uint;
pub const WGPUNativeSurfaceGetCurrentTextureStatus = enum_WGPUNativeSurfaceGetCurrentTextureStatus;
pub const WGPUNativeFeature_Immediates: c_int = 196609;
pub const WGPUNativeFeature_TextureAdapterSpecificFormatFeatures: c_int = 196610;
pub const WGPUNativeFeature_MultiDrawIndirectCount: c_int = 196612;
pub const WGPUNativeFeature_VertexWritableStorage: c_int = 196613;
pub const WGPUNativeFeature_TextureBindingArray: c_int = 196614;
pub const WGPUNativeFeature_SampledTextureAndStorageBufferArrayNonUniformIndexing: c_int = 196615;
pub const WGPUNativeFeature_PipelineStatisticsQuery: c_int = 196616;
pub const WGPUNativeFeature_StorageResourceBindingArray: c_int = 196617;
pub const WGPUNativeFeature_PartiallyBoundBindingArray: c_int = 196618;
pub const WGPUNativeFeature_TextureFormat16bitNorm: c_int = 196619;
pub const WGPUNativeFeature_TextureCompressionAstcHdr: c_int = 196620;
pub const WGPUNativeFeature_MappablePrimaryBuffers: c_int = 196622;
pub const WGPUNativeFeature_BufferBindingArray: c_int = 196623;
pub const WGPUNativeFeature_StorageTextureArrayNonUniformIndexing: c_int = 196624;
pub const WGPUNativeFeature_PolygonModeLine: c_int = 196627;
pub const WGPUNativeFeature_PolygonModePoint: c_int = 196628;
pub const WGPUNativeFeature_ConservativeRasterization: c_int = 196629;
pub const WGPUNativeFeature_ClearTexture: c_int = 196630;
pub const WGPUNativeFeature_Multiview: c_int = 196632;
pub const WGPUNativeFeature_VertexAttribute64bit: c_int = 196633;
pub const WGPUNativeFeature_TextureFormatNv12: c_int = 196634;
pub const WGPUNativeFeature_RayQuery: c_int = 196636;
pub const WGPUNativeFeature_ShaderF64: c_int = 196637;
pub const WGPUNativeFeature_ShaderI16: c_int = 196638;
pub const WGPUNativeFeature_ShaderEarlyDepthTest: c_int = 196640;
pub const WGPUNativeFeature_Subgroup: c_int = 196641;
pub const WGPUNativeFeature_SubgroupVertex: c_int = 196642;
pub const WGPUNativeFeature_SubgroupBarrier: c_int = 196643;
pub const WGPUNativeFeature_TimestampQueryInsideEncoders: c_int = 196644;
pub const WGPUNativeFeature_TimestampQueryInsidePasses: c_int = 196645;
pub const WGPUNativeFeature_ShaderInt64: c_int = 196646;
pub const WGPUNativeFeature_ShaderFloat32Atomic: c_int = 196647;
pub const WGPUNativeFeature_TextureAtomic: c_int = 196648;
pub const WGPUNativeFeature_TextureFormatP010: c_int = 196649;
pub const WGPUNativeFeature_PipelineCache: c_int = 196651;
pub const WGPUNativeFeature_ShaderInt64AtomicMinMax: c_int = 196652;
pub const WGPUNativeFeature_ShaderInt64AtomicAllOps: c_int = 196653;
pub const WGPUNativeFeature_TextureInt64Atomic: c_int = 196656;
pub const WGPUNativeFeature_ShaderBarycentrics: c_int = 196663;
pub const WGPUNativeFeature_SelectiveMultiview: c_int = 196664;
pub const WGPUNativeFeature_MultisampleArray: c_int = 196666;
pub const WGPUNativeFeature_CooperativeMatrix: c_int = 196667;
pub const WGPUNativeFeature_ShaderPerVertex: c_int = 196668;
pub const WGPUNativeFeature_ShaderDrawIndex: c_int = 196669;
pub const WGPUNativeFeature_AccelerationStructureBindingArray: c_int = 196670;
pub const WGPUNativeFeature_MemoryDecorationCoherent: c_int = 196671;
pub const WGPUNativeFeature_MemoryDecorationVolatile: c_int = 196672;
pub const WGPUNativeFeature_Force32: c_int = 2147483647;
pub const enum_WGPUNativeFeature = c_uint;
pub const WGPUNativeFeature = enum_WGPUNativeFeature;
pub const WGPULogLevel_Off: c_int = 0;
pub const WGPULogLevel_Error: c_int = 1;
pub const WGPULogLevel_Warn: c_int = 2;
pub const WGPULogLevel_Info: c_int = 3;
pub const WGPULogLevel_Debug: c_int = 4;
pub const WGPULogLevel_Trace: c_int = 5;
pub const WGPULogLevel_Force32: c_int = 2147483647;
pub const enum_WGPULogLevel = c_uint;
pub const WGPULogLevel = enum_WGPULogLevel;
pub const WGPUInstanceBackend = WGPUFlags;
pub const WGPUInstanceBackend_All: WGPUInstanceBackend = 0;
pub const WGPUInstanceBackend_Vulkan: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 0))));
pub const WGPUInstanceBackend_GL: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 1))));
pub const WGPUInstanceBackend_Metal: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 2))));
pub const WGPUInstanceBackend_DX12: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 3))));
pub const WGPUInstanceBackend_BrowserWebGPU: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 5))));
pub const WGPUInstanceBackend_Primary: WGPUInstanceBackend = @bitCast(@as(c_long, (((@as(c_int, 1) << @intCast(@as(c_int, 0))) | (@as(c_int, 1) << @intCast(@as(c_int, 2)))) | (@as(c_int, 1) << @intCast(@as(c_int, 3)))) | (@as(c_int, 1) << @intCast(@as(c_int, 5)))));
pub const WGPUInstanceBackend_Secondary: WGPUInstanceBackend = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 1))));
pub const WGPUInstanceBackend_Force32: WGPUInstanceBackend = 2147483647;
pub const WGPUInstanceFlag = WGPUFlags;
pub const WGPUInstanceFlag_Empty: WGPUInstanceFlag = 0;
pub const WGPUInstanceFlag_Debug: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 0))));
pub const WGPUInstanceFlag_Validation: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 1))));
pub const WGPUInstanceFlag_DiscardHalLabels: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 2))));
pub const WGPUInstanceFlag_AllowUnderlyingNoncompliantAdapter: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 3))));
pub const WGPUInstanceFlag_GPUBasedValidation: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 4))));
pub const WGPUInstanceFlag_ValidationIndirectCall: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 5))));
pub const WGPUInstanceFlag_AutomaticTimestampNormalization: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 6))));
pub const WGPUInstanceFlag_Default: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 24))));
pub const WGPUInstanceFlag_Debugging: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 25))));
pub const WGPUInstanceFlag_AdvancedDebugging: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 26))));
pub const WGPUInstanceFlag_WithEnv: WGPUInstanceFlag = @bitCast(@as(c_long, @as(c_int, 1) << @intCast(@as(c_int, 27))));
pub const WGPUInstanceFlag_Force32: WGPUInstanceFlag = 2147483647;
pub const WGPUDx12Compiler_Undefined: c_int = 0;
pub const WGPUDx12Compiler_Fxc: c_int = 1;
pub const WGPUDx12Compiler_Dxc: c_int = 2;
pub const WGPUDx12Compiler_Force32: c_int = 2147483647;
pub const enum_WGPUDx12Compiler = c_uint;
pub const WGPUDx12Compiler = enum_WGPUDx12Compiler;
pub const WGPUGles3MinorVersion_Automatic: c_int = 0;
pub const WGPUGles3MinorVersion_Version0: c_int = 1;
pub const WGPUGles3MinorVersion_Version1: c_int = 2;
pub const WGPUGles3MinorVersion_Version2: c_int = 3;
pub const WGPUGles3MinorVersion_Force32: c_int = 2147483647;
pub const enum_WGPUGles3MinorVersion = c_uint;
pub const WGPUGles3MinorVersion = enum_WGPUGles3MinorVersion;
pub const WGPUPipelineStatisticName_VertexShaderInvocations: c_int = 0;
pub const WGPUPipelineStatisticName_ClipperInvocations: c_int = 1;
pub const WGPUPipelineStatisticName_ClipperPrimitivesOut: c_int = 2;
pub const WGPUPipelineStatisticName_FragmentShaderInvocations: c_int = 3;
pub const WGPUPipelineStatisticName_ComputeShaderInvocations: c_int = 4;
pub const WGPUPipelineStatisticName_Force32: c_int = 2147483647;
pub const enum_WGPUPipelineStatisticName = c_uint;
pub const WGPUPipelineStatisticName = enum_WGPUPipelineStatisticName;
pub const WGPUNativeQueryType_PipelineStatistics: c_int = 196608;
pub const WGPUNativeQueryType_Force32: c_int = 2147483647;
pub const enum_WGPUNativeQueryType = c_uint;
pub const WGPUNativeQueryType = enum_WGPUNativeQueryType;
pub const WGPUDxcMaxShaderModel_V6_0: c_int = 0;
pub const WGPUDxcMaxShaderModel_V6_1: c_int = 1;
pub const WGPUDxcMaxShaderModel_V6_2: c_int = 2;
pub const WGPUDxcMaxShaderModel_V6_3: c_int = 3;
pub const WGPUDxcMaxShaderModel_V6_4: c_int = 4;
pub const WGPUDxcMaxShaderModel_V6_5: c_int = 5;
pub const WGPUDxcMaxShaderModel_V6_6: c_int = 6;
pub const WGPUDxcMaxShaderModel_V6_7: c_int = 7;
pub const WGPUDxcMaxShaderModel_Force32: c_int = 2147483647;
pub const enum_WGPUDxcMaxShaderModel = c_uint;
pub const WGPUDxcMaxShaderModel = enum_WGPUDxcMaxShaderModel;
pub const WGPUGLFenceBehaviour_Normal: c_int = 0;
pub const WGPUGLFenceBehaviour_AutoFinish: c_int = 1;
pub const WGPUGLFenceBehaviour_Force32: c_int = 2147483647;
pub const enum_WGPUGLFenceBehaviour = c_uint;
pub const WGPUGLFenceBehaviour = enum_WGPUGLFenceBehaviour;
pub const WGPUDx12SwapchainKind_Undefined: c_int = 0;
pub const WGPUDx12SwapchainKind_DxgiFromHwnd: c_int = 1;
pub const WGPUDx12SwapchainKind_DxgiFromVisual: c_int = 2;
pub const WGPUDx12SwapchainKind_Force32: c_int = 2147483647;
pub const enum_WGPUDx12SwapchainKind = c_uint;
pub const WGPUDx12SwapchainKind = enum_WGPUDx12SwapchainKind;
pub const WGPUNativeDisplayHandleType_None: c_int = 0;
pub const WGPUNativeDisplayHandleType_Xlib: c_int = 1;
pub const WGPUNativeDisplayHandleType_Xcb: c_int = 2;
pub const WGPUNativeDisplayHandleType_Wayland: c_int = 3;
pub const WGPUNativeDisplayHandleType_Force32: c_int = 2147483647;
pub const enum_WGPUNativeDisplayHandleType = c_uint;
pub const WGPUNativeDisplayHandleType = enum_WGPUNativeDisplayHandleType;
pub const struct_WGPUXlibDisplayHandle = extern struct {
    display: ?*anyopaque = null,
    screen: c_int = 0,
};
pub const WGPUXlibDisplayHandle = struct_WGPUXlibDisplayHandle;
pub const struct_WGPUXcbDisplayHandle = extern struct {
    connection: ?*anyopaque = null,
    screen: c_int = 0,
};
pub const WGPUXcbDisplayHandle = struct_WGPUXcbDisplayHandle;
pub const struct_WGPUWaylandDisplayHandle = extern struct {
    display: ?*anyopaque = null,
};
pub const WGPUWaylandDisplayHandle = struct_WGPUWaylandDisplayHandle;
const union_unnamed_2 = extern union {
    xlib: WGPUXlibDisplayHandle,
    xcb: WGPUXcbDisplayHandle,
    wayland: WGPUWaylandDisplayHandle,
};
pub const struct_WGPUNativeDisplayHandle = extern struct {
    type: WGPUNativeDisplayHandleType = @import("std").mem.zeroes(WGPUNativeDisplayHandleType),
    data: union_unnamed_2 = @import("std").mem.zeroes(union_unnamed_2),
};
pub const WGPUNativeDisplayHandle = struct_WGPUNativeDisplayHandle;
pub const struct_WGPUInstanceExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    backends: WGPUInstanceBackend = 0,
    flags: WGPUInstanceFlag = 0,
    dx12ShaderCompiler: WGPUDx12Compiler = @import("std").mem.zeroes(WGPUDx12Compiler),
    gles3MinorVersion: WGPUGles3MinorVersion = @import("std").mem.zeroes(WGPUGles3MinorVersion),
    glFenceBehaviour: WGPUGLFenceBehaviour = @import("std").mem.zeroes(WGPUGLFenceBehaviour),
    dxcPath: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    dxcMaxShaderModel: WGPUDxcMaxShaderModel = @import("std").mem.zeroes(WGPUDxcMaxShaderModel),
    dx12PresentationSystem: WGPUDx12SwapchainKind = @import("std").mem.zeroes(WGPUDx12SwapchainKind),
    budgetForDeviceCreation: [*c]const u8 = null,
    budgetForDeviceLoss: [*c]const u8 = null,
    displayHandle: WGPUNativeDisplayHandle = @import("std").mem.zeroes(WGPUNativeDisplayHandle),
};
pub const WGPUInstanceExtras = struct_WGPUInstanceExtras;
pub const struct_WGPUDeviceExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    tracePath: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUDeviceExtras = struct_WGPUDeviceExtras;
pub const struct_WGPUNativeLimits = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    maxNonSamplerBindings: u32 = 0,
    maxBindingArrayElementsPerShaderStage: u32 = 0,
    maxBindingArraySamplerElementsPerShaderStage: u32 = 0,
    maxMultiviewViewCount: u32 = 0,
};
pub const WGPUNativeLimits = struct_WGPUNativeLimits;
pub const struct_WGPUPipelineLayoutExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    immediateDataSize: u32 = 0,
};
pub const WGPUPipelineLayoutExtras = struct_WGPUPipelineLayoutExtras;
pub const WGPUSubmissionIndex = u64;
pub const struct_WGPUShaderDefine = extern struct {
    name: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    value: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
};
pub const WGPUShaderDefine = struct_WGPUShaderDefine;
pub const struct_WGPUShaderSourceGLSL = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    stage: WGPUShaderStage = 0,
    code: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    defineCount: u32 = 0,
    defines: [*c]const WGPUShaderDefine = null,
};
pub const WGPUShaderSourceGLSL = struct_WGPUShaderSourceGLSL;
pub const struct_WGPUShaderModuleDescriptorSpirV = extern struct {
    label: WGPUStringView = @import("std").mem.zeroes(WGPUStringView),
    sourceSize: u32 = 0,
    source: [*c]const u32 = null,
};
pub const WGPUShaderModuleDescriptorSpirV = struct_WGPUShaderModuleDescriptorSpirV;
pub const struct_WGPURegistryReport = extern struct {
    numAllocated: usize = 0,
    numKeptFromUser: usize = 0,
    numReleasedFromUser: usize = 0,
    elementSize: usize = 0,
};
pub const WGPURegistryReport = struct_WGPURegistryReport;
pub const struct_WGPUHubReport = extern struct {
    adapters: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    devices: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    queues: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    pipelineLayouts: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    shaderModules: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    bindGroupLayouts: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    bindGroups: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    commandBuffers: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    renderBundles: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    renderPipelines: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    computePipelines: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    pipelineCaches: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    querySets: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    buffers: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    textures: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    textureViews: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    samplers: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
};
pub const WGPUHubReport = struct_WGPUHubReport;
pub const struct_WGPUGlobalReport = extern struct {
    surfaces: WGPURegistryReport = @import("std").mem.zeroes(WGPURegistryReport),
    hub: WGPUHubReport = @import("std").mem.zeroes(WGPUHubReport),
};
pub const WGPUGlobalReport = struct_WGPUGlobalReport;
pub const struct_WGPUInstanceEnumerateAdapterOptions = extern struct {
    nextInChain: [*c]const WGPUChainedStruct = null,
    backends: WGPUInstanceBackend = 0,
};
pub const WGPUInstanceEnumerateAdapterOptions = struct_WGPUInstanceEnumerateAdapterOptions;
pub const struct_WGPUBindGroupEntryExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    buffers: [*c]const WGPUBuffer = null,
    bufferCount: usize = 0,
    samplers: [*c]const WGPUSampler = null,
    samplerCount: usize = 0,
    textureViews: [*c]const WGPUTextureView = null,
    textureViewCount: usize = 0,
};
pub const WGPUBindGroupEntryExtras = struct_WGPUBindGroupEntryExtras;
pub const struct_WGPUBindGroupLayoutEntryExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    count: u32 = 0,
};
pub const WGPUBindGroupLayoutEntryExtras = struct_WGPUBindGroupLayoutEntryExtras;
pub const struct_WGPUQuerySetDescriptorExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    pipelineStatistics: [*c]const WGPUPipelineStatisticName = null,
    pipelineStatisticCount: usize = 0,
};
pub const WGPUQuerySetDescriptorExtras = struct_WGPUQuerySetDescriptorExtras;
pub const struct_WGPUSurfaceConfigurationExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    desiredMaximumFrameLatency: u32 = 0,
};
pub const WGPUSurfaceConfigurationExtras = struct_WGPUSurfaceConfigurationExtras;
pub const struct_WGPUSurfaceSourceSwapChainPanel = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    panelNative: ?*anyopaque = null,
};
pub const WGPUSurfaceSourceSwapChainPanel = struct_WGPUSurfaceSourceSwapChainPanel;
pub const WGPUPolygonMode_Fill: c_int = 0;
pub const WGPUPolygonMode_Line: c_int = 1;
pub const WGPUPolygonMode_Point: c_int = 2;
pub const enum_WGPUPolygonMode = c_uint;
pub const WGPUPolygonMode = enum_WGPUPolygonMode;
pub const struct_WGPUPrimitiveStateExtras = extern struct {
    chain: WGPUChainedStruct = @import("std").mem.zeroes(WGPUChainedStruct),
    polygonMode: WGPUPolygonMode = @import("std").mem.zeroes(WGPUPolygonMode),
    conservative: WGPUBool = 0,
};
pub const WGPUPrimitiveStateExtras = struct_WGPUPrimitiveStateExtras;
pub const WGPULogCallback = ?*const fn (level: WGPULogLevel, message: WGPUStringView, userdata: ?*anyopaque) callconv(.c) void;
pub const WGPUNativeTextureFormat_R16Unorm: c_int = 196609;
pub const WGPUNativeTextureFormat_R16Snorm: c_int = 196610;
pub const WGPUNativeTextureFormat_Rg16Unorm: c_int = 196611;
pub const WGPUNativeTextureFormat_Rg16Snorm: c_int = 196612;
pub const WGPUNativeTextureFormat_Rgba16Unorm: c_int = 196613;
pub const WGPUNativeTextureFormat_Rgba16Snorm: c_int = 196614;
pub const WGPUNativeTextureFormat_NV12: c_int = 196615;
pub const WGPUNativeTextureFormat_P010: c_int = 196616;
pub const enum_WGPUNativeTextureFormat = c_uint;
pub const WGPUNativeTextureFormat = enum_WGPUNativeTextureFormat;
pub const struct_WGPUImageSubresourceRange = extern struct {
    aspect: WGPUTextureAspect = @import("std").mem.zeroes(WGPUTextureAspect),
    baseMipLevel: u32 = 0,
    mipLevelCount: u32 = 0,
    baseArrayLayer: u32 = 0,
    arrayLayerCount: u32 = 0,
};
pub const WGPUImageSubresourceRange = struct_WGPUImageSubresourceRange;
pub extern fn wgpuGenerateReport(instance: WGPUInstance, report: [*c]WGPUGlobalReport) void;
pub extern fn wgpuInstanceEnumerateAdapters(instance: WGPUInstance, options: [*c]const WGPUInstanceEnumerateAdapterOptions, adapters: [*c]WGPUAdapter) usize;
pub extern fn wgpuQueueSubmitForIndex(queue: WGPUQueue, commandCount: usize, commands: [*c]const WGPUCommandBuffer) WGPUSubmissionIndex;
pub extern fn wgpuQueueGetTimestampPeriod(queue: WGPUQueue) f32;
pub extern fn wgpuDevicePoll(device: WGPUDevice, wait: WGPUBool, submissionIndex: [*c]const WGPUSubmissionIndex) WGPUBool;
pub extern fn wgpuDeviceCreateShaderModuleSpirV(device: WGPUDevice, descriptor: [*c]const WGPUShaderModuleDescriptorSpirV) WGPUShaderModule;
pub extern fn wgpuSetLogCallback(callback: WGPULogCallback, userdata: ?*anyopaque) void;
pub extern fn wgpuSetLogLevel(level: WGPULogLevel) void;
pub extern fn wgpuGetVersion() u32;
pub extern fn wgpuDeviceGetNativeMetalDevice(device: WGPUDevice) ?*anyopaque;
pub extern fn wgpuQueueGetNativeMetalCommandQueue(queue: WGPUQueue) ?*anyopaque;
pub extern fn wgpuTextureGetNativeMetalTexture(texture: WGPUTexture) ?*anyopaque;
pub extern fn wgpuRenderPassEncoderSetImmediates(encoder: WGPURenderPassEncoder, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void;
pub extern fn wgpuComputePassEncoderSetImmediates(encoder: WGPUComputePassEncoder, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void;
pub extern fn wgpuRenderBundleEncoderSetImmediates(encoder: WGPURenderBundleEncoder, offset: u32, sizeBytes: u32, data: ?*const anyopaque) void;
pub extern fn wgpuRenderPassEncoderMultiDrawIndirect(encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count: u32) void;
pub extern fn wgpuRenderPassEncoderMultiDrawIndexedIndirect(encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count: u32) void;
pub extern fn wgpuRenderPassEncoderMultiDrawIndirectCount(encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count_buffer: WGPUBuffer, count_buffer_offset: u64, max_count: u32) void;
pub extern fn wgpuRenderPassEncoderMultiDrawIndexedIndirectCount(encoder: WGPURenderPassEncoder, buffer: WGPUBuffer, offset: u64, count_buffer: WGPUBuffer, count_buffer_offset: u64, max_count: u32) void;
pub extern fn wgpuComputePassEncoderBeginPipelineStatisticsQuery(computePassEncoder: WGPUComputePassEncoder, querySet: WGPUQuerySet, queryIndex: u32) void;
pub extern fn wgpuComputePassEncoderEndPipelineStatisticsQuery(computePassEncoder: WGPUComputePassEncoder) void;
pub extern fn wgpuRenderPassEncoderBeginPipelineStatisticsQuery(renderPassEncoder: WGPURenderPassEncoder, querySet: WGPUQuerySet, queryIndex: u32) void;
pub extern fn wgpuRenderPassEncoderEndPipelineStatisticsQuery(renderPassEncoder: WGPURenderPassEncoder) void;
pub extern fn wgpuComputePassEncoderWriteTimestamp(computePassEncoder: WGPUComputePassEncoder, querySet: WGPUQuerySet, queryIndex: u32) void;
pub extern fn wgpuRenderPassEncoderWriteTimestamp(renderPassEncoder: WGPURenderPassEncoder, querySet: WGPUQuerySet, queryIndex: u32) void;
pub extern fn wgpuDeviceStartGraphicsDebuggerCapture(device: WGPUDevice) WGPUBool;
pub extern fn wgpuDeviceStopGraphicsDebuggerCapture(device: WGPUDevice) void;
pub extern fn wgpuCommandEncoderClearTexture(commandEncoder: WGPUCommandEncoder, texture: WGPUTexture, range: [*c]const WGPUImageSubresourceRange) void;

pub const __VERSION__ = "Aro aro-zig";
pub const __Aro__ = "";
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __GNUC__ = @as(c_int, 7);
pub const __GNUC_MINOR__ = @as(c_int, 1);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 0);
pub const __ARO_EMULATE_NO__ = @as(c_int, 0);
pub const __ARO_EMULATE_CLANG__ = @as(c_int, 1);
pub const __ARO_EMULATE_GCC__ = @as(c_int, 2);
pub const __ARO_EMULATE_MSVC__ = @as(c_int, 3);
pub const __ARO_EMULATE__ = __ARO_EMULATE_GCC__;
pub inline fn __building_module(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`"); // <builtin>:33:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`"); // <builtin>:34:9
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __VAES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __VPCLMULQDQ__ = @as(c_int, 1);
pub const __LZCNT__ = @as(c_int, 1);
pub const __RDRND__ = @as(c_int, 1);
pub const __FSGSBASE__ = @as(c_int, 1);
pub const __BMI__ = @as(c_int, 1);
pub const __BMI2__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __PRFCHW__ = @as(c_int, 1);
pub const __ADX__ = @as(c_int, 1);
pub const __MWAITX__ = @as(c_int, 1);
pub const __MOVBE__ = @as(c_int, 1);
pub const __SSE4A__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __GFNI__ = @as(c_int, 1);
pub const __AVX512CD__ = @as(c_int, 1);
pub const __AVX512VPOPCNTDQ__ = @as(c_int, 1);
pub const __AVX512VNNI__ = @as(c_int, 1);
pub const __AVX512BF16__ = @as(c_int, 1);
pub const __AVX512DQ__ = @as(c_int, 1);
pub const __AVX512BITALG__ = @as(c_int, 1);
pub const __AVX512BW__ = @as(c_int, 1);
pub const __AVX512VL__ = @as(c_int, 1);
pub const __EVEX256__ = @as(c_int, 1);
pub const __AVX512VBMI__ = @as(c_int, 1);
pub const __AVX512VBMI2__ = @as(c_int, 1);
pub const __AVX512IFMA__ = @as(c_int, 1);
pub const __AVX512VP2INTERSECT__ = @as(c_int, 1);
pub const __SHA__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __XSAVE__ = @as(c_int, 1);
pub const __XSAVEOPT__ = @as(c_int, 1);
pub const __XSAVEC__ = @as(c_int, 1);
pub const __XSAVES__ = @as(c_int, 1);
pub const __PKU__ = @as(c_int, 1);
pub const __CLFLUSHOPT__ = @as(c_int, 1);
pub const __CLWB__ = @as(c_int, 1);
pub const __WBNOINVD__ = @as(c_int, 1);
pub const __SHSTK__ = @as(c_int, 1);
pub const __PREFETCHI__ = @as(c_int, 1);
pub const __CLZERO__ = @as(c_int, 1);
pub const __RDPID__ = @as(c_int, 1);
pub const __RDPRU__ = @as(c_int, 1);
pub const __MOVDIRI__ = @as(c_int, 1);
pub const __MOVDIR64B__ = @as(c_int, 1);
pub const __INVPCID__ = @as(c_int, 1);
pub const __AVXVNNI__ = @as(c_int, 1);
pub const __CRC32__ = @as(c_int, 1);
pub const __AVX512F__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const __ELF__ = @as(c_int, 1);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __ATOMIC_BOOL_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WINT_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_SHORT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_INT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LLONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_POINTER_LOCK_FREE = @as(c_int, 1);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SCHAR_WIDTH__ = @as(c_int, 8);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __LONG_LONG_WIDTH__ = @as(c_int, 64);
pub const __WCHAR_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIG_ATOMIC_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __BITINT_MAXWIDTH__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 10);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTPTR_TYPE__ = c_long;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:175:9
pub const __INTMAX_C = __helpers.L_SUFFIX;
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:178:9
pub const __UINTMAX_C = __helpers.UL_SUFFIX;
pub const __PTRDIFF_TYPE__ = c_long;
pub const __SIZE_TYPE__ = c_ulong;
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_uint;
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub inline fn __INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub inline fn __INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub inline fn __INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:204:9
pub const __INT64_C = __helpers.L_SUFFIX;
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub inline fn __UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub inline fn __UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`"); // <builtin>:229:9
pub const __UINT32_C = __helpers.U_SUFFIX;
pub const __UINT32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:238:9
pub const __UINT64_C = __helpers.UL_SUFFIX;
pub const __UINT64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const INT_LEAST8_FMTd__ = "hhd";
pub const INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const UINT_LEAST8_FMTo__ = "hho";
pub const UINT_LEAST8_FMTu__ = "hhu";
pub const UINT_LEAST8_FMTx__ = "hhx";
pub const UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const INT_FAST8_FMTd__ = "hhd";
pub const INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const UINT_FAST8_FMTo__ = "hho";
pub const UINT_FAST8_FMTu__ = "hhu";
pub const UINT_FAST8_FMTx__ = "hhx";
pub const UINT_FAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const INT_LEAST16_FMTd__ = "hd";
pub const INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST16_FMTo__ = "ho";
pub const UINT_LEAST16_FMTu__ = "hu";
pub const UINT_LEAST16_FMTx__ = "hx";
pub const UINT_LEAST16_FMTX__ = "hX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const INT_FAST16_FMTd__ = "hd";
pub const INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_FAST16_FMTo__ = "ho";
pub const UINT_FAST16_FMTu__ = "hu";
pub const UINT_FAST16_FMTx__ = "hx";
pub const UINT_FAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const INT_LEAST32_FMTd__ = "d";
pub const INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST32_FMTo__ = "o";
pub const UINT_LEAST32_FMTu__ = "u";
pub const UINT_LEAST32_FMTx__ = "x";
pub const UINT_LEAST32_FMTX__ = "X";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const INT_FAST32_FMTd__ = "d";
pub const INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_FAST32_FMTo__ = "o";
pub const UINT_FAST32_FMTu__ = "u";
pub const UINT_FAST32_FMTx__ = "x";
pub const UINT_FAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const INT_LEAST64_FMTd__ = "ld";
pub const INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_LEAST64_FMTo__ = "lo";
pub const UINT_LEAST64_FMTu__ = "lu";
pub const UINT_LEAST64_FMTx__ = "lx";
pub const UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const INT_FAST64_FMTd__ = "ld";
pub const INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_FMTo__ = "lo";
pub const UINT_FAST64_FMTu__ = "lu";
pub const UINT_FAST64_FMTx__ = "lx";
pub const UINT_FAST64_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = "";
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = "";
pub const __FLT16_HAS_QUIET_NAN__ = "";
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = "";
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = "";
pub const __FLT_HAS_QUIET_NAN__ = "";
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = "";
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = "";
pub const __DBL_HAS_QUIET_NAN__ = "";
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = "";
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = "";
pub const __LDBL_HAS_QUIET_NAN__ = "";
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __FLT_EVAL_METHOD__ = @as(c_int, 0);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __pic__ = @as(c_int, 2);
pub const __PIC__ = @as(c_int, 2);
pub const __GLIBC_MINOR__ = @as(c_int, 42);
pub const WGPU_H_ = "";
pub const WEBGPU_H_ = "";
pub const WGPU_EXPORT = "";
pub const WGPU_OBJECT_ATTRIBUTE = "";
pub const WGPU_ENUM_ATTRIBUTE = "";
pub const WGPU_STRUCTURE_ATTRIBUTE = "";
pub const WGPU_FUNCTION_ATTRIBUTE = "";
pub const WGPU_NULLABLE = "";
pub const __CLANG_STDINT_H = "";
pub const _STDINT_H = @as(c_int, 1);
pub const _FEATURES_H = @as(c_int, 1);
pub const __KERNEL_STRICT_NAMES = "";
pub inline fn __GNUC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub inline fn __glibc_clang_prereq(maj: anytype, min: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &maj;
    _ = &min;
    return @as(c_int, 0);
}
pub const __GLIBC_USE = @compileError("unable to translate macro: undefined identifier `__GLIBC_USE_`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/features.h:191:9
pub const _DEFAULT_SOURCE = @as(c_int, 1);
pub const __GLIBC_USE_ISOC2Y = @as(c_int, 0);
pub const __GLIBC_USE_ISOC23 = @as(c_int, 0);
pub const __USE_ISOC11 = @as(c_int, 1);
pub const __USE_POSIX_IMPLICITLY = @as(c_int, 1);
pub const _POSIX_SOURCE = @as(c_int, 1);
pub const _POSIX_C_SOURCE = @as(c_long, 200809);
pub const __USE_POSIX = @as(c_int, 1);
pub const __USE_POSIX2 = @as(c_int, 1);
pub const __USE_POSIX199309 = @as(c_int, 1);
pub const __USE_POSIX199506 = @as(c_int, 1);
pub const __USE_XOPEN2K = @as(c_int, 1);
pub const __USE_ISOC95 = @as(c_int, 1);
pub const __USE_ISOC99 = @as(c_int, 1);
pub const __USE_XOPEN2K8 = @as(c_int, 1);
pub const _ATFILE_SOURCE = @as(c_int, 1);
pub const __WORDSIZE = @as(c_int, 64);
pub const __WORDSIZE_TIME64_COMPAT32 = @as(c_int, 1);
pub const __SYSCALL_WORDSIZE = @as(c_int, 64);
pub const __TIMESIZE = __WORDSIZE;
pub const __USE_TIME_BITS64 = @as(c_int, 1);
pub const __USE_MISC = @as(c_int, 1);
pub const __USE_ATFILE = @as(c_int, 1);
pub const __USE_FORTIFY_LEVEL = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_GETS = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_SCANF = @as(c_int, 0);
pub const __GLIBC_USE_C23_STRTOL = @as(c_int, 0);
pub const _STDC_PREDEF_H = @as(c_int, 1);
pub const __STDC_IEC_559__ = @as(c_int, 1);
pub const __STDC_IEC_60559_BFP__ = @as(c_long, 201404);
pub const __STDC_IEC_559_COMPLEX__ = @as(c_int, 1);
pub const __STDC_IEC_60559_COMPLEX__ = @as(c_long, 201404);
pub const __STDC_ISO_10646__ = @as(c_long, 201706);
pub const __GNU_LIBRARY__ = @as(c_int, 6);
pub const __GLIBC__ = @as(c_int, 2);
pub inline fn __GLIBC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub const _SYS_CDEFS_H = @as(c_int, 1);
pub const __glibc_has_attribute = @compileError("unable to translate macro: undefined identifier `__has_attribute`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:45:10
pub inline fn __glibc_has_builtin(name: anytype) @TypeOf(__builtin.has_builtin(name)) {
    _ = &name;
    return __builtin.has_builtin(name);
}
pub const __glibc_has_extension = @compileError("unable to translate macro: undefined identifier `__has_extension`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:55:10
pub const __LEAF = @compileError("unable to translate macro: undefined identifier `__leaf__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:65:11
pub const __LEAF_ATTR = @compileError("unable to translate macro: undefined identifier `__leaf__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:66:11
pub const __THROW = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:79:11
pub const __THROWNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:80:11
pub const __NTH = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:81:11
pub const __NTHNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:82:11
pub const __COLD = @compileError("unable to translate macro: undefined identifier `__cold__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:102:11
pub inline fn __P(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub inline fn __PMT(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:131:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token ''"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:132:9
pub const __ptr_t = ?*anyopaque;
pub const __BEGIN_DECLS = "";
pub const __END_DECLS = "";
pub const __attribute_overloadable__ = "";
pub inline fn __bos(ptr: anytype) @TypeOf(__builtin.object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1))) {
    _ = &ptr;
    return __builtin.object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1));
}
pub inline fn __bos0(ptr: anytype) @TypeOf(__builtin.object_size(ptr, @as(c_int, 0))) {
    _ = &ptr;
    return __builtin.object_size(ptr, @as(c_int, 0));
}
pub inline fn __glibc_objsize0(__o: anytype) @TypeOf(__bos0(__o)) {
    _ = &__o;
    return __bos0(__o);
}
pub inline fn __glibc_objsize(__o: anytype) @TypeOf(__bos(__o)) {
    _ = &__o;
    return __bos(__o);
}
pub const __warnattr = @compileError("unable to translate macro: undefined identifier `__warning__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:366:10
pub const __errordecl = @compileError("unable to translate macro: undefined identifier `__error__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:367:10
pub const __flexarr = @compileError("unable to translate C expr: unexpected token '['"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:379:10
pub const __glibc_c99_flexarr_available = @as(c_int, 1);
pub const __REDIRECT = @compileError("unable to translate C expr: unexpected token '__asm__'"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:410:10
pub const __REDIRECT_NTH = @compileError("unable to translate C expr: unexpected token '__asm__'"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:417:11
pub const __REDIRECT_NTHNL = @compileError("unable to translate C expr: unexpected token '__asm__'"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:419:11
pub const __ASMNAME = @compileError("unable to translate macro: undefined identifier `__USER_LABEL_PREFIX__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:422:10
pub inline fn __ASMNAME2(prefix: anytype, cname: anytype) @TypeOf(__STRING(prefix) ++ cname) {
    _ = &prefix;
    _ = &cname;
    return __STRING(prefix) ++ cname;
}
pub const __REDIRECT_FORTIFY = __REDIRECT;
pub const __REDIRECT_FORTIFY_NTH = __REDIRECT_NTH;
pub const __attribute_malloc__ = @compileError("unable to translate macro: undefined identifier `__malloc__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:452:10
pub const __attribute_alloc_size__ = @compileError("unable to translate macro: undefined identifier `__alloc_size__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:460:10
pub const __attribute_alloc_align__ = @compileError("unable to translate macro: undefined identifier `__alloc_align__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:469:10
pub const __attribute_pure__ = @compileError("unable to translate macro: undefined identifier `__pure__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:479:10
pub const __attribute_const__ = @compileError("unable to translate C expr: unexpected token '__attribute__'"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:486:10
pub const __attribute_maybe_unused__ = @compileError("unable to translate macro: undefined identifier `__unused__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:492:10
pub const __attribute_used__ = @compileError("unable to translate macro: undefined identifier `__used__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:501:10
pub const __attribute_noinline__ = @compileError("unable to translate macro: undefined identifier `__noinline__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:502:10
pub const __attribute_deprecated__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:510:10
pub const __attribute_deprecated_msg__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:520:10
pub const __attribute_format_arg__ = @compileError("unable to translate macro: undefined identifier `__format_arg__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:533:10
pub const __attribute_format_strfmon__ = @compileError("unable to translate macro: undefined identifier `__format__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:543:10
pub const __attribute_nonnull__ = @compileError("unable to translate macro: undefined identifier `__nonnull__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:555:11
pub inline fn __nonnull(params: anytype) @TypeOf(__attribute_nonnull__(params)) {
    _ = &params;
    return __attribute_nonnull__(params);
}
pub const __returns_nonnull = @compileError("unable to translate macro: undefined identifier `__returns_nonnull__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:568:10
pub const __attribute_warn_unused_result__ = @compileError("unable to translate macro: undefined identifier `__warn_unused_result__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:577:10
pub const __wur = "";
pub const __always_inline = @compileError("unable to translate macro: undefined identifier `__always_inline__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:595:10
pub const __attribute_artificial__ = @compileError("unable to translate macro: undefined identifier `__artificial__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:604:10
pub const __extern_inline = @compileError("unable to translate C expr: unexpected token 'extern'"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:626:11
pub const __extern_always_inline = @compileError("unable to translate C expr: unexpected token 'extern'"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:627:11
pub const __fortify_function = __extern_always_inline ++ __attribute_artificial__;
pub const __va_arg_pack = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg_pack`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:638:10
pub const __va_arg_pack_len = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg_pack_len`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:639:10
pub const __restrict_arr = @compileError("unable to translate C expr: unexpected token '__restrict'"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:666:10
pub inline fn __glibc_unlikely(cond: anytype) @TypeOf(__builtin.expect(cond, @as(c_int, 0))) {
    _ = &cond;
    return __builtin.expect(cond, @as(c_int, 0));
}
pub inline fn __glibc_likely(cond: anytype) @TypeOf(__builtin.expect(cond, @as(c_int, 1))) {
    _ = &cond;
    return __builtin.expect(cond, @as(c_int, 1));
}
pub const __attribute_nonstring__ = "";
pub inline fn __attribute_copy__(arg: anytype) void {
    _ = &arg;
    return;
}
pub const __LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = @as(c_int, 0);
pub inline fn __LDBL_REDIR1(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR(name: anytype, proto: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR1_NTH(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto ++ __THROW;
}
pub inline fn __LDBL_REDIR_NTH(name: anytype, proto: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    return name ++ proto ++ __THROW;
}
pub inline fn __LDBL_REDIR2_DECL(name: anytype) void {
    _ = &name;
    return;
}
pub inline fn __LDBL_REDIR_DECL(name: anytype) void {
    _ = &name;
    return;
}
pub inline fn __REDIRECT_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT(name, proto, alias);
}
pub inline fn __REDIRECT_NTH_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT_NTH(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT_NTH(name, proto, alias);
}
pub const __glibc_macro_warning1 = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:807:10
pub const __glibc_macro_warning = @compileError("unable to translate macro: undefined identifier `GCC`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:808:10
pub const __HAVE_GENERIC_SELECTION = @as(c_int, 1);
pub inline fn __fortified_attr_access(a: anytype, o: anytype, s: anytype) void {
    _ = &a;
    _ = &o;
    _ = &s;
    return;
}
pub inline fn __attr_access(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __attr_access_none(argno: anytype) void {
    _ = &argno;
    return;
}
pub inline fn __attr_dealloc(dealloc: anytype, argno: anytype) void {
    _ = &dealloc;
    _ = &argno;
    return;
}
pub const __attr_dealloc_free = "";
pub const __attribute_returns_twice__ = @compileError("unable to translate macro: undefined identifier `__returns_twice__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:872:10
pub const __attribute_struct_may_alias__ = @compileError("unable to translate macro: undefined identifier `__may_alias__`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/sys/cdefs.h:881:10
pub const __stub___compat_bdflush = "";
pub const __stub_chflags = "";
pub const __stub_fchflags = "";
pub const __stub_gtty = "";
pub const __stub_revoke = "";
pub const __stub_setlogin = "";
pub const __stub_sigreturn = "";
pub const __stub_stty = "";
pub const _BITS_TYPES_H = @as(c_int, 1);
pub const __S16_TYPE = c_short;
pub const __U16_TYPE = c_ushort;
pub const __S32_TYPE = c_int;
pub const __U32_TYPE = c_uint;
pub const __SLONGWORD_TYPE = c_long;
pub const __ULONGWORD_TYPE = c_ulong;
pub const __SQUAD_TYPE = c_long;
pub const __UQUAD_TYPE = c_ulong;
pub const __SWORD_TYPE = c_long;
pub const __UWORD_TYPE = c_ulong;
pub const __SLONG32_TYPE = c_int;
pub const __ULONG32_TYPE = c_uint;
pub const __S64_TYPE = c_long;
pub const __U64_TYPE = c_ulong;
pub const _BITS_TYPESIZES_H = @as(c_int, 1);
pub const __SYSCALL_SLONG_TYPE = __SLONGWORD_TYPE;
pub const __SYSCALL_ULONG_TYPE = __ULONGWORD_TYPE;
pub const __DEV_T_TYPE = __UQUAD_TYPE;
pub const __UID_T_TYPE = __U32_TYPE;
pub const __GID_T_TYPE = __U32_TYPE;
pub const __INO_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __INO64_T_TYPE = __UQUAD_TYPE;
pub const __MODE_T_TYPE = __U32_TYPE;
pub const __NLINK_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSWORD_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF64_T_TYPE = __SQUAD_TYPE;
pub const __PID_T_TYPE = __S32_TYPE;
pub const __RLIM_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __RLIM64_T_TYPE = __UQUAD_TYPE;
pub const __BLKCNT_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __BLKCNT64_T_TYPE = __SQUAD_TYPE;
pub const __FSBLKCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSBLKCNT64_T_TYPE = __UQUAD_TYPE;
pub const __FSFILCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSFILCNT64_T_TYPE = __UQUAD_TYPE;
pub const __ID_T_TYPE = __U32_TYPE;
pub const __CLOCK_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __TIME_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __USECONDS_T_TYPE = __U32_TYPE;
pub const __SUSECONDS_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __SUSECONDS64_T_TYPE = __SQUAD_TYPE;
pub const __DADDR_T_TYPE = __S32_TYPE;
pub const __KEY_T_TYPE = __S32_TYPE;
pub const __CLOCKID_T_TYPE = __S32_TYPE;
pub const __TIMER_T_TYPE = ?*anyopaque;
pub const __BLKSIZE_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __FSID_T_TYPE = @compileError("unable to translate macro: undefined identifier `__val`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/typesizes.h:73:9
pub const __SSIZE_T_TYPE = __SWORD_TYPE;
pub const __CPU_MASK_TYPE = __SYSCALL_ULONG_TYPE;
pub const __OFF_T_MATCHES_OFF64_T = @as(c_int, 1);
pub const __INO_T_MATCHES_INO64_T = @as(c_int, 1);
pub const __RLIM_T_MATCHES_RLIM64_T = @as(c_int, 1);
pub const __STATFS_MATCHES_STATFS64 = @as(c_int, 1);
pub const __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = @as(c_int, 1);
pub const __FD_SETSIZE = @as(c_int, 1024);
pub const _BITS_TIME64_H = @as(c_int, 1);
pub const __TIME64_T_TYPE = __TIME_T_TYPE;
pub const _BITS_WCHAR_H = @as(c_int, 1);
pub const __WCHAR_MAX = __WCHAR_MAX__;
pub const __WCHAR_MIN = -__WCHAR_MAX - @as(c_int, 1);
pub const _BITS_STDINT_INTN_H = @as(c_int, 1);
pub const _BITS_STDINT_UINTN_H = @as(c_int, 1);
pub const _BITS_STDINT_LEAST_H = @as(c_int, 1);
pub const __intptr_t_defined = "";
pub const INT8_MIN = -@as(c_int, 128);
pub const INT16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT32_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT8_MAX = @as(c_int, 127);
pub const INT16_MAX = @as(c_int, 32767);
pub const INT32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT8_MAX = @as(c_int, 255);
pub const UINT16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_LEAST8_MIN = -@as(c_int, 128);
pub const INT_LEAST16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT_LEAST32_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT_LEAST64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_LEAST8_MAX = @as(c_int, 127);
pub const INT_LEAST16_MAX = @as(c_int, 32767);
pub const INT_LEAST32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT_LEAST64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_LEAST8_MAX = @as(c_int, 255);
pub const UINT_LEAST16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_FAST8_MIN = -@as(c_int, 128);
pub const INT_FAST16_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST32_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_FAST8_MAX = @as(c_int, 127);
pub const INT_FAST16_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST32_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_FAST8_MAX = @as(c_int, 255);
pub const UINT_FAST16_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST32_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INTPTR_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INTPTR_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const UINTPTR_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const INTMAX_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INTMAX_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINTMAX_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const PTRDIFF_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const PTRDIFF_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const SIG_ATOMIC_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const SIG_ATOMIC_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const SIZE_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const WCHAR_MIN = __WCHAR_MIN;
pub const WCHAR_MAX = __WCHAR_MAX;
pub const WINT_MIN = @as(c_uint, 0);
pub const WINT_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub inline fn INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const INT64_C = __helpers.L_SUFFIX;
pub inline fn UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const UINT32_C = __helpers.U_SUFFIX;
pub const UINT64_C = __helpers.UL_SUFFIX;
pub const INTMAX_C = __helpers.L_SUFFIX;
pub const UINTMAX_C = __helpers.UL_SUFFIX;
pub const __STDC_VERSION_STDDEF_H__ = @as(c_long, 202311);
pub const NULL = __helpers.cast(?*anyopaque, @as(c_int, 0));
pub const offsetof = @compileError("unable to translate macro: undefined identifier `__builtin_offsetof`"); // /nix/store/nllnya5hr3hg2dp0vz8ajap4n2dqraw6-zig-0.17.0-dev.269+ebff43698/lib/compiler/aro/include/stddef.h:18:9
pub const _MATH_H = @as(c_int, 1);
pub const __GLIBC_USE_LIB_EXT2 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT_C23 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT_C23 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_TYPES_EXT = @as(c_int, 0);
pub const _BITS_LIBM_SIMD_DECL_STUBS_H = @as(c_int, 1);
pub const __DECL_SIMD_cos = "";
pub const __DECL_SIMD_cosf = "";
pub const __DECL_SIMD_cosl = "";
pub const __DECL_SIMD_cosf16 = "";
pub const __DECL_SIMD_cosf32 = "";
pub const __DECL_SIMD_cosf64 = "";
pub const __DECL_SIMD_cosf128 = "";
pub const __DECL_SIMD_cosf32x = "";
pub const __DECL_SIMD_cosf64x = "";
pub const __DECL_SIMD_cosf128x = "";
pub const __DECL_SIMD_sin = "";
pub const __DECL_SIMD_sinf = "";
pub const __DECL_SIMD_sinl = "";
pub const __DECL_SIMD_sinf16 = "";
pub const __DECL_SIMD_sinf32 = "";
pub const __DECL_SIMD_sinf64 = "";
pub const __DECL_SIMD_sinf128 = "";
pub const __DECL_SIMD_sinf32x = "";
pub const __DECL_SIMD_sinf64x = "";
pub const __DECL_SIMD_sinf128x = "";
pub const __DECL_SIMD_sincos = "";
pub const __DECL_SIMD_sincosf = "";
pub const __DECL_SIMD_sincosl = "";
pub const __DECL_SIMD_sincosf16 = "";
pub const __DECL_SIMD_sincosf32 = "";
pub const __DECL_SIMD_sincosf64 = "";
pub const __DECL_SIMD_sincosf128 = "";
pub const __DECL_SIMD_sincosf32x = "";
pub const __DECL_SIMD_sincosf64x = "";
pub const __DECL_SIMD_sincosf128x = "";
pub const __DECL_SIMD_log = "";
pub const __DECL_SIMD_logf = "";
pub const __DECL_SIMD_logl = "";
pub const __DECL_SIMD_logf16 = "";
pub const __DECL_SIMD_logf32 = "";
pub const __DECL_SIMD_logf64 = "";
pub const __DECL_SIMD_logf128 = "";
pub const __DECL_SIMD_logf32x = "";
pub const __DECL_SIMD_logf64x = "";
pub const __DECL_SIMD_logf128x = "";
pub const __DECL_SIMD_exp = "";
pub const __DECL_SIMD_expf = "";
pub const __DECL_SIMD_expl = "";
pub const __DECL_SIMD_expf16 = "";
pub const __DECL_SIMD_expf32 = "";
pub const __DECL_SIMD_expf64 = "";
pub const __DECL_SIMD_expf128 = "";
pub const __DECL_SIMD_expf32x = "";
pub const __DECL_SIMD_expf64x = "";
pub const __DECL_SIMD_expf128x = "";
pub const __DECL_SIMD_pow = "";
pub const __DECL_SIMD_powf = "";
pub const __DECL_SIMD_powl = "";
pub const __DECL_SIMD_powf16 = "";
pub const __DECL_SIMD_powf32 = "";
pub const __DECL_SIMD_powf64 = "";
pub const __DECL_SIMD_powf128 = "";
pub const __DECL_SIMD_powf32x = "";
pub const __DECL_SIMD_powf64x = "";
pub const __DECL_SIMD_powf128x = "";
pub const __DECL_SIMD_acos = "";
pub const __DECL_SIMD_acosf = "";
pub const __DECL_SIMD_acosl = "";
pub const __DECL_SIMD_acosf16 = "";
pub const __DECL_SIMD_acosf32 = "";
pub const __DECL_SIMD_acosf64 = "";
pub const __DECL_SIMD_acosf128 = "";
pub const __DECL_SIMD_acosf32x = "";
pub const __DECL_SIMD_acosf64x = "";
pub const __DECL_SIMD_acosf128x = "";
pub const __DECL_SIMD_atan = "";
pub const __DECL_SIMD_atanf = "";
pub const __DECL_SIMD_atanl = "";
pub const __DECL_SIMD_atanf16 = "";
pub const __DECL_SIMD_atanf32 = "";
pub const __DECL_SIMD_atanf64 = "";
pub const __DECL_SIMD_atanf128 = "";
pub const __DECL_SIMD_atanf32x = "";
pub const __DECL_SIMD_atanf64x = "";
pub const __DECL_SIMD_atanf128x = "";
pub const __DECL_SIMD_asin = "";
pub const __DECL_SIMD_asinf = "";
pub const __DECL_SIMD_asinl = "";
pub const __DECL_SIMD_asinf16 = "";
pub const __DECL_SIMD_asinf32 = "";
pub const __DECL_SIMD_asinf64 = "";
pub const __DECL_SIMD_asinf128 = "";
pub const __DECL_SIMD_asinf32x = "";
pub const __DECL_SIMD_asinf64x = "";
pub const __DECL_SIMD_asinf128x = "";
pub const __DECL_SIMD_hypot = "";
pub const __DECL_SIMD_hypotf = "";
pub const __DECL_SIMD_hypotl = "";
pub const __DECL_SIMD_hypotf16 = "";
pub const __DECL_SIMD_hypotf32 = "";
pub const __DECL_SIMD_hypotf64 = "";
pub const __DECL_SIMD_hypotf128 = "";
pub const __DECL_SIMD_hypotf32x = "";
pub const __DECL_SIMD_hypotf64x = "";
pub const __DECL_SIMD_hypotf128x = "";
pub const __DECL_SIMD_exp2 = "";
pub const __DECL_SIMD_exp2f = "";
pub const __DECL_SIMD_exp2l = "";
pub const __DECL_SIMD_exp2f16 = "";
pub const __DECL_SIMD_exp2f32 = "";
pub const __DECL_SIMD_exp2f64 = "";
pub const __DECL_SIMD_exp2f128 = "";
pub const __DECL_SIMD_exp2f32x = "";
pub const __DECL_SIMD_exp2f64x = "";
pub const __DECL_SIMD_exp2f128x = "";
pub const __DECL_SIMD_exp10 = "";
pub const __DECL_SIMD_exp10f = "";
pub const __DECL_SIMD_exp10l = "";
pub const __DECL_SIMD_exp10f16 = "";
pub const __DECL_SIMD_exp10f32 = "";
pub const __DECL_SIMD_exp10f64 = "";
pub const __DECL_SIMD_exp10f128 = "";
pub const __DECL_SIMD_exp10f32x = "";
pub const __DECL_SIMD_exp10f64x = "";
pub const __DECL_SIMD_exp10f128x = "";
pub const __DECL_SIMD_cosh = "";
pub const __DECL_SIMD_coshf = "";
pub const __DECL_SIMD_coshl = "";
pub const __DECL_SIMD_coshf16 = "";
pub const __DECL_SIMD_coshf32 = "";
pub const __DECL_SIMD_coshf64 = "";
pub const __DECL_SIMD_coshf128 = "";
pub const __DECL_SIMD_coshf32x = "";
pub const __DECL_SIMD_coshf64x = "";
pub const __DECL_SIMD_coshf128x = "";
pub const __DECL_SIMD_expm1 = "";
pub const __DECL_SIMD_expm1f = "";
pub const __DECL_SIMD_expm1l = "";
pub const __DECL_SIMD_expm1f16 = "";
pub const __DECL_SIMD_expm1f32 = "";
pub const __DECL_SIMD_expm1f64 = "";
pub const __DECL_SIMD_expm1f128 = "";
pub const __DECL_SIMD_expm1f32x = "";
pub const __DECL_SIMD_expm1f64x = "";
pub const __DECL_SIMD_expm1f128x = "";
pub const __DECL_SIMD_sinh = "";
pub const __DECL_SIMD_sinhf = "";
pub const __DECL_SIMD_sinhl = "";
pub const __DECL_SIMD_sinhf16 = "";
pub const __DECL_SIMD_sinhf32 = "";
pub const __DECL_SIMD_sinhf64 = "";
pub const __DECL_SIMD_sinhf128 = "";
pub const __DECL_SIMD_sinhf32x = "";
pub const __DECL_SIMD_sinhf64x = "";
pub const __DECL_SIMD_sinhf128x = "";
pub const __DECL_SIMD_cbrt = "";
pub const __DECL_SIMD_cbrtf = "";
pub const __DECL_SIMD_cbrtl = "";
pub const __DECL_SIMD_cbrtf16 = "";
pub const __DECL_SIMD_cbrtf32 = "";
pub const __DECL_SIMD_cbrtf64 = "";
pub const __DECL_SIMD_cbrtf128 = "";
pub const __DECL_SIMD_cbrtf32x = "";
pub const __DECL_SIMD_cbrtf64x = "";
pub const __DECL_SIMD_cbrtf128x = "";
pub const __DECL_SIMD_atan2 = "";
pub const __DECL_SIMD_atan2f = "";
pub const __DECL_SIMD_atan2l = "";
pub const __DECL_SIMD_atan2f16 = "";
pub const __DECL_SIMD_atan2f32 = "";
pub const __DECL_SIMD_atan2f64 = "";
pub const __DECL_SIMD_atan2f128 = "";
pub const __DECL_SIMD_atan2f32x = "";
pub const __DECL_SIMD_atan2f64x = "";
pub const __DECL_SIMD_atan2f128x = "";
pub const __DECL_SIMD_log10 = "";
pub const __DECL_SIMD_log10f = "";
pub const __DECL_SIMD_log10l = "";
pub const __DECL_SIMD_log10f16 = "";
pub const __DECL_SIMD_log10f32 = "";
pub const __DECL_SIMD_log10f64 = "";
pub const __DECL_SIMD_log10f128 = "";
pub const __DECL_SIMD_log10f32x = "";
pub const __DECL_SIMD_log10f64x = "";
pub const __DECL_SIMD_log10f128x = "";
pub const __DECL_SIMD_log2 = "";
pub const __DECL_SIMD_log2f = "";
pub const __DECL_SIMD_log2l = "";
pub const __DECL_SIMD_log2f16 = "";
pub const __DECL_SIMD_log2f32 = "";
pub const __DECL_SIMD_log2f64 = "";
pub const __DECL_SIMD_log2f128 = "";
pub const __DECL_SIMD_log2f32x = "";
pub const __DECL_SIMD_log2f64x = "";
pub const __DECL_SIMD_log2f128x = "";
pub const __DECL_SIMD_log1p = "";
pub const __DECL_SIMD_log1pf = "";
pub const __DECL_SIMD_log1pl = "";
pub const __DECL_SIMD_log1pf16 = "";
pub const __DECL_SIMD_log1pf32 = "";
pub const __DECL_SIMD_log1pf64 = "";
pub const __DECL_SIMD_log1pf128 = "";
pub const __DECL_SIMD_log1pf32x = "";
pub const __DECL_SIMD_log1pf64x = "";
pub const __DECL_SIMD_log1pf128x = "";
pub const __DECL_SIMD_logp1 = "";
pub const __DECL_SIMD_logp1f = "";
pub const __DECL_SIMD_logp1l = "";
pub const __DECL_SIMD_logp1f16 = "";
pub const __DECL_SIMD_logp1f32 = "";
pub const __DECL_SIMD_logp1f64 = "";
pub const __DECL_SIMD_logp1f128 = "";
pub const __DECL_SIMD_logp1f32x = "";
pub const __DECL_SIMD_logp1f64x = "";
pub const __DECL_SIMD_logp1f128x = "";
pub const __DECL_SIMD_atanh = "";
pub const __DECL_SIMD_atanhf = "";
pub const __DECL_SIMD_atanhl = "";
pub const __DECL_SIMD_atanhf16 = "";
pub const __DECL_SIMD_atanhf32 = "";
pub const __DECL_SIMD_atanhf64 = "";
pub const __DECL_SIMD_atanhf128 = "";
pub const __DECL_SIMD_atanhf32x = "";
pub const __DECL_SIMD_atanhf64x = "";
pub const __DECL_SIMD_atanhf128x = "";
pub const __DECL_SIMD_acosh = "";
pub const __DECL_SIMD_acoshf = "";
pub const __DECL_SIMD_acoshl = "";
pub const __DECL_SIMD_acoshf16 = "";
pub const __DECL_SIMD_acoshf32 = "";
pub const __DECL_SIMD_acoshf64 = "";
pub const __DECL_SIMD_acoshf128 = "";
pub const __DECL_SIMD_acoshf32x = "";
pub const __DECL_SIMD_acoshf64x = "";
pub const __DECL_SIMD_acoshf128x = "";
pub const __DECL_SIMD_erf = "";
pub const __DECL_SIMD_erff = "";
pub const __DECL_SIMD_erfl = "";
pub const __DECL_SIMD_erff16 = "";
pub const __DECL_SIMD_erff32 = "";
pub const __DECL_SIMD_erff64 = "";
pub const __DECL_SIMD_erff128 = "";
pub const __DECL_SIMD_erff32x = "";
pub const __DECL_SIMD_erff64x = "";
pub const __DECL_SIMD_erff128x = "";
pub const __DECL_SIMD_tanh = "";
pub const __DECL_SIMD_tanhf = "";
pub const __DECL_SIMD_tanhl = "";
pub const __DECL_SIMD_tanhf16 = "";
pub const __DECL_SIMD_tanhf32 = "";
pub const __DECL_SIMD_tanhf64 = "";
pub const __DECL_SIMD_tanhf128 = "";
pub const __DECL_SIMD_tanhf32x = "";
pub const __DECL_SIMD_tanhf64x = "";
pub const __DECL_SIMD_tanhf128x = "";
pub const __DECL_SIMD_asinh = "";
pub const __DECL_SIMD_asinhf = "";
pub const __DECL_SIMD_asinhl = "";
pub const __DECL_SIMD_asinhf16 = "";
pub const __DECL_SIMD_asinhf32 = "";
pub const __DECL_SIMD_asinhf64 = "";
pub const __DECL_SIMD_asinhf128 = "";
pub const __DECL_SIMD_asinhf32x = "";
pub const __DECL_SIMD_asinhf64x = "";
pub const __DECL_SIMD_asinhf128x = "";
pub const __DECL_SIMD_erfc = "";
pub const __DECL_SIMD_erfcf = "";
pub const __DECL_SIMD_erfcl = "";
pub const __DECL_SIMD_erfcf16 = "";
pub const __DECL_SIMD_erfcf32 = "";
pub const __DECL_SIMD_erfcf64 = "";
pub const __DECL_SIMD_erfcf128 = "";
pub const __DECL_SIMD_erfcf32x = "";
pub const __DECL_SIMD_erfcf64x = "";
pub const __DECL_SIMD_erfcf128x = "";
pub const __DECL_SIMD_tan = "";
pub const __DECL_SIMD_tanf = "";
pub const __DECL_SIMD_tanl = "";
pub const __DECL_SIMD_tanf16 = "";
pub const __DECL_SIMD_tanf32 = "";
pub const __DECL_SIMD_tanf64 = "";
pub const __DECL_SIMD_tanf128 = "";
pub const __DECL_SIMD_tanf32x = "";
pub const __DECL_SIMD_tanf64x = "";
pub const __DECL_SIMD_tanf128x = "";
pub const __DECL_SIMD_sinpi = "";
pub const __DECL_SIMD_sinpif = "";
pub const __DECL_SIMD_sinpil = "";
pub const __DECL_SIMD_sinpif16 = "";
pub const __DECL_SIMD_sinpif32 = "";
pub const __DECL_SIMD_sinpif64 = "";
pub const __DECL_SIMD_sinpif128 = "";
pub const __DECL_SIMD_sinpif32x = "";
pub const __DECL_SIMD_sinpif64x = "";
pub const __DECL_SIMD_sinpif128x = "";
pub const __DECL_SIMD_cospi = "";
pub const __DECL_SIMD_cospif = "";
pub const __DECL_SIMD_cospil = "";
pub const __DECL_SIMD_cospif16 = "";
pub const __DECL_SIMD_cospif32 = "";
pub const __DECL_SIMD_cospif64 = "";
pub const __DECL_SIMD_cospif128 = "";
pub const __DECL_SIMD_cospif32x = "";
pub const __DECL_SIMD_cospif64x = "";
pub const __DECL_SIMD_cospif128x = "";
pub const __DECL_SIMD_tanpi = "";
pub const __DECL_SIMD_tanpif = "";
pub const __DECL_SIMD_tanpil = "";
pub const __DECL_SIMD_tanpif16 = "";
pub const __DECL_SIMD_tanpif32 = "";
pub const __DECL_SIMD_tanpif64 = "";
pub const __DECL_SIMD_tanpif128 = "";
pub const __DECL_SIMD_tanpif32x = "";
pub const __DECL_SIMD_tanpif64x = "";
pub const __DECL_SIMD_tanpif128x = "";
pub const __DECL_SIMD_acospi = "";
pub const __DECL_SIMD_acospif = "";
pub const __DECL_SIMD_acospil = "";
pub const __DECL_SIMD_acospif16 = "";
pub const __DECL_SIMD_acospif32 = "";
pub const __DECL_SIMD_acospif64 = "";
pub const __DECL_SIMD_acospif128 = "";
pub const __DECL_SIMD_acospif32x = "";
pub const __DECL_SIMD_acospif64x = "";
pub const __DECL_SIMD_acospif128x = "";
pub const __DECL_SIMD_asinpi = "";
pub const __DECL_SIMD_asinpif = "";
pub const __DECL_SIMD_asinpil = "";
pub const __DECL_SIMD_asinpif16 = "";
pub const __DECL_SIMD_asinpif32 = "";
pub const __DECL_SIMD_asinpif64 = "";
pub const __DECL_SIMD_asinpif128 = "";
pub const __DECL_SIMD_asinpif32x = "";
pub const __DECL_SIMD_asinpif64x = "";
pub const __DECL_SIMD_asinpif128x = "";
pub const __DECL_SIMD_atanpi = "";
pub const __DECL_SIMD_atanpif = "";
pub const __DECL_SIMD_atanpil = "";
pub const __DECL_SIMD_atanpif16 = "";
pub const __DECL_SIMD_atanpif32 = "";
pub const __DECL_SIMD_atanpif64 = "";
pub const __DECL_SIMD_atanpif128 = "";
pub const __DECL_SIMD_atanpif32x = "";
pub const __DECL_SIMD_atanpif64x = "";
pub const __DECL_SIMD_atanpif128x = "";
pub const __DECL_SIMD_atan2pi = "";
pub const __DECL_SIMD_atan2pif = "";
pub const __DECL_SIMD_atan2pil = "";
pub const __DECL_SIMD_atan2pif16 = "";
pub const __DECL_SIMD_atan2pif32 = "";
pub const __DECL_SIMD_atan2pif64 = "";
pub const __DECL_SIMD_atan2pif128 = "";
pub const __DECL_SIMD_atan2pif32x = "";
pub const __DECL_SIMD_atan2pif64x = "";
pub const __DECL_SIMD_atan2pif128x = "";
pub const _BITS_FLOATN_H = "";
pub const __HAVE_FLOAT128 = @as(c_int, 1);
pub const __HAVE_DISTINCT_FLOAT128 = @as(c_int, 1);
pub const __HAVE_FLOAT64X = @as(c_int, 1);
pub const __HAVE_FLOAT64X_LONG_DOUBLE = @as(c_int, 1);
pub const __f128 = @compileError("unable to translate macro: undefined identifier `f128`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/floatn.h:72:12
pub const __CFLOAT128 = @compileError("unable to translate: invalid numeric type"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/floatn.h:86:12
pub const _BITS_FLOATN_COMMON_H = "";
pub const __HAVE_FLOAT16 = @as(c_int, 0);
pub const __HAVE_FLOAT32 = @as(c_int, 1);
pub const __HAVE_FLOAT64 = @as(c_int, 1);
pub const __HAVE_FLOAT32X = @as(c_int, 1);
pub const __HAVE_FLOAT128X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT16 = __HAVE_FLOAT16;
pub const __HAVE_DISTINCT_FLOAT32 = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT64 = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT32X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT64X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT128X = __HAVE_FLOAT128X;
pub const __HAVE_FLOAT128_UNLIKE_LDBL = (__HAVE_DISTINCT_FLOAT128 != 0) and (__LDBL_MANT_DIG__ != @as(c_int, 113));
pub const __HAVE_FLOATN_NOT_TYPEDEF = @as(c_int, 1);
pub const __f32 = @compileError("unable to translate macro: undefined identifier `f32`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/floatn-common.h:93:12
pub const __f64 = @compileError("unable to translate macro: undefined identifier `f64`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/floatn-common.h:105:12
pub const __f32x = @compileError("unable to translate macro: undefined identifier `f32x`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/floatn-common.h:113:12
pub const __f64x = @compileError("unable to translate macro: undefined identifier `f64x`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/floatn-common.h:125:12
pub const __CFLOAT32 = @compileError("unable to translate: invalid numeric type"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/floatn-common.h:151:12
pub const __CFLOAT64 = @compileError("unable to translate: invalid numeric type"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/floatn-common.h:163:12
pub const __CFLOAT32X = @compileError("unable to translate: invalid numeric type"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/floatn-common.h:171:12
pub const __CFLOAT64X = @compileError("unable to translate: invalid numeric type"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/floatn-common.h:183:12
pub const HUGE_VAL = @compileError("unable to translate macro: undefined identifier `__builtin_huge_val`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:48:10
pub const HUGE_VALF = __builtin.huge_valf();
pub const HUGE_VALL = @compileError("unable to translate macro: undefined identifier `__builtin_huge_vall`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:60:11
pub const INFINITY = __builtin.inff();
pub const NAN = __builtin.nanf("");
pub const __GLIBC_FLT_EVAL_METHOD = __FLT_EVAL_METHOD__;
pub const __FP_LOGB0_IS_MIN = @as(c_int, 1);
pub const __FP_LOGBNAN_IS_MIN = @as(c_int, 1);
pub const FP_ILOGB0 = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const FP_ILOGBNAN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const __SIMD_DECL = @compileError("unable to translate macro: undefined identifier `__DECL_SIMD_`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/mathcalls-macros.h:19:9
pub const __MATHCALL_VEC = @compileError("unable to translate macro: undefined identifier `__MATH_PRECNAME`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/mathcalls-macros.h:21:9
pub const __MATHDECL_VEC = @compileError("unable to translate macro: undefined identifier `__MATH_PRECNAME`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/mathcalls-macros.h:25:9
pub const __MATHCALLX = @compileError("unable to translate macro: undefined identifier `_Mdouble_`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/mathcalls-macros.h:34:9
pub const __MATHDECLX = @compileError("unable to translate macro: undefined identifier `__MATHDECL_1`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/mathcalls-macros.h:36:9
pub const __MATHREDIR = @compileError("unable to translate macro: undefined identifier `__MATH_PRECNAME`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/bits/mathcalls-macros.h:47:9
pub const __MATH_DECLARE_LDOUBLE = @as(c_int, 1);
pub const __MATH_TG_F32 = @compileError("unable to translate macro: undefined identifier `f`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:853:12
pub const __MATH_TG_F64X = @compileError("unable to translate macro: undefined identifier `l`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:859:13
pub const __MATH_TG = @compileError("unable to translate macro: undefined identifier `f`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:866:11
pub const fpclassify = @compileError("unable to translate macro: undefined identifier `__builtin_fpclassify`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:936:11
pub inline fn signbit(x: anytype) @TypeOf(__builtin.signbit(x)) {
    _ = &x;
    return __builtin.signbit(x);
}
pub const isfinite = @compileError("unable to translate macro: undefined identifier `__builtin_isfinite`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:963:11
pub const isnormal = @compileError("unable to translate macro: undefined identifier `__builtin_isnormal`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:971:11
pub const MATH_ERRNO = @as(c_int, 1);
pub const MATH_ERREXCEPT = @as(c_int, 2);
pub const math_errhandling = MATH_ERRNO | MATH_ERREXCEPT;
pub const M_E = @as(f64, 2.7182818284590452354);
pub const M_LOG2E = @as(f64, 1.4426950408889634074);
pub const M_LOG10E = @as(f64, 0.43429448190325182765);
pub const M_LN2 = @as(f64, 0.69314718055994530942);
pub const M_LN10 = @as(f64, 2.30258509299404568402);
pub const M_PI = @as(f64, 3.14159265358979323846);
pub const M_PI_2 = @as(f64, 1.57079632679489661923);
pub const M_PI_4 = @as(f64, 0.78539816339744830962);
pub const M_1_PI = @as(f64, 0.31830988618379067154);
pub const M_2_PI = @as(f64, 0.63661977236758134308);
pub const M_2_SQRTPI = @as(f64, 1.12837916709551257390);
pub const M_SQRT2 = @as(f64, 1.41421356237309504880);
pub const M_SQRT1_2 = @as(f64, 0.70710678118654752440);
pub const isgreater = @compileError("unable to translate macro: undefined identifier `__builtin_isgreater`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:1275:11
pub const isgreaterequal = @compileError("unable to translate macro: undefined identifier `__builtin_isgreaterequal`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:1276:11
pub const isless = @compileError("unable to translate macro: undefined identifier `__builtin_isless`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:1277:11
pub const islessequal = @compileError("unable to translate macro: undefined identifier `__builtin_islessequal`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:1278:11
pub const islessgreater = @compileError("unable to translate macro: undefined identifier `__builtin_islessgreater`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:1279:11
pub const isunordered = @compileError("unable to translate macro: undefined identifier `__builtin_isunordered`"); // /nix/store/fbbw928argckfii0j322346ihmllg7a7-glibc-2.42-61-dev/include/math.h:1280:11
pub const _wgpu_COMMA = @compileError("unable to translate C expr: unexpected token ','"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:68:9
pub const _wgpu_ENUM_ZERO_INIT = @compileError("unable to translate C expr: unexpected token 'a number'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:78:11
pub const _wgpu_STRUCT_ZERO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:79:11
pub inline fn _wgpu_MAKE_INIT_STRUCT(@"type": anytype, value: anytype) @TypeOf(@"type" ++ value) {
    _ = &@"type";
    _ = &value;
    return @"type" ++ value;
}
pub const WGPU_TRUE = UINT32_C(@as(c_int, 1));
pub const WGPU_FALSE = UINT32_C(@as(c_int, 0));
pub const WGPU_ARRAY_LAYER_COUNT_UNDEFINED = UINT32_MAX;
pub const WGPU_COPY_STRIDE_UNDEFINED = UINT32_MAX;
pub const WGPU_DEPTH_CLEAR_VALUE_UNDEFINED = NAN;
pub const WGPU_DEPTH_SLICE_UNDEFINED = UINT32_MAX;
pub const WGPU_LIMIT_U32_UNDEFINED = UINT32_MAX;
pub const WGPU_LIMIT_U64_UNDEFINED = UINT64_MAX;
pub const WGPU_MIP_LEVEL_COUNT_UNDEFINED = UINT32_MAX;
pub const WGPU_QUERY_SET_INDEX_UNDEFINED = UINT32_MAX;
pub const WGPU_STRLEN = SIZE_MAX;
pub const WGPU_WHOLE_MAP_SIZE = SIZE_MAX;
pub const WGPU_WHOLE_SIZE = UINT64_MAX;
pub const WGPU_STRING_VIEW_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:201:9
pub const WGPU_BUFFER_MAP_CALLBACK_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1548:9
pub const WGPU_COMPILATION_INFO_CALLBACK_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1572:9
pub const WGPU_CREATE_COMPUTE_PIPELINE_ASYNC_CALLBACK_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1596:9
pub const WGPU_CREATE_RENDER_PIPELINE_ASYNC_CALLBACK_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1620:9
pub const WGPU_DEVICE_LOST_CALLBACK_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1644:9
pub const WGPU_POP_ERROR_SCOPE_CALLBACK_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1668:9
pub const WGPU_QUEUE_WORK_DONE_CALLBACK_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1692:9
pub const WGPU_REQUEST_ADAPTER_CALLBACK_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1716:9
pub const WGPU_REQUEST_DEVICE_CALLBACK_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1740:9
pub const WGPU_UNCAPTURED_ERROR_CALLBACK_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1758:9
pub const WGPU_ADAPTER_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1825:9
pub const WGPU_BLEND_COMPONENT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1869:9
pub const WGPU_BUFFER_BINDING_LAYOUT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1900:9
pub const WGPU_BUFFER_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1939:9
pub const WGPU_COLOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1976:9
pub const WGPU_COMMAND_BUFFER_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:1999:9
pub const WGPU_COMMAND_ENCODER_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2020:9
pub const WGPU_COMPATIBILITY_MODE_LIMITS_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2055:9
pub const WGPU_COMPILATION_MESSAGE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2117:9
pub const WGPU_CONSTANT_ENTRY_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2151:9
pub const WGPU_EXTENT_3D_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2178:9
pub const WGPU_EXTERNAL_TEXTURE_BINDING_ENTRY_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2200:9
pub const WGPU_EXTERNAL_TEXTURE_BINDING_LAYOUT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2220:9
pub const WGPU_FUTURE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2244:9
pub const WGPU_INSTANCE_LIMITS_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2264:9
pub const WGPU_MULTISAMPLE_STATE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2291:9
pub const WGPU_ORIGIN_3D_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2319:9
pub const WGPU_PASS_TIMESTAMP_WRITES_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2349:9
pub const WGPU_PIPELINE_LAYOUT_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2384:9
pub const WGPU_PRIMITIVE_STATE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2431:9
pub const WGPU_QUERY_SET_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2464:9
pub const WGPU_QUEUE_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2487:9
pub const WGPU_RENDER_BUNDLE_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2508:9
pub const WGPU_RENDER_BUNDLE_ENCODER_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2553:9
pub const WGPU_RENDER_PASS_DEPTH_STENCIL_ATTACHMENT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2617:9
pub const WGPU_RENDER_PASS_MAX_DRAW_COUNT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2644:9
pub const WGPU_REQUEST_ADAPTER_WEBXR_OPTIONS_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2670:9
pub const WGPU_SAMPLER_BINDING_LAYOUT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2695:9
pub const WGPU_SAMPLER_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2782:9
pub const WGPU_SHADER_SOURCE_SPIRV_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2815:9
pub const WGPU_SHADER_SOURCE_WGSL_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2840:9
pub const WGPU_STENCIL_FACE_STATE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2885:9
pub const WGPU_STORAGE_TEXTURE_BINDING_LAYOUT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2920:9
pub const WGPU_SUPPORTED_FEATURES_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2944:9
pub const WGPU_SUPPORTED_INSTANCE_FEATURES_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2966:9
pub const WGPU_SUPPORTED_WGSL_LANGUAGE_FEATURES_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:2988:9
pub const WGPU_SURFACE_CAPABILITIES_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3044:9
pub const WGPU_SURFACE_COLOR_MANAGEMENT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3075:9
pub const WGPU_SURFACE_CONFIGURATION_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3156:9
pub const WGPU_SURFACE_SOURCE_ANDROID_NATIVE_WINDOW_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3187:9
pub const WGPU_SURFACE_SOURCE_METAL_LAYER_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3213:9
pub const WGPU_SURFACE_SOURCE_WAYLAND_SURFACE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3245:9
pub const WGPU_SURFACE_SOURCE_WINDOWS_HWND_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3279:9
pub const WGPU_SURFACE_SOURCE_XCB_WINDOW_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3312:9
pub const WGPU_SURFACE_SOURCE_XLIB_WINDOW_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3345:9
pub const WGPU_SURFACE_TEXTURE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3380:9
pub const WGPU_TEXEL_COPY_BUFFER_LAYOUT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3407:9
pub const WGPU_TEXTURE_BINDING_LAYOUT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3441:9
pub const WGPU_TEXTURE_BINDING_VIEW_DIMENSION_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3466:9
pub const WGPU_TEXTURE_COMPONENT_SWIZZLE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3524:9
pub const WGPU_VERTEX_ATTRIBUTE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3553:9
pub const WGPU_BIND_GROUP_ENTRY_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3612:9
pub const WGPU_BIND_GROUP_LAYOUT_ENTRY_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3662:9
pub const WGPU_BLEND_STATE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3690:9
pub const WGPU_COMPILATION_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3716:9
pub const WGPU_COMPUTE_PASS_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3742:9
pub const WGPU_COMPUTE_STATE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3776:9
pub const WGPU_DEPTH_STENCIL_STATE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3842:9
pub const WGPU_FUTURE_WAIT_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3879:9
pub const WGPU_INSTANCE_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:3906:9
pub const WGPU_LIMITS_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4051:9
pub const WGPU_RENDER_PASS_COLOR_ATTACHMENT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4124:9
pub const WGPU_REQUEST_ADAPTER_OPTIONS_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4180:9
pub const WGPU_SHADER_MODULE_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4205:9
pub const WGPU_SURFACE_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4232:9
pub const WGPU_TEXEL_COPY_BUFFER_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4254:9
pub const WGPU_TEXEL_COPY_TEXTURE_INFO_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4287:9
pub const WGPU_TEXTURE_COMPONENT_SWIZZLE_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4308:9
pub const WGPU_TEXTURE_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4367:9
pub const WGPU_VERTEX_BUFFER_LAYOUT_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4419:9
pub const WGPU_BIND_GROUP_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4455:9
pub const WGPU_BIND_GROUP_LAYOUT_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4487:9
pub const WGPU_COLOR_TARGET_STATE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4520:9
pub const WGPU_COMPUTE_PIPELINE_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4551:9
pub const WGPU_DEVICE_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4603:9
pub const WGPU_RENDER_PASS_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4650:9
pub const WGPU_TEXTURE_VIEW_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4711:9
pub const WGPU_VERTEX_STATE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4760:9
pub const WGPU_FRAGMENT_STATE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4806:9
pub const WGPU_RENDER_PIPELINE_DESCRIPTOR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/webgpu-headers/webgpu.h:4856:9
pub const WGPU_NATIVE_LIMITS_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /home/toasty/z-wgpu-native/vendor/wgpu-native/ffi/wgpu.h:1223:9
pub const WGPUAdapterImpl = struct_WGPUAdapterImpl;
pub const WGPUBindGroupImpl = struct_WGPUBindGroupImpl;
pub const WGPUBindGroupLayoutImpl = struct_WGPUBindGroupLayoutImpl;
pub const WGPUBufferImpl = struct_WGPUBufferImpl;
pub const WGPUCommandBufferImpl = struct_WGPUCommandBufferImpl;
pub const WGPUCommandEncoderImpl = struct_WGPUCommandEncoderImpl;
pub const WGPUComputePassEncoderImpl = struct_WGPUComputePassEncoderImpl;
pub const WGPUComputePipelineImpl = struct_WGPUComputePipelineImpl;
pub const WGPUDeviceImpl = struct_WGPUDeviceImpl;
pub const WGPUExternalTextureImpl = struct_WGPUExternalTextureImpl;
pub const WGPUInstanceImpl = struct_WGPUInstanceImpl;
pub const WGPUPipelineLayoutImpl = struct_WGPUPipelineLayoutImpl;
pub const WGPUQuerySetImpl = struct_WGPUQuerySetImpl;
pub const WGPUQueueImpl = struct_WGPUQueueImpl;
pub const WGPURenderBundleImpl = struct_WGPURenderBundleImpl;
pub const WGPURenderBundleEncoderImpl = struct_WGPURenderBundleEncoderImpl;
pub const WGPURenderPassEncoderImpl = struct_WGPURenderPassEncoderImpl;
pub const WGPURenderPipelineImpl = struct_WGPURenderPipelineImpl;
pub const WGPUSamplerImpl = struct_WGPUSamplerImpl;
pub const WGPUShaderModuleImpl = struct_WGPUShaderModuleImpl;
pub const WGPUSurfaceImpl = struct_WGPUSurfaceImpl;
pub const WGPUTextureImpl = struct_WGPUTextureImpl;
pub const WGPUTextureViewImpl = struct_WGPUTextureViewImpl;
