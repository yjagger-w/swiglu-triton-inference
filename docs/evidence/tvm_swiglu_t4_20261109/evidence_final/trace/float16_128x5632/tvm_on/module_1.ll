; ModuleID = 'TVMMod'
source_filename = "TVMMod"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-conda-linux-gnu"

%0 = type { i32, i32, double }

@__tvm_ffi__library_ctx = linkonce dllexport local_unnamed_addr global ptr null, align 8
@__TVMFFIFunctionCall = linkonce dllexport local_unnamed_addr global ptr null, align 8
@__TVMBackendGetFuncFromEnv = linkonce dllexport local_unnamed_addr global ptr null, align 8
@.str = private constant [10 x i8] c"TypeError\00", align 1
@.str.1 = private constant [10 x i8] c"Expected \00", align 1
@.str.2 = private constant [2 x i8] c"3\00", align 1
@.str.3 = private constant [11 x i8] c" arguments\00", align 1
@.str.4 = private constant [19 x i8] c" when calling:\0A  `\00", align 1
@.str.5 = private constant [139 x i8] c"custom_swiglu_float16_128x5632(gate: Tensor([128, 5632], float16), up: Tensor([128, 5632], float16), swiglu: Tensor([128, 5632], float16))\00", align 1
@.str.6 = private constant [2 x i8] c"`\00", align 1
@.str.7 = private constant [21 x i8] c"args pointer is NULL\00", align 1
@.str.8 = private constant [30 x i8] c"Mismatched type on argument #\00", align 1
@.str.9 = private constant [2 x i8] c"0\00", align 1
@.str.10 = private constant [15 x i8] c"`,\0A  expected \00", align 1
@.str.11 = private constant [7 x i8] c"Tensor\00", align 1
@.str.12 = private constant [2 x i8] c"1\00", align 1
@.str.13 = private constant [2 x i8] c"2\00", align 1
@.str.14 = private constant [11 x i8] c"ValueError\00", align 1
@.str.15 = private constant [12 x i8] c"Mismatched \00", align 1
@.str.16 = private constant [5 x i8] c"gate\00", align 1
@.str.17 = private constant [20 x i8] c".ndim on argument #\00", align 1
@.str.18 = private constant [21 x i8] c".dtype on argument #\00", align 1
@.str.19 = private constant [8 x i8] c"float16\00", align 1
@.str.20 = private constant [27 x i8] c".device_type on argument #\00", align 1
@.str.21 = private constant [5 x i8] c"cuda\00", align 1
@.str.22 = private constant [3 x i8] c"up\00", align 1
@.str.23 = private constant [7 x i8] c"swiglu\00", align 1
@.str.24 = private constant [23 x i8] c".strides on argument #\00", align 1
@.str.25 = private constant [34 x i8] c"`,\0A  expected to be compact array\00", align 1
@.str.26 = private constant [36 x i8] c" data pointer is NULL on argument #\00", align 1
@.str.27 = private constant [36 x i8] c"`,\0A  expected non-NULL data pointer\00", align 1
@.str.28 = private constant [13 x i8] c"up.device_id\00", align 1
@.str.29 = private constant [15 x i8] c" on argument #\00", align 1
@.str.30 = private constant [24 x i8] c"`,\0A  expected to match \00", align 1
@.str.31 = private constant [15 x i8] c"gate.device_id\00", align 1
@.str.32 = private constant [17 x i8] c"swiglu.device_id\00", align 1
@.str.33 = private constant [9 x i8] c"Invalid \00", align 1
@.str.34 = private constant [14 x i8] c"gate.shape[0]\00", align 1
@.str.35 = private constant [4 x i8] c"128\00", align 1
@.str.36 = private constant [14 x i8] c"gate.shape[1]\00", align 1
@.str.37 = private constant [5 x i8] c"5632\00", align 1
@.str.38 = private constant [17 x i8] c"gate.byte_offset\00", align 1
@.str.39 = private constant [12 x i8] c"up.shape[0]\00", align 1
@.str.40 = private constant [12 x i8] c"up.shape[1]\00", align 1
@.str.41 = private constant [15 x i8] c"up.byte_offset\00", align 1
@.str.42 = private constant [16 x i8] c"swiglu.shape[0]\00", align 1
@.str.43 = private constant [16 x i8] c"swiglu.shape[1]\00", align 1
@.str.44 = private constant [19 x i8] c"swiglu.byte_offset\00", align 1
@.tvm_func.__tvm_set_device = internal unnamed_addr global ptr null, align 8
@.str.45 = private constant [17 x i8] c"__tvm_set_device\00", align 1
@.tvm_func.custom_swiglu_float16_128x5632_kernel = internal unnamed_addr global ptr null, align 8
@.str.46 = private constant [38 x i8] c"custom_swiglu_float16_128x5632_kernel\00", align 1
@llvm.global_ctors = appending global [0 x { i32, ptr, ptr }] zeroinitializer

define dllexport i32 @__tvm_ffi_custom_swiglu_float16_128x5632(ptr noalias readnone captures(none) %self_handle, ptr noalias readonly captures(address_is_null) %args, i32 %num_args, ptr noalias readnone captures(none) %result) local_unnamed_addr #0 !dbg !5 {
entry:
    #dbg_value(ptr poison, !11, !DIExpression(), !15)
    #dbg_value(ptr %args, !12, !DIExpression(), !15)
    #dbg_value(i32 %num_args, !13, !DIExpression(), !15)
    #dbg_value(ptr poison, !14, !DIExpression(), !15)
  %0 = alloca ptr, align 8, !dbg !15
  %stack_ffi_any79 = alloca [6 x %0], align 8, !dbg !15
    #dbg_declare(ptr %stack_ffi_any79, !16, !DIExpression(), !15)
    #dbg_declare(ptr %stack_ffi_any79, !16, !DIExpression(), !15)
  %1 = icmp eq i32 %num_args, 3, !dbg !15
  br i1 %1, label %assert_end, label %assert_fail, !dbg !15, !prof !17

common.ret:                                       ; preds = %call_end72, %handle_init_end, %handle_init, %assert_fail69, %assert_fail67, %assert_fail65, %assert_fail63, %assert_fail61, %assert_fail59, %assert_fail57, %assert_fail55, %assert_fail53, %assert_fail51, %assert_fail49, %assert_fail47, %assert_fail43, %assert_fail41, %assert_fail39, %assert_fail35, %assert_fail33, %assert_fail31, %assert_fail29, %assert_fail27, %assert_fail25, %assert_fail23, %assert_fail21, %assert_fail19, %assert_fail17, %assert_fail15, %assert_fail13, %assert_fail11, %assert_fail9, %assert_fail7, %assert_fail5, %assert_fail3, %assert_fail1, %assert_fail
  %common.ret.op = phi i32 [ -1, %assert_fail ], [ -1, %assert_fail1 ], [ -1, %assert_fail3 ], [ -1, %assert_fail5 ], [ -1, %assert_fail7 ], [ -1, %assert_fail9 ], [ -1, %assert_fail11 ], [ -1, %assert_fail13 ], [ -1, %assert_fail15 ], [ -1, %assert_fail17 ], [ -1, %assert_fail19 ], [ -1, %assert_fail21 ], [ -1, %assert_fail23 ], [ -1, %assert_fail25 ], [ -1, %assert_fail27 ], [ -1, %assert_fail29 ], [ -1, %assert_fail31 ], [ -1, %assert_fail33 ], [ -1, %assert_fail35 ], [ -1, %assert_fail39 ], [ -1, %assert_fail41 ], [ -1, %assert_fail43 ], [ -1, %assert_fail47 ], [ -1, %assert_fail49 ], [ -1, %assert_fail51 ], [ -1, %assert_fail53 ], [ -1, %assert_fail55 ], [ -1, %assert_fail57 ], [ -1, %assert_fail59 ], [ -1, %assert_fail61 ], [ -1, %assert_fail63 ], [ -1, %assert_fail65 ], [ -1, %assert_fail67 ], [ -1, %assert_fail69 ], [ %148, %handle_init_end ], [ %145, %handle_init ], [ %151, %call_end72 ]
  ret i32 %common.ret.op, !dbg !15

