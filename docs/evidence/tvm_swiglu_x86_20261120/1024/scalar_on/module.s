	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
@feat.00 = 0
	.file	"TVMMod"
	.def	__tvm_ffi_custom_swiglu_float32_1024;
	.scl	2;
	.type	32;
	.endef
	.text
	.globl	__tvm_ffi_custom_swiglu_float32_1024
	.p2align	4
__tvm_ffi_custom_swiglu_float32_1024:
.Lfunc_begin0:
	.file	1 "." "IRModule.CodeGenLLVM"
	.loc	1 0 0
.seh_proc __tvm_ffi_custom_swiglu_float32_1024
	pushq	%r15
	.seh_pushreg %r15
	pushq	%r14
	.seh_pushreg %r14
	pushq	%r13
	.seh_pushreg %r13
	pushq	%r12
	.seh_pushreg %r12
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbp
	.seh_pushreg %rbp
	pushq	%rbx
	.seh_pushreg %rbx
	subq	$72, %rsp
	.seh_stackalloc 72
	.seh_endprologue
	cmpl	$3, %r8d
	jne	.LBB0_1
.Ltmp0:
	testq	%rdx, %rdx
	je	.LBB0_3
.Ltmp1:
	movl	(%rdx), %ecx
.Ltmp2:
	cmpl	$63, %ecx
	jg	.LBB0_8
.Ltmp3:
	cmpl	$7, %ecx
	ja	.LBB0_7
.Ltmp4:
	movl	$145, %eax
	btl	%ecx, %eax
	jae	.LBB0_7
.Ltmp5:
.LBB0_8:
	movq	8(%rdx), %rax
	xorl	%r9d, %r9d
	cmpl	$70, %ecx
	movl	$24, %ecx
.Ltmp6:
	cmoveq	%rcx, %r9
	movl	16(%rdx), %r8d
.Ltmp7:
	cmpl	$63, %r8d
	jg	.LBB0_12
.Ltmp8:
	cmpl	$7, %r8d
	ja	.LBB0_11
.Ltmp9:
	movl	$145, %r10d
	btl	%r8d, %r10d
	jae	.LBB0_11
.Ltmp10:
.LBB0_12:
	movq	24(%rdx), %r10
	xorl	%r11d, %r11d
	cmpl	$70, %r8d
	cmoveq	%rcx, %r11
	movl	32(%rdx), %ecx
.Ltmp11:
	cmpl	$63, %ecx
	jg	.LBB0_16
.Ltmp12:
	cmpl	$7, %ecx
	ja	.LBB0_15
.Ltmp13:
	movl	$145, %r8d
.Ltmp14:
	btl	%ecx, %r8d
	jae	.LBB0_15
.Ltmp15:
.LBB0_16:
	xorl	%r8d, %r8d
	cmpl	$70, %ecx
	movl	$24, %esi
	cmovneq	%r8, %rsi
	testq	%rax, %rax
	je	.LBB0_7
.Ltmp16:
	cmpl	$1, 16(%rax,%r9)
	jne	.LBB0_18
.Ltmp17:
	cmpw	$1, 22(%rax,%r9)
	jne	.LBB0_26
.Ltmp18:
	cmpb	$32, 21(%rax,%r9)
	jne	.LBB0_26
.Ltmp19:
	cmpb	$2, 20(%rax,%r9)
	jne	.LBB0_26
.Ltmp20:
	cmpl	$1, 8(%rax,%r9)
	jne	.LBB0_28
.Ltmp21:
	testq	%r10, %r10
	je	.LBB0_11
.Ltmp22:
	cmpl	$1, 16(%r10,%r11)
	jne	.LBB0_31
.Ltmp23:
	cmpw	$1, 22(%r10,%r11)
	jne	.LBB0_37
.Ltmp24:
	cmpb	$32, 21(%r10,%r11)
	jne	.LBB0_37
.Ltmp25:
	cmpb	$2, 20(%r10,%r11)
	jne	.LBB0_37
.Ltmp26:
	cmpl	$1, 8(%r10,%r11)
	jne	.LBB0_39
.Ltmp27:
	movq	40(%rdx), %rdi
.Ltmp28:
	testq	%rdi, %rdi
	je	.LBB0_15
.Ltmp29:
	cmpl	$1, 16(%rdi,%rsi)
	jne	.LBB0_42
.Ltmp30:
	cmpw	$1, 22(%rdi,%rsi)
	jne	.LBB0_48
.Ltmp31:
	cmpb	$32, 21(%rdi,%rsi)
	jne	.LBB0_48
.Ltmp32:
	cmpb	$2, 20(%rdi,%rsi)
	jne	.LBB0_48
.Ltmp33:
	cmpl	$1, 8(%rdi,%rsi)
	jne	.LBB0_50
.Ltmp34:
	movq	24(%rax,%r9), %r15
.Ltmp35:
	movq	32(%rax,%r9), %rbx
.Ltmp36:
	movl	12(%rax,%r9), %ebp
.Ltmp37:
	movq	(%rax,%r9), %rcx
.Ltmp38:
	movq	24(%r10,%r11), %r14
.Ltmp39:
	movq	32(%r10,%r11), %r13
.Ltmp40:
	movq	(%r10,%r11), %rdx
.Ltmp41:
	movq	24(%rdi,%rsi), %r8
.Ltmp42:
	movq	%r8, 64(%rsp)
	movq	32(%rdi,%rsi), %r12
.Ltmp43:
	movq	(%rdi,%rsi), %r8
.Ltmp44:
	testq	%rbx, %rbx
	je	.LBB0_53
.Ltmp45:
	cmpl	$1, (%rbx)
	jne	.LBB0_58
.Ltmp46:
.LBB0_53:
	testq	%rcx, %rcx
	je	.LBB0_54
