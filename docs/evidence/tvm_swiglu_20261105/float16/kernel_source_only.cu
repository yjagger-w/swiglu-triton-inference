
#ifdef __CUDACC_RTC__
  #include <cuda/std/cstdint>
  using cuda::std::uint8_t;
  using cuda::std::uint16_t;
  using cuda::std::uint32_t;
  using cuda::std::uint64_t;
  using cuda::std::int8_t;
  using cuda::std::int16_t;
  using cuda::std::int32_t;
  using cuda::std::int64_t;

  #include <cuda/std/type_traits>
  namespace std {
    using cuda::std::is_same;
    using cuda::std::is_same_v;
    using cuda::std::is_integral;
    using cuda::std::is_signed;
    using cuda::std::is_unsigned;
    using cuda::std::is_floating_point;
    using cuda::std::enable_if;
    using cuda::std::conditional;
  }

  // NVRTC uses asm/volatile instead of __asm__/__volatile__ (gcc extension).
  #ifndef __asm__
  #define __asm__ asm
  #endif
  #ifndef __volatile__
  #define __volatile__ volatile
  #endif
#else
  #include <cstdint>
  #include <type_traits>
  #include <cuda.h>
#endif

#if defined(__CUDA_ARCH__) && (__CUDA_ARCH__ >= 530)
#include <cuda_fp16.h>
__device__ half max(half a, half b)
{
  return __hgt(__half(a), __half(b)) ? a : b;
}
__device__ half min(half a, half b)
{
  return __hlt(__half(a), __half(b)) ? a : b;
}
#endif // __CUDA_ARCH__ >= 530

// Pack two half values.
static inline __device__ __host__ unsigned
__pack_half2(const half x, const half y) {
  unsigned v0 = *((unsigned short *)&x);
  unsigned v1 = *((unsigned short *)&y);
  return (v1 << 16) | v0;
}

#define CUDA_UNSUPPORTED_HALF_MATH_BINARY(HALF_MATH_NAME, FP32_MATH_NAME) \
static inline __device__ __host__ half HALF_MATH_NAME(half x, half y) {   \
  float tmp_x = __half2float(x);                                          \
  float tmp_y = __half2float(y);                                          \
  float result = FP32_MATH_NAME(tmp_x, tmp_y);                            \
  return __float2half(result);                                            \
}

#define CUDA_UNSUPPORTED_HALF_MATH_UNARY(HALF_MATH_NAME, FP32_MATH_NAME) \
static inline __device__ __host__ half HALF_MATH_NAME(half x) {          \
  float tmp_x = __half2float(x);                                         \
  float result = FP32_MATH_NAME(tmp_x);                                  \
  return __float2half(result);                                           \
}

// Some fp16 math functions are not supported in cuda_fp16.h,
// so we define them here to make sure the generated CUDA code
// is valid.
#if defined(__CUDA_ARCH__)
#if (__CUDA_ARCH__ >= 530)
CUDA_UNSUPPORTED_HALF_MATH_BINARY(hpow, powf)
#if ((__CUDACC_VER_MAJOR__ < 12) || ((__CUDACC_VER_MAJOR__ == 12) && (__CUDACC_VER_MINOR__ < 8)))
CUDA_UNSUPPORTED_HALF_MATH_UNARY(htanh, tanhf)
#endif
CUDA_UNSUPPORTED_HALF_MATH_UNARY(htan, tanf)
CUDA_UNSUPPORTED_HALF_MATH_UNARY(hatan, atanf)
CUDA_UNSUPPORTED_HALF_MATH_UNARY(herf, erf)
#else
CUDA_UNSUPPORTED_HALF_MATH_UNARY(hexp, exp)
#endif
#endif

#undef CUDA_UNSUPPORTED_HALF_MATH_BINARY
#undef CUDA_UNSUPPORTED_HALF_MATH_UNARY

template <typename T, typename TVec2>
struct __align__(8) half4_bfloat164 {
  T x, y, z, w;
  __host__ __device__ half4_bfloat164() : x(T(0)), y(T(0)), z(T(0)), w(T(0)) {}
  __host__ __device__ half4_bfloat164(T x, T y, T z, T w) : x(x), y(y), z(z), w(w) {}

};

using half4 = half4_bfloat164<__half, __half2>;
__host__ __device__ half4 make_half4(__half x, __half y, __half z, __half w) {
    return half4(x, y, z, w);
}

#if (((__CUDACC_VER_MAJOR__ == 11) && (__CUDACC_VER_MINOR__ >= 4)) || \
     (__CUDACC_VER_MAJOR__ > 11))
#define TVM_ENABLE_L2_PREFETCH 1
#else
#define TVM_ENABLE_L2_PREFETCH 0
#endif

#ifdef _WIN32
  using uint = unsigned int;
  using uchar = unsigned char;
  using ushort = unsigned short;
  using int64_t = long long;
  using uint64_t = unsigned long long;
#else
  #define uint unsigned int
  #define uchar unsigned char
  #define ushort unsigned short
#endif
extern "C" __global__ void __launch_bounds__(128) main_kernel(half* __restrict__ gate, half* __restrict__ swiglu, half* __restrict__ up);
extern "C" __global__ void __launch_bounds__(128) main_kernel(half* __restrict__ gate, half* __restrict__ swiglu, half* __restrict__ up) {
  for (int i0_2_s = 0; i0_2_s < 2; ++i0_2_s) {
    int cse_v1 = (((((int)blockIdx.x) * 256) + (((int)threadIdx.x) * 2)) + i0_2_s);
    if ((((((int)blockIdx.x) * 256) + (((int)threadIdx.x) * 2)) + i0_2_s) < 1025) {
      swiglu[(((((int)blockIdx.x) * 256) + (((int)threadIdx.x) * 2)) + i0_2_s)] = ((half)(((float)((half)__fdiv_rn(((float)gate[(((((int)blockIdx.x) * 256) + (((int)threadIdx.x) * 2)) + i0_2_s)]), (0x1.0000000000000p+0f/*1.000000e+00*/ + expf((((float)gate[(((((int)blockIdx.x) * 256) + (((int)threadIdx.x) * 2)) + i0_2_s)]) * -0x1.0000000000000p+0f/*-1.000000e+00*/)))))) * ((float)up[(((((int)blockIdx.x) * 256) + (((int)threadIdx.x) * 2)) + i0_2_s)])));
    }
  }
}

