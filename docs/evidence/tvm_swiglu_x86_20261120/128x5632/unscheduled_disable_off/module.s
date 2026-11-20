	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
@feat.00 = 0
	.file	"TVMMod"
	.def	__tvm_ffi_contract_silu;
	.scl	2;
	.type	32;
	.endef
	.text
	.globl	__tvm_ffi_contract_silu
	.p2align	4
__tvm_ffi_contract_silu:
.Lfunc_begin0:
	.file	1 "." "IRModule.CodeGenLLVM"
	.loc	1 0 0
.seh_proc __tvm_ffi_contract_silu
	pushq	%r14
	.seh_pushreg %r14
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbx
	.seh_pushreg %rbx
	subq	$72, %rsp
	.seh_stackalloc 72
	.seh_endprologue
	cmpl	$2, %r8d
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
	xorl	%r8d, %r8d
.Ltmp6:
	cmpl	$70, %ecx
	movl	$24, %ecx
.Ltmp7:
	cmoveq	%rcx, %r8
	movl	16(%rdx), %r10d
.Ltmp8:
	cmpl	$63, %r10d
	jg	.LBB0_12
.Ltmp9:
	cmpl	$7, %r10d
	ja	.LBB0_11
.Ltmp10:
	movl	$145, %r9d
.Ltmp11:
	btl	%r10d, %r9d
	jae	.LBB0_11
.Ltmp12:
.LBB0_12:
	xorl	%r9d, %r9d
	cmpl	$70, %r10d
	cmoveq	%rcx, %r9
	testq	%rax, %rax
	je	.LBB0_7
.Ltmp13:
	cmpl	$2, 16(%rax,%r8)
	jne	.LBB0_14
.Ltmp14:
	cmpw	$1, 22(%rax,%r8)
	jne	.LBB0_22
.Ltmp15:
	cmpb	$32, 21(%rax,%r8)
	jne	.LBB0_22
.Ltmp16:
	cmpb	$2, 20(%rax,%r8)
	jne	.LBB0_22
.Ltmp17:
	cmpl	$1, 8(%rax,%r8)
	jne	.LBB0_24
.Ltmp18:
	movq	24(%rdx), %r10
.Ltmp19:
	testq	%r10, %r10
	je	.LBB0_11
.Ltmp20:
	cmpl	$2, 16(%r10,%r9)
	jne	.LBB0_27
.Ltmp21:
	cmpw	$1, 22(%r10,%r9)
	jne	.LBB0_33
.Ltmp22:
	cmpb	$32, 21(%r10,%r9)
	jne	.LBB0_33
.Ltmp23:
	cmpb	$2, 20(%r10,%r9)
	jne	.LBB0_33
.Ltmp24:
	cmpl	$1, 8(%r10,%r9)
	jne	.LBB0_35
.Ltmp25:
	movq	24(%rax,%r8), %rsi
.Ltmp26:
	movq	32(%rax,%r8), %r14
.Ltmp27:
	movl	12(%rax,%r8), %edi
.Ltmp28:
	movq	(%rax,%r8), %rcx
.Ltmp29:
	movq	24(%r10,%r9), %r11
.Ltmp30:
	movq	32(%r10,%r9), %rbx
.Ltmp31:
	movq	(%r10,%r9), %rdx
.Ltmp32:
	testq	%r14, %r14
	je	.LBB0_39
.Ltmp33:
	cmpq	$5632, (%r14)
	jne	.LBB0_44
.Ltmp34:
	cmpq	$1, 8(%r14)
	jne	.LBB0_44
.Ltmp35:
.LBB0_39:
	testq	%rcx, %rcx
	je	.LBB0_40
.Ltmp36:
	testq	%rbx, %rbx
	je	.LBB0_49
.Ltmp37:
	cmpq	$5632, (%rbx)
	jne	.LBB0_67
.Ltmp38:
	cmpq	$1, 8(%rbx)
	jne	.LBB0_67
.Ltmp39:
.LBB0_49:
	cmpl	12(%r10,%r9), %edi
	jne	.LBB0_50
.Ltmp40:
	testq	%rdx, %rdx
	je	.LBB0_52
.Ltmp41:
	cmpq	$128, (%rsi)
	jne	.LBB0_54
.Ltmp42:
	cmpq	$5632, 8(%rsi)
	jne	.LBB0_56
.Ltmp43:
	cmpq	$0, 40(%rax,%r8)
	jne	.LBB0_58
.Ltmp44:
	cmpq	$128, (%r11)
	jne	.LBB0_60
.Ltmp45:
	cmpq	$5632, 8(%r11)
	jne	.LBB0_62
.Ltmp46:
	cmpq	$0, 40(%r10,%r9)
	jne	.LBB0_64
.Ltmp47:
	callq	contract_silu_compute_
.Ltmp48:
	xorl	%eax, %eax
.Ltmp49:
.LBB0_66:
	.seh_startepilogue
	addq	$72, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r14
	.seh_endepilogue
	retq
.Ltmp50:
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
	jmp	.LBB0_42
.Ltmp51:
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
	jmp	.LBB0_42
.Ltmp52:
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
.Ltmp53:
	leaq	.L.str.1(%rip), %r8
.Ltmp54:
	leaq	.L.str.2(%rip), %r9
.Ltmp55:
	jmp	.LBB0_42
.Ltmp56:
.LBB0_3:
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, 48(%rsp)
	leaq	.L.str.6(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp57:
	leaq	.L.str.7(%rip), %r8
.Ltmp58:
	leaq	.L.str.4(%rip), %r9
.Ltmp59:
	movl	$4, %edx
.Ltmp60:
	jmp	.LBB0_43
.Ltmp61:
.LBB0_14:
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.16(%rip), %rax
	jmp	.LBB0_15
.Ltmp62:
.LBB0_22:
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
	jmp	.LBB0_16
.Ltmp63:
.LBB0_24:
	leaq	.L.str.20(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.19(%rip), %rax
.Ltmp64:
.LBB0_15:
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp65:
.LBB0_16:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.15(%rip), %r9
	jmp	.LBB0_17
.Ltmp66:
.LBB0_27:
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.16(%rip), %rax
	jmp	.LBB0_28
.Ltmp67:
.LBB0_33:
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
	jmp	.LBB0_29
.Ltmp68:
.LBB0_35:
	leaq	.L.str.20(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.19(%rip), %rax
.Ltmp69:
.LBB0_28:
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp70:
.LBB0_29:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.21(%rip), %r9
	jmp	.LBB0_17
.Ltmp71:
.LBB0_40:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp72:
	leaq	.L.str.15(%rip), %r8
	jmp	.LBB0_41
.Ltmp73:
.LBB0_44:
	leaq	.L.str.23(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.22(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 64(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp74:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.15(%rip), %r9
	movl	$7, %edx
.Ltmp75:
	jmp	.LBB0_18
.Ltmp76:
.LBB0_50:
	leaq	.L.str.29(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.28(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp77:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.26(%rip), %r9
	jmp	.LBB0_17
.Ltmp78:
.LBB0_67:
	leaq	.L.str.23(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.22(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 64(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp79:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.21(%rip), %r9
	movl	$7, %edx
.Ltmp80:
	jmp	.LBB0_18
.Ltmp81:
.LBB0_52:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp82:
	leaq	.L.str.21(%rip), %r8
.Ltmp83:
.LBB0_41:
	leaq	.L.str.24(%rip), %r9
.Ltmp84:
.LBB0_42:
	movl	$6, %edx
.Ltmp85:
.LBB0_43:
	callq	__tvm_set_raised_6
	movl	$-1, %eax
	jmp	.LBB0_66
.Ltmp86:
.LBB0_54:
	leaq	.L.str.32(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp87:
	leaq	.L.str.30(%rip), %r8
	leaq	.L.str.31(%rip), %r9
	jmp	.LBB0_17
.Ltmp88:
.LBB0_56:
	leaq	.L.str.34(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp89:
	leaq	.L.str.30(%rip), %r8
	leaq	.L.str.33(%rip), %r9
	jmp	.LBB0_17
.Ltmp90:
.LBB0_58:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rcx
.Ltmp91:
	movq	%rcx, 56(%rsp)
	leaq	.L.str.5(%rip), %rcx
	movq	%rcx, 48(%rsp)
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
	leaq	.L.str.30(%rip), %r8
	leaq	.L.str.35(%rip), %r9
	jmp	.LBB0_17
.Ltmp92:
.LBB0_60:
	leaq	.L.str.32(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp93:
	leaq	.L.str.30(%rip), %r8
	leaq	.L.str.36(%rip), %r9
	jmp	.LBB0_17
.Ltmp94:
.LBB0_62:
	leaq	.L.str.34(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp95:
	leaq	.L.str.30(%rip), %r8
	leaq	.L.str.37(%rip), %r9
	jmp	.LBB0_17
.Ltmp96:
.LBB0_64:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp97:
	leaq	.L.str.30(%rip), %r8
	leaq	.L.str.38(%rip), %r9
.Ltmp98:
.LBB0_17:
	movl	$8, %edx
.Ltmp99:
.LBB0_18:
	callq	__tvm_set_raised_12
	movl	$-1, %eax
	jmp	.LBB0_66
.Ltmp100:
.Lfunc_end0:
	.seh_endproc

	.def	__tvm_ffi_multiply;
	.scl	2;
	.type	32;
	.endef
	.globl	__tvm_ffi_multiply
	.p2align	4
__tvm_ffi_multiply:
.Lfunc_begin1:
	.loc	1 0 0
.seh_proc __tvm_ffi_multiply
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
	subq	$88, %rsp
	.seh_stackalloc 88
	.seh_endprologue
	cmpl	$3, %r8d
	jne	.LBB1_1
.Ltmp101:
	testq	%rdx, %rdx
	je	.LBB1_3
.Ltmp102:
	movl	(%rdx), %ecx
.Ltmp103:
	cmpl	$63, %ecx
	jg	.LBB1_8
.Ltmp104:
	cmpl	$7, %ecx
	ja	.LBB1_7
.Ltmp105:
	movl	$145, %eax
	btl	%ecx, %eax
	jae	.LBB1_7
.Ltmp106:
.LBB1_8:
	movq	8(%rdx), %rax
	xorl	%r9d, %r9d
.Ltmp107:
	cmpl	$70, %ecx
	movl	$24, %ecx
.Ltmp108:
	cmoveq	%rcx, %r9
	movl	16(%rdx), %r8d
.Ltmp109:
	cmpl	$63, %r8d
	jg	.LBB1_12
.Ltmp110:
	cmpl	$7, %r8d
	ja	.LBB1_11
.Ltmp111:
	movl	$145, %r10d
	btl	%r8d, %r10d
	jae	.LBB1_11
.Ltmp112:
.LBB1_12:
	movq	24(%rdx), %r10
	xorl	%r11d, %r11d
	cmpl	$70, %r8d
	cmoveq	%rcx, %r11
	movl	32(%rdx), %ecx
.Ltmp113:
	cmpl	$63, %ecx
	jg	.LBB1_16
.Ltmp114:
	cmpl	$7, %ecx
	ja	.LBB1_15
.Ltmp115:
	movl	$145, %r8d
.Ltmp116:
	btl	%ecx, %r8d
	jae	.LBB1_15
.Ltmp117:
.LBB1_16:
	xorl	%r8d, %r8d
	cmpl	$70, %ecx
	movl	$24, %esi
	cmovneq	%r8, %rsi
	testq	%rax, %rax
	je	.LBB1_7
.Ltmp118:
	cmpl	$2, 16(%rax,%r9)
	jne	.LBB1_18
.Ltmp119:
	cmpw	$1, 22(%rax,%r9)
	jne	.LBB1_26
.Ltmp120:
	cmpb	$32, 21(%rax,%r9)
	jne	.LBB1_26
.Ltmp121:
	cmpb	$2, 20(%rax,%r9)
	jne	.LBB1_26
.Ltmp122:
	cmpl	$1, 8(%rax,%r9)
	jne	.LBB1_28
.Ltmp123:
	testq	%r10, %r10
	je	.LBB1_11
.Ltmp124:
	cmpl	$2, 16(%r10,%r11)
	jne	.LBB1_31
.Ltmp125:
	cmpw	$1, 22(%r10,%r11)
	jne	.LBB1_37
.Ltmp126:
	cmpb	$32, 21(%r10,%r11)
	jne	.LBB1_37
.Ltmp127:
	cmpb	$2, 20(%r10,%r11)
	jne	.LBB1_37
.Ltmp128:
	cmpl	$1, 8(%r10,%r11)
	jne	.LBB1_39
.Ltmp129:
	movq	40(%rdx), %rdi
.Ltmp130:
	testq	%rdi, %rdi
	je	.LBB1_15
.Ltmp131:
	cmpl	$2, 16(%rdi,%rsi)
	jne	.LBB1_42
.Ltmp132:
	cmpw	$1, 22(%rdi,%rsi)
	jne	.LBB1_48
.Ltmp133:
	cmpb	$32, 21(%rdi,%rsi)
	jne	.LBB1_48
.Ltmp134:
	cmpb	$2, 20(%rdi,%rsi)
	jne	.LBB1_48
.Ltmp135:
	cmpl	$1, 8(%rdi,%rsi)
	jne	.LBB1_50
.Ltmp136:
	movq	24(%rax,%r9), %r15
.Ltmp137:
	movq	32(%rax,%r9), %rbx
.Ltmp138:
	movl	12(%rax,%r9), %ebp
.Ltmp139:
	movq	(%rax,%r9), %rcx
.Ltmp140:
	movq	24(%r10,%r11), %r14
.Ltmp141:
	movq	32(%r10,%r11), %r13
.Ltmp142:
	movq	(%r10,%r11), %rdx
.Ltmp143:
	movq	24(%rdi,%rsi), %r8
.Ltmp144:
	movq	%r8, 80(%rsp)
	movq	32(%rdi,%rsi), %r12
.Ltmp145:
	movq	(%rdi,%rsi), %r8
.Ltmp146:
	testq	%rbx, %rbx
	je	.LBB1_54
.Ltmp147:
	cmpq	$5632, (%rbx)
	jne	.LBB1_59
.Ltmp148:
	cmpq	$1, 8(%rbx)
	jne	.LBB1_59
.Ltmp149:
.LBB1_54:
	testq	%rcx, %rcx
	je	.LBB1_55
.Ltmp150:
	testq	%r13, %r13
	je	.LBB1_64
.Ltmp151:
	cmpq	$5632, (%r13)
	jne	.LBB1_95
.Ltmp152:
	cmpq	$1, 8(%r13)
	jne	.LBB1_95
.Ltmp153:
.LBB1_64:
	cmpl	12(%r10,%r11), %ebp
	jne	.LBB1_65
.Ltmp154:
	testq	%rdx, %rdx
	je	.LBB1_67
.Ltmp155:
	testq	%r12, %r12
	je	.LBB1_71
.Ltmp156:
	cmpq	$5632, (%r12)
	jne	.LBB1_96
.Ltmp157:
	cmpq	$1, 8(%r12)
	jne	.LBB1_96
.Ltmp158:
.LBB1_71:
	cmpl	12(%rdi,%rsi), %ebp
	jne	.LBB1_72
.Ltmp159:
	testq	%r8, %r8
	je	.LBB1_74
.Ltmp160:
	cmpq	$128, (%r15)
	jne	.LBB1_76
.Ltmp161:
	cmpq	$5632, 8(%r15)
	jne	.LBB1_78
.Ltmp162:
	cmpq	$0, 40(%rax,%r9)
	jne	.LBB1_80
.Ltmp163:
	cmpq	$128, (%r14)
	jne	.LBB1_82
.Ltmp164:
	cmpq	$5632, 8(%r14)
	jne	.LBB1_84
.Ltmp165:
	cmpq	$0, 40(%r10,%r11)
	jne	.LBB1_86
.Ltmp166:
	movq	80(%rsp), %rax
	cmpq	$128, (%rax)
	jne	.LBB1_88
.Ltmp167:
	cmpq	$5632, 8(%rax)
	jne	.LBB1_90
.Ltmp168:
	cmpq	$0, 40(%rdi,%rsi)
	jne	.LBB1_92
.Ltmp169:
	callq	multiply_compute_
.Ltmp170:
	xorl	%eax, %eax
.Ltmp171:
.LBB1_94:
	.seh_startepilogue
	addq	$88, %rsp
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
.Ltmp172:
.LBB1_7:
	leaq	.L.str.11(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
	leaq	.L.str.8(%rip), %r8
	leaq	.L.str.9(%rip), %r9
	jmp	.LBB1_57
.Ltmp173:
.LBB1_11:
	leaq	.L.str.11(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
	leaq	.L.str.8(%rip), %r8
	leaq	.L.str.12(%rip), %r9
	jmp	.LBB1_57
.Ltmp174:
.LBB1_15:
	leaq	.L.str.11(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp175:
	leaq	.L.str.8(%rip), %r8
	leaq	.L.str.2(%rip), %r9
	jmp	.LBB1_57
.Ltmp176:
.LBB1_1:
	leaq	.L.str.6(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.3(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp177:
	leaq	.L.str.1(%rip), %r8
.Ltmp178:
	leaq	.L.str.39(%rip), %r9
.Ltmp179:
	jmp	.LBB1_57
.Ltmp180:
.LBB1_3:
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, 48(%rsp)
	leaq	.L.str.6(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp181:
	leaq	.L.str.7(%rip), %r8
.Ltmp182:
	leaq	.L.str.4(%rip), %r9
.Ltmp183:
	movl	$4, %edx
.Ltmp184:
	jmp	.LBB1_58
.Ltmp185:
.LBB1_18:
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.16(%rip), %rax
	jmp	.LBB1_19
.Ltmp186:
.LBB1_26:
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp187:
	jmp	.LBB1_20
.Ltmp188:
.LBB1_28:
	leaq	.L.str.20(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.19(%rip), %rax
.Ltmp189:
.LBB1_19:
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp190:
.LBB1_20:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.41(%rip), %r9
	jmp	.LBB1_21
.Ltmp191:
.LBB1_31:
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.16(%rip), %rax
	jmp	.LBB1_32
.Ltmp192:
.LBB1_37:
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp193:
	jmp	.LBB1_33
.Ltmp194:
.LBB1_39:
	leaq	.L.str.20(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.19(%rip), %rax
.Ltmp195:
.LBB1_32:
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp196:
.LBB1_33:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.42(%rip), %r9
	jmp	.LBB1_21
.Ltmp197:
.LBB1_42:
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rcx
.Ltmp198:
	movq	%rcx, 56(%rsp)
	leaq	.L.str.40(%rip), %rcx
	movq	%rcx, 48(%rsp)
	movq	%rax, 40(%rsp)
	leaq	.L.str.16(%rip), %rax
	jmp	.LBB1_43
.Ltmp199:
.LBB1_48:
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp200:
	jmp	.LBB1_44
.Ltmp201:
.LBB1_50:
	leaq	.L.str.20(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.19(%rip), %rax
.Ltmp202:
.LBB1_43:
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp203:
.LBB1_44:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.43(%rip), %r9
	jmp	.LBB1_21
.Ltmp204:
.LBB1_55:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp205:
	leaq	.L.str.41(%rip), %r8
.Ltmp206:
	jmp	.LBB1_56
.Ltmp207:
.LBB1_59:
	leaq	.L.str.23(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.22(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 64(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp208:
	leaq	.L.str.14(%rip), %r8
.Ltmp209:
	leaq	.L.str.41(%rip), %r9
	movl	$7, %edx
.Ltmp210:
	jmp	.LBB1_22
.Ltmp211:
.LBB1_65:
	leaq	.L.str.45(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.28(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp212:
	leaq	.L.str.14(%rip), %r8
.Ltmp213:
	leaq	.L.str.44(%rip), %r9
	jmp	.LBB1_21
.Ltmp214:
.LBB1_95:
	leaq	.L.str.23(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.22(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 64(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp215:
	leaq	.L.str.14(%rip), %r8
.Ltmp216:
	leaq	.L.str.42(%rip), %r9
	movl	$7, %edx
.Ltmp217:
	jmp	.LBB1_22
.Ltmp218:
.LBB1_67:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp219:
	leaq	.L.str.42(%rip), %r8
.Ltmp220:
	jmp	.LBB1_56
.Ltmp221:
.LBB1_72:
	leaq	.L.str.45(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.28(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp222:
	leaq	.L.str.14(%rip), %r8
.Ltmp223:
	leaq	.L.str.46(%rip), %r9
	jmp	.LBB1_21
.Ltmp224:
.LBB1_96:
	leaq	.L.str.23(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.22(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 64(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp225:
	leaq	.L.str.14(%rip), %r8
.Ltmp226:
	leaq	.L.str.43(%rip), %r9
	movl	$7, %edx
.Ltmp227:
	jmp	.LBB1_22
.Ltmp228:
.LBB1_74:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp229:
	leaq	.L.str.43(%rip), %r8
.Ltmp230:
.LBB1_56:
	leaq	.L.str.24(%rip), %r9
.Ltmp231:
.LBB1_57:
	movl	$6, %edx
.Ltmp232:
.LBB1_58:
	callq	__tvm_set_raised_6
	movl	$-1, %eax
	jmp	.LBB1_94
.Ltmp233:
.LBB1_76:
	leaq	.L.str.32(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp234:
	leaq	.L.str.30(%rip), %r8
.Ltmp235:
	leaq	.L.str.47(%rip), %r9
	jmp	.LBB1_21
.Ltmp236:
.LBB1_78:
	leaq	.L.str.34(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp237:
	leaq	.L.str.30(%rip), %r8
.Ltmp238:
	leaq	.L.str.48(%rip), %r9
	jmp	.LBB1_21
.Ltmp239:
.LBB1_80:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rcx
.Ltmp240:
	movq	%rcx, 56(%rsp)
	leaq	.L.str.40(%rip), %rcx
	movq	%rcx, 48(%rsp)
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
	leaq	.L.str.30(%rip), %r8
.Ltmp241:
	leaq	.L.str.49(%rip), %r9
	jmp	.LBB1_21
.Ltmp242:
.LBB1_82:
	leaq	.L.str.32(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp243:
	leaq	.L.str.30(%rip), %r8
.Ltmp244:
	leaq	.L.str.50(%rip), %r9
	jmp	.LBB1_21
.Ltmp245:
.LBB1_84:
	leaq	.L.str.34(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp246:
	leaq	.L.str.30(%rip), %r8
.Ltmp247:
	leaq	.L.str.51(%rip), %r9
	jmp	.LBB1_21
.Ltmp248:
.LBB1_86:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp249:
	leaq	.L.str.30(%rip), %r8
.Ltmp250:
	leaq	.L.str.52(%rip), %r9
	jmp	.LBB1_21
.Ltmp251:
.LBB1_88:
	leaq	.L.str.32(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp252:
	leaq	.L.str.30(%rip), %r8
.Ltmp253:
	leaq	.L.str.53(%rip), %r9
	jmp	.LBB1_21
.Ltmp254:
.LBB1_90:
	leaq	.L.str.34(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp255:
	leaq	.L.str.30(%rip), %r8
.Ltmp256:
	leaq	.L.str.54(%rip), %r9
	jmp	.LBB1_21
.Ltmp257:
.LBB1_92:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.40(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp258:
	leaq	.L.str.30(%rip), %r8
.Ltmp259:
	leaq	.L.str.55(%rip), %r9
.Ltmp260:
.LBB1_21:
	movl	$8, %edx
.Ltmp261:
.LBB1_22:
	callq	__tvm_set_raised_12
	movl	$-1, %eax
	jmp	.LBB1_94
.Ltmp262:
.Lfunc_end1:
	.seh_endproc

	.def	__tvm_set_raised_6;
	.scl	3;
	.type	32;
	.endef
	.p2align	4
__tvm_set_raised_6:
.Lfunc_begin2:
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
.Lfunc_end2:
	.seh_endproc

	.def	__tvm_set_raised_12;
	.scl	3;
	.type	32;
	.endef
	.p2align	4
__tvm_set_raised_12:
.Lfunc_begin3:
.seh_proc __tvm_set_raised_12
	subq	$136, %rsp
	.seh_stackalloc 136
	.seh_endprologue
	movl	%edx, %eax
	movq	208(%rsp), %rdx
	vmovaps	192(%rsp), %xmm0
	vmovaps	176(%rsp), %xmm1
	movq	%r8, 40(%rsp)
	movq	%r9, 48(%rsp)
	vmovups	%xmm1, 56(%rsp)
	leaq	.L.str.4(%rip), %r8
	movq	%r8, 72(%rsp)
	vmovups	%xmm0, 80(%rsp)
	movq	%rdx, 96(%rsp)
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
.Lfunc_end3:
	.seh_endproc

	.def	contract_silu_compute_;
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
contract_silu_compute_:
.Lfunc_begin4:
	.loc	1 0 0
	pushq	%r14
	pushq	%rsi
	pushq	%rdi
	pushq	%rbx
	subq	$168, %rsp
	vmovaps	%xmm7, 144(%rsp)
	vmovaps	%xmm6, 128(%rsp)
	movq	%rdx, %rsi
	movq	%rcx, %rdi
	.loc	1 0 0 prologue_end
	xorl	%ebx, %ebx
.Ltmp263:
	vbroadcastss	__real@80000000(%rip), %ymm0
	vmovups	%ymm0, 64(%rsp)
.Ltmp264:
	.p2align	4
.LBB4_1:
	xorl	%r14d, %r14d
.Ltmp265:
	.p2align	4
.LBB4_2:
	vmovaps	(%rdi,%r14,4), %ymm1
	vmovups	%ymm1, 96(%rsp)
	vxorps	%ymm0, %ymm1, %ymm0
	vmovups	%ymm0, 32(%rsp)
	vextractf128	$1, %ymm0, %xmm6
	vmovaps	%xmm6, %xmm0
	vzeroupper
	callq	expf
	vmovaps	%xmm0, %xmm7
	vshufps	$245, %xmm6, %xmm6, %xmm0
	callq	expf
	vinsertps	$16, %xmm0, %xmm7, %xmm7
	vshufps	$78, %xmm6, %xmm6, %xmm0
	callq	expf
	vinsertps	$32, %xmm0, %xmm7, %xmm7
	vshufps	$255, %xmm6, %xmm6, %xmm0
	callq	expf
	vinsertps	$48, %xmm0, %xmm7, %xmm7
	vmovups	32(%rsp), %ymm0
	vzeroupper
	callq	expf
	vmovaps	%xmm0, %xmm6
	vpermilps	$245, 32(%rsp), %xmm0
	callq	expf
	vinsertps	$16, %xmm0, %xmm6, %xmm6
	vpermilps	$78, 32(%rsp), %xmm0
	callq	expf
	vinsertps	$32, %xmm0, %xmm6, %xmm6
	vpermilps	$255, 32(%rsp), %xmm0
	callq	expf
	vbroadcastss	__real@3f800000(%rip), %ymm1
	vinsertps	$48, %xmm0, %xmm6, %xmm0
	vinsertf128	$1, %xmm7, %ymm0, %ymm0
	vaddps	%ymm1, %ymm0, %ymm0
	vmovups	96(%rsp), %ymm1
	vdivps	%ymm0, %ymm1, %ymm0
	vmovaps	%ymm0, (%rsi,%r14,4)
	vmovups	64(%rsp), %ymm0
	addq	$8, %r14
	cmpq	$5632, %r14
	jne	.LBB4_2
.Ltmp266:
	incq	%rbx
.Ltmp267:
	addq	$22528, %rsi
	addq	$22528, %rdi
	cmpq	$128, %rbx
	jne	.LBB4_1
.Ltmp268:
	vmovaps	128(%rsp), %xmm6
	vmovaps	144(%rsp), %xmm7
	addq	$168, %rsp
	popq	%rbx
.Ltmp269:
	popq	%rdi
	popq	%rsi
	popq	%r14
	vzeroupper
	retq
.Ltmp270:
.Lfunc_end4:

	.def	multiply_compute_;
	.scl	3;
	.type	32;
	.endef
	.p2align	4
multiply_compute_:
.Lfunc_begin5:
	.loc	1 0 0
	.loc	1 0 0 prologue_end
	xorl	%eax, %eax
.Ltmp271:
	.p2align	4
.LBB5_1:
	movl	$24, %r9d
.Ltmp272:
	.p2align	4
.LBB5_2:
	vmovaps	-96(%rdx,%r9,4), %ymm0
	vmovaps	-64(%rdx,%r9,4), %ymm1
	vmovaps	-32(%rdx,%r9,4), %ymm2
	vmovaps	(%rdx,%r9,4), %ymm3
	vmulps	-96(%rcx,%r9,4), %ymm0, %ymm0
	vmulps	-64(%rcx,%r9,4), %ymm1, %ymm1
	vmulps	-32(%rcx,%r9,4), %ymm2, %ymm2
	vmulps	(%rcx,%r9,4), %ymm3, %ymm3
	vmovaps	%ymm0, -96(%r8,%r9,4)
	vmovaps	%ymm1, -64(%r8,%r9,4)
	vmovaps	%ymm2, -32(%r8,%r9,4)
	vmovaps	%ymm3, (%r8,%r9,4)
	addq	$32, %r9
	cmpq	$5656, %r9
	jne	.LBB5_2
.Ltmp273:
	incq	%rax
.Ltmp274:
	addq	$22528, %r8
	addq	$22528, %rcx
	addq	$22528, %rdx
	cmpq	$128, %rax
	jne	.LBB5_1
.Ltmp275:
	vzeroupper
	retq
.Ltmp276:
.Lfunc_end5:

	.def	__truncsfhf2;
	.scl	2;
	.type	32;
	.endef
	.weak	__truncsfhf2
	.p2align	4
__truncsfhf2:
.Lfunc_begin6:
	vmovd	%xmm0, %eax
	movl	%eax, %edx
	andl	$2147483647, %edx
	leal	-947912704(%rdx), %ecx
	leal	-1199570944(%rdx), %r8d
	cmpl	%r8d, %ecx
	jae	.LBB6_5
	movl	%eax, %edx
	shrl	$13, %edx
	movl	%eax, %r8d
	andl	$8191, %r8d
	cmpl	$4097, %r8d
	jb	.LBB6_3
	addl	$-114687, %edx
	movl	%edx, %ecx
	jmp	.LBB6_13
.LBB6_5:
	cmpl	$2139095041, %edx
	jb	.LBB6_7
	movl	%eax, %ecx
	shrl	$13, %ecx
	andl	$511, %ecx
	orl	$32256, %ecx
	jmp	.LBB6_13
.LBB6_3:
	leal	-114688(%rdx), %ecx
	cmpl	$4096, %r8d
	jne	.LBB6_13
	andl	$1, %edx
	addl	%edx, %ecx
	jmp	.LBB6_13
.LBB6_7:
	movl	$31744, %ecx
	cmpl	$1199570943, %edx
	ja	.LBB6_13
	xorl	%ecx, %ecx
	cmpl	$754974720, %edx
	jb	.LBB6_13
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
	jb	.LBB6_11
	incl	%ecx
	jmp	.LBB6_13
.LBB6_11:
	cmpl	$4096, %r8d
	jne	.LBB6_13
	movl	%ecx, %edx
	andl	$1, %edx
	addl	%edx, %ecx
.LBB6_13:
	shrl	$16, %eax
	andl	$32768, %eax
	orl	%ecx, %eax
	vpinsrw	$0, %eax, %xmm0, %xmm0
	retq
.Lfunc_end6:

	.def	__extendhfsf2;
	.scl	2;
	.type	32;
	.endef
	.weak	__extendhfsf2
	.p2align	4
__extendhfsf2:
.Lfunc_begin7:
	vpextrw	$0, %xmm0, %eax
	movl	%eax, %edx
	andl	$32767, %edx
	leal	-1024(%rdx), %ecx
	movzwl	%cx, %ecx
	cmpl	$30719, %ecx
	ja	.LBB7_2
	shll	$13, %edx
	addl	$939524096, %edx
	jmp	.LBB7_7
.LBB7_2:
	cmpl	$31744, %edx
	jb	.LBB7_4
	shll	$13, %edx
	orl	$2139095040, %edx
	jmp	.LBB7_7
.LBB7_4:
	testl	%edx, %edx
	je	.LBB7_5
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
	jmp	.LBB7_7
.LBB7_5:
	xorl	%edx, %edx
.LBB7_7:
	andl	$32768, %eax
	shll	$16, %eax
	orl	%edx, %eax
	vmovd	%eax, %xmm0
	retq
.Lfunc_end7:

	.section	.rdata,"dr"
.L.str:
	.asciz	"TypeError"

.L.str.1:
	.asciz	"Expected "

.L.str.2:
	.asciz	"2"

.L.str.3:
	.asciz	" arguments"

.L.str.4:
	.asciz	" when calling:\n  `"

.L.str.5:
	.asciz	"contract_silu(gate: Tensor([T.int64(128), T.int64(5632)], float32), silu: Tensor([T.int64(128), T.int64(5632)], float32))"

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
	.asciz	"ValueError"

.L.str.14:
	.asciz	"Mismatched "

.L.str.15:
	.asciz	"gate"

.L.str.16:
	.asciz	".ndim on argument #"

.L.str.17:
	.asciz	".dtype on argument #"

.L.str.18:
	.asciz	"float32"

.L.str.19:
	.asciz	".device_type on argument #"

.L.str.20:
	.asciz	"cpu"

.L.str.21:
	.asciz	"silu"

.L.str.22:
	.asciz	".strides on argument #"

.L.str.23:
	.asciz	"`,\n  expected to be compact array"

.L.str.24:
	.asciz	" data pointer is NULL on argument #"

.L.str.25:
	.asciz	"`,\n  expected non-NULL data pointer"

.L.str.26:
	.asciz	"silu.device_id"

.L.str.27:
	.asciz	" on argument #"

.L.str.28:
	.asciz	"`,\n  expected to match "

.L.str.29:
	.asciz	"gate.device_id"

.L.str.30:
	.asciz	"Invalid "

.L.str.31:
	.asciz	"gate.shape[0]"

.L.str.32:
	.asciz	"128"

.L.str.33:
	.asciz	"gate.shape[1]"

.L.str.34:
	.asciz	"5632"

.L.str.35:
	.asciz	"gate.byte_offset"

.L.str.36:
	.asciz	"silu.shape[0]"

.L.str.37:
	.asciz	"silu.shape[1]"

.L.str.38:
	.asciz	"silu.byte_offset"

.L.str.39:
	.asciz	"3"

.L.str.40:
	.asciz	"multiply(lv: Tensor([T.int64(128), T.int64(5632)], float32), up: Tensor([T.int64(128), T.int64(5632)], float32), T_multiply: Tensor([T.int64(128), T.int64(5632)], float32))"

.L.str.41:
	.asciz	"lv"

.L.str.42:
	.asciz	"up"

.L.str.43:
	.asciz	"T_multiply"

.L.str.44:
	.asciz	"up.device_id"

.L.str.45:
	.asciz	"lv.device_id"

.L.str.46:
	.asciz	"T_multiply.device_id"

.L.str.47:
	.asciz	"lv.shape[0]"

.L.str.48:
	.asciz	"lv.shape[1]"

.L.str.49:
	.asciz	"lv.byte_offset"

.L.str.50:
	.asciz	"up.shape[0]"

.L.str.51:
	.asciz	"up.shape[1]"

.L.str.52:
	.asciz	"up.byte_offset"

.L.str.53:
	.asciz	"T_multiply.shape[0]"

.L.str.54:
	.asciz	"T_multiply.shape[1]"

.L.str.55:
	.asciz	"T_multiply.byte_offset"

	.section	.drectve,"yni"
	.ascii	" /EXPORT:__tvm_ffi_contract_silu"
	.ascii	" /EXPORT:__tvm_ffi_multiply"
	.section	.debug$S,"dr"
	.p2align	2, 0x0
	.long	4
	.long	241
	.long	.Ltmp278-.Ltmp277
.Ltmp277:
	.short	.Ltmp280-.Ltmp279
.Ltmp279:
	.short	4353
	.long	0
	.byte	0
	.p2align	2, 0x0
.Ltmp280:
	.short	.Ltmp282-.Ltmp281
.Ltmp281:
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
.Ltmp282:
.Ltmp278:
	.p2align	2, 0x0
	.section	.debug_loc,"dr"
.Ldebug_loc0:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin0-.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp52-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	.Ltmp52-.Lfunc_begin0
	.quad	.Ltmp53-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp53-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp57-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Lfunc_end0-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc1:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin0-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	.Ltmp61-.Lfunc_begin0
	.quad	.Ltmp71-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Lfunc_end0-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc2:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin0-.Lfunc_begin0
	.quad	.Ltmp6-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp6-.Lfunc_begin0
	.quad	.Ltmp52-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	.Ltmp52-.Lfunc_begin0
	.quad	.Ltmp54-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp54-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp58-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Lfunc_end0-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc3:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin0-.Lfunc_begin0
	.quad	.Ltmp11-.Lfunc_begin0
	.short	1
	.byte	89
	.quad	.Ltmp11-.Lfunc_begin0
	.quad	.Ltmp52-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	89
	.byte	159
	.quad	.Ltmp52-.Lfunc_begin0
	.quad	.Ltmp55-.Lfunc_begin0
	.short	1
	.byte	89
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	89
	.byte	159
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp59-.Lfunc_begin0
	.short	1
	.byte	89
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Lfunc_end0-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	89
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc4:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp7-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	0
	.quad	0
.Ldebug_loc5:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp8-.Lfunc_begin0
	.quad	.Ltmp19-.Lfunc_begin0
	.short	1
	.byte	90
	.quad	.Ltmp61-.Lfunc_begin0
	.quad	.Ltmp66-.Lfunc_begin0
	.short	1
	.byte	90
	.quad	0
	.quad	0
.Ldebug_loc6:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.short	2
	.byte	116
	.byte	0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.short	2
	.byte	116
	.byte	0
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.short	2
	.byte	116
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc7:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp27-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc8:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.short	1
	.byte	85
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.short	1
	.byte	85
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.short	1
	.byte	85
	.quad	0
	.quad	0
.Ldebug_loc9:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp29-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp72-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp73-.Lfunc_begin0
	.quad	.Ltmp74-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp76-.Lfunc_begin0
	.quad	.Ltmp77-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp78-.Lfunc_begin0
	.quad	.Ltmp79-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp81-.Lfunc_begin0
	.quad	.Ltmp82-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp87-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp88-.Lfunc_begin0
	.quad	.Ltmp89-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp90-.Lfunc_begin0
	.quad	.Ltmp91-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp92-.Lfunc_begin0
	.quad	.Ltmp93-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp94-.Lfunc_begin0
	.quad	.Ltmp95-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp96-.Lfunc_begin0
	.quad	.Ltmp97-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc10:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp30-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.short	2
	.byte	123
	.byte	0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.short	2
	.byte	123
	.byte	0
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.short	2
	.byte	123
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc11:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc12:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp71-.Lfunc_begin0
	.quad	.Ltmp75-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp76-.Lfunc_begin0
	.quad	.Ltmp80-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp81-.Lfunc_begin0
	.quad	.Ltmp84-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp86-.Lfunc_begin0
	.quad	.Ltmp98-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc13:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin1-.Lfunc_begin0
	.quad	.Ltmp103-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp103-.Lfunc_begin0
	.quad	.Ltmp176-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	.Ltmp176-.Lfunc_begin0
	.quad	.Ltmp177-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp177-.Lfunc_begin0
	.quad	.Ltmp180-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	.Ltmp180-.Lfunc_begin0
	.quad	.Ltmp181-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp181-.Lfunc_begin0
	.quad	.Lfunc_end1-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc14:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin1-.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp172-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	.Ltmp172-.Lfunc_begin0
	.quad	.Ltmp184-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp184-.Lfunc_begin0
	.quad	.Ltmp185-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	.Ltmp185-.Lfunc_begin0
	.quad	.Ltmp204-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Lfunc_end1-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc15:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin1-.Lfunc_begin0
	.quad	.Ltmp109-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp109-.Lfunc_begin0
	.quad	.Ltmp176-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	.Ltmp176-.Lfunc_begin0
	.quad	.Ltmp178-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp178-.Lfunc_begin0
	.quad	.Ltmp180-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	.Ltmp180-.Lfunc_begin0
	.quad	.Ltmp182-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp182-.Lfunc_begin0
	.quad	.Lfunc_end1-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc16:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin1-.Lfunc_begin0
	.quad	.Ltmp107-.Lfunc_begin0
	.short	1
	.byte	89
	.quad	.Ltmp107-.Lfunc_begin0
	.quad	.Ltmp176-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	89
	.byte	159
	.quad	.Ltmp176-.Lfunc_begin0
	.quad	.Ltmp179-.Lfunc_begin0
	.short	1
	.byte	89
	.quad	.Ltmp179-.Lfunc_begin0
	.quad	.Ltmp180-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	89
	.byte	159
	.quad	.Ltmp180-.Lfunc_begin0
	.quad	.Ltmp183-.Lfunc_begin0
	.short	1
	.byte	89
	.quad	.Ltmp183-.Lfunc_begin0
	.quad	.Lfunc_end1-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	89
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc17:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp103-.Lfunc_begin0
	.quad	.Ltmp108-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	0
	.quad	0
.Ldebug_loc18:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp109-.Lfunc_begin0
	.quad	.Ltmp116-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	0
	.quad	0
.Ldebug_loc19:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp113-.Lfunc_begin0
	.quad	.Ltmp140-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp174-.Lfunc_begin0
	.quad	.Ltmp175-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp185-.Lfunc_begin0
	.quad	.Ltmp187-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp188-.Lfunc_begin0
	.quad	.Ltmp190-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp191-.Lfunc_begin0
	.quad	.Ltmp193-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp194-.Lfunc_begin0
	.quad	.Ltmp196-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp197-.Lfunc_begin0
	.quad	.Ltmp198-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp199-.Lfunc_begin0
	.quad	.Ltmp200-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp201-.Lfunc_begin0
	.quad	.Ltmp202-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	0
	.quad	0
.Ldebug_loc20:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp137-.Lfunc_begin0
	.quad	.Ltmp171-.Lfunc_begin0
	.short	2
	.byte	127
	.byte	0
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp231-.Lfunc_begin0
	.short	2
	.byte	127
	.byte	0
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp260-.Lfunc_begin0
	.short	2
	.byte	127
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc21:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp138-.Lfunc_begin0
	.quad	.Ltmp171-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp231-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp260-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc22:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp139-.Lfunc_begin0
	.quad	.Ltmp171-.Lfunc_begin0
	.short	1
	.byte	86
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp231-.Lfunc_begin0
	.short	1
	.byte	86
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp260-.Lfunc_begin0
	.short	1
	.byte	86
	.quad	0
	.quad	0
.Ldebug_loc23:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp140-.Lfunc_begin0
	.quad	.Ltmp170-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp205-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp207-.Lfunc_begin0
	.quad	.Ltmp208-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp211-.Lfunc_begin0
	.quad	.Ltmp212-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp214-.Lfunc_begin0
	.quad	.Ltmp215-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp218-.Lfunc_begin0
	.quad	.Ltmp219-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp221-.Lfunc_begin0
	.quad	.Ltmp222-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp224-.Lfunc_begin0
	.quad	.Ltmp225-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp228-.Lfunc_begin0
	.quad	.Ltmp229-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp234-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp236-.Lfunc_begin0
	.quad	.Ltmp237-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp239-.Lfunc_begin0
	.quad	.Ltmp240-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp242-.Lfunc_begin0
	.quad	.Ltmp243-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp245-.Lfunc_begin0
	.quad	.Ltmp246-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp248-.Lfunc_begin0
	.quad	.Ltmp249-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp251-.Lfunc_begin0
	.quad	.Ltmp252-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp254-.Lfunc_begin0
	.quad	.Ltmp255-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp257-.Lfunc_begin0
	.quad	.Ltmp258-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc24:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp141-.Lfunc_begin0
	.quad	.Ltmp171-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp231-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp260-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc25:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp142-.Lfunc_begin0
	.quad	.Ltmp171-.Lfunc_begin0
	.short	2
	.byte	125
	.byte	0
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp231-.Lfunc_begin0
	.short	2
	.byte	125
	.byte	0
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp260-.Lfunc_begin0
	.short	2
	.byte	125
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc26:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp143-.Lfunc_begin0
	.quad	.Ltmp170-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp210-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp211-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp218-.Lfunc_begin0
	.quad	.Ltmp227-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp228-.Lfunc_begin0
	.quad	.Ltmp231-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp260-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc27:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp144-.Lfunc_begin0
	.quad	.Ltmp146-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp147-.Lfunc_begin0
	.quad	.Ltmp171-.Lfunc_begin0
	.short	4
	.byte	119
	.byte	208
	.byte	0
	.byte	6
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp231-.Lfunc_begin0
	.short	4
	.byte	119
	.byte	208
	.byte	0
	.byte	6
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp260-.Lfunc_begin0
	.short	4
	.byte	119
	.byte	208
	.byte	0
	.byte	6
	.quad	0
	.quad	0
.Ldebug_loc28:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp145-.Lfunc_begin0
	.quad	.Ltmp171-.Lfunc_begin0
	.short	2
	.byte	124
	.byte	0
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp231-.Lfunc_begin0
	.short	2
	.byte	124
	.byte	0
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp260-.Lfunc_begin0
	.short	2
	.byte	124
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc29:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp146-.Lfunc_begin0
	.quad	.Ltmp170-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp204-.Lfunc_begin0
	.quad	.Ltmp206-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp207-.Lfunc_begin0
	.quad	.Ltmp209-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp211-.Lfunc_begin0
	.quad	.Ltmp213-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp214-.Lfunc_begin0
	.quad	.Ltmp216-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp218-.Lfunc_begin0
	.quad	.Ltmp220-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp221-.Lfunc_begin0
	.quad	.Ltmp223-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp224-.Lfunc_begin0
	.quad	.Ltmp226-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp228-.Lfunc_begin0
	.quad	.Ltmp230-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp233-.Lfunc_begin0
	.quad	.Ltmp235-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp236-.Lfunc_begin0
	.quad	.Ltmp238-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp239-.Lfunc_begin0
	.quad	.Ltmp241-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp242-.Lfunc_begin0
	.quad	.Ltmp244-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp245-.Lfunc_begin0
	.quad	.Ltmp247-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp248-.Lfunc_begin0
	.quad	.Ltmp250-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp251-.Lfunc_begin0
	.quad	.Ltmp253-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp254-.Lfunc_begin0
	.quad	.Ltmp256-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp257-.Lfunc_begin0
	.quad	.Ltmp259-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc30:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin4-.Lfunc_begin0
	.quad	.Ltmp264-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp264-.Lfunc_begin0
	.quad	.Lfunc_end4-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc31:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin4-.Lfunc_begin0
	.quad	.Ltmp264-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp264-.Lfunc_begin0
	.quad	.Lfunc_end4-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc32:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp263-.Lfunc_begin0
	.quad	.Ltmp264-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	0
	.byte	159
	.quad	.Ltmp264-.Lfunc_begin0
	.quad	.Ltmp269-.Lfunc_begin0
	.short	1
	.byte	83
	.quad	0
	.quad	0
.Ldebug_loc33:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin5-.Lfunc_begin0
	.quad	.Ltmp271-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp271-.Lfunc_begin0
	.quad	.Lfunc_end5-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc34:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin5-.Lfunc_begin0
	.quad	.Ltmp271-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp271-.Lfunc_begin0
	.quad	.Lfunc_end5-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc35:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin5-.Lfunc_begin0
	.quad	.Ltmp271-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp271-.Lfunc_begin0
	.quad	.Lfunc_end5-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
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
	.byte	2
	.byte	23
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	4
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
	.byte	5
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
	.byte	6
	.byte	52
	.byte	0
	.byte	28
	.byte	13
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	7
	.byte	52
	.byte	0
	.byte	2
	.byte	24
	.byte	3
	.byte	14
	.byte	73
	.byte	19
	.byte	0
	.byte	0
	.byte	8
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
	.byte	9
	.byte	15
	.byte	0
	.byte	0
	.byte	0
	.byte	10
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

	.long	639
	.byte	3
	.secrel32	.Ldebug_loc0
	.secrel32	.Linfo_string8
	.long	646
	.byte	3
	.secrel32	.Ldebug_loc1
	.secrel32	.Linfo_string9
	.long	646
	.byte	3
	.secrel32	.Ldebug_loc2
	.secrel32	.Linfo_string10
	.long	639
	.byte	3
	.secrel32	.Ldebug_loc3
	.secrel32	.Linfo_string11
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc4
	.secrel32	.Linfo_string12
	.long	639
	.byte	4
	.secrel32	.Ldebug_loc5
	.secrel32	.Linfo_string13
	.long	639
	.byte	4
	.secrel32	.Ldebug_loc6
	.secrel32	.Linfo_string14
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc7
	.secrel32	.Linfo_string15
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc8
	.secrel32	.Linfo_string16
	.long	639
	.byte	4
	.secrel32	.Ldebug_loc9
	.secrel32	.Linfo_string17
	.long	647
	.byte	4
	.secrel32	.Ldebug_loc10
	.secrel32	.Linfo_string19
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc11
	.secrel32	.Linfo_string20
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc12
	.secrel32	.Linfo_string21
	.long	647
	.byte	0
	.byte	2
	.quad	.Lfunc_begin1
	.long	.Lfunc_end1-.Lfunc_begin1
	.byte	1
	.byte	87
	.secrel32	.Linfo_string5

	.long	639
	.byte	3
	.secrel32	.Ldebug_loc13
	.secrel32	.Linfo_string8
	.long	646
	.byte	3
	.secrel32	.Ldebug_loc14
	.secrel32	.Linfo_string9
	.long	646
	.byte	3
	.secrel32	.Ldebug_loc15
	.secrel32	.Linfo_string10
	.long	639
	.byte	3
	.secrel32	.Ldebug_loc16
	.secrel32	.Linfo_string11
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc17
	.secrel32	.Linfo_string22
	.long	639
	.byte	4
	.secrel32	.Ldebug_loc18
	.secrel32	.Linfo_string23
	.long	639
	.byte	4
	.secrel32	.Ldebug_loc19
	.secrel32	.Linfo_string24
	.long	639
	.byte	4
	.secrel32	.Ldebug_loc20
	.secrel32	.Linfo_string25
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc21
	.secrel32	.Linfo_string26
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc22
	.secrel32	.Linfo_string16
	.long	639
	.byte	4
	.secrel32	.Ldebug_loc23
	.secrel32	.Linfo_string27
	.long	647
	.byte	4
	.secrel32	.Ldebug_loc24
	.secrel32	.Linfo_string28
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc25
	.secrel32	.Linfo_string29
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc26
	.secrel32	.Linfo_string30
	.long	647
	.byte	4
	.secrel32	.Ldebug_loc27
	.secrel32	.Linfo_string31
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc28
	.secrel32	.Linfo_string32
	.long	646
	.byte	4
	.secrel32	.Ldebug_loc29
	.secrel32	.Linfo_string33
	.long	647
	.byte	0
	.byte	5
	.quad	.Lfunc_begin4
	.long	.Lfunc_end4-.Lfunc_begin4
	.byte	1
	.byte	87
	.secrel32	.Linfo_string6

	.byte	3
	.long	639
	.byte	3
	.secrel32	.Ldebug_loc30
	.secrel32	.Linfo_string17
	.long	647
	.byte	3
	.secrel32	.Ldebug_loc31
	.secrel32	.Linfo_string21
	.long	647
	.byte	4
	.secrel32	.Ldebug_loc32
	.secrel32	.Linfo_string34
	.long	639
	.byte	6
	.byte	0
	.secrel32	.Linfo_string35
	.long	639
	.byte	0
	.byte	5
	.quad	.Lfunc_begin5
	.long	.Lfunc_end5-.Lfunc_begin5
	.byte	1
	.byte	87
	.secrel32	.Linfo_string7

	.byte	3
	.long	639
	.byte	3
	.secrel32	.Ldebug_loc33
	.secrel32	.Linfo_string27
	.long	647
	.byte	3
	.secrel32	.Ldebug_loc34
	.secrel32	.Linfo_string30
	.long	647
	.byte	3
	.secrel32	.Ldebug_loc35
	.secrel32	.Linfo_string33
	.long	647
	.byte	7
	.byte	1
	.byte	80
	.secrel32	.Linfo_string36
	.long	639
	.byte	6
	.byte	0
	.secrel32	.Linfo_string37
	.long	639
	.byte	0
	.byte	8
	.secrel32	.Linfo_string4
	.byte	5
	.byte	4
	.byte	9
	.byte	10
	.long	652
	.byte	8
	.secrel32	.Linfo_string18
	.byte	4
	.byte	4
	.byte	0
.Ldebug_info_end0:
	.section	.debug_ranges,"dr"
.Ldebug_ranges0:
	.quad	.Lfunc_begin0
	.quad	.Lfunc_end1
	.quad	.Lfunc_begin4
	.quad	.Lfunc_end5
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
	.asciz	"__tvm_ffi_contract_silu"
.Linfo_string4:
	.asciz	"int32"
.Linfo_string5:
	.asciz	"__tvm_ffi_multiply"
.Linfo_string6:
	.asciz	"contract_silu_compute_"
.Linfo_string7:
	.asciz	"multiply_compute_"
.Linfo_string8:
	.asciz	"self_handle"
.Linfo_string9:
	.asciz	"args"
.Linfo_string10:
	.asciz	"num_args"
.Linfo_string11:
	.asciz	"result"
.Linfo_string12:
	.asciz	"var_gate.type_index"
.Linfo_string13:
	.asciz	"var_silu.type_index"
.Linfo_string14:
	.asciz	"contract_silu.var_gate_shape"
.Linfo_string15:
	.asciz	"contract_silu.var_gate_strides"
.Linfo_string16:
	.asciz	"dev_id"
.Linfo_string17:
	.asciz	"gate"
.Linfo_string18:
	.asciz	"float32"
.Linfo_string19:
	.asciz	"contract_silu.var_silu_shape"
.Linfo_string20:
	.asciz	"contract_silu.var_silu_strides"
.Linfo_string21:
	.asciz	"silu"
.Linfo_string22:
	.asciz	"var_lv.type_index"
.Linfo_string23:
	.asciz	"var_up.type_index"
.Linfo_string24:
	.asciz	"var_T_multiply.type_index"
.Linfo_string25:
	.asciz	"multiply.var_lv_shape"
.Linfo_string26:
	.asciz	"multiply.var_lv_strides"
.Linfo_string27:
	.asciz	"lv"
.Linfo_string28:
	.asciz	"multiply.var_up_shape"
.Linfo_string29:
	.asciz	"multiply.var_up_strides"
.Linfo_string30:
	.asciz	"up"
.Linfo_string31:
	.asciz	"multiply.var_T_multiply_shape"
.Linfo_string32:
	.asciz	"multiply.var_T_multiply_strides"
.Linfo_string33:
	.asciz	"T_multiply"
.Linfo_string34:
	.asciz	"i0"
.Linfo_string35:
	.asciz	"i1"
.Linfo_string36:
	.asciz	"ax0"
.Linfo_string37:
	.asciz	"ax1"
	.section	.debug_pubnames,"dr"
	.long	.LpubNames_end0-.LpubNames_start0
.LpubNames_start0:
	.short	2
	.secrel32	.Lcu_begin0
	.long	660
	.long	42
	.asciz	"__tvm_ffi_contract_silu"
	.long	235
	.asciz	"__tvm_ffi_multiply"
	.long	480
	.asciz	"contract_silu_compute_"
	.long	554
	.asciz	"multiply_compute_"
	.long	0
.LpubNames_end0:
	.section	.debug_pubtypes,"dr"
	.long	.LpubTypes_end0-.LpubTypes_start0
.LpubTypes_start0:
	.short	2
	.secrel32	.Lcu_begin0
	.long	660
	.long	639
	.asciz	"int32"
	.long	652
	.asciz	"float32"
	.long	0
.LpubTypes_end0:
	.globl	_fltused
	.section	.debug_line,"dr"
.Lline_table_start0:
