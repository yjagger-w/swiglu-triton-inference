
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
extern "C" __global__ void __launch_bounds__(1024) fused_contract_silu_multiply_kernel(float* __restrict__ gate, float* __restrict__ silu);
extern "C" __global__ void __launch_bounds__(1024) fused_contract_silu_multiply_kernel_1(float* __restrict__ T_multiply, float* __restrict__ silu, float* __restrict__ up);
extern "C" __global__ void __launch_bounds__(1024) fused_contract_silu_multiply_kernel(float* __restrict__ gate, float* __restrict__ silu) {
  for (int i0_i1_fused_0 = 0; i0_i1_fused_0 < 3; ++i0_i1_fused_0) {
    if (((i0_i1_fused_0 * 4) + (((int)blockIdx.x) >> 6)) < 11) {
      int cse_v1 = (((i0_i1_fused_0 * 262144) + (((int)blockIdx.x) * 1024)) + ((int)threadIdx.x));
      silu[(((i0_i1_fused_0 * 262144) + (((int)blockIdx.x) * 1024)) + ((int)threadIdx.x))] = __fdiv_rn(gate[(((i0_i1_fused_0 * 262144) + (((int)blockIdx.x) * 1024)) + ((int)threadIdx.x))], (0x1p+0f/*1.000000e+00*/ + expf((gate[(((i0_i1_fused_0 * 262144) + (((int)blockIdx.x) * 1024)) + ((int)threadIdx.x))] * -0x1p+0f/*-1.000000e+00*/))));
    }
  }
}

extern "C" __global__ void __launch_bounds__(1024) fused_contract_silu_multiply_kernel_1(float* __restrict__ T_multiply, float* __restrict__ silu, float* __restrict__ up) {
  for (int ax0_ax1_fused_0 = 0; ax0_ax1_fused_0 < 3; ++ax0_ax1_fused_0) {
    if (((ax0_ax1_fused_0 * 4) + (((int)blockIdx.x) >> 6)) < 11) {
      int cse_v2 = (((ax0_ax1_fused_0 * 262144) + (((int)blockIdx.x) * 1024)) + ((int)threadIdx.x));
      T_multiply[(((ax0_ax1_fused_0 * 262144) + (((int)blockIdx.x) * 1024)) + ((int)threadIdx.x))] = (silu[(((ax0_ax1_fused_0 * 262144) + (((int)blockIdx.x) * 1024)) + ((int)threadIdx.x))] * up[(((ax0_ax1_fused_0 * 262144) + (((int)blockIdx.x) * 1024)) + ((int)threadIdx.x))]);
    }
  }
}

