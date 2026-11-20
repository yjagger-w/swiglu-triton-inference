; ModuleID = 'TVMMod'
source_filename = "TVMMod"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

$__tvm_ffi_main = comdat any

@.str = private constant [10 x i8] c"TypeError\00", align 1
@.str.1 = private constant [10 x i8] c"Expected \00", align 1
@.str.2 = private constant [2 x i8] c"3\00", align 1
@.str.3 = private constant [11 x i8] c" arguments\00", align 1
@.str.4 = private constant [19 x i8] c" when calling:\0A  `\00", align 1
@.str.5 = private constant [131 x i8] c"custom_swiglu_float32_1x5632(gate: Tensor([1, 5632], float32), up: Tensor([1, 5632], float32), swiglu: Tensor([1, 5632], float32))\00", align 1
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
@.str.19 = private constant [8 x i8] c"float32\00", align 1
@.str.20 = private constant [27 x i8] c".device_type on argument #\00", align 1
@.str.21 = private constant [4 x i8] c"cpu\00", align 1
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
@.str.35 = private constant [14 x i8] c"gate.shape[1]\00", align 1
@.str.36 = private constant [5 x i8] c"5632\00", align 1
@.str.37 = private constant [17 x i8] c"gate.byte_offset\00", align 1
@.str.38 = private constant [12 x i8] c"up.shape[0]\00", align 1
@.str.39 = private constant [12 x i8] c"up.shape[1]\00", align 1
@.str.40 = private constant [15 x i8] c"up.byte_offset\00", align 1
@.str.41 = private constant [16 x i8] c"swiglu.shape[0]\00", align 1
@.str.42 = private constant [16 x i8] c"swiglu.shape[1]\00", align 1
@.str.43 = private constant [19 x i8] c"swiglu.byte_offset\00", align 1
@llvm.global_ctors = appending global [0 x { i32, ptr, ptr }] zeroinitializer

define dllexport range(i32 -1, 1) i32 @__tvm_ffi_custom_swiglu_float32_1x5632(ptr noalias readnone captures(none) %self_handle, ptr noalias readonly captures(address_is_null) %args, i32 %num_args, ptr noalias readnone captures(none) %result) local_unnamed_addr #0 !dbg !5 {
entry:
    #dbg_value(ptr poison, !11, !DIExpression(), !15)
    #dbg_value(ptr %args, !12, !DIExpression(), !15)
    #dbg_value(i32 %num_args, !13, !DIExpression(), !15)
    #dbg_value(ptr poison, !14, !DIExpression(), !15)
  %0 = icmp eq i32 %num_args, 3, !dbg !15
  br i1 %0, label %assert_end, label %assert_fail, !dbg !15, !prof !16

common.ret:                                       ; preds = %assert_end70, %assert_fail69, %assert_fail67, %assert_fail65, %assert_fail63, %assert_fail61, %assert_fail59, %assert_fail57, %assert_fail55, %assert_fail53, %assert_fail51, %assert_fail49, %assert_fail47, %assert_fail43, %assert_fail41, %assert_fail39, %assert_fail35, %assert_fail33, %assert_fail31, %assert_fail29, %assert_fail27, %assert_fail25, %assert_fail23, %assert_fail21, %assert_fail19, %assert_fail17, %assert_fail15, %assert_fail13, %assert_fail11, %assert_fail9, %assert_fail7, %assert_fail5, %assert_fail3, %assert_fail1, %assert_fail
  %common.ret.op = phi i32 [ -1, %assert_fail ], [ -1, %assert_fail1 ], [ -1, %assert_fail3 ], [ -1, %assert_fail5 ], [ -1, %assert_fail7 ], [ -1, %assert_fail9 ], [ -1, %assert_fail11 ], [ -1, %assert_fail13 ], [ -1, %assert_fail15 ], [ -1, %assert_fail17 ], [ -1, %assert_fail19 ], [ -1, %assert_fail21 ], [ -1, %assert_fail23 ], [ -1, %assert_fail25 ], [ -1, %assert_fail27 ], [ -1, %assert_fail29 ], [ -1, %assert_fail31 ], [ -1, %assert_fail33 ], [ -1, %assert_fail35 ], [ -1, %assert_fail39 ], [ -1, %assert_fail41 ], [ -1, %assert_fail43 ], [ -1, %assert_fail47 ], [ -1, %assert_fail49 ], [ -1, %assert_fail51 ], [ -1, %assert_fail53 ], [ -1, %assert_fail55 ], [ -1, %assert_fail57 ], [ -1, %assert_fail59 ], [ -1, %assert_fail61 ], [ -1, %assert_fail63 ], [ -1, %assert_fail65 ], [ -1, %assert_fail67 ], [ -1, %assert_fail69 ], [ 0, %assert_end70 ]
  ret i32 %common.ret.op, !dbg !15

assert_fail:                                      ; preds = %entry
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.1, ptr nonnull @.str.2, ptr nonnull @.str.3, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.6), !dbg !15
  br label %common.ret, !dbg !15

assert_end:                                       ; preds = %entry
  %.not = icmp eq ptr %args, null, !dbg !15
  br i1 %.not, label %assert_fail1, label %assert_end2, !dbg !15, !prof !17

assert_fail1:                                     ; preds = %assert_end
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 4, ptr nonnull @.str.7, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.6, ptr null, ptr null), !dbg !15
  br label %common.ret, !dbg !15

assert_end2:                                      ; preds = %assert_end
  %var_gate.type_index = load i32, ptr %args, align 4, !dbg !15
    #dbg_value(i32 %var_gate.type_index, !18, !DIExpression(), !15)
    #dbg_value(i32 %var_gate.type_index, !18, !DIExpression(), !15)
  %var_gate.type_index.fr = freeze i32 %var_gate.type_index, !dbg !15
  %1 = icmp sgt i32 %var_gate.type_index.fr, 63, !dbg !15
  br i1 %1, label %assert_end4, label %switch.early.test, !dbg !15

switch.early.test:                                ; preds = %assert_end2
  switch i32 %var_gate.type_index.fr, label %assert_fail3 [
    i32 7, label %assert_end4
    i32 4, label %assert_end4
    i32 0, label %assert_end4
  ], !dbg !15, !prof !19

assert_fail3:                                     ; preds = %switch.early.test
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.9, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end4:                                      ; preds = %switch.early.test, %switch.early.test, %switch.early.test, %assert_end2
  %2 = getelementptr inbounds nuw i8, ptr %args, i64 8, !dbg !15
  %3 = load ptr, ptr %2, align 8, !dbg !15
  %4 = icmp eq i32 %var_gate.type_index.fr, 70, !dbg !15
  %var_gate.idx = select i1 %4, i64 24, i64 0, !dbg !15
  %var_gate = getelementptr inbounds nuw i8, ptr %3, i64 %var_gate.idx, !dbg !15
    #dbg_declare(ptr %var_gate, !20, !DIExpression(), !15)
    #dbg_declare(ptr %var_gate, !20, !DIExpression(), !15)
  %5 = getelementptr inbounds nuw i8, ptr %args, i64 16, !dbg !15
  %var_up.type_index = load i32, ptr %5, align 8, !dbg !15
    #dbg_value(i32 %var_up.type_index, !21, !DIExpression(), !15)
    #dbg_value(i32 %var_up.type_index, !21, !DIExpression(), !15)
  %var_up.type_index.fr = freeze i32 %var_up.type_index, !dbg !15
  %6 = icmp sgt i32 %var_up.type_index.fr, 63, !dbg !15
  br i1 %6, label %assert_end6, label %switch.early.test71, !dbg !15

switch.early.test71:                              ; preds = %assert_end4
  switch i32 %var_up.type_index.fr, label %assert_fail5 [
    i32 7, label %assert_end6
    i32 4, label %assert_end6
    i32 0, label %assert_end6
  ], !dbg !15, !prof !19

assert_fail5:                                     ; preds = %switch.early.test71
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.12, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end6:                                      ; preds = %switch.early.test71, %switch.early.test71, %switch.early.test71, %assert_end4
  %7 = getelementptr inbounds nuw i8, ptr %args, i64 24, !dbg !15
  %8 = load ptr, ptr %7, align 8, !dbg !15
  %9 = icmp eq i32 %var_up.type_index.fr, 70, !dbg !15
  %var_up.idx = select i1 %9, i64 24, i64 0, !dbg !15
  %var_up = getelementptr inbounds nuw i8, ptr %8, i64 %var_up.idx, !dbg !15
    #dbg_declare(ptr %var_up, !22, !DIExpression(), !15)
    #dbg_declare(ptr %var_up, !22, !DIExpression(), !15)
  %10 = getelementptr inbounds nuw i8, ptr %args, i64 32, !dbg !15
  %var_swiglu.type_index = load i32, ptr %10, align 8, !dbg !15
    #dbg_value(i32 %var_swiglu.type_index, !23, !DIExpression(), !15)
    #dbg_value(i32 %var_swiglu.type_index, !23, !DIExpression(), !15)
  %var_swiglu.type_index.fr = freeze i32 %var_swiglu.type_index, !dbg !15
  %11 = icmp sgt i32 %var_swiglu.type_index.fr, 63, !dbg !15
  br i1 %11, label %assert_end8, label %switch.early.test72, !dbg !15

switch.early.test72:                              ; preds = %assert_end6
  switch i32 %var_swiglu.type_index.fr, label %assert_fail7 [
    i32 7, label %assert_end8
    i32 4, label %assert_end8
    i32 0, label %assert_end8
  ], !dbg !15, !prof !19

assert_fail7:                                     ; preds = %switch.early.test72
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.13, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end8:                                      ; preds = %switch.early.test72, %switch.early.test72, %switch.early.test72, %assert_end6
  %12 = getelementptr inbounds nuw i8, ptr %args, i64 40, !dbg !15
  %13 = load ptr, ptr %12, align 8, !dbg !15
  %14 = icmp eq i32 %var_swiglu.type_index.fr, 70, !dbg !15
  %var_swiglu.idx = select i1 %14, i64 24, i64 0, !dbg !15
  %var_swiglu = getelementptr inbounds nuw i8, ptr %13, i64 %var_swiglu.idx, !dbg !15
    #dbg_declare(ptr %var_swiglu, !24, !DIExpression(), !15)
    #dbg_declare(ptr %var_swiglu, !24, !DIExpression(), !15)
  %.not73 = icmp eq ptr %3, null, !dbg !15
  br i1 %.not73, label %assert_fail9, label %assert_end10, !dbg !15, !prof !17

assert_fail9:                                     ; preds = %assert_end8
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.9, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end10:                                     ; preds = %assert_end8
  %15 = getelementptr inbounds nuw i8, ptr %var_gate, i64 16, !dbg !15
  %16 = load i32, ptr %15, align 4, !dbg !15
  %17 = icmp eq i32 %16, 2, !dbg !15
  br i1 %17, label %assert_end12, label %assert_fail11, !dbg !15, !prof !16

assert_fail11:                                    ; preds = %assert_end10
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.16, ptr nonnull @.str.17, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.13), !dbg !15
  br label %common.ret, !dbg !15

assert_end12:                                     ; preds = %assert_end10
  %18 = getelementptr inbounds nuw i8, ptr %var_gate, i64 22, !dbg !15
  %19 = load i16, ptr %18, align 2, !dbg !15
  %20 = icmp eq i16 %19, 1, !dbg !15
  %21 = getelementptr inbounds nuw i8, ptr %var_gate, i64 21, !dbg !15
  %22 = load i8, ptr %21, align 1, !dbg !15
  %23 = icmp eq i8 %22, 32, !dbg !15
  %24 = getelementptr inbounds nuw i8, ptr %var_gate, i64 20, !dbg !15
  %25 = load i8, ptr %24, align 2, !dbg !15
  %26 = icmp eq i8 %25, 2, !dbg !15
  %27 = and i1 %23, %26, !dbg !15
  %28 = and i1 %20, %27, !dbg !15
  br i1 %28, label %assert_end14, label %assert_fail13, !dbg !15, !prof !16

assert_fail13:                                    ; preds = %assert_end12
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.16, ptr nonnull @.str.18, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.19), !dbg !15
  br label %common.ret, !dbg !15

assert_end14:                                     ; preds = %assert_end12
  %29 = getelementptr inbounds nuw i8, ptr %var_gate, i64 24, !dbg !15
  %custom_swiglu_float32_1x5632.var_gate_shape = load ptr, ptr %29, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_gate_shape, !25, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_gate_shape, !25, !DIExpression(), !15)
  %30 = getelementptr inbounds nuw i8, ptr %var_gate, i64 32, !dbg !15
  %custom_swiglu_float32_1x5632.var_gate_strides = load ptr, ptr %30, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_gate_strides, !26, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_gate_strides, !26, !DIExpression(), !15)
  %31 = getelementptr inbounds nuw i8, ptr %var_gate, i64 8, !dbg !15
  %32 = load i32, ptr %31, align 8, !dbg !15
  %33 = icmp eq i32 %32, 1, !dbg !15
  br i1 %33, label %assert_end16, label %assert_fail15, !dbg !15, !prof !16

assert_fail15:                                    ; preds = %assert_end14
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.16, ptr nonnull @.str.20, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.21), !dbg !15
  br label %common.ret, !dbg !15

assert_end16:                                     ; preds = %assert_end14
  %34 = getelementptr inbounds nuw i8, ptr %var_gate, i64 12, !dbg !15
  %dev_id = load i32, ptr %34, align 4, !dbg !15
    #dbg_value(i32 %dev_id, !27, !DIExpression(), !15)
    #dbg_value(i32 %dev_id, !27, !DIExpression(), !15)
  %gate = load ptr, ptr %var_gate, align 8, !dbg !15
    #dbg_declare(ptr %gate, !28, !DIExpression(), !15)
    #dbg_declare(ptr %gate, !28, !DIExpression(), !15)
  call void @llvm.assume(i1 true) [ "align"(ptr %gate, i64 64) ], !dbg !15
  %.not74 = icmp eq ptr %8, null, !dbg !15
  br i1 %.not74, label %assert_fail17, label %assert_end18, !dbg !15, !prof !17

assert_fail17:                                    ; preds = %assert_end16
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.12, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end18:                                     ; preds = %assert_end16
  %35 = getelementptr inbounds nuw i8, ptr %var_up, i64 16, !dbg !15
  %36 = load i32, ptr %35, align 4, !dbg !15
  %37 = icmp eq i32 %36, 2, !dbg !15
  br i1 %37, label %assert_end20, label %assert_fail19, !dbg !15, !prof !16

assert_fail19:                                    ; preds = %assert_end18
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.22, ptr nonnull @.str.17, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.13), !dbg !15
  br label %common.ret, !dbg !15

assert_end20:                                     ; preds = %assert_end18
  %38 = getelementptr inbounds nuw i8, ptr %var_up, i64 22, !dbg !15
  %39 = load i16, ptr %38, align 2, !dbg !15
  %40 = icmp eq i16 %39, 1, !dbg !15
  %41 = getelementptr inbounds nuw i8, ptr %var_up, i64 21, !dbg !15
  %42 = load i8, ptr %41, align 1, !dbg !15
  %43 = icmp eq i8 %42, 32, !dbg !15
  %44 = getelementptr inbounds nuw i8, ptr %var_up, i64 20, !dbg !15
  %45 = load i8, ptr %44, align 2, !dbg !15
  %46 = icmp eq i8 %45, 2, !dbg !15
  %47 = and i1 %43, %46, !dbg !15
  %48 = and i1 %40, %47, !dbg !15
  br i1 %48, label %assert_end22, label %assert_fail21, !dbg !15, !prof !16

assert_fail21:                                    ; preds = %assert_end20
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.22, ptr nonnull @.str.18, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.19), !dbg !15
  br label %common.ret, !dbg !15

assert_end22:                                     ; preds = %assert_end20
  %49 = getelementptr inbounds nuw i8, ptr %var_up, i64 24, !dbg !15
  %custom_swiglu_float32_1x5632.var_up_shape = load ptr, ptr %49, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_up_shape, !31, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_up_shape, !31, !DIExpression(), !15)
  %50 = getelementptr inbounds nuw i8, ptr %var_up, i64 32, !dbg !15
  %custom_swiglu_float32_1x5632.var_up_strides = load ptr, ptr %50, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_up_strides, !32, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_up_strides, !32, !DIExpression(), !15)
  %51 = getelementptr inbounds nuw i8, ptr %var_up, i64 8, !dbg !15
  %52 = load i32, ptr %51, align 8, !dbg !15
  %53 = icmp eq i32 %52, 1, !dbg !15
  br i1 %53, label %assert_end24, label %assert_fail23, !dbg !15, !prof !16

assert_fail23:                                    ; preds = %assert_end22
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.22, ptr nonnull @.str.20, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.21), !dbg !15
  br label %common.ret, !dbg !15

assert_end24:                                     ; preds = %assert_end22
  %up = load ptr, ptr %var_up, align 8, !dbg !15
    #dbg_declare(ptr %up, !33, !DIExpression(), !15)
    #dbg_declare(ptr %up, !33, !DIExpression(), !15)
  call void @llvm.assume(i1 true) [ "align"(ptr %up, i64 64) ], !dbg !15
  %.not75 = icmp eq ptr %13, null, !dbg !15
  br i1 %.not75, label %assert_fail25, label %assert_end26, !dbg !15, !prof !17

assert_fail25:                                    ; preds = %assert_end24
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str, i32 6, ptr nonnull @.str.8, ptr nonnull @.str.13, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.10, ptr nonnull @.str.11), !dbg !15
  br label %common.ret, !dbg !15

assert_end26:                                     ; preds = %assert_end24
  %54 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 16, !dbg !15
  %55 = load i32, ptr %54, align 4, !dbg !15
  %56 = icmp eq i32 %55, 2, !dbg !15
  br i1 %56, label %assert_end28, label %assert_fail27, !dbg !15, !prof !16

assert_fail27:                                    ; preds = %assert_end26
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.23, ptr nonnull @.str.17, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.13), !dbg !15
  br label %common.ret, !dbg !15

assert_end28:                                     ; preds = %assert_end26
  %57 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 22, !dbg !15
  %58 = load i16, ptr %57, align 2, !dbg !15
  %59 = icmp eq i16 %58, 1, !dbg !15
  %60 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 21, !dbg !15
  %61 = load i8, ptr %60, align 1, !dbg !15
  %62 = icmp eq i8 %61, 32, !dbg !15
  %63 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 20, !dbg !15
  %64 = load i8, ptr %63, align 2, !dbg !15
  %65 = icmp eq i8 %64, 2, !dbg !15
  %66 = and i1 %62, %65, !dbg !15
  %67 = and i1 %59, %66, !dbg !15
  br i1 %67, label %assert_end30, label %assert_fail29, !dbg !15, !prof !16

assert_fail29:                                    ; preds = %assert_end28
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.23, ptr nonnull @.str.18, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.19), !dbg !15
  br label %common.ret, !dbg !15

assert_end30:                                     ; preds = %assert_end28
  %68 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 24, !dbg !15
  %custom_swiglu_float32_1x5632.var_swiglu_shape = load ptr, ptr %68, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_swiglu_shape, !34, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_swiglu_shape, !34, !DIExpression(), !15)
  %69 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 32, !dbg !15
  %custom_swiglu_float32_1x5632.var_swiglu_strides = load ptr, ptr %69, align 8, !dbg !15
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_swiglu_strides, !35, !DIExpression(), !15)
    #dbg_declare(ptr %custom_swiglu_float32_1x5632.var_swiglu_strides, !35, !DIExpression(), !15)
  %70 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 8, !dbg !15
  %71 = load i32, ptr %70, align 8, !dbg !15
  %72 = icmp eq i32 %71, 1, !dbg !15
  br i1 %72, label %assert_end32, label %assert_fail31, !dbg !15, !prof !16

assert_fail31:                                    ; preds = %assert_end30
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.23, ptr nonnull @.str.20, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.21), !dbg !15
  br label %common.ret, !dbg !15

assert_end32:                                     ; preds = %assert_end30
  %swiglu = load ptr, ptr %var_swiglu, align 8, !dbg !15
    #dbg_declare(ptr %swiglu, !36, !DIExpression(), !15)
    #dbg_declare(ptr %swiglu, !36, !DIExpression(), !15)
  call void @llvm.assume(i1 true) [ "align"(ptr %swiglu, i64 64) ], !dbg !15
  %.not76 = icmp eq ptr %custom_swiglu_float32_1x5632.var_gate_strides, null, !dbg !15
  br i1 %.not76, label %if_end, label %if_then, !dbg !15, !prof !17

if_then:                                          ; preds = %assert_end32
  %73 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float32_1x5632.var_gate_strides, i64 8, !dbg !15
  %74 = load i64, ptr %73, align 8, !dbg !15
  %75 = and i64 %74, 4294967295, !dbg !15
  %76 = icmp eq i64 %75, 1, !dbg !15
  br i1 %76, label %if_end, label %assert_fail33, !dbg !15, !prof !16

if_end:                                           ; preds = %if_then, %assert_end32
  %.not77 = icmp eq ptr %gate, null, !dbg !15
  br i1 %.not77, label %assert_fail35, label %assert_end36, !dbg !15, !prof !17

assert_fail33:                                    ; preds = %if_then
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 7, ptr nonnull @.str.15, ptr nonnull @.str.16, ptr nonnull @.str.24, ptr nonnull @.str.9, ptr nonnull @.str.25, ptr null), !dbg !15
  br label %common.ret, !dbg !15

assert_fail35:                                    ; preds = %if_end
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str.14, i32 6, ptr nonnull @.str.16, ptr nonnull @.str.26, ptr nonnull @.str.9, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.27), !dbg !15
  br label %common.ret, !dbg !15

assert_end36:                                     ; preds = %if_end
  %.not78 = icmp eq ptr %custom_swiglu_float32_1x5632.var_up_strides, null, !dbg !15
  br i1 %.not78, label %if_end38, label %if_then37, !dbg !15, !prof !17

if_then37:                                        ; preds = %assert_end36
  %77 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float32_1x5632.var_up_strides, i64 8, !dbg !15
  %78 = load i64, ptr %77, align 8, !dbg !15
  %79 = and i64 %78, 4294967295, !dbg !15
  %80 = icmp eq i64 %79, 1, !dbg !15
  br i1 %80, label %if_end38, label %assert_fail39, !dbg !15, !prof !16

if_end38:                                         ; preds = %if_then37, %assert_end36
  %81 = getelementptr inbounds nuw i8, ptr %var_up, i64 12, !dbg !15
  %82 = load i32, ptr %81, align 4, !dbg !15
  %83 = icmp eq i32 %dev_id, %82, !dbg !15
  br i1 %83, label %assert_end42, label %assert_fail41, !dbg !15, !prof !16

assert_fail39:                                    ; preds = %if_then37
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 7, ptr nonnull @.str.15, ptr nonnull @.str.22, ptr nonnull @.str.24, ptr nonnull @.str.12, ptr nonnull @.str.25, ptr null), !dbg !15
  br label %common.ret, !dbg !15

assert_fail41:                                    ; preds = %if_end38
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.28, ptr nonnull @.str.29, ptr nonnull @.str.12, ptr nonnull @.str.30, ptr nonnull @.str.31), !dbg !15
  br label %common.ret, !dbg !15

assert_end42:                                     ; preds = %if_end38
  %.not79 = icmp eq ptr %up, null, !dbg !15
  br i1 %.not79, label %assert_fail43, label %assert_end44, !dbg !15, !prof !17

assert_fail43:                                    ; preds = %assert_end42
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str.14, i32 6, ptr nonnull @.str.22, ptr nonnull @.str.26, ptr nonnull @.str.12, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.27), !dbg !15
  br label %common.ret, !dbg !15

assert_end44:                                     ; preds = %assert_end42
  %.not80 = icmp eq ptr %custom_swiglu_float32_1x5632.var_swiglu_strides, null, !dbg !15
  br i1 %.not80, label %if_end46, label %if_then45, !dbg !15, !prof !17

if_then45:                                        ; preds = %assert_end44
  %84 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float32_1x5632.var_swiglu_strides, i64 8, !dbg !15
  %85 = load i64, ptr %84, align 8, !dbg !15
  %86 = and i64 %85, 4294967295, !dbg !15
  %87 = icmp eq i64 %86, 1, !dbg !15
  br i1 %87, label %if_end46, label %assert_fail47, !dbg !15, !prof !16

if_end46:                                         ; preds = %if_then45, %assert_end44
  %88 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 12, !dbg !15
  %89 = load i32, ptr %88, align 4, !dbg !15
  %90 = icmp eq i32 %dev_id, %89, !dbg !15
  br i1 %90, label %assert_end50, label %assert_fail49, !dbg !15, !prof !16

assert_fail47:                                    ; preds = %if_then45
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 7, ptr nonnull @.str.15, ptr nonnull @.str.23, ptr nonnull @.str.24, ptr nonnull @.str.13, ptr nonnull @.str.25, ptr null), !dbg !15
  br label %common.ret, !dbg !15

assert_fail49:                                    ; preds = %if_end46
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.15, ptr nonnull @.str.32, ptr nonnull @.str.29, ptr nonnull @.str.13, ptr nonnull @.str.30, ptr nonnull @.str.31), !dbg !15
  br label %common.ret, !dbg !15

assert_end50:                                     ; preds = %if_end46
  %.not81 = icmp eq ptr %swiglu, null, !dbg !15
  br i1 %.not81, label %assert_fail51, label %assert_end52, !dbg !15, !prof !17

assert_fail51:                                    ; preds = %assert_end50
  tail call fastcc void @__tvm_set_raised_6(ptr nonnull @.str.14, i32 6, ptr nonnull @.str.23, ptr nonnull @.str.26, ptr nonnull @.str.13, ptr nonnull @.str.4, ptr nonnull @.str.5, ptr nonnull @.str.27), !dbg !15
  br label %common.ret, !dbg !15

assert_end52:                                     ; preds = %assert_end50
  %91 = load i64, ptr %custom_swiglu_float32_1x5632.var_gate_shape, align 8, !dbg !15
  %92 = and i64 %91, 4294967295, !dbg !15
  %93 = icmp eq i64 %92, 1, !dbg !15
  br i1 %93, label %assert_end54, label %assert_fail53, !dbg !15, !prof !16

assert_fail53:                                    ; preds = %assert_end52
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.34, ptr nonnull @.str.29, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.12), !dbg !15
  br label %common.ret, !dbg !15

assert_end54:                                     ; preds = %assert_end52
  %94 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float32_1x5632.var_gate_shape, i64 8, !dbg !15
  %95 = load i64, ptr %94, align 8, !dbg !15
  %96 = and i64 %95, 4294967295, !dbg !15
  %97 = icmp eq i64 %96, 5632, !dbg !15
  br i1 %97, label %assert_end56, label %assert_fail55, !dbg !15, !prof !16

assert_fail55:                                    ; preds = %assert_end54
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.35, ptr nonnull @.str.29, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.36), !dbg !15
  br label %common.ret, !dbg !15

assert_end56:                                     ; preds = %assert_end54
  %98 = getelementptr inbounds nuw i8, ptr %var_gate, i64 40, !dbg !15
  %99 = load i64, ptr %98, align 8, !dbg !15
  %100 = icmp eq i64 %99, 0, !dbg !15
  br i1 %100, label %assert_end58, label %assert_fail57, !dbg !15, !prof !16

assert_fail57:                                    ; preds = %assert_end56
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.37, ptr nonnull @.str.29, ptr nonnull @.str.9, ptr nonnull @.str.10, ptr nonnull @.str.9), !dbg !15
  br label %common.ret, !dbg !15

assert_end58:                                     ; preds = %assert_end56
  %101 = load i64, ptr %custom_swiglu_float32_1x5632.var_up_shape, align 8, !dbg !15
  %102 = and i64 %101, 4294967295, !dbg !15
  %103 = icmp eq i64 %102, 1, !dbg !15
  br i1 %103, label %assert_end60, label %assert_fail59, !dbg !15, !prof !16

assert_fail59:                                    ; preds = %assert_end58
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.38, ptr nonnull @.str.29, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.12), !dbg !15
  br label %common.ret, !dbg !15

assert_end60:                                     ; preds = %assert_end58
  %104 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float32_1x5632.var_up_shape, i64 8, !dbg !15
  %105 = load i64, ptr %104, align 8, !dbg !15
  %106 = and i64 %105, 4294967295, !dbg !15
  %107 = icmp eq i64 %106, 5632, !dbg !15
  br i1 %107, label %assert_end62, label %assert_fail61, !dbg !15, !prof !16

assert_fail61:                                    ; preds = %assert_end60
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.39, ptr nonnull @.str.29, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.36), !dbg !15
  br label %common.ret, !dbg !15

assert_end62:                                     ; preds = %assert_end60
  %108 = getelementptr inbounds nuw i8, ptr %var_up, i64 40, !dbg !15
  %109 = load i64, ptr %108, align 8, !dbg !15
  %110 = icmp eq i64 %109, 0, !dbg !15
  br i1 %110, label %assert_end64, label %assert_fail63, !dbg !15, !prof !16

assert_fail63:                                    ; preds = %assert_end62
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.40, ptr nonnull @.str.29, ptr nonnull @.str.12, ptr nonnull @.str.10, ptr nonnull @.str.9), !dbg !15
  br label %common.ret, !dbg !15

assert_end64:                                     ; preds = %assert_end62
  %111 = load i64, ptr %custom_swiglu_float32_1x5632.var_swiglu_shape, align 8, !dbg !15
  %112 = and i64 %111, 4294967295, !dbg !15
  %113 = icmp eq i64 %112, 1, !dbg !15
  br i1 %113, label %assert_end66, label %assert_fail65, !dbg !15, !prof !16

assert_fail65:                                    ; preds = %assert_end64
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.41, ptr nonnull @.str.29, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.12), !dbg !15
  br label %common.ret, !dbg !15

assert_end66:                                     ; preds = %assert_end64
  %114 = getelementptr inbounds nuw i8, ptr %custom_swiglu_float32_1x5632.var_swiglu_shape, i64 8, !dbg !15
  %115 = load i64, ptr %114, align 8, !dbg !15
  %116 = and i64 %115, 4294967295, !dbg !15
  %117 = icmp eq i64 %116, 5632, !dbg !15
  br i1 %117, label %assert_end68, label %assert_fail67, !dbg !15, !prof !16

assert_fail67:                                    ; preds = %assert_end66
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.42, ptr nonnull @.str.29, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.36), !dbg !15
  br label %common.ret, !dbg !15

assert_end68:                                     ; preds = %assert_end66
  %118 = getelementptr inbounds nuw i8, ptr %var_swiglu, i64 40, !dbg !15
  %119 = load i64, ptr %118, align 8, !dbg !15
  %120 = icmp eq i64 %119, 0, !dbg !15
  br i1 %120, label %assert_end70, label %assert_fail69, !dbg !15, !prof !16

assert_fail69:                                    ; preds = %assert_end68
  tail call fastcc void @__tvm_set_raised_12(ptr nonnull @.str.14, i32 8, ptr nonnull @.str.33, ptr nonnull @.str.43, ptr nonnull @.str.29, ptr nonnull @.str.13, ptr nonnull @.str.10, ptr nonnull @.str.9), !dbg !15
  br label %common.ret, !dbg !15

assert_end70:                                     ; preds = %assert_end68
  tail call fastcc void @custom_swiglu_float32_1x5632_compute_(ptr nonnull %gate, ptr nonnull %up, ptr nonnull %swiglu), !dbg !15
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

; Function Attrs: nofree noinline norecurse nosync nounwind memory(argmem: readwrite)
define internal fastcc void @custom_swiglu_float32_1x5632_compute_(ptr noalias readonly align 64 captures(none) %gate, ptr noalias readonly align 64 captures(none) %up, ptr noalias writeonly align 64 captures(none) %swiglu) unnamed_addr #3 !dbg !37 {
entry:
    #dbg_value(ptr %gate, !41, !DIExpression(), !44)
    #dbg_value(ptr %up, !42, !DIExpression(), !44)
    #dbg_value(ptr %swiglu, !43, !DIExpression(), !44)
    #dbg_value(i32 0, !45, !DIExpression(), !44)
  br label %for_begin_i0_i1_fused_1.preheader, !dbg !44

for_begin_i0_i1_fused_1.preheader:                ; preds = %entry, %for_begin_i0_i1_fused_1.preheader
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for_begin_i0_i1_fused_1.preheader ]
    #dbg_value(i64 %indvars.iv, !45, !DIExpression(), !44)
  %0 = shl nuw nsw i64 %indvars.iv, 3
    #dbg_value(i32 0, !46, !DIExpression(), !44)
    #dbg_value(i64 0, !46, !DIExpression(), !44)
    #dbg_value(i64 %0, !47, !DIExpression(), !44)
  %1 = getelementptr inbounds nuw float, ptr %up, i64 %0, !dbg !44
  %2 = load float, ptr %1, align 32, !dbg !44, !tbaa !48
  %3 = getelementptr inbounds nuw float, ptr %gate, i64 %0, !dbg !44
  %4 = load float, ptr %3, align 32, !dbg !44, !tbaa !51
  %5 = fneg float %4, !dbg !44
  %6 = tail call float @llvm.exp.f32(float %5), !dbg !44
  %7 = fadd float %6, 1.000000e+00, !dbg !44
  %8 = fdiv float %4, %7, !dbg !44
  %9 = fmul float %2, %8, !dbg !44
  %10 = getelementptr inbounds nuw float, ptr %swiglu, i64 %0, !dbg !44
  store float %9, ptr %10, align 32, !dbg !44, !tbaa !53
    #dbg_value(i64 1, !46, !DIExpression(), !44)
  %11 = or disjoint i64 %0, 1, !dbg !44
    #dbg_value(i64 %11, !47, !DIExpression(), !44)
  %12 = getelementptr inbounds nuw float, ptr %up, i64 %11, !dbg !44
  %13 = load float, ptr %12, align 4, !dbg !44, !tbaa !48
  %14 = getelementptr inbounds nuw float, ptr %gate, i64 %11, !dbg !44
  %15 = load float, ptr %14, align 4, !dbg !44, !tbaa !51
  %16 = fneg float %15, !dbg !44
  %17 = tail call float @llvm.exp.f32(float %16), !dbg !44
  %18 = fadd float %17, 1.000000e+00, !dbg !44
  %19 = fdiv float %15, %18, !dbg !44
  %20 = fmul float %13, %19, !dbg !44
  %21 = getelementptr inbounds nuw float, ptr %swiglu, i64 %11, !dbg !44
  store float %20, ptr %21, align 4, !dbg !44, !tbaa !53
    #dbg_value(i64 2, !46, !DIExpression(), !44)
  %22 = or disjoint i64 %0, 2, !dbg !44
    #dbg_value(i64 %22, !47, !DIExpression(), !44)
  %23 = getelementptr inbounds nuw float, ptr %up, i64 %22, !dbg !44
  %24 = load float, ptr %23, align 8, !dbg !44, !tbaa !48
  %25 = getelementptr inbounds nuw float, ptr %gate, i64 %22, !dbg !44
  %26 = load float, ptr %25, align 8, !dbg !44, !tbaa !51
  %27 = fneg float %26, !dbg !44
  %28 = tail call float @llvm.exp.f32(float %27), !dbg !44
  %29 = fadd float %28, 1.000000e+00, !dbg !44
  %30 = fdiv float %26, %29, !dbg !44
  %31 = fmul float %24, %30, !dbg !44
  %32 = getelementptr inbounds nuw float, ptr %swiglu, i64 %22, !dbg !44
  store float %31, ptr %32, align 8, !dbg !44, !tbaa !53
    #dbg_value(i64 3, !46, !DIExpression(), !44)
  %33 = or disjoint i64 %0, 3, !dbg !44
    #dbg_value(i64 %33, !47, !DIExpression(), !44)
  %34 = getelementptr inbounds nuw float, ptr %up, i64 %33, !dbg !44
  %35 = load float, ptr %34, align 4, !dbg !44, !tbaa !48
  %36 = getelementptr inbounds nuw float, ptr %gate, i64 %33, !dbg !44
  %37 = load float, ptr %36, align 4, !dbg !44, !tbaa !51
  %38 = fneg float %37, !dbg !44
  %39 = tail call float @llvm.exp.f32(float %38), !dbg !44
  %40 = fadd float %39, 1.000000e+00, !dbg !44
  %41 = fdiv float %37, %40, !dbg !44
  %42 = fmul float %35, %41, !dbg !44
  %43 = getelementptr inbounds nuw float, ptr %swiglu, i64 %33, !dbg !44
  store float %42, ptr %43, align 4, !dbg !44, !tbaa !53
    #dbg_value(i64 4, !46, !DIExpression(), !44)
  %44 = or disjoint i64 %0, 4, !dbg !44
    #dbg_value(i64 %44, !47, !DIExpression(), !44)
  %45 = getelementptr inbounds nuw float, ptr %up, i64 %44, !dbg !44
  %46 = load float, ptr %45, align 16, !dbg !44, !tbaa !48
  %47 = getelementptr inbounds nuw float, ptr %gate, i64 %44, !dbg !44
  %48 = load float, ptr %47, align 16, !dbg !44, !tbaa !51
  %49 = fneg float %48, !dbg !44
  %50 = tail call float @llvm.exp.f32(float %49), !dbg !44
  %51 = fadd float %50, 1.000000e+00, !dbg !44
  %52 = fdiv float %48, %51, !dbg !44
  %53 = fmul float %46, %52, !dbg !44
  %54 = getelementptr inbounds nuw float, ptr %swiglu, i64 %44, !dbg !44
  store float %53, ptr %54, align 16, !dbg !44, !tbaa !53
    #dbg_value(i64 5, !46, !DIExpression(), !44)
  %55 = or disjoint i64 %0, 5, !dbg !44
    #dbg_value(i64 %55, !47, !DIExpression(), !44)
  %56 = getelementptr inbounds nuw float, ptr %up, i64 %55, !dbg !44
  %57 = load float, ptr %56, align 4, !dbg !44, !tbaa !48
  %58 = getelementptr inbounds nuw float, ptr %gate, i64 %55, !dbg !44
  %59 = load float, ptr %58, align 4, !dbg !44, !tbaa !51
  %60 = fneg float %59, !dbg !44
  %61 = tail call float @llvm.exp.f32(float %60), !dbg !44
  %62 = fadd float %61, 1.000000e+00, !dbg !44
  %63 = fdiv float %59, %62, !dbg !44
  %64 = fmul float %57, %63, !dbg !44
  %65 = getelementptr inbounds nuw float, ptr %swiglu, i64 %55, !dbg !44
  store float %64, ptr %65, align 4, !dbg !44, !tbaa !53
    #dbg_value(i64 6, !46, !DIExpression(), !44)
  %66 = or disjoint i64 %0, 6, !dbg !44
    #dbg_value(i64 %66, !47, !DIExpression(), !44)
  %67 = getelementptr inbounds nuw float, ptr %up, i64 %66, !dbg !44
  %68 = load float, ptr %67, align 8, !dbg !44, !tbaa !48
  %69 = getelementptr inbounds nuw float, ptr %gate, i64 %66, !dbg !44
  %70 = load float, ptr %69, align 8, !dbg !44, !tbaa !51
  %71 = fneg float %70, !dbg !44
  %72 = tail call float @llvm.exp.f32(float %71), !dbg !44
  %73 = fadd float %72, 1.000000e+00, !dbg !44
  %74 = fdiv float %70, %73, !dbg !44
  %75 = fmul float %68, %74, !dbg !44
  %76 = getelementptr inbounds nuw float, ptr %swiglu, i64 %66, !dbg !44
  store float %75, ptr %76, align 8, !dbg !44, !tbaa !53
    #dbg_value(i64 7, !46, !DIExpression(), !44)
  %77 = or disjoint i64 %0, 7, !dbg !44
    #dbg_value(i64 %77, !47, !DIExpression(), !44)
  %78 = getelementptr inbounds nuw float, ptr %up, i64 %77, !dbg !44
  %79 = load float, ptr %78, align 4, !dbg !44, !tbaa !48
  %80 = getelementptr inbounds nuw float, ptr %gate, i64 %77, !dbg !44
  %81 = load float, ptr %80, align 4, !dbg !44, !tbaa !51
  %82 = fneg float %81, !dbg !44
  %83 = tail call float @llvm.exp.f32(float %82), !dbg !44
  %84 = fadd float %83, 1.000000e+00, !dbg !44
  %85 = fdiv float %81, %84, !dbg !44
  %86 = fmul float %79, %85, !dbg !44
  %87 = getelementptr inbounds nuw float, ptr %swiglu, i64 %77, !dbg !44
  store float %86, ptr %87, align 4, !dbg !44, !tbaa !53
    #dbg_value(i64 8, !46, !DIExpression(), !44)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !44
    #dbg_value(i64 %indvars.iv.next, !45, !DIExpression(), !44)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 704, !dbg !44
  br i1 %exitcond.not, label %for_end_i0_i1_fused_0, label %for_begin_i0_i1_fused_1.preheader, !dbg !44, !prof !55

for_end_i0_i1_fused_0:                            ; preds = %for_begin_i0_i1_fused_1.preheader
  ret void, !dbg !44
}

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #4

define weak dllexport i32 @__tvm_ffi_main(ptr %0, ptr %1, i32 %2, ptr %3) local_unnamed_addr comdat {
entry:
  %4 = tail call i32 @__tvm_ffi_custom_swiglu_float32_1x5632(ptr poison, ptr %1, i32 %2, ptr poison), !dbg !15
  ret i32 %4, !dbg !15
}

; Function Attrs: nofree nosync nounwind memory(none)
define weak dso_local half @__truncsfhf2(float %a0) local_unnamed_addr #5 {
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
define weak dso_local float @__extendhfsf2(half %a0) local_unnamed_addr #5 {
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
declare float @llvm.fabs.f32(float) #6

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare half @llvm.fabs.f16(half) #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #7

attributes #0 = { "target-cpu"="x86-64" "target-features"="+avx2" }
attributes #1 = { noinline }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #3 = { nofree noinline norecurse nosync nounwind memory(argmem: readwrite) "target-cpu"="x86-64" "target-features"="+avx2" }
attributes #4 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nofree nosync nounwind memory(none) "target-cpu"="x86-64" "target-features"="+avx2" }
attributes #6 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: write) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "TVM", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "IRModule.CodeGenLLVM", directory: ".")
!2 = !{i32 2, !"tvm_target", !"{\22kind\22:\22llvm\22,\22mtriple\22:\22x86_64-pc-windows-msvc\22,\22mcpu\22:\22x86-64\22,\22mattr\22:[\22+avx2\22],\22cl-opt\22:[\22-vectorize-loops:bool=false\22,\22-vectorize-slp:bool=false\22]}"}
!3 = !{i32 4, !"Debug Info Version", i32 3}
!4 = !{i32 4, !"Dwarf Version", i32 4}
!5 = distinct !DISubprogram(name: "__tvm_ffi_custom_swiglu_float32_1x5632", scope: !1, file: !1, type: !6, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !10)
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
!16 = !{!"branch_weights", i32 1048576, i32 1}
!17 = !{!"branch_weights", i32 1, i32 1048576}
!18 = !DILocalVariable(name: "var_gate.type_index", scope: !5, file: !1, type: !8)
!19 = !{!"branch_weights", i32 1, i32 349525, i32 349525, i32 349525}
!20 = !DILocalVariable(name: "var_gate", scope: !5, file: !1, type: !9)
!21 = !DILocalVariable(name: "var_up.type_index", scope: !5, file: !1, type: !8)
!22 = !DILocalVariable(name: "var_up", scope: !5, file: !1, type: !9)
!23 = !DILocalVariable(name: "var_swiglu.type_index", scope: !5, file: !1, type: !8)
!24 = !DILocalVariable(name: "var_swiglu", scope: !5, file: !1, type: !9)
!25 = !DILocalVariable(name: "custom_swiglu_float32_1x5632.var_gate_shape", scope: !5, file: !1, type: !9)
!26 = !DILocalVariable(name: "custom_swiglu_float32_1x5632.var_gate_strides", scope: !5, file: !1, type: !9)
!27 = !DILocalVariable(name: "dev_id", scope: !5, file: !1, type: !8)
!28 = !DILocalVariable(name: "gate", scope: !5, file: !1, type: !29)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30)
!30 = !DIBasicType(name: "float32", size: 32, encoding: DW_ATE_float)
!31 = !DILocalVariable(name: "custom_swiglu_float32_1x5632.var_up_shape", scope: !5, file: !1, type: !9)
!32 = !DILocalVariable(name: "custom_swiglu_float32_1x5632.var_up_strides", scope: !5, file: !1, type: !9)
!33 = !DILocalVariable(name: "up", scope: !5, file: !1, type: !29)
!34 = !DILocalVariable(name: "custom_swiglu_float32_1x5632.var_swiglu_shape", scope: !5, file: !1, type: !9)
!35 = !DILocalVariable(name: "custom_swiglu_float32_1x5632.var_swiglu_strides", scope: !5, file: !1, type: !9)
!36 = !DILocalVariable(name: "swiglu", scope: !5, file: !1, type: !29)
!37 = distinct !DISubprogram(name: "custom_swiglu_float32_1x5632_compute_", scope: !1, file: !1, type: !38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !40)
!38 = !DISubroutineType(cc: DW_CC_nocall, types: !39)
!39 = !{!8, !29, !29, !29}
!40 = !{!41, !42, !43}
!41 = !DILocalVariable(name: "gate", arg: 1, scope: !37, file: !1, type: !29)
!42 = !DILocalVariable(name: "up", arg: 2, scope: !37, file: !1, type: !29)
!43 = !DILocalVariable(name: "swiglu", arg: 3, scope: !37, file: !1, type: !29)
!44 = !DILocation(line: 0, scope: !37)
!45 = !DILocalVariable(name: "i0_i1_fused_0", scope: !37, file: !1, type: !8)
!46 = !DILocalVariable(name: "i0_i1_fused_1", scope: !37, file: !1, type: !8)
!47 = !DILocalVariable(name: "cse_v1", scope: !37, file: !1, type: !8)
!48 = !{!49, !49, i64 0}
!49 = !{!"0000015D61E06D58", !50, i64 0}
!50 = !{!"tvm-tbaa"}
!51 = !{!52, !52, i64 0}
!52 = !{!"0000015D61E06F98", !50, i64 0}
!53 = !{!54, !54, i64 0}
!54 = !{!"0000015D61E06638", !50, i64 0}
!55 = !{!"branch_weights", i32 1, i32 1048575}