assert_fail:                                      ; preds = %entry
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.1, ptr nonnull @.str.2, ptr nonnull @.str.3, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.6), !dbg !15
  br label %common.ret, !dbg !15

assert_end:                                       ; preds = %entry
  %.not = icmp eq ptr %args, null, !dbg !15
  br i1 %.not, label %assert_fail1, label %assert_end2, !dbg !15, !prof !18

assert_fail1:                                     ; preds = %assert_end
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 4, ptr nonnull @.str.7, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.6, ptr null, ptr null), !dbg !15
  br label %common.ret, !dbg !15

assert_end2:                                      ; preds = %assert_end
  %var_gate.type_index = load i32, ptr %args, align 4, !dbg !15
    #dbg_value(i32 %var_gate.type_index, !19, !DIExpression(), !15)
    #dbg_value(i32 %var_gate.type_index, !19, !DIExpression(), !15)
  %var_gate.type_index.fr = freeze i32 %var_gate.type_index, !dbg !15
  %2 = icmp sgt i32 %var_gate.type_index.fr, 63, !dbg !15
  br i1 %2, label %assert_end4, label %switch.early.test, !dbg !15

switch.early.test:                                ; preds = %assert_end2
  switch i32 %var_gate.type_index.fr, label %assert_fail3 [
    i32 7, label %assert_end4
    i32 4, label %assert_end4
    i32 0, label %assert_end4
  ], !dbg !15, !prof !20

assert_fail3:                                     ; preds = %switch.early.test
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.9, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end4:                                      ; preds = %switch.early.test, %switch.early.test, %switch.early.test, %assert_end2
  %3 = getelementptr inbounds nuw i8, ptr %args, i64 8, !dbg !15
  %4 = load ptr, ptr %3, align 8, !dbg !15
  %5 = icmp eq i32 %var_gate.type_index.fr, 70, !dbg !15
  %var_gate.idx = select i1 %5, i64 24, i64 0, !dbg !15
  %var_gate = getelementptr inbounds nuw i8, ptr %4, i64 %var_gate.idx, !dbg !15
    #dbg_declare(ptr %var_gate, !21, !DIExpression(), !15)
    #dbg_declare(ptr %var_gate, !21, !DIExpression(), !15)
  %6 = getelementptr inbounds nuw i8, ptr %args, i64 16, !dbg !15
  %var_up.type_index = load i32, ptr %6, align 8, !dbg !15
    #dbg_value(i32 %var_up.type_index, !22, !DIExpression(), !15)
    #dbg_value(i32 %var_up.type_index, !22, !DIExpression(), !15)
  %var_up.type_index.fr = freeze i32 %var_up.type_index, !dbg !15
  %7 = icmp sgt i32 %var_up.type_index.fr, 63, !dbg !15
  br i1 %7, label %assert_end6, label %switch.early.test75, !dbg !15

switch.early.test75:                              ; preds = %assert_end4
  switch i32 %var_up.type_index.fr, label %assert_fail5 [
    i32 7, label %assert_end6
    i32 4, label %assert_end6
    i32 0, label %assert_end6
  ], !dbg !15, !prof !20

assert_fail5:                                     ; preds = %switch.early.test75
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.12, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end6:                                      ; preds = %switch.early.test75, %switch.early.test75, %switch.early.test75, %assert_end4
  %8 = getelementptr inbounds nuw i8, ptr %args, i64 24, !dbg !15
  %9 = load ptr, ptr %8, align 8, !dbg !15
  %10 = icmp eq i32 %var_up.type_index.fr, 70, !dbg !15
  %var_up.idx = select i1 %10, i64 24, i64 0, !dbg !15
  %var_up = getelementptr inbounds nuw i8, ptr %9, i64 %var_up.idx, !dbg !15
    #dbg_declare(ptr %var_up, !23, !DIExpression(), !15)
    #dbg_declare(ptr %var_up, !23, !DIExpression(), !15)
  %11 = getelementptr inbounds nuw i8, ptr %args, i64 32, !dbg !15
  %var_swiglu.type_index = load i32, ptr %11, align 8, !dbg !15
    #dbg_value(i32 %var_swiglu.type_index, !24, !DIExpression(), !15)
    #dbg_value(i32 %var_swiglu.type_index, !24, !DIExpression(), !15)
  %var_swiglu.type_index.fr = freeze i32 %var_swiglu.type_index, !dbg !15
  %12 = icmp sgt i32 %var_swiglu.type_index.fr, 63, !dbg !15
  br i1 %12, label %assert_end8, label %switch.early.test76, !dbg !15

switch.early.test76:                              ; preds = %assert_end6
  switch i32 %var_swiglu.type_index.fr, label %assert_fail7 [
    i32 7, label %assert_end8
    i32 4, label %assert_end8
    i32 0, label %assert_end8
  ], !dbg !15, !prof !20

assert_fail7:                                     ; preds = %switch.early.test76
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.13, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end8:                                      ; preds = %switch.early.test76, %switch.early.test76, %switch.early.test76, %assert_end6
  %13 = getelementptr inbounds nuw i8, ptr %args, i64 40, !dbg !15
  %14 = load ptr, ptr %13, align 8, !dbg !15
  %15 = icmp eq i32 %var_swiglu.type_index.fr, 70, !dbg !15
  %var_swiglu.idx = select i1 %15, i64 24, i64 0, !dbg !15
  %var_swiglu = getelementptr inbounds nuw i8, ptr %14, i64 %var_swiglu.idx, !dbg !15
    #dbg_declare(ptr %var_swiglu, !25, !DIExpression(), !15)
    #dbg_declare(ptr %var_swiglu, !25, !DIExpression(), !15)
  %.not80 = icmp eq ptr %4, null, !dbg !15
  br i1 %.not80, label %assert_fail9, label %assert_end10, !dbg !15, !prof !18

assert_fail9:                                     ; preds = %assert_end8
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.9, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end10:                                     ; preds = %assert_end8
  %16 = getelementptr inbounds nuw i8, ptr %var_gate, i64 16, !dbg !15
  %17 = load i32, ptr %16, align 4, !dbg !15
  %18 = icmp eq i32 %17, 2, !dbg !15
  br i1 %18, label %assert_end12, label %assert_fail11, !dbg !15, !prof !17

assert_fail11:                                    ; preds = %assert_end10
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.16, ptr nonnull @.str.17, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.13), !dbg !15
  br label %common.ret, !dbg !15

assert_end12:                                     ; preds = %assert_end10
  %19 = getelementptr inbounds nuw i8, ptr %var_gate, i64 22, !dbg !15
  %20 = load i16, ptr %19, align 2, !dbg !15
  %21 = icmp eq i16 %20, 1, !dbg !15
  %22 = getelementptr inbounds nuw i8, ptr %var_gate, i64 21, !dbg !15
  %23 = load i8, ptr %22, align 1, !dbg !15
  %24 = icmp eq i8 %23, 16, !dbg !15
  %25 = getelementptr inbounds nuw i8, ptr %var_gate, i64 20, !dbg !15
  %26 = load i8, ptr %25, align 2, !dbg !15
  %27 = icmp eq i8 %26, 2, !dbg !15
  %28 = and i1 %24, %27, !dbg !15
  %29 = and i1 %21, %28, !dbg !15
  br i1 %29, label %assert_end14, label %assert_fail13, !dbg !15, !prof !17

assert_fail13:                                    ; preds = %assert_end12
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.16, ptr nonnull @.str.18, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.19), !dbg !15
  br label %common.ret, !dbg !15

assert_end14:                                     ; preds = %assert_end12
  %30 = getelementptr inbounds nuw i8, ptr %var_gate, i64 24, !dbg !15
  %custom_swiglu_float16_128x5632.var_gate_shape = load ptr, ptr %30, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_gate_shape, !26, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_gate_shape, !26, !DIExpression(), !15)
  %31 = getelementptr inbounds nuw i8, ptr %var_gate, i64 32, !dbg !15
  %custom_swiglu_float16_128x5632.var_gate_strides = load ptr, ptr %31, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_gate_strides, !27, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_gate_strides, !27, !DIExpression(), !15)
  %32 = getelementptr inbounds nuw i8, ptr %var_gate, i64 8, !dbg !15
  %33 = load i32, ptr %32, align 8, !dbg !15
  %34 = icmp eq i32 %33, 2, !dbg !15
  br i1 %34, label %assert_end16, label %assert_fail15, !dbg !15, !prof !17

assert_fail15:                                    ; preds = %assert_end14
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.16, ptr nonnull @.str.20, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.21), !dbg !15
  br label %common.ret, !dbg !15

assert_end16:                                     ; preds = %assert_end14
  %35 = getelementptr inbounds nuw i8, ptr %var_gate, i64 12, !dbg !15
  %dev_id = load i32, ptr %35, align 4, !dbg !15
    #dbg_value(i32 %dev_id, !28, !DIExpression(), !15)
    #dbg_value(i32 %dev_id, !28, !DIExpression(), !15)
  %gate = load ptr, ptr %var_gate, align 8, !dbg !15
    #dbg_declare(ptr %gate, !29, !DIExpression(), !15)
    #dbg_declare(ptr %gate, !29, !DIExpression(), !15)
  call void @llvm.assume(i1 true) [ "align"(ptr %gate, i64 64) ], !dbg !15
  %.not81 = icmp eq ptr %9, null, !dbg !15
  br i1 %.not81, label %assert_fail17, label %assert_end18, !dbg !15, !prof !18

assert_fail17:                                    ; preds = %assert_end16
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.12, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end18:                                     ; preds = %assert_end16
  %36 = getelementptr inbounds nuw i8, ptr %var_up, i64 16, !dbg !15
  %37 = load i32, ptr %36, align 4, !dbg !15
  %38 = icmp eq i32 %37, 2, !dbg !15
  br i1 %38, label %assert_end20, label %assert_fail19, !dbg !15, !prof !17

assert_fail19:                                    ; preds = %assert_end18
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.22, ptr nonnull @.str.17, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.13), !dbg !15
  br label %common.ret, !dbg !15

assert_end20:                                     ; preds = %assert_end18
  %39 = getelementptr inbounds nuw i8, ptr %var_up, i64 22, !dbg !15
  %40 = load i16, ptr %39, align 2, !dbg !15
  %41 = icmp eq i16 %40, 1, !dbg !15
  %42 = getelementptr inbounds nuw i8, ptr %var_up, i64 21, !dbg !15
  %43 = load i8, ptr %42, align 1, !dbg !15
  %44 = icmp eq i8 %43, 16, !dbg !15
  %45 = getelementptr inbounds nuw i8, ptr %var_up, i64 20, !dbg !15
  %46 = load i8, ptr %45, align 2, !dbg !15
  %47 = icmp eq i8 %46, 2, !dbg !15
  %48 = and i1 %44, %47, !dbg !15
  %49 = and i1 %41, %48, !dbg !15
  br i1 %49, label %assert_end22, label %assert_fail21, !dbg !15, !prof !17

assert_fail21:                                    ; preds = %assert_end20
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.22, ptr nonnull @.str.18, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.19), !dbg !15
  br label %common.ret, !dbg !15

assert_end22:                                     ; preds = %assert_end20
  %50 = getelementptr inbounds nuw i8, ptr %var_up, i64 24, !dbg !15
  %custom_swiglu_float16_128x5632.var_up_shape = load ptr, ptr %50, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_up_shape, !32, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_up_shape, !32, !DIExpression(), !15)
  %51 = getelementptr inbounds nuw i8, ptr %var_up, i64 32, !dbg !15
  %custom_swiglu_float16_128x5632.var_up_strides = load ptr, ptr %51, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_up_strides, !33, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_up_strides, !33, !DIExpression(), !15)
  %52 = getelementptr inbounds nuw i8, ptr %var_up, i64 8, !dbg !15
  %53 = load i32, ptr %52, align 8, !dbg !15
  %54 = icmp eq i32 %53, 2, !dbg !15
  br i1 %54, label %assert_end24, label %assert_fail23, !dbg !15, !prof !17

assert_fail23:                                    ; preds = %assert_end22
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.22, ptr nonnull @.str.20, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.21), !dbg !15
  br label %common.ret, !dbg !15

assert_end24:                                     ; preds = %assert_end22
  %up = load ptr, ptr %var_up, align 8, !dbg !15
    #dbg_declare(ptr %up, !34, !DIExpression(), !15)
    #dbg_declare(ptr %up, !34, !DIExpression(), !15)
  call void @llvm.assume(i1 true) [ "align"(ptr %up, i64 64) ], !dbg !15
  %.not82 = icmp eq ptr %14, null, !dbg !15
  br i1 %.not82, label %assert_fail25, label %assert_end26, !dbg !15, !prof !18

assert_fail25:                                    ; preds = %assert_end24
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.13, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end26:                                     ; preds = %assert_end24
  %55 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 16, !dbg !15
  %56 = load i32, ptr %55, align 4, !dbg !15
  %57 = icmp eq i32 %56, 2, !dbg !15
  br i1 %57, label %assert_end28, label %assert_fail27, !dbg !15, !prof !17

assert_fail27:                                    ; preds = %assert_end26
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.23, ptr nonnull @.str.17, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.13), !dbg !15
  br label %common.ret, !dbg !15

assert_end28:                                     ; preds = %assert_end26
  %58 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 22, !dbg !15
  %59 = load i16, ptr %58, align 2, !dbg !15
  %60 = icmp eq i16 %59, 1, !dbg !15
  %61 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 21, !dbg !15
  %62 = load i8, ptr %61, align 1, !dbg !15
  %63 = icmp eq i8 %62, 16, !dbg !15
  %64 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 20, !dbg !15
  %65 = load i8, ptr %64, align 2, !dbg !15
  %66 = icmp eq i8 %65, 2, !dbg !15
  %67 = and i1 %63, %66, !dbg !15
  %68 = and i1 %60, %67, !dbg !15
  br i1 %68, label %assert_end30, label %assert_fail29, !dbg !15, !prof !17

assert_fail29:                                    ; preds = %assert_end28
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.23, ptr nonnull @.str.18, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.19), !dbg !15
  br label %common.ret, !dbg !15

assert_end30:                                     ; preds = %assert_end28
  %69 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 24, !dbg !15
  %custom_swiglu_float16_128x5632.var_swiglu_shape = load ptr, ptr %69, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_swiglu_shape, !35, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_swiglu_shape, !35, !DIExpression(), !15)
  %70 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 32, !dbg !15
  %custom_swiglu_float16_128x5632.var_swiglu_strides = load ptr, ptr %70, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_swiglu_strides, !36, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float16_128x5632.var_swiglu_strides, !36, !DIExpression(), !15)
  %71 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 8, !dbg !15
  %72 = load i32, ptr %71, align 8, !dbg !15
  %73 = icmp eq i32 %72, 2, !dbg !15
  br i1 %73, label %assert_end32, label %assert_fail31, !dbg !15, !prof !17

assert_fail31:                                    ; preds = %assert_end30
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.23, ptr nonnull @.str.20, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.21), !dbg !15
  br label %common.ret, !dbg !15

assert_end32:                                     ; preds = %assert_end30
  %swiglu = load ptr, ptr %var_swiglu, align 8, !dbg !15
    #dbg_declare(ptr %swiglu, !37, !DIExpression(), !15)
    #dbg_declare(ptr %swiglu, !37, !DIExpression(), !15)
  call void @llvm.assume(i1 true) [ "align"(ptr %swiglu, i64 64) ], !dbg !15
  %.not83 = icmp eq ptr %custom_swiglu_float16_128x5632.var_gate_strides, null, !dbg !15
  br i1 %.not83, label %if_end, label %if_then, !dbg !15, !prof !18

if_then:                                          ; preds = %assert_end32
  %74 = load i64, ptr %custom_swiglu_float16_128x5632.var_gate_strides, align 8, !dbg !15
  %75 = and i64 %74, 4294967295, !dbg !15
  %76 = icmp eq i64 %75, 5632, !dbg !15
  %77 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float16_128x5632.var_gate_strides, i64 8, !dbg !15
  %78 = load i64, ptr %77, align 8, !dbg !15
  %79 = and i64 %78, 4294967295, !dbg !15
  %80 = icmp eq i64 %79, 1, !dbg !15
  %81 = and i1 %76, %80, !dbg !15
  br i1 %81, label %if_end, label %assert_fail33, !dbg !15, !prof !17

if_end:                                           ; preds = %if_then, %assert_end32
  %.not84 = icmp eq ptr %gate, null, !dbg !15
  br i1 %.not84, label %assert_fail35, label %assert_end36, !dbg !15, !prof !18

assert_fail33:                                    ; preds = %if_then
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 7, ptr nonnull @.str.15, ptr nonnull @.str.16, ptr nonnull @.str.24, ptr nonnull @.str.9, ptr nonnull @.str.25, ptr null), !dbg !15
  br label %common.ret, !dbg !15

assert_fail35:                                    ; preds = %if_end
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str.14, i32 6, ptr nonnull @.str.16, ptr nonnull @.str.26, ptr nonnull @.str.9, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.27), !dbg !15
  br label %common.ret, !dbg !15

assert_end36:                                     ; preds = %if_end
  %.not85 = icmp eq ptr %custom_swiglu_float16_128x5632.var_up_strides, null, !dbg !15
  br i1 %.not85, label %if_end38, label %if_then37, !dbg !15, !prof !18

if_then37:                                        ; preds = %assert_end36
  %82 = load i64, ptr %custom_swiglu_float16_128x5632.var_up_strides, align 8, !dbg !15
  %83 = and i64 %82, 4294967295, !dbg !15
  %84 = icmp eq i64 %83, 5632, !dbg !15
  %85 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float16_128x5632.var_up_strides, i64 8, !dbg !15
  %86 = load i64, ptr %85, align 8, !dbg !15
  %87 = and i64 %86, 4294967295, !dbg !15
  %88 = icmp eq i64 %87, 1, !dbg !15
  %89 = and i1 %84, %88, !dbg !15
  br i1 %89, label %if_end38, label %assert_fail39, !dbg !15, !prof !17

if_end38:                                         ; preds = %if_then37, %assert_end36
  %90 = getelementptr inbounds nuw i8, ptr %var_up, i64 12, !dbg !15
  %91 = load i32, ptr %90, align 4, !dbg !15
  %92 = icmp eq i32 %dev_id, %91, !dbg !15
  br i1 %92, label %assert_end42, label %assert_fail41, !dbg !15, !prof !17

assert_fail39:                                    ; preds = %if_then37
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 7, ptr nonnull @.str.15, ptr nonnull @.str.22, ptr nonnull @.str.24, ptr nonnull @.str.12, ptr nonnull @.str.25, ptr null), !dbg !15
  br label %common.ret, !dbg !15

assert_fail41:                                    ; preds = %if_end38
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.28, ptr nonnull @.str.29, ptr nonnull @.str.12, ptr nonnull @.str.30, ptr nonnull @.str.31), !dbg !15
  br label %common.ret, !dbg !15

assert_end42:                                     ; preds = %if_end38
  %.not86 = icmp eq ptr %up, null, !dbg !15
  br i1 %.not86, label %assert_fail43, label %assert_end44, !dbg !15, !prof !18

assert_fail43:                                    ; preds = %assert_end42
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str.14, i32 6, ptr nonnull @.str.22, ptr nonnull @.str.26, ptr nonnull @.str.12, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.27), !dbg !15
  br label %common.ret, !dbg !15

assert_end44:                                     ; preds = %assert_end42
  %.not87 = icmp eq ptr %custom_swiglu_float16_128x5632.var_swiglu_strides, null, !dbg !15
  br i1 %.not87, label %if_end46, label %if_then45, !dbg !15, !prof !18

if_then45:                                        ; preds = %assert_end44
  %93 = load i64, ptr %custom_swiglu_float16_128x5632.var_swiglu_strides, align 8, !dbg !15
  %94 = and i64 %93, 4294967295, !dbg !15
  %95 = icmp eq i64 %94, 5632, !dbg !15
  %96 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float16_128x5632.var_swiglu_strides, i64 8, !dbg !15
  %97 = load i64, ptr %96, align 8, !dbg !15
  %98 = and i64 %97, 4294967295, !dbg !15
  %99 = icmp eq i64 %98, 1, !dbg !15
  %100 = and i1 %95, %99, !dbg !15
  br i1 %100, label %if_end46, label %assert_fail47, !dbg !15, !prof !17

if_end46:                                         ; preds = %if_then45, %assert_end44
  %101 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 12, !dbg !15
  %102 = load i32, ptr %101, align 4, !dbg !15
  %103 = icmp eq i32 %dev_id, %102, !dbg !15
  br i1 %103, label %assert_end50, label %assert_fail49, !dbg !15, !prof !17

assert_fail47:                                    ; preds = %if_then45
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 7, ptr nonnull @.str.15, ptr nonnull @.str.23, ptr nonnull @.str.24, ptr nonnull @.str.13, ptr nonnull @.str.25, ptr null), !dbg !15
  br label %common.ret, !dbg !15

assert_fail49:                                    ; preds = %if_end46
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.32, ptr nonnull @.str.29, ptr nonnull @.str.13, ptr nonnull @.str.30, ptr nonnull @.str.31), !dbg !15
  br label %common.ret, !dbg !15

assert_end50:                                     ; preds = %if_end46
  %.not88 = icmp eq ptr %swiglu, null, !dbg !15
  br i1 %.not88, label %assert_fail51, label %assert_end52, !dbg !15, !prof !18

assert_fail51:                                    ; preds = %assert_end50
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str.14, i32 6, ptr nonnull @.str.23, ptr nonnull @.str.26, ptr nonnull @.str.13, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.27), !dbg !15
  br label %common.ret, !dbg !15

assert_end52:                                     ; preds = %assert_end50
  %104 = load i64, ptr %custom_swiglu_float16_128x5632.var_gate_shape, align 8, !dbg !15
  %105 = and i64 %104, 4294967295, !dbg !15
  %106 = icmp eq i64 %105, 128, !dbg !15
  br i1 %106, label %assert_end54, label %assert_fail53, !dbg !15, !prof !17

assert_fail53:                                    ; preds = %assert_end52
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.34, ptr nonnull @.str.29, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.35), !dbg !15
  br label %common.ret, !dbg !15

assert_end54:                                     ; preds = %assert_end52
  %107 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float16_128x5632.var_gate_shape, i64 8, !dbg !15
  %108 = load i64, ptr %107, align 8, !dbg !15
  %109 = and i64 %108, 4294967295, !dbg !15
  %110 = icmp eq i64 %109, 5632, !dbg !15
  br i1 %110, label %assert_end56, label %assert_fail55, !dbg !15, !prof !17

assert_fail55:                                    ; preds = %assert_end54
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.36, ptr nonnull @.str.29, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.37), !dbg !15
  br label %common.ret, !dbg !15

assert_end56:                                     ; preds = %assert_end54
  %111 = getelementptr inbounds nuw i8, ptr %var_gate, i64 40, !dbg !15
  %112 = load i64, ptr %111, align 8, !dbg !15
  %113 = icmp eq i64 %112, 0, !dbg !15
  br i1 %113, label %assert_end58, label %assert_fail57, !dbg !15, !prof !17

assert_fail57:                                    ; preds = %assert_end56
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.38, ptr nonnull @.str.29, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.9), !dbg !15
  br label %common.ret, !dbg !15

assert_end58:                                     ; preds = %assert_end56
  %114 = load i64, ptr %custom_swiglu_float16_128x5632.var_up_shape, align 8, !dbg !15
  %115 = and i64 %114, 4294967295, !dbg !15
  %116 = icmp eq i64 %115, 128, !dbg !15
  br i1 %116, label %assert_end60, label %assert_fail59, !dbg !15, !prof !17

assert_fail59:                                    ; preds = %assert_end58
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.39, ptr nonnull @.str.29, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.35), !dbg !15
  br label %common.ret, !dbg !15

assert_end60:                                     ; preds = %assert_end58
  %117 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float16_128x5632.var_up_shape, i64 8, !dbg !15
  %118 = load i64, ptr %117, align 8, !dbg !15
  %119 = and i64 %118, 4294967295, !dbg !15
  %120 = icmp eq i64 %119, 5632, !dbg !15
  br i1 %120, label %assert_end62, label %assert_fail61, !dbg !15, !prof !17

assert_fail61:                                    ; preds = %assert_end60
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.40, ptr nonnull @.str.29, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.37), !dbg !15
  br label %common.ret, !dbg !15

assert_end62:                                     ; preds = %assert_end60
  %121 = getelementptr inbounds nuw i8, ptr %var_up, i64 40, !dbg !15
  %122 = load i64, ptr %121, align 8, !dbg !15
  %123 = icmp eq i64 %122, 0, !dbg !15
  br i1 %123, label %assert_end64, label %assert_fail63, !dbg !15, !prof !17

assert_fail63:                                    ; preds = %assert_end62
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.41, ptr nonnull @.str.29, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.9), !dbg !15
  br label %common.ret, !dbg !15

assert_end64:                                     ; preds = %assert_end62
  %124 = load i64, ptr %custom_swiglu_float16_128x5632.var_swiglu_shape, align 8, !dbg !15
  %125 = and i64 %124, 4294967295, !dbg !15
  %126 = icmp eq i64 %125, 128, !dbg !15
  br i1 %126, label %assert_end66, label %assert_fail65, !dbg !15, !prof !17

assert_fail65:                                    ; preds = %assert_end64
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.42, ptr nonnull @.str.29, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.35), !dbg !15
  br label %common.ret, !dbg !15

assert_end66:                                     ; preds = %assert_end64
  %127 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float16_128x5632.var_swiglu_shape, i64 8, !dbg !15
  %128 = load i64, ptr %127, align 8, !dbg !15
  %129 = and i64 %128, 4294967295, !dbg !15
  %130 = icmp eq i64 %129, 5632, !dbg !15
  br i1 %130, label %assert_end68, label %assert_fail67, !dbg !15, !prof !17

assert_fail67:                                    ; preds = %assert_end66
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.43, ptr nonnull @.str.29, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.37), !dbg !15
  br label %common.ret, !dbg !15

assert_end68:                                     ; preds = %assert_end66
  %131 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 40, !dbg !15
  %132 = load i64, ptr %131, align 8, !dbg !15
  %133 = icmp eq i64 %132, 0, !dbg !15
  br i1 %133, label %assert_end70, label %assert_fail69, !dbg !15, !prof !17

assert_fail69:                                    ; preds = %assert_end68
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.44, ptr nonnull @.str.29, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.9), !dbg !15
  br label %common.ret, !dbg !15

assert_end70:                                     ; preds = %assert_end68
  store i32 1, ptr %stack_ffi_any79, align 8, !dbg !15
  %134 = getelementptr inbounds nuw i8, ptr %stack_ffi_any79, i64 4, !dbg !15
  store i32 0, ptr %134, align 4, !dbg !15
  %135 = getelementptr inbounds nuw i8, ptr %stack_ffi_any79, i64 8, !dbg !15
  store i64 2, ptr %135, align 8, !dbg !15
  %136 = getelementptr inbounds nuw i8, ptr %stack_ffi_any79, i64 16, !dbg !15
  store i32 1, ptr %136, align 8, !dbg !15
  %137 = getelementptr inbounds nuw i8, ptr %stack_ffi_any79, i64 20, !dbg !15
  store i32 0, ptr %137, align 4, !dbg !15
  %138 = sext i32 %dev_id to i64, !dbg !15
  %139 = getelementptr inbounds nuw i8, ptr %stack_ffi_any79, i64 24, !dbg !15
  store i64 %138, ptr %139, align 8, !dbg !15
  %140 = getelementptr inbounds nuw i8, ptr %stack_ffi_any79, i64 32, !dbg !15
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %140, i8 0, i64 16, i1 false), !dbg !15
  %141 = load ptr, ptr @__TVMFFIFunctionCall, align 8, !dbg !15, !tbaa !38
  %142 = load ptr, ptr @.tvm_func.__tvm_set_device, align 8, !dbg !15
  %.not89 = icmp eq ptr %142, null, !dbg !15
  br i1 %.not89, label %handle_init, label %handle_init_end, !dbg !15, !prof !18

handle_init:                                      ; preds = %assert_end70
  %143 = load ptr, ptr @__tvm_ffi__library_ctx, align 8, !dbg !15, !tbaa !38
  %144 = load ptr, ptr @__TVMBackendGetFuncFromEnv, align 8, !dbg !15, !tbaa !38
  %145 = call i32 %144(ptr %143, ptr nonnull @.str.45, ptr nonnull %0), !dbg !15
  %146 = icmp eq i32 %145, 0, !dbg !15
  br i1 %146, label %call_end, label %common.ret, !dbg !15, !prof !17

handle_init_end:                                  ; preds = %call_end, %assert_end70
  %147 = phi ptr [ %142, %assert_end70 ], [ %150, %call_end ], !dbg !15
  %148 = call i32 %141(ptr %147, ptr nonnull %stack_ffi_any79, i32 2, ptr nonnull %140), !dbg !15
  %149 = icmp eq i32 %148, 0, !dbg !15
  br i1 %149, label %call_end72, label %common.ret, !dbg !15, !prof !17

call_end:                                         ; preds = %handle_init
  %150 = load ptr, ptr %0, align 8, !dbg !15
  store ptr %150, ptr @.tvm_func.__tvm_set_device, align 8, !dbg !15
  br label %handle_init_end, !dbg !15

call_end72:                                       ; preds = %handle_init_end
  %151 = call fastcc i32 @custom_swiglu_float16_128x5632_compute_(ptr nonnull %gate, ptr nonnull %up, ptr nonnull %swiglu, ptr %stack_ffi_any79), !dbg !15
  br label %common.ret, !dbg !15
}

; Function Attrs: noinline
define internal fastcc void @__tvm_set_raised_6(ptr %0, i32 range(i32 4, 7) %1, ptr %2, ptr %3, ptr %4, ptr %5, ptr %6, ptr %7) unnamed_addr #1 {
entry:
  %8 = alloca [6 x ptr], align 8
  store ptr %2, ptr %8, align 8
  %9 = getelementptr inbounds nuw i8, ptr %8, i64 8
  store ptr %3, ptr %9, align 8
  %10 = getelementptr inbounds nuw i8, ptr %8, i64 16
  store ptr %4, ptr %10, align 8
  %11 = getelementptr inbounds nuw i8, ptr %8, i64 24
  store ptr %5, ptr %11, align 8
  %12 = getelementptr inbounds nuw i8, ptr %8, i64 32
  store ptr %6, ptr %12, align 8
  %13 = getelementptr inbounds nuw i8, ptr %8, i64 40
  store ptr %7, ptr %13, align 8
  call void @TVMFFIErrorSetRaisedFromCStrParts(ptr %0, ptr nonnull %8, i32 %1)
  ret void
}

declare void @TVMFFIErrorSetRaisedFromCStrParts(ptr, ptr, i32) local_unnamed_addr

; Function Attrs: noinline
define internal fastcc void @__tvm_set_raised_12(ptr %0, i32 range(i32 7, 9) %1, ptr %2, ptr %3, ptr %4, ptr %5, ptr %6, ptr %7) unnamed_addr #1 {
entry:
  %8 = alloca [12 x ptr], align 8
  store ptr %2, ptr %8, align 8
  %9 = getelementptr inbounds nuw i8, ptr %8, i64 8
  store ptr %3, ptr %9, align 8
  %10 = getelementptr inbounds nuw i8, ptr %8, i64 16
  store ptr %4, ptr %10, align 8
  %11 = getelementptr inbounds nuw i8, ptr %8, i64 24
  store ptr %5, ptr %11, align 8
  %12 = getelementptr inbounds nuw i8, ptr %8, i64 32
  store ptr @.str.4, ptr %12, align 8
  %13 = getelementptr inbounds nuw i8, ptr %8, i64 40
  store ptr @.str.5, ptr %13, align 8
  %14 = getelementptr inbounds nuw i8, ptr %8, i64 48
  store ptr %6, ptr %14, align 8
  %15 = getelementptr inbounds nuw i8, ptr %8, i64 56
  store ptr %7, ptr %15, align 8
  %16 = getelementptr inbounds nuw i8, ptr %8, i64 64
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %16, i8 0, i64 32, i1 false)
  call void @TVMFFIErrorSetRaisedFromCStrParts(ptr %0, ptr nonnull %8, i32 %1)
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #2

; Function Attrs: noinline
define internal fastcc i32 @custom_swiglu_float16_128x5632_compute_(ptr noalias align 64 %gate, ptr noalias align 64 %up, ptr noalias align 64 %swiglu, ptr noalias nonnull initializes((0, 96)) %stack_ffi_any) unnamed_addr #3 !dbg !41 {
entry:
    #dbg_value(ptr %gate, !45, !DIExpression(), !49)
    #dbg_value(ptr %up, !46, !DIExpression(), !49)
    #dbg_value(ptr %swiglu, !47, !DIExpression(), !49)
    #dbg_value(ptr %stack_ffi_any, !48, !DIExpression(), !49)
  %0 = alloca ptr, align 8, !dbg !49
  %1 = icmp eq ptr %gate, null, !dbg !49
  %. = select i1 %1, i32 0, i32 4, !dbg !49
  store i32 %., ptr %stack_ffi_any, align 4, !dbg !49
  %2 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 4, !dbg !49
  store i32 0, ptr %2, align 4, !dbg !49
  %3 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 8, !dbg !49
  store ptr %gate, ptr %3, align 8, !dbg !49
  %4 = icmp eq ptr %swiglu, null, !dbg !49
  %spec.select = select i1 %4, i32 0, i32 4, !dbg !49
  %5 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 16, !dbg !49
  store i32 %spec.select, ptr %5, align 8, !dbg !49
  %6 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 20, !dbg !49
  store i32 0, ptr %6, align 4, !dbg !49
  %7 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 24, !dbg !49
  store ptr %swiglu, ptr %7, align 8, !dbg !49
  %8 = icmp eq ptr %up, null, !dbg !49
  %.sink10 = select i1 %8, i32 0, i32 4, !dbg !49
  %9 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 32, !dbg !49
  store i32 %.sink10, ptr %9, align 8, !dbg !49
  %10 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 36, !dbg !49
  store i32 0, ptr %10, align 4, !dbg !49
  %11 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 40, !dbg !49
  store ptr %up, ptr %11, align 8, !dbg !49
  %12 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 48, !dbg !49
  store i32 1, ptr %12, align 8, !dbg !49
  %13 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 52, !dbg !49
  store i32 0, ptr %13, align 4, !dbg !49
  %14 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 56, !dbg !49
  store i64 2816, ptr %14, align 8, !dbg !49
  %15 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 64, !dbg !49
  store i32 1, ptr %15, align 8, !dbg !49
  %16 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 68, !dbg !49
  store i32 0, ptr %16, align 4, !dbg !49
  %17 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 72, !dbg !49
  store i64 128, ptr %17, align 8, !dbg !49
  %18 = getelementptr inbounds nuw i8, ptr %stack_ffi_any, i64 80, !dbg !49
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(16) %18, i8 0, i64 16, i1 false), !dbg !49
  %19 = load ptr, ptr @__TVMFFIFunctionCall, align 8, !dbg !49, !tbaa !38
  %20 = load ptr, ptr @.tvm_func.custom_swiglu_float16_128x5632_kernel, align 8, !dbg !49
  %.not = icmp eq ptr %20, null, !dbg !49
  br i1 %.not, label %handle_init, label %handle_init_end, !dbg !49, !prof !18

handle_init:                                      ; preds = %entry
  %21 = load ptr, ptr @__tvm_ffi__library_ctx, align 8, !dbg !49, !tbaa !38
  %22 = load ptr, ptr @__TVMBackendGetFuncFromEnv, align 8, !dbg !49, !tbaa !38
  %23 = call i32 %22(ptr %21, ptr nonnull @.str.46, ptr nonnull %0), !dbg !49
  %24 = icmp eq i32 %23, 0, !dbg !49
  br i1 %24, label %call_end, label %common.ret, !dbg !49, !prof !17

handle_init_end:                                  ; preds = %call_end, %entry
  %25 = phi ptr [ %20, %entry ], [ %27, %call_end ], !dbg !49
  %26 = call i32 %19(ptr %25, ptr nonnull %stack_ffi_any, i32 5, ptr nonnull %18), !dbg !49
  br label %common.ret, !dbg !49

common.ret:                                       ; preds = %handle_init_end, %handle_init
  %common.ret.op = phi i32 [ %26, %handle_init_end ], [ %23, %handle_init ]
  ret i32 %common.ret.op, !dbg !49

call_end:                                         ; preds = %handle_init
  %27 = load ptr, ptr %0, align 8, !dbg !49
  store ptr %27, ptr @.tvm_func.custom_swiglu_float16_128x5632_kernel, align 8, !dbg !49
  br label %handle_init_end, !dbg !49
}

define weak dllexport i32 @__tvm_ffi_main(ptr %0, ptr %1, i32 %2, ptr %3) local_unnamed_addr {
entry:
  %4 = tail call i32 @__tvm_ffi_custom_swiglu_float16_128x5632(ptr poison, ptr %1, i32 %2, ptr poison), !dbg !15
  ret i32 %4, !dbg !15
}

; Function Attrs: nofree nosync nounwind memory(none)
define weak dso_local half @__truncsfhf2(float %a0) local_unnamed_addr #4 section ".text.tvm.fp16.conv" {
b0:
  %v0 = bitcast float %a0 to i32
  %0 = tail call float @llvm.fabs.f32(float %a0)
  %v1 = bitcast float %0 to i32
  %v2 = add nsw i32 %v1, -947912704
  %v3 = add nsw i32 %v1, -1199570944
  %v4 = icmp ult i32 %v2, %v3
  br i1 %v4, label %b1, label %b5

b1:                                               ; preds = %b0
  %v5 = lshr i32 %v0, 13
  %v7 = add nsw i32 %v5, -114688
  %v8 = and i32 %v0, 8191
  %v9 = icmp samesign ugt i32 %v8, 4096
  br i1 %v9, label %b2, label %b3

b2:                                               ; preds = %b1
  %v10 = add nsw i32 %v5, -114687
  br label %b13

b3:                                               ; preds = %b1
  %v11 = icmp eq i32 %v8, 4096
  br i1 %v11, label %b4, label %b13

b4:                                               ; preds = %b3
  %v13 = and i32 %v5, 1
  %v14 = add nsw i32 %v7, %v13
  br label %b13

b5:                                               ; preds = %b0
  %v15 = icmp samesign ugt i32 %v1, 2139095040
  br i1 %v15, label %b6, label %b7

b6:                                               ; preds = %b5
  %v16 = lshr i32 %v0, 13
  %v17 = and i32 %v16, 511
  %v18 = or disjoint i32 %v17, 32256
  br label %b13

b7:                                               ; preds = %b5
  %v19 = icmp samesign ugt i32 %v1, 1199570943
  br i1 %v19, label %b13, label %b8

b8:                                               ; preds = %b7
  %v20 = icmp samesign ult i32 %v1, 754974720
  br i1 %v20, label %b13, label %b9

b9:                                               ; preds = %b8
  %v21 = lshr i32 %v1, 23
  %v22 = sub nsw i32 113, %v21
  %v23 = and i32 %v0, 8388607
  %v24 = or disjoint i32 %v23, 8388608
  %v25 = add nsw i32 %v21, -81
  %v26 = shl i32 %v24, %v25
  %v27 = icmp ne i32 %v26, 0
  %v28 = lshr i32 %v24, %v22
  %v29 = zext i1 %v27 to i32
  %v30 = lshr i32 %v28, 13
  %v31 = and i32 %v28, 8191
  %v32 = or i32 %v31, %v29
  %v33 = icmp samesign ugt i32 %v32, 4096
  br i1 %v33, label %b10, label %b11

b10:                                              ; preds = %b9
  %v34 = add nuw nsw i32 %v30, 1
  br label %b13

b11:                                              ; preds = %b9
  %v35 = icmp eq i32 %v32, 4096
  br i1 %v35, label %b12, label %b13

b12:                                              ; preds = %b11
  %v36 = and i32 %v30, 1
  %v37 = add nuw nsw i32 %v36, %v30
  br label %b13

b13:                                              ; preds = %b12, %b11, %b10, %b8, %b7, %b6, %b4, %b3, %b2
  %v38 = phi i32 [ %v18, %b6 ], [ %v10, %b2 ], [ %v14, %b4 ], [ %v7, %b3 ], [ 31744, %b7 ], [ 0, %b8 ], [ %v34, %b10 ], [ %v37, %b12 ], [ %v30, %b11 ]
  %v39 = lshr i32 %v0, 16
  %v40 = and i32 %v39, 32768
  %v41 = or i32 %v38, %v40
  %vlast = trunc i32 %v41 to i16
  %vres = bitcast i16 %vlast to half
  ret half %vres
}

; Function Attrs: nofree nosync nounwind memory(none)
define weak dso_local float @__extendhfsf2(half %a0) local_unnamed_addr #4 section ".text.tvm.fp16.conv" {
b0:
  %0 = tail call half @llvm.fabs.f16(half %a0)
  %v1 = bitcast half %0 to i16
  %v2 = zext nneg i16 %v1 to i32
  %v3 = add nsw i16 %v1, -1024
  %v4 = icmp ult i16 %v3, 30720
  br i1 %v4, label %b1, label %b2

b1:                                               ; preds = %b0
  %v5 = shl nuw nsw i32 %v2, 13
  %v6 = add nuw nsw i32 %v5, 939524096
  br label %b6

b2:                                               ; preds = %b0
  %v7 = icmp samesign ugt i16 %v1, 31743
  br i1 %v7, label %b3, label %b4

b3:                                               ; preds = %b2
  %v8 = shl nuw nsw i32 %v2, 13
  %v9 = or i32 %v8, 2139095040
  br label %b6

b4:                                               ; preds = %b2
  %v10 = icmp eq i16 %v1, 0
  br i1 %v10, label %b6, label %b5

b5:                                               ; preds = %b4
  %v11 = icmp samesign ult i16 %v1, 256
  %v12 = lshr i32 %v2, 8
  %v13 = select i1 %v11, i32 %v2, i32 %v12
  %v14 = select i1 %v11, i32 32, i32 24
  %v15 = icmp samesign ult i32 %v13, 16
  %v16 = lshr i32 %v13, 4
  %v17 = add nsw i32 %v14, -4
  %v18 = select i1 %v15, i32 %v13, i32 %v16
  %v19 = select i1 %v15, i32 %v14, i32 %v17
  %v20 = icmp samesign ult i32 %v18, 4
  %v21 = lshr i32 %v18, 2
  %v22 = add nsw i32 %v19, -2
  %v23 = select i1 %v20, i32 %v18, i32 %v21
  %v24 = select i1 %v20, i32 %v19, i32 %v22
  %v25 = icmp samesign ult i32 %v23, 2
  %v26 = sub nsw i32 0, %v23
  %v27 = select i1 %v25, i32 %v26, i32 -2
  %v28 = add nsw i32 %v27, %v24
  %v29 = add nsw i32 %v28, -8
  %v30 = shl i32 %v2, %v29
  %v31 = xor i32 %v30, 8388608
  %v32 = shl i32 %v28, 23
  %v33 = sub i32 1124073472, %v32
  %v34 = or i32 %v31, %v33
  br label %b6

b6:                                               ; preds = %b5, %b4, %b3, %b1
  %v35 = phi i32 [ %v6, %b1 ], [ %v9, %b3 ], [ %v34, %b5 ], [ 0, %b4 ]
  %vinp = bitcast half %a0 to i16
  %v36 = and i16 %vinp, -32768
  %v37 = zext i16 %v36 to i32
  %v38 = shl nuw i32 %v37, 16
  %v39 = or i32 %v35, %v38
  %v40 = bitcast i32 %v39 to float
  ret float %v40
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fabs.f32(float) #5

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.fabs.f16(half) #5

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #6

attributes #0 = { "target-cpu"="generic" }
attributes #1 = { noinline }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #3 = { noinline "target-cpu"="generic" }
attributes #4 = { nofree nosync nounwind memory(none) "target-cpu"="generic" "target-features" }
attributes #5 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: write) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "TVM", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "IRModule.CodeGenLLVM", directory: ".")
!2 = !{i32 2, !"tvm_target", !"{\22kind\22:\22llvm\22,\22mtriple\22:\22x86_64-conda-linux-gnu\22}"}
!3 = !{i32 4, !"Debug Info Version", i32 3}
!4 = !{i32 4, !"Dwarf Version", i32 4}
!5 = distinct !DISubprogram(name: "__tvm_ffi_custom_swiglu_float16_128x5632", scope: !1, file: !1, type: !6, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !10)
!6 = !DISubroutineType(types: !7)
!7 = !{!8, !9, !9, !8, !9}
!8 = !DIBasicType(name: "int32", size: 32, encoding: DW_ATE_signed)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null)
!10 = !{!11, !12, !13, !14}
!11 = !DILocalVariable(name: "self_handle", arg: 1, scope: !5, file: !1, type: !9)
!12 = !DILocalVariable(name: "args", arg: 2, scope: !5, file: !1, type: !9)
!13 = !DILocalVariable(name: "num_args", arg: 3, scope: !5, file: !1, type: !8)
!14 = !DILocalVariable(name: "result", arg: 4, scope: !5, file: !1, type: !9)
!15 = !DILocation(line: 0, scope: !5)
!16 = !DILocalVariable(name: "stack_ffi_any", scope: !5, file: !1, type: !9)
!17 = !{!"branch_weights", i32 1048576, i32 1}
!18 = !{!"branch_weights", i32 1, i32 1048576}
!19 = !DILocalVariable(name: "var_gate.type_index", scope: !5, file: !1, type: !8)
!20 = !{!"branch_weights", i32 1, i32 349525, i32 349525, i32 349525}
!21 = !DILocalVariable(name: "var_gate", scope: !5, file: !1, type: !9)
!22 = !DILocalVariable(name: "var_up.type_index", scope: !5, file: !1, type: !8)
!23 = !DILocalVariable(name: "var_up", scope: !5, file: !1, type: !9)
!24 = !DILocalVariable(name: "var_swiglu.type_index", scope: !5, file: !1, type: !8)
!25 = !DILocalVariable(name: "var_swiglu", scope: !5, file: !1, type: !9)
!26 = !DILocalVariable(name: "custom_swiglu_float16_128x5632.var_gate_shape", scope: !5, file: !1, type: !9)
!27 = !DILocalVariable(name: "custom_swiglu_float16_128x5632.var_gate_strides", scope: !5, file: !1, type: !9)
!28 = !DILocalVariable(name: "dev_id", scope: !5, file: !1, type: !8)
!29 = !DILocalVariable(name: "gate", scope: !5, file: !1, type: !30)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31)
!31 = !DIBasicType(name: "float16", size: 16, encoding: DW_ATE_float)
!32 = !DILocalVariable(name: "custom_swiglu_float16_128x5632.var_up_shape", scope: !5, file: !1, type: !9)
!33 = !DILocalVariable(name: "custom_swiglu_float16_128x5632.var_up_strides", scope: !5, file: !1, type: !9)
!34 = !DILocalVariable(name: "up", scope: !5, file: !1, type: !30)
!35 = !DILocalVariable(name: "custom_swiglu_float16_128x5632.var_swiglu_shape", scope: !5, file: !1, type: !9)
!36 = !DILocalVariable(name: "custom_swiglu_float16_128x5632.var_swiglu_strides", scope: !5, file: !1, type: !9)
!37 = !DILocalVariable(name: "swiglu", scope: !5, file: !1, type: !30)
!38 = !{!39, !39, i64 0}
!39 = !{!"ctx_ptr", !40, i64 0}
!40 = !{!"tvm-tbaa"}
!41 = distinct !DISubprogram(name: "custom_swiglu_float16_128x5632_compute_", scope: !1, file: !1, type: !42, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !44)
!42 = !DISubroutineType(types: !43)
!43 = !{!8, !30, !30, !30, !9}
!44 = !{!45, !46, !47, !48}
!45 = !DILocalVariable(name: "gate", arg: 1, scope: !41, file: !1, type: !30)
!46 = !DILocalVariable(name: "up", arg: 2, scope: !41, file: !1, type: !30)
!47 = !DILocalVariable(name: "swiglu", arg: 3, scope: !41, file: !1, type: !30)
!48 = !DILocalVariable(name: "stack_ffi_any", arg: 4, scope: !41, file: !1, type: !9)
!49 = !DILocation(line: 0, scope: !41)