.Ltmp47:
	testq	%r13, %r13
	je	.LBB0_62
.Ltmp48:
	cmpl	$1, (%r13)
	jne	.LBB0_86
.Ltmp49:
.LBB0_62:
	cmpl	12(%r10,%r11), %ebp
	jne	.LBB0_63
.Ltmp50:
	testq	%rdx, %rdx
	je	.LBB0_65
.Ltmp51:
	testq	%r12, %r12
	je	.LBB0_68
.Ltmp52:
	cmpl	$1, (%r12)
	jne	.LBB0_87
.Ltmp53:
.LBB0_68:
	cmpl	12(%rdi,%rsi), %ebp
	jne	.LBB0_69
.Ltmp54:
	testq	%r8, %r8
	je	.LBB0_71
.Ltmp55:
	cmpl	$1024, (%r15)
	jne	.LBB0_73
.Ltmp56:
	cmpq	$0, 40(%rax,%r9)
	jne	.LBB0_75
.Ltmp57:
	cmpl	$1024, (%r14)
	jne	.LBB0_77
.Ltmp58:
	cmpq	$0, 40(%r10,%r11)
	jne	.LBB0_79
.Ltmp59:
	movq	64(%rsp), %rax
	cmpl	$1024, (%rax)
	jne	.LBB0_81
.Ltmp60:
	cmpq	$0, 40(%rdi,%rsi)
	jne	.LBB0_83
.Ltmp61:
	callq	custom_swiglu_float32_1024_compute_
.Ltmp62:
	xorl	%eax, %eax
.Ltmp63:
.LBB0_85:
	.seh_startepilogue
	addq	$72, %rsp
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	.seh_endepilogue
	retq
.Ltmp64:
.LBB0_7:
	leaq	.L.str.11(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
	leaq	.L.str.8(%rip), %r8
	leaq	.L.str.9(%rip), %r9
	jmp	.LBB0_56
.Ltmp65:
.LBB0_11:
	leaq	.L.str.11(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
	leaq	.L.str.8(%rip), %r8
	leaq	.L.str.12(%rip), %r9
	jmp	.LBB0_56
.Ltmp66:
.LBB0_15:
	leaq	.L.str.11(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp67:
	leaq	.L.str.8(%rip), %r8
	leaq	.L.str.13(%rip), %r9
	jmp	.LBB0_56
.Ltmp68:
.LBB0_1:
	leaq	.L.str.6(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.3(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
	leaq	.L.str.1(%rip), %r8
.Ltmp69:
	leaq	.L.str.2(%rip), %r9
	jmp	.LBB0_56
.Ltmp70:
.LBB0_3:
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, 48(%rsp)
	leaq	.L.str.6(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
	leaq	.L.str.7(%rip), %r8
.Ltmp71:
	leaq	.L.str.4(%rip), %r9
	movl	$4, %edx
.Ltmp72:
	jmp	.LBB0_57
.Ltmp73:
.LBB0_18:
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	jmp	.LBB0_19
.Ltmp74:
.LBB0_26:
	leaq	.L.str.19(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp75:
	jmp	.LBB0_20
.Ltmp76:
.LBB0_28:
	leaq	.L.str.21(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.20(%rip), %rax
.Ltmp77:
.LBB0_19:
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp78:
.LBB0_20:
	leaq	.L.str.15(%rip), %r8
	leaq	.L.str.16(%rip), %r9
	jmp	.LBB0_21
.Ltmp79:
.LBB0_31:
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rcx
.Ltmp80:
	movq	%rcx, 48(%rsp)
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	jmp	.LBB0_32
.Ltmp81:
.LBB0_37:
	leaq	.L.str.19(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp82:
	jmp	.LBB0_33
.Ltmp83:
.LBB0_39:
	leaq	.L.str.21(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.20(%rip), %rax
.Ltmp84:
.LBB0_32:
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp85:
.LBB0_33:
	leaq	.L.str.15(%rip), %r8
	leaq	.L.str.22(%rip), %r9
	jmp	.LBB0_21
.Ltmp86:
.LBB0_42:
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.13(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	jmp	.LBB0_43
.Ltmp87:
.LBB0_48:
	leaq	.L.str.19(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.13(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp88:
	jmp	.LBB0_44
.Ltmp89:
.LBB0_50:
	leaq	.L.str.21(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.13(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.20(%rip), %rax
.Ltmp90:
.LBB0_43:
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp91:
.LBB0_44:
	leaq	.L.str.15(%rip), %r8
	leaq	.L.str.23(%rip), %r9
	jmp	.LBB0_21
.Ltmp92:
.LBB0_58:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.24(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 56(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp93:
	leaq	.L.str.15(%rip), %r8
.Ltmp94:
	leaq	.L.str.16(%rip), %r9
	movl	$7, %edx
.Ltmp95:
	jmp	.LBB0_22
.Ltmp96:
.LBB0_54:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp97:
	leaq	.L.str.16(%rip), %r8
.Ltmp98:
	jmp	.LBB0_55
.Ltmp99:
.LBB0_86:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.24(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 56(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp100:
	leaq	.L.str.15(%rip), %r8
.Ltmp101:
	leaq	.L.str.22(%rip), %r9
	movl	$7, %edx
.Ltmp102:
	jmp	.LBB0_22
.Ltmp103:
.LBB0_63:
	leaq	.L.str.31(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.30(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.29(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp104:
	leaq	.L.str.15(%rip), %r8
.Ltmp105:
	leaq	.L.str.28(%rip), %r9
	jmp	.LBB0_21
.Ltmp106:
.LBB0_65:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp107:
	leaq	.L.str.22(%rip), %r8
.Ltmp108:
	jmp	.LBB0_55
.Ltmp109:
.LBB0_87:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.13(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.24(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 56(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp110:
	leaq	.L.str.15(%rip), %r8
.Ltmp111:
	leaq	.L.str.23(%rip), %r9
	movl	$7, %edx
.Ltmp112:
	jmp	.LBB0_22
.Ltmp113:
.LBB0_69:
	leaq	.L.str.31(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.30(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.13(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.29(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp114:
	leaq	.L.str.15(%rip), %r8
.Ltmp115:
	leaq	.L.str.32(%rip), %r9
	jmp	.LBB0_21
.Ltmp116:
.LBB0_71:
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.13(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp117:
	leaq	.L.str.23(%rip), %r8
.Ltmp118:
.LBB0_55:
	leaq	.L.str.26(%rip), %r9
.Ltmp119:
.LBB0_56:
	movl	$6, %edx
.Ltmp120:
.LBB0_57:
	callq	__tvm_set_raised_6
	movl	$-1, %eax
	jmp	.LBB0_85
.Ltmp121:
.LBB0_73:
	leaq	.L.str.35(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.29(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp122:
	leaq	.L.str.33(%rip), %r8
.Ltmp123:
	leaq	.L.str.34(%rip), %r9
	jmp	.LBB0_21
.Ltmp124:
.LBB0_75:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rcx
.Ltmp125:
	movq	%rcx, 48(%rsp)
	movq	%rax, 40(%rsp)
	leaq	.L.str.29(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
	leaq	.L.str.33(%rip), %r8
.Ltmp126:
	leaq	.L.str.36(%rip), %r9
	jmp	.LBB0_21
.Ltmp127:
.LBB0_77:
	leaq	.L.str.35(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.29(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp128:
	leaq	.L.str.33(%rip), %r8
.Ltmp129:
	leaq	.L.str.37(%rip), %r9
	jmp	.LBB0_21
.Ltmp130:
.LBB0_79:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.29(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp131:
	leaq	.L.str.33(%rip), %r8
.Ltmp132:
	leaq	.L.str.38(%rip), %r9
	jmp	.LBB0_21
.Ltmp133:
.LBB0_81:
	leaq	.L.str.35(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.13(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.29(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp134:
	leaq	.L.str.33(%rip), %r8
.Ltmp135:
	leaq	.L.str.39(%rip), %r9
	jmp	.LBB0_21
.Ltmp136:
.LBB0_83:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.13(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.29(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.14(%rip), %rcx
.Ltmp137:
	leaq	.L.str.33(%rip), %r8
.Ltmp138:
	leaq	.L.str.40(%rip), %r9
.Ltmp139:
.LBB0_21:
	movl	$8, %edx
.Ltmp140:
.LBB0_22:
	callq	__tvm_set_raised_12
	movl	$-1, %eax
	jmp	.LBB0_85
.Ltmp141:
.Lfunc_end0:
	.seh_endproc

	.def	__tvm_set_raised_6;
	.scl	3;
	.type	32;
	.endef
	.p2align	4
__tvm_set_raised_6:
.Lfunc_begin1:
.seh_proc __tvm_set_raised_6
	subq	$88, %rsp
	.seh_stackalloc 88
	.seh_endprologue
	movl	%edx, %eax
	vmovups	128(%rsp), %ymm0
	movq	%r8, 40(%rsp)
	movq	%r9, 48(%rsp)
	vmovups	%ymm0, 56(%rsp)
	leaq	40(%rsp), %rdx
	movl	%eax, %r8d
	vzeroupper
	callq	TVMFFIErrorSetRaisedFromCStrParts
	nop
	.seh_startepilogue
	addq	$88, %rsp
	.seh_endepilogue
	retq
.Lfunc_end1:
	.seh_endproc

	.def	__tvm_set_raised_12;
	.scl	3;
	.type	32;
	.endef
	.p2align	4
__tvm_set_raised_12:
.Lfunc_begin2:
.seh_proc __tvm_set_raised_12
	subq	$136, %rsp
	.seh_stackalloc 136
	.seh_endprologue
	movl	%edx, %eax
	vmovaps	192(%rsp), %xmm0
	vmovaps	176(%rsp), %xmm1
	movq	%r8, 40(%rsp)
	movq	%r9, 48(%rsp)
	vmovups	%xmm1, 56(%rsp)
	leaq	.L.str.4(%rip), %rdx
	movq	%rdx, 72(%rsp)
	leaq	.L.str.5(%rip), %rdx
	movq	%rdx, 80(%rsp)
	vmovups	%xmm0, 88(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%ymm0, 104(%rsp)
	leaq	40(%rsp), %rdx
	movl	%eax, %r8d
	vzeroupper
	callq	TVMFFIErrorSetRaisedFromCStrParts
	nop
	.seh_startepilogue
	addq	$136, %rsp
	.seh_endepilogue
	retq
.Lfunc_end2:
	.seh_endproc

	.def	custom_swiglu_float32_1024_compute_;
	.scl	3;
	.type	32;
	.endef
	.globl	__real@80000000
	.section	.rdata,"dr",discard,__real@80000000
	.p2align	2, 0x0
__real@80000000:
	.long	0x80000000
	.globl	__real@3f800000
	.section	.rdata,"dr",discard,__real@3f800000
	.p2align	2, 0x0
__real@3f800000:
	.long	0x3f800000
	.text
	.p2align	4
custom_swiglu_float32_1024_compute_:
.Lfunc_begin3:
	.loc	1 0 0
	pushq	%r14
	pushq	%rsi
	pushq	%rdi
	pushq	%rbx
	subq	$88, %rsp
	vmovaps	%xmm8, 64(%rsp)
	vmovaps	%xmm7, 48(%rsp)
	vmovaps	%xmm6, 32(%rsp)
	movq	%r8, %rsi
	movq	%rdx, %rdi
	movq	%rcx, %rbx
	xorl	%r14d, %r14d
.Ltmp142:
	vbroadcastss	__real@80000000(%rip), %xmm6
	vmovss	__real@3f800000(%rip), %xmm7
.Ltmp143:
	.p2align	4
.LBB3_1:
	vmovss	(%rbx,%r14), %xmm8
	vxorps	%xmm6, %xmm8, %xmm0
	callq	expf
	vaddss	%xmm7, %xmm0, %xmm0
	vdivss	%xmm0, %xmm8, %xmm0
	vmulss	(%rdi,%r14), %xmm0, %xmm0
	vmovss	%xmm0, (%rsi,%r14)
.Ltmp144:
	vmovss	4(%rbx,%r14), %xmm8
	vxorps	%xmm6, %xmm8, %xmm0
	callq	expf
	vaddss	%xmm7, %xmm0, %xmm0
	vdivss	%xmm0, %xmm8, %xmm0
	vmulss	4(%rdi,%r14), %xmm0, %xmm0
	vmovss	%xmm0, 4(%rsi,%r14)
.Ltmp145:
	vmovss	8(%rbx,%r14), %xmm8
	vxorps	%xmm6, %xmm8, %xmm0
	callq	expf
	vaddss	%xmm7, %xmm0, %xmm0
	vdivss	%xmm0, %xmm8, %xmm0
	vmulss	8(%rdi,%r14), %xmm0, %xmm0
	vmovss	%xmm0, 8(%rsi,%r14)
.Ltmp146:
	vmovss	12(%rbx,%r14), %xmm8
	vxorps	%xmm6, %xmm8, %xmm0
	callq	expf
	vaddss	%xmm7, %xmm0, %xmm0
	vdivss	%xmm0, %xmm8, %xmm0
	vmulss	12(%rdi,%r14), %xmm0, %xmm0
	vmovss	%xmm0, 12(%rsi,%r14)
.Ltmp147:
	vmovss	16(%rbx,%r14), %xmm8
	vxorps	%xmm6, %xmm8, %xmm0
	callq	expf
	vaddss	%xmm7, %xmm0, %xmm0
	vdivss	%xmm0, %xmm8, %xmm0
	vmulss	16(%rdi,%r14), %xmm0, %xmm0
	vmovss	%xmm0, 16(%rsi,%r14)
.Ltmp148:
	vmovss	20(%rbx,%r14), %xmm8
	vxorps	%xmm6, %xmm8, %xmm0
	callq	expf
	vaddss	%xmm7, %xmm0, %xmm0
	vdivss	%xmm0, %xmm8, %xmm0
	vmulss	20(%rdi,%r14), %xmm0, %xmm0
	vmovss	%xmm0, 20(%rsi,%r14)
.Ltmp149:
	vmovss	24(%rbx,%r14), %xmm8
	vxorps	%xmm6, %xmm8, %xmm0
	callq	expf
	vaddss	%xmm7, %xmm0, %xmm0
	vdivss	%xmm0, %xmm8, %xmm0
	vmulss	24(%rdi,%r14), %xmm0, %xmm0
	vmovss	%xmm0, 24(%rsi,%r14)
.Ltmp150:
	vmovss	28(%rbx,%r14), %xmm8
	vxorps	%xmm6, %xmm8, %xmm0
	callq	expf
	vaddss	%xmm7, %xmm0, %xmm0
	vdivss	%xmm0, %xmm8, %xmm0
	vmulss	28(%rdi,%r14), %xmm0, %xmm0
	vmovss	%xmm0, 28(%rsi,%r14)
.Ltmp151:
	addq	$32, %r14
.Ltmp152:
	cmpq	$4096, %r14
	jne	.LBB3_1
.Ltmp153:
	vmovaps	32(%rsp), %xmm6
	vmovaps	48(%rsp), %xmm7
	vmovaps	64(%rsp), %xmm8
	addq	$88, %rsp
	popq	%rbx
.Ltmp154:
	popq	%rdi
.Ltmp155:
	popq	%rsi
.Ltmp156:
	popq	%r14
	retq
.Ltmp157:
.Lfunc_end3:

	.def	__tvm_ffi_main;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,__tvm_ffi_main
	.globl	__tvm_ffi_main
	.p2align	4
__tvm_ffi_main:
.Lfunc_begin4:
	jmp	__tvm_ffi_custom_swiglu_float32_1024
.Lfunc_end4:

	.def	__truncsfhf2;
	.scl	2;
	.type	32;
	.endef
	.text
	.weak	__truncsfhf2
	.p2align	4
__truncsfhf2:
.Lfunc_begin5:
	vmovd	%xmm0, %eax
	movl	%eax, %edx
	andl	$2147483647, %edx
	leal	-947912704(%rdx), %ecx
	leal	-1199570944(%rdx), %r8d
	cmpl	%r8d, %ecx
	jae	.LBB5_5
	movl	%eax, %edx
	shrl	$13, %edx
	movl	%eax, %r8d
	andl	$8191, %r8d
	cmpl	$4097, %r8d
	jb	.LBB5_3
	addl	$-114687, %edx
	movl	%edx, %ecx
	jmp	.LBB5_13
.LBB5_5:
	cmpl	$2139095041, %edx
	jb	.LBB5_7
	movl	%eax, %ecx
	shrl	$13, %ecx
	andl	$511, %ecx
	orl	$32256, %ecx
	jmp	.LBB5_13
.LBB5_3:
	leal	-114688(%rdx), %ecx
	cmpl	$4096, %r8d
	jne	.LBB5_13
	andl	$1, %edx
	addl	%edx, %ecx
	jmp	.LBB5_13
.LBB5_7:
	movl	$31744, %ecx
	cmpl	$1199570943, %edx
	ja	.LBB5_13
	xorl	%ecx, %ecx
	cmpl	$754974720, %edx
	jb	.LBB5_13
	shrl	$23, %edx
	movl	%eax, %r8d
	andl	$8388607, %r8d
	orl	$8388608, %r8d
	leal	-81(%rdx), %ecx
	movl	%r8d, %r9d
	shll	%cl, %r9d
	xorl	%r10d, %r10d
	testl	%r9d, %r9d
	setne	%r10b
	movb	$113, %cl
	subb	%dl, %cl
	shrl	%cl, %r8d
	movl	%r8d, %ecx
	shrl	$13, %ecx
	andl	$8191, %r8d
	orl	%r10d, %r8d
	cmpl	$4097, %r8d
	jb	.LBB5_11
	incl	%ecx
	jmp	.LBB5_13
.LBB5_11:
	cmpl	$4096, %r8d
	jne	.LBB5_13
	movl	%ecx, %edx
	andl	$1, %edx
	addl	%edx, %ecx
.LBB5_13:
	shrl	$16, %eax
	andl	$32768, %eax
	orl	%ecx, %eax
	vpinsrw	$0, %eax, %xmm0, %xmm0
	retq
.Lfunc_end5:

	.def	__extendhfsf2;
	.scl	2;
	.type	32;
	.endef
	.weak	__extendhfsf2
	.p2align	4
__extendhfsf2:
.Lfunc_begin6:
	vpextrw	$0, %xmm0, %eax
	movl	%eax, %edx
	andl	$32767, %edx
	leal	-1024(%rdx), %ecx
	movzwl	%cx, %ecx
	cmpl	$30719, %ecx
	ja	.LBB6_2
	shll	$13, %edx
	addl	$939524096, %edx
	jmp	.LBB6_7
.LBB6_2:
	cmpl	$31744, %edx
	jb	.LBB6_4
	shll	$13, %edx
	orl	$2139095040, %edx
	jmp	.LBB6_7
.LBB6_4:
	testl	%edx, %edx
	je	.LBB6_5
	movl	%edx, %ecx
	shrl	$8, %ecx
	xorl	%r8d, %r8d
	cmpl	$256, %edx
	setb	%r8b
	cmovbl	%edx, %ecx
	leal	24(,%r8,8), %r9d
	movl	%ecx, %r10d
	shrl	$4, %r10d
	cmpl	$16, %ecx
	leal	20(,%r8,8), %r8d
	cmovbl	%ecx, %r10d
	cmovbl	%r9d, %r8d
	movl	%r10d, %ecx
	shrl	$2, %ecx
	leal	-2(%r8), %r9d
	cmpl	$4, %r10d
	cmovbl	%r10d, %ecx
	cmovbl	%r8d, %r9d
	movl	%ecx, %r8d
	negl	%r8d
	cmpl	$2, %ecx
	movl	$-2, %r10d
	cmovbl	%r8d, %r10d
	addl	%r9d, %r10d
	leal	-8(%r10), %ecx
	shll	%cl, %edx
	xorl	$8388608, %edx
	shll	$23, %r10d
	movl	$1124073472, %ecx
	subl	%r10d, %ecx
	orl	%edx, %ecx
	movl	%ecx, %edx
	jmp	.LBB6_7
.LBB6_5:
	xorl	%edx, %edx
.LBB6_7:
	andl	$32768, %eax
	shll	$16, %eax
	orl	%edx, %eax
	vmovd	%eax, %xmm0
	retq
.Lfunc_end6:

	.section	.rdata,"dr"
.L.str:
	.asciz	"TypeError"

.L.str.1:
	.asciz	"Expected "

.L.str.2:
	.asciz	"3"

.L.str.3:
	.asciz	" arguments"

.L.str.4:
	.asciz	" when calling:\n  `"

.L.str.5:
	.asciz	"custom_swiglu_float32_1024(gate: Tensor([1024], float32), up: Tensor([1024], float32), swiglu: Tensor([1024], float32))"

.L.str.6:
	.asciz	"`"

.L.str.7:
	.asciz	"args pointer is NULL"

.L.str.8:
	.asciz	"Mismatched type on argument #"

.L.str.9:
	.asciz	"0"

.L.str.10:
	.asciz	"`,\n  expected "

.L.str.11:
	.asciz	"Tensor"

.L.str.12:
	.asciz	"1"

.L.str.13:
	.asciz	"2"

.L.str.14:
	.asciz	"ValueError"

.L.str.15:
	.asciz	"Mismatched "

.L.str.16:
	.asciz	"gate"

.L.str.17:
	.asciz	".ndim on argument #"

.L.str.18:
	.asciz	".dtype on argument #"

.L.str.19:
	.asciz	"float32"

.L.str.20:
	.asciz	".device_type on argument #"

.L.str.21:
	.asciz	"cpu"

.L.str.22:
	.asciz	"up"

.L.str.23:
	.asciz	"swiglu"

.L.str.24:
	.asciz	".strides on argument #"

.L.str.25:
	.asciz	"`,\n  expected to be compact array"

.L.str.26:
	.asciz	" data pointer is NULL on argument #"

.L.str.27:
	.asciz	"`,\n  expected non-NULL data pointer"

.L.str.28:
	.asciz	"up.device_id"

.L.str.29:
	.asciz	" on argument #"

.L.str.30:
	.asciz	"`,\n  expected to match "

.L.str.31:
	.asciz	"gate.device_id"

.L.str.32:
	.asciz	"swiglu.device_id"

.L.str.33:
	.asciz	"Invalid "

.L.str.34:
	.asciz	"gate.shape[0]"

.L.str.35:
	.asciz	"1024"

.L.str.36:
	.asciz	"gate.byte_offset"

.L.str.37:
	.asciz	"up.shape[0]"

.L.str.38:
	.asciz	"up.byte_offset"

.L.str.39:
	.asciz	"swiglu.shape[0]"

.L.str.40:
	.asciz	"swiglu.byte_offset"

	.section	.drectve,"yni"
	.ascii	" /EXPORT:__tvm_ffi_custom_swiglu_float32_1024"
	.ascii	" /EXPORT:__tvm_ffi_main"
	.section	.debug$S,"dr"
	.p2align	2, 0x0
	.long	4
	.long	241
	.long	.Ltmp159-.Ltmp158
.Ltmp158:
	.short	.Ltmp161-.Ltmp160
.Ltmp160:
	.short	4353
	.long	0
	.byte	0
	.p2align	2, 0x0
.Ltmp161:
	.short	.Ltmp163-.Ltmp162
.Ltmp162:
	.short	4412
	.long	0
	.short	208
	.short	0
	.short	0
	.short	0
	.short	0
	.short	22010
	.short	0
	.short	0
	.short	0
	.asciz	"TVM"
	.p2align	2, 0x0
.Ltmp163:
.Ltmp159:
	.p2align	2, 0x0
	.section	.debug_loc,"dr"
.Ldebug_loc0:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin0-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp64-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	.Ltmp64-.Lfunc_begin0
	.quad	.Ltmp72-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp72-.Lfunc_begin0
	.quad	.Ltmp73-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	.Ltmp73-.Lfunc_begin0
	.quad	.Ltmp92-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Lfunc_end0-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc1:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin0-.Lfunc_begin0
	.quad	.Ltmp7-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp7-.Lfunc_begin0
	.quad	.Ltmp68-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	.Ltmp68-.Lfunc_begin0
	.quad	.Ltmp69-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp69-.Lfunc_begin0
	.quad	.Ltmp70-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	.Ltmp70-.Lfunc_begin0
	.quad	.Ltmp71-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Lfunc_end0-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc2:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp6-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	0
	.quad	0
.Ldebug_loc3:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp7-.Lfunc_begin0
	.quad	.Ltmp14-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	0
	.quad	0
.Ldebug_loc4:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp11-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp66-.Lfunc_begin0
	.quad	.Ltmp67-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp73-.Lfunc_begin0
	.quad	.Ltmp75-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp76-.Lfunc_begin0
	.quad	.Ltmp78-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp79-.Lfunc_begin0
	.quad	.Ltmp80-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp81-.Lfunc_begin0
	.quad	.Ltmp82-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp83-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp88-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp89-.Lfunc_begin0
	.quad	.Ltmp91-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	0
	.quad	0
.Ldebug_loc5:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.short	2
	.byte	127
	.byte	0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.short	2
	.byte	127
	.byte	0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.short	2
	.byte	127
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc6:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc7:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.short	1
	.byte	86
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.short	1
	.byte	86
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.short	1
	.byte	86
	.quad	0
	.quad	0
.Ldebug_loc8:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp62-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp93-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp96-.Lfunc_begin0
	.quad	.Ltmp97-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp99-.Lfunc_begin0
	.quad	.Ltmp100-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp103-.Lfunc_begin0
	.quad	.Ltmp104-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp106-.Lfunc_begin0
	.quad	.Ltmp107-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp109-.Lfunc_begin0
	.quad	.Ltmp110-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp113-.Lfunc_begin0
	.quad	.Ltmp114-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp116-.Lfunc_begin0
	.quad	.Ltmp117-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp122-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp124-.Lfunc_begin0
	.quad	.Ltmp125-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp127-.Lfunc_begin0
	.quad	.Ltmp128-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp130-.Lfunc_begin0
	.quad	.Ltmp131-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp133-.Lfunc_begin0
	.quad	.Ltmp134-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp136-.Lfunc_begin0
	.quad	.Ltmp137-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc9:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc10:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.short	2
	.byte	125
	.byte	0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.short	2
	.byte	125
	.byte	0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.short	2
	.byte	125
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc11:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp62-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp95-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp96-.Lfunc_begin0
	.quad	.Ltmp102-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp103-.Lfunc_begin0
	.quad	.Ltmp112-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp113-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc12:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.short	4
	.byte	119
	.byte	192
	.byte	0
	.byte	6
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.short	4
	.byte	119
	.byte	192
	.byte	0
	.byte	6
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.short	4
	.byte	119
	.byte	192
	.byte	0
	.byte	6
	.quad	0
	.quad	0
.Ldebug_loc13:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp63-.Lfunc_begin0
	.short	2
	.byte	124
	.byte	0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp119-.Lfunc_begin0
	.short	2
	.byte	124
	.byte	0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.short	2
	.byte	124
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc14:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp62-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp94-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp96-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp99-.Lfunc_begin0
	.quad	.Ltmp101-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp103-.Lfunc_begin0
	.quad	.Ltmp105-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp106-.Lfunc_begin0
	.quad	.Ltmp108-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp109-.Lfunc_begin0
	.quad	.Ltmp111-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp113-.Lfunc_begin0
	.quad	.Ltmp115-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp116-.Lfunc_begin0
	.quad	.Ltmp118-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp121-.Lfunc_begin0
	.quad	.Ltmp123-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp124-.Lfunc_begin0
	.quad	.Ltmp126-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp127-.Lfunc_begin0
	.quad	.Ltmp129-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp130-.Lfunc_begin0
	.quad	.Ltmp132-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp133-.Lfunc_begin0
	.quad	.Ltmp135-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp136-.Lfunc_begin0
	.quad	.Ltmp138-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc15:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin3-.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp154-.Lfunc_begin0
	.short	1
	.byte	83
	.quad	.Ltmp154-.Lfunc_begin0
	.quad	.Lfunc_end3-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc16:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin3-.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp155-.Lfunc_begin0
	.short	1
	.byte	85
	.quad	.Ltmp155-.Lfunc_begin0
	.quad	.Lfunc_end3-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc17:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin3-.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp156-.Lfunc_begin0
	.short	1
	.byte	84
	.quad	.Ltmp156-.Lfunc_begin0
	.quad	.Lfunc_end3-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc18:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp142-.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	0
	.byte	159
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp151-.Lfunc_begin0
	.short	6
	.byte	126
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	159
	.quad	.Ltmp151-.Lfunc_begin0
	.quad	.Ltmp152-.Lfunc_begin0
	.short	9
	.byte	126
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	17
	.byte	1
	.byte	34
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc19:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp144-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	0
	.byte	159
	.quad	.Ltmp144-.Lfunc_begin0
	.quad	.Ltmp145-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	1
	.byte	159
	.quad	.Ltmp145-.Lfunc_begin0
	.quad	.Ltmp146-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	2
	.byte	159
	.quad	.Ltmp146-.Lfunc_begin0
	.quad	.Ltmp147-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	3
	.byte	159
	.quad	.Ltmp147-.Lfunc_begin0
	.quad	.Ltmp148-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	4
	.byte	159
	.quad	.Ltmp148-.Lfunc_begin0
	.quad	.Ltmp149-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	5
	.byte	159
	.quad	.Ltmp149-.Lfunc_begin0
	.quad	.Ltmp150-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	6
	.byte	159
	.quad	.Ltmp150-.Lfunc_begin0
	.quad	.Ltmp151-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	7
	.byte	159
	.quad	.Ltmp151-.Lfunc_begin0
	.quad	.Lfunc_end3-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	8
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc20:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp144-.Lfunc_begin0
	.short	9
	.byte	126
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	17
	.byte	8
	.byte	30
	.byte	159
	.quad	.Ltmp144-.Lfunc_begin0
	.quad	.Ltmp145-.Lfunc_begin0
	.short	12
	.byte	126
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	17
	.byte	8
	.byte	30
	.byte	17
	.byte	1
	.byte	34
	.byte	159
	.quad	.Ltmp145-.Lfunc_begin0
	.quad	.Ltmp146-.Lfunc_begin0
	.short	12
	.byte	126
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	17
	.byte	8
	.byte	30
	.byte	17
	.byte	2
	.byte	34
	.byte	159
	.quad	.Ltmp146-.Lfunc_begin0
	.quad	.Ltmp147-.Lfunc_begin0
	.short	12
	.byte	126
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	17
	.byte	8
	.byte	30
	.byte	17
	.byte	3
	.byte	34
	.byte	159
	.quad	.Ltmp147-.Lfunc_begin0
	.quad	.Ltmp148-.Lfunc_begin0
	.short	12
	.byte	126
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	17
	.byte	8
	.byte	30
	.byte	17
	.byte	4
	.byte	34
	.byte	159
	.quad	.Ltmp148-.Lfunc_begin0
	.quad	.Ltmp149-.Lfunc_begin0
	.short	12
	.byte	126
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	17
	.byte	8
	.byte	30
	.byte	17
	.byte	5
	.byte	34
	.byte	159
	.quad	.Ltmp149-.Lfunc_begin0
	.quad	.Ltmp150-.Lfunc_begin0
	.short	12
	.byte	126
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	17
	.byte	8
	.byte	30
	.byte	17
	.byte	6
	.byte	34
	.byte	159
	.quad	.Ltmp150-.Lfunc_begin0
	.quad	.Ltmp152-.Lfunc_begin0
	.short	12
	.byte	126
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	17
	.byte	8
	.byte	30
	.byte	17
	.byte	7
	.byte	34
	.byte	159
	.quad	0
	.quad	0
	.section	.debug_abbrev,"dr"
	.byte	1
	.byte	17
	.byte	1
	.byte	37
	.byte	14
	.byte	19
	.byte	5
	.byte	3
	.byte	14
	.byte	16
	.byte	23
	.byte	27
	.byte	14
	.ascii	"\264B"
	.byte	25
	.byte	17
	.byte	1
	.byte	85
	.byte	23
	.byte	0
	.byte	0
	.byte	2
	.byte	46
	.byte	1
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	64
	.byte	24
	.byte	3
	.byte	14
	.byte	39
	.byte	25
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	3
	.byte	5
	.byte	0
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	4
	.byte	5
	.byte	0
	.byte	2
	.byte	23
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	5
	.byte	52
	.byte	0
	.byte	2
	.byte	23
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	6
	.byte	46
	.byte	1
	.byte	17
	.byte	1
	.byte	18
	.byte	6
	.byte	64
	.byte	24
	.byte	3
	.byte	14
	.byte	39
	.byte	25
	.byte	54
	.byte	11
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	7
	.byte	36
	.byte	0
	.byte	3
	.byte	14
	.byte	62
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	8
	.byte	15
	.byte	0
	.byte	0
	.byte	0
	.byte	9
	.byte	15
	.byte	0
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_info,"dr"
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0
.Ldebug_info_start0:
	.short	4
	.secrel32	.debug_abbrev
	.byte	8
	.byte	1
	.secrel32	.Linfo_string0
	.short	2
	.secrel32	.Linfo_string1
	.secrel32	.Lline_table_start0
	.secrel32	.Linfo_string2

	.quad	0
	.secrel32	.Ldebug_ranges0
	.byte	2
	.quad	.Lfunc_begin0
	.long	.Lfunc_end0-.Lfunc_begin0
	.byte	1
	.byte	87
	.secrel32	.Linfo_string3

	.long	382
	.byte	3
	.secrel32	.Linfo_string22
	.long	389
	.byte	4
	.secrel32	.Ldebug_loc0
	.secrel32	.Linfo_string6
	.long	389
	.byte	4
	.secrel32	.Ldebug_loc1
	.secrel32	.Linfo_string7
	.long	382
	.byte	3
	.secrel32	.Linfo_string23
	.long	389
	.byte	5
	.secrel32	.Ldebug_loc2
	.secrel32	.Linfo_string8
	.long	382
	.byte	5
	.secrel32	.Ldebug_loc3
	.secrel32	.Linfo_string9
	.long	382
	.byte	5
	.secrel32	.Ldebug_loc4
	.secrel32	.Linfo_string10
	.long	382
	.byte	5
	.secrel32	.Ldebug_loc5
	.secrel32	.Linfo_string11
	.long	389
	.byte	5
	.secrel32	.Ldebug_loc6
	.secrel32	.Linfo_string12
	.long	389
	.byte	5
	.secrel32	.Ldebug_loc7
	.secrel32	.Linfo_string13
	.long	382
	.byte	5
	.secrel32	.Ldebug_loc8
	.secrel32	.Linfo_string14
	.long	390
	.byte	5
	.secrel32	.Ldebug_loc9
	.secrel32	.Linfo_string16
	.long	389
	.byte	5
	.secrel32	.Ldebug_loc10
	.secrel32	.Linfo_string17
	.long	389
	.byte	5
	.secrel32	.Ldebug_loc11
	.secrel32	.Linfo_string18
	.long	390
	.byte	5
	.secrel32	.Ldebug_loc12
	.secrel32	.Linfo_string19
	.long	389
	.byte	5
	.secrel32	.Ldebug_loc13
	.secrel32	.Linfo_string20
	.long	389
	.byte	5
	.secrel32	.Ldebug_loc14
	.secrel32	.Linfo_string21
	.long	390
	.byte	0
	.byte	6
	.quad	.Lfunc_begin3
	.long	.Lfunc_end3-.Lfunc_begin3
	.byte	1
	.byte	87
	.secrel32	.Linfo_string5

	.byte	3
	.long	382
	.byte	4
	.secrel32	.Ldebug_loc15
	.secrel32	.Linfo_string14
	.long	390
	.byte	4
	.secrel32	.Ldebug_loc16
	.secrel32	.Linfo_string18
	.long	390
	.byte	4
	.secrel32	.Ldebug_loc17
	.secrel32	.Linfo_string21
	.long	390
	.byte	5
	.secrel32	.Ldebug_loc18
	.secrel32	.Linfo_string24
	.long	382
	.byte	5
	.secrel32	.Ldebug_loc19
	.secrel32	.Linfo_string25
	.long	382
	.byte	5
	.secrel32	.Ldebug_loc20
	.secrel32	.Linfo_string26
	.long	382
	.byte	0
	.byte	7
	.secrel32	.Linfo_string4
	.byte	5
	.byte	4
	.byte	8
	.byte	9
	.long	395
	.byte	7
	.secrel32	.Linfo_string15
	.byte	4
	.byte	4
	.byte	0
.Ldebug_info_end0:
	.section	.debug_ranges,"dr"
.Ldebug_ranges0:
	.quad	.Lfunc_begin0
	.quad	.Lfunc_end0
	.quad	.Lfunc_begin3
	.quad	.Lfunc_end3
	.quad	0
	.quad	0
	.section	.debug_str,"dr"
.Linfo_string0:
	.asciz	"TVM"
.Linfo_string1:
	.asciz	"IRModule.CodeGenLLVM"
.Linfo_string2:
	.asciz	"."
.Linfo_string3:
	.asciz	"__tvm_ffi_custom_swiglu_float32_1024"
.Linfo_string4:
	.asciz	"int32"
.Linfo_string5:
	.asciz	"custom_swiglu_float32_1024_compute_"
.Linfo_string6:
	.asciz	"args"
.Linfo_string7:
	.asciz	"num_args"
.Linfo_string8:
	.asciz	"var_gate.type_index"
.Linfo_string9:
	.asciz	"var_up.type_index"
.Linfo_string10:
	.asciz	"var_swiglu.type_index"
.Linfo_string11:
	.asciz	"custom_swiglu_float32_1024.var_gate_shape"
.Linfo_string12:
	.asciz	"custom_swiglu_float32_1024.var_gate_strides"
.Linfo_string13:
	.asciz	"dev_id"
.Linfo_string14:
	.asciz	"gate"
.Linfo_string15:
	.asciz	"float32"
.Linfo_string16:
	.asciz	"custom_swiglu_float32_1024.var_up_shape"
.Linfo_string17:
	.asciz	"custom_swiglu_float32_1024.var_up_strides"
.Linfo_string18:
	.asciz	"up"
.Linfo_string19:
	.asciz	"custom_swiglu_float32_1024.var_swiglu_shape"
.Linfo_string20:
	.asciz	"custom_swiglu_float32_1024.var_swiglu_strides"
.Linfo_string21:
	.asciz	"swiglu"
.Linfo_string22:
	.asciz	"self_handle"
.Linfo_string23:
	.asciz	"result"
.Linfo_string24:
	.asciz	"i0_0"
.Linfo_string25:
	.asciz	"i0_1"
.Linfo_string26:
	.asciz	"cse_v1"
	.section	.debug_pubnames,"dr"
	.long	.LpubNames_end0-.LpubNames_start0
.LpubNames_start0:
	.short	2
	.secrel32	.Lcu_begin0
	.long	403
	.long	42
	.asciz	"__tvm_ffi_custom_swiglu_float32_1024"
	.long	279
	.asciz	"custom_swiglu_float32_1024_compute_"
	.long	0
.LpubNames_end0:
	.section	.debug_pubtypes,"dr"
	.long	.LpubTypes_end0-.LpubTypes_start0
.LpubTypes_start0:
	.short	2
	.secrel32	.Lcu_begin0
	.long	403
	.long	382
	.asciz	"int32"
	.long	395
	.asciz	"float32"
	.long	0
.LpubTypes_end0:
	.globl	_fltused
	.section	.debug_line,"dr"
.Lline_table_start0:
