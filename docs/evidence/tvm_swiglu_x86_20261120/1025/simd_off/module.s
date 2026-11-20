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
	cmpl	$1, 16(%rax,%r8)
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
	cmpl	$1, 16(%r10,%r9)
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
	je	.LBB0_38
.Ltmp33:
	cmpq	$1, (%r14)
	jne	.LBB0_43
.Ltmp34:
.LBB0_38:
	testq	%rcx, %rcx
	je	.LBB0_39
.Ltmp35:
	testq	%rbx, %rbx
	je	.LBB0_47
.Ltmp36:
	cmpq	$1, (%rbx)
	jne	.LBB0_61
.Ltmp37:
.LBB0_47:
	cmpl	12(%r10,%r9), %edi
	jne	.LBB0_48
.Ltmp38:
	testq	%rdx, %rdx
	je	.LBB0_50
.Ltmp39:
	cmpq	$1025, (%rsi)
	jne	.LBB0_52
.Ltmp40:
	cmpq	$0, 40(%rax,%r8)
	jne	.LBB0_54
.Ltmp41:
	cmpq	$1025, (%r11)
	jne	.LBB0_56
.Ltmp42:
	cmpq	$0, 40(%r10,%r9)
	jne	.LBB0_58
.Ltmp43:
	callq	contract_silu_compute_
.Ltmp44:
	xorl	%eax, %eax
.Ltmp45:
.LBB0_60:
	.seh_startepilogue
	addq	$72, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r14
	.seh_endepilogue
	retq
.Ltmp46:
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
	jmp	.LBB0_41
.Ltmp47:
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
	jmp	.LBB0_41
.Ltmp48:
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
.Ltmp49:
	leaq	.L.str.1(%rip), %r8
.Ltmp50:
	leaq	.L.str.2(%rip), %r9
.Ltmp51:
	jmp	.LBB0_41
.Ltmp52:
.LBB0_3:
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, 48(%rsp)
	leaq	.L.str.6(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp53:
	leaq	.L.str.7(%rip), %r8
.Ltmp54:
	leaq	.L.str.4(%rip), %r9
.Ltmp55:
	movl	$4, %edx
.Ltmp56:
	jmp	.LBB0_42
.Ltmp57:
.LBB0_14:
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.16(%rip), %rax
	jmp	.LBB0_15
.Ltmp58:
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
.Ltmp59:
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
.Ltmp60:
.LBB0_15:
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp61:
.LBB0_16:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.15(%rip), %r9
	jmp	.LBB0_17
.Ltmp62:
.LBB0_27:
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rcx
	movq	%rcx, 56(%rsp)
	leaq	.L.str.5(%rip), %rcx
	movq	%rcx, 48(%rsp)
	movq	%rax, 40(%rsp)
	leaq	.L.str.16(%rip), %rax
	jmp	.LBB0_28
.Ltmp63:
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
.Ltmp64:
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
.Ltmp65:
.LBB0_28:
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp66:
.LBB0_29:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.21(%rip), %r9
	jmp	.LBB0_17
.Ltmp67:
.LBB0_43:
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
.Ltmp68:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.15(%rip), %r9
	movl	$7, %edx
.Ltmp69:
	jmp	.LBB0_18
.Ltmp70:
.LBB0_39:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp71:
	leaq	.L.str.15(%rip), %r8
	jmp	.LBB0_40
.Ltmp72:
.LBB0_61:
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
.Ltmp73:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.21(%rip), %r9
	movl	$7, %edx
.Ltmp74:
	jmp	.LBB0_18
.Ltmp75:
.LBB0_48:
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
.Ltmp76:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.26(%rip), %r9
	jmp	.LBB0_17
.Ltmp77:
.LBB0_50:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.5(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp78:
	leaq	.L.str.21(%rip), %r8
.Ltmp79:
.LBB0_40:
	leaq	.L.str.24(%rip), %r9
.Ltmp80:
.LBB0_41:
	movl	$6, %edx
.Ltmp81:
.LBB0_42:
	callq	__tvm_set_raised_6
	movl	$-1, %eax
	jmp	.LBB0_60
.Ltmp82:
.LBB0_52:
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
.Ltmp83:
	leaq	.L.str.30(%rip), %r8
	leaq	.L.str.31(%rip), %r9
	jmp	.LBB0_17
.Ltmp84:
.LBB0_54:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rcx
.Ltmp85:
	movq	%rcx, 56(%rsp)
	leaq	.L.str.5(%rip), %rcx
	movq	%rcx, 48(%rsp)
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
	leaq	.L.str.30(%rip), %r8
	leaq	.L.str.33(%rip), %r9
	jmp	.LBB0_17
.Ltmp86:
.LBB0_56:
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
.Ltmp87:
	leaq	.L.str.30(%rip), %r8
	leaq	.L.str.34(%rip), %r9
	jmp	.LBB0_17
.Ltmp88:
.LBB0_58:
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
.Ltmp89:
	leaq	.L.str.30(%rip), %r8
	leaq	.L.str.35(%rip), %r9
.Ltmp90:
.LBB0_17:
	movl	$8, %edx
.Ltmp91:
.LBB0_18:
	callq	__tvm_set_raised_12
	movl	$-1, %eax
	jmp	.LBB0_60
.Ltmp92:
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
.Ltmp93:
	testq	%rdx, %rdx
	je	.LBB1_3
.Ltmp94:
	movl	(%rdx), %ecx
.Ltmp95:
	cmpl	$63, %ecx
	jg	.LBB1_8
.Ltmp96:
	cmpl	$7, %ecx
	ja	.LBB1_7
.Ltmp97:
	movl	$145, %eax
	btl	%ecx, %eax
	jae	.LBB1_7
.Ltmp98:
.LBB1_8:
	movq	8(%rdx), %rax
	xorl	%r9d, %r9d
.Ltmp99:
	cmpl	$70, %ecx
	movl	$24, %ecx
.Ltmp100:
	cmoveq	%rcx, %r9
	movl	16(%rdx), %r8d
.Ltmp101:
	cmpl	$63, %r8d
	jg	.LBB1_12
.Ltmp102:
	cmpl	$7, %r8d
	ja	.LBB1_11
.Ltmp103:
	movl	$145, %r10d
	btl	%r8d, %r10d
	jae	.LBB1_11
.Ltmp104:
.LBB1_12:
	movq	24(%rdx), %r10
	xorl	%r11d, %r11d
	cmpl	$70, %r8d
	cmoveq	%rcx, %r11
	movl	32(%rdx), %ecx
.Ltmp105:
	cmpl	$63, %ecx
	jg	.LBB1_16
.Ltmp106:
	cmpl	$7, %ecx
	ja	.LBB1_15
.Ltmp107:
	movl	$145, %r8d
.Ltmp108:
	btl	%ecx, %r8d
	jae	.LBB1_15
.Ltmp109:
.LBB1_16:
	xorl	%r8d, %r8d
	cmpl	$70, %ecx
	movl	$24, %esi
	cmovneq	%r8, %rsi
	testq	%rax, %rax
	je	.LBB1_7
.Ltmp110:
	cmpl	$1, 16(%rax,%r9)
	jne	.LBB1_18
.Ltmp111:
	cmpw	$1, 22(%rax,%r9)
	jne	.LBB1_26
.Ltmp112:
	cmpb	$32, 21(%rax,%r9)
	jne	.LBB1_26
.Ltmp113:
	cmpb	$2, 20(%rax,%r9)
	jne	.LBB1_26
.Ltmp114:
	cmpl	$1, 8(%rax,%r9)
	jne	.LBB1_28
.Ltmp115:
	testq	%r10, %r10
	je	.LBB1_11
.Ltmp116:
	cmpl	$1, 16(%r10,%r11)
	jne	.LBB1_31
.Ltmp117:
	cmpw	$1, 22(%r10,%r11)
	jne	.LBB1_37
.Ltmp118:
	cmpb	$32, 21(%r10,%r11)
	jne	.LBB1_37
.Ltmp119:
	cmpb	$2, 20(%r10,%r11)
	jne	.LBB1_37
.Ltmp120:
	cmpl	$1, 8(%r10,%r11)
	jne	.LBB1_39
.Ltmp121:
	movq	40(%rdx), %rdi
.Ltmp122:
	testq	%rdi, %rdi
	je	.LBB1_15
.Ltmp123:
	cmpl	$1, 16(%rdi,%rsi)
	jne	.LBB1_42
.Ltmp124:
	cmpw	$1, 22(%rdi,%rsi)
	jne	.LBB1_48
.Ltmp125:
	cmpb	$32, 21(%rdi,%rsi)
	jne	.LBB1_48
.Ltmp126:
	cmpb	$2, 20(%rdi,%rsi)
	jne	.LBB1_48
.Ltmp127:
	cmpl	$1, 8(%rdi,%rsi)
	jne	.LBB1_50
.Ltmp128:
	movq	24(%rax,%r9), %r15
.Ltmp129:
	movq	32(%rax,%r9), %rbx
.Ltmp130:
	movl	12(%rax,%r9), %ebp
.Ltmp131:
	movq	(%rax,%r9), %rcx
.Ltmp132:
	movq	24(%r10,%r11), %r14
.Ltmp133:
	movq	32(%r10,%r11), %r13
.Ltmp134:
	movq	(%r10,%r11), %rdx
.Ltmp135:
	movq	24(%rdi,%rsi), %r8
.Ltmp136:
	movq	%r8, 80(%rsp)
	movq	32(%rdi,%rsi), %r12
.Ltmp137:
	movq	(%rdi,%rsi), %r8
.Ltmp138:
	testq	%rbx, %rbx
	je	.LBB1_53
.Ltmp139:
	cmpq	$1, (%rbx)
	jne	.LBB1_58
.Ltmp140:
.LBB1_53:
	testq	%rcx, %rcx
	je	.LBB1_54
.Ltmp141:
	testq	%r13, %r13
	je	.LBB1_62
.Ltmp142:
	cmpq	$1, (%r13)
	jne	.LBB1_86
.Ltmp143:
.LBB1_62:
	cmpl	12(%r10,%r11), %ebp
	jne	.LBB1_63
.Ltmp144:
	testq	%rdx, %rdx
	je	.LBB1_65
.Ltmp145:
	testq	%r12, %r12
	je	.LBB1_68
.Ltmp146:
	cmpq	$1, (%r12)
	jne	.LBB1_87
.Ltmp147:
.LBB1_68:
	cmpl	12(%rdi,%rsi), %ebp
	jne	.LBB1_69
.Ltmp148:
	testq	%r8, %r8
	je	.LBB1_71
.Ltmp149:
	cmpq	$1025, (%r15)
	jne	.LBB1_73
.Ltmp150:
	cmpq	$0, 40(%rax,%r9)
	jne	.LBB1_75
.Ltmp151:
	cmpq	$1025, (%r14)
	jne	.LBB1_77
.Ltmp152:
	cmpq	$0, 40(%r10,%r11)
	jne	.LBB1_79
.Ltmp153:
	movq	80(%rsp), %rax
	cmpq	$1025, (%rax)
	jne	.LBB1_81
.Ltmp154:
	cmpq	$0, 40(%rdi,%rsi)
	jne	.LBB1_83
.Ltmp155:
	callq	multiply_compute_
.Ltmp156:
	xorl	%eax, %eax
.Ltmp157:
.LBB1_85:
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
.Ltmp158:
.LBB1_7:
	leaq	.L.str.11(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
	leaq	.L.str.8(%rip), %r8
	leaq	.L.str.9(%rip), %r9
	jmp	.LBB1_56
.Ltmp159:
.LBB1_11:
	leaq	.L.str.11(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
	leaq	.L.str.8(%rip), %r8
	leaq	.L.str.12(%rip), %r9
	jmp	.LBB1_56
.Ltmp160:
.LBB1_15:
	leaq	.L.str.11(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp161:
	leaq	.L.str.8(%rip), %r8
	leaq	.L.str.2(%rip), %r9
	jmp	.LBB1_56
.Ltmp162:
.LBB1_1:
	leaq	.L.str.6(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.3(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp163:
	leaq	.L.str.1(%rip), %r8
.Ltmp164:
	leaq	.L.str.36(%rip), %r9
.Ltmp165:
	jmp	.LBB1_56
.Ltmp166:
.LBB1_3:
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, 48(%rsp)
	leaq	.L.str.6(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp167:
	leaq	.L.str.7(%rip), %r8
.Ltmp168:
	leaq	.L.str.4(%rip), %r9
.Ltmp169:
	movl	$4, %edx
.Ltmp170:
	jmp	.LBB1_57
.Ltmp171:
.LBB1_18:
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.16(%rip), %rax
	jmp	.LBB1_19
.Ltmp172:
.LBB1_26:
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp173:
	jmp	.LBB1_20
.Ltmp174:
.LBB1_28:
	leaq	.L.str.20(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.19(%rip), %rax
.Ltmp175:
.LBB1_19:
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp176:
.LBB1_20:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.38(%rip), %r9
	jmp	.LBB1_21
.Ltmp177:
.LBB1_31:
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rcx
.Ltmp178:
	movq	%rcx, 56(%rsp)
	leaq	.L.str.37(%rip), %rcx
	movq	%rcx, 48(%rsp)
	movq	%rax, 40(%rsp)
	leaq	.L.str.16(%rip), %rax
	jmp	.LBB1_32
.Ltmp179:
.LBB1_37:
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp180:
	jmp	.LBB1_33
.Ltmp181:
.LBB1_39:
	leaq	.L.str.20(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.19(%rip), %rax
.Ltmp182:
.LBB1_32:
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp183:
.LBB1_33:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.39(%rip), %r9
	jmp	.LBB1_21
.Ltmp184:
.LBB1_42:
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.16(%rip), %rax
	jmp	.LBB1_43
.Ltmp185:
.LBB1_48:
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.17(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str(%rip), %rcx
.Ltmp186:
	jmp	.LBB1_44
.Ltmp187:
.LBB1_50:
	leaq	.L.str.20(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.19(%rip), %rax
.Ltmp188:
.LBB1_43:
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp189:
.LBB1_44:
	leaq	.L.str.14(%rip), %r8
	leaq	.L.str.40(%rip), %r9
	jmp	.LBB1_21
.Ltmp190:
.LBB1_58:
	leaq	.L.str.23(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.22(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 64(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp191:
	leaq	.L.str.14(%rip), %r8
.Ltmp192:
	leaq	.L.str.38(%rip), %r9
	movl	$7, %edx
.Ltmp193:
	jmp	.LBB1_22
.Ltmp194:
.LBB1_54:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp195:
	leaq	.L.str.38(%rip), %r8
.Ltmp196:
	jmp	.LBB1_55
.Ltmp197:
.LBB1_86:
	leaq	.L.str.23(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.22(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 64(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp198:
	leaq	.L.str.14(%rip), %r8
.Ltmp199:
	leaq	.L.str.39(%rip), %r9
	movl	$7, %edx
.Ltmp200:
	jmp	.LBB1_22
.Ltmp201:
.LBB1_63:
	leaq	.L.str.42(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.28(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp202:
	leaq	.L.str.14(%rip), %r8
.Ltmp203:
	leaq	.L.str.41(%rip), %r9
	jmp	.LBB1_21
.Ltmp204:
.LBB1_65:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp205:
	leaq	.L.str.39(%rip), %r8
.Ltmp206:
	jmp	.LBB1_55
.Ltmp207:
.LBB1_87:
	leaq	.L.str.23(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.22(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 64(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp208:
	leaq	.L.str.14(%rip), %r8
.Ltmp209:
	leaq	.L.str.40(%rip), %r9
	movl	$7, %edx
.Ltmp210:
	jmp	.LBB1_22
.Ltmp211:
.LBB1_69:
	leaq	.L.str.42(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.28(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp212:
	leaq	.L.str.14(%rip), %r8
.Ltmp213:
	leaq	.L.str.43(%rip), %r9
	jmp	.LBB1_21
.Ltmp214:
.LBB1_71:
	leaq	.L.str.25(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.4(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp215:
	leaq	.L.str.40(%rip), %r8
.Ltmp216:
.LBB1_55:
	leaq	.L.str.24(%rip), %r9
.Ltmp217:
.LBB1_56:
	movl	$6, %edx
.Ltmp218:
.LBB1_57:
	callq	__tvm_set_raised_6
	movl	$-1, %eax
	jmp	.LBB1_85
.Ltmp219:
.LBB1_73:
	leaq	.L.str.32(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp220:
	leaq	.L.str.30(%rip), %r8
.Ltmp221:
	leaq	.L.str.44(%rip), %r9
	jmp	.LBB1_21
.Ltmp222:
.LBB1_75:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rcx
.Ltmp223:
	movq	%rcx, 56(%rsp)
	leaq	.L.str.37(%rip), %rcx
	movq	%rcx, 48(%rsp)
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
	leaq	.L.str.30(%rip), %r8
.Ltmp224:
	leaq	.L.str.45(%rip), %r9
	jmp	.LBB1_21
.Ltmp225:
.LBB1_77:
	leaq	.L.str.32(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp226:
	leaq	.L.str.30(%rip), %r8
.Ltmp227:
	leaq	.L.str.46(%rip), %r9
	jmp	.LBB1_21
.Ltmp228:
.LBB1_79:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp229:
	leaq	.L.str.30(%rip), %r8
.Ltmp230:
	leaq	.L.str.47(%rip), %r9
	jmp	.LBB1_21
.Ltmp231:
.LBB1_81:
	leaq	.L.str.32(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp232:
	leaq	.L.str.30(%rip), %r8
.Ltmp233:
	leaq	.L.str.48(%rip), %r9
	jmp	.LBB1_21
.Ltmp234:
.LBB1_83:
	leaq	.L.str.9(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L.str.10(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L.str.37(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L.str.2(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L.str.27(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L.str.13(%rip), %rcx
.Ltmp235:
	leaq	.L.str.30(%rip), %r8
.Ltmp236:
	leaq	.L.str.49(%rip), %r9
.Ltmp237:
.LBB1_21:
	movl	$8, %edx
.Ltmp238:
.LBB1_22:
	callq	__tvm_set_raised_12
	movl	$-1, %eax
	jmp	.LBB1_85
.Ltmp239:
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
	pushq	%rsi
	pushq	%rdi
	pushq	%rbx
	subq	$160, %rsp
	vmovaps	%xmm7, 144(%rsp)
	vmovaps	%xmm6, 128(%rsp)
	movq	%rdx, %rsi
	movq	%rcx, %rdi
	xorl	%ebx, %ebx
.Ltmp240:
	vbroadcastss	__real@80000000(%rip), %ymm0
	vmovups	%ymm0, 64(%rsp)
.Ltmp241:
	.p2align	4
.LBB4_1:
	vmovaps	(%rdi,%rbx), %ymm0
	vmovups	%ymm0, 96(%rsp)
	vxorps	64(%rsp), %ymm0, %ymm0
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
	vinsertps	$48, %xmm0, %xmm6, %xmm0
	vinsertf128	$1, %xmm7, %ymm0, %ymm0
	vbroadcastss	__real@3f800000(%rip), %ymm1
	vaddps	%ymm1, %ymm0, %ymm0
	vmovups	96(%rsp), %ymm1
	vdivps	%ymm0, %ymm1, %ymm0
	vmovaps	%ymm0, (%rsi,%rbx)
.Ltmp242:
	addq	$32, %rbx
.Ltmp243:
	cmpq	$4096, %rbx
	jne	.LBB4_1
.Ltmp244:
	vmovss	4096(%rdi), %xmm6
	vbroadcastss	__real@80000000(%rip), %xmm0
	vxorps	%xmm0, %xmm6, %xmm0
	vzeroupper
	callq	expf
	vaddss	__real@3f800000(%rip), %xmm0, %xmm0
	vdivss	%xmm0, %xmm6, %xmm0
	vmovss	%xmm0, 4096(%rsi)
	vmovaps	128(%rsp), %xmm6
	vmovaps	144(%rsp), %xmm7
	addq	$160, %rsp
	popq	%rbx
	popq	%rdi
.Ltmp245:
	popq	%rsi
.Ltmp246:
	retq
.Ltmp247:
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
.Ltmp248:
	.p2align	4
.LBB5_1:
	vmovaps	(%rdx,%rax), %ymm0
	vmulps	(%rcx,%rax), %ymm0, %ymm0
.Ltmp249:
	vmovaps	32(%rdx,%rax), %ymm1
	vmulps	32(%rcx,%rax), %ymm1, %ymm1
	vmovaps	%ymm0, (%r8,%rax)
	vmovaps	%ymm1, 32(%r8,%rax)
.Ltmp250:
	addq	$64, %rax
.Ltmp251:
	cmpq	$4096, %rax
	jne	.LBB5_1
.Ltmp252:
	vmovss	4096(%rdx), %xmm0
	vmulss	4096(%rcx), %xmm0, %xmm0
	vmovss	%xmm0, 4096(%r8)
	vzeroupper
	retq
.Ltmp253:
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
	.asciz	"contract_silu(gate: Tensor([T.int64(1025)], float32), silu: Tensor([T.int64(1025)], float32))"

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
	.asciz	"1025"

.L.str.33:
	.asciz	"gate.byte_offset"

.L.str.34:
	.asciz	"silu.shape[0]"

.L.str.35:
	.asciz	"silu.byte_offset"

.L.str.36:
	.asciz	"3"

.L.str.37:
	.asciz	"multiply(lv: Tensor([T.int64(1025)], float32), up: Tensor([T.int64(1025)], float32), T_multiply: Tensor([T.int64(1025)], float32))"

.L.str.38:
	.asciz	"lv"

.L.str.39:
	.asciz	"up"

.L.str.40:
	.asciz	"T_multiply"

.L.str.41:
	.asciz	"up.device_id"

.L.str.42:
	.asciz	"lv.device_id"

.L.str.43:
	.asciz	"T_multiply.device_id"

.L.str.44:
	.asciz	"lv.shape[0]"

.L.str.45:
	.asciz	"lv.byte_offset"

.L.str.46:
	.asciz	"up.shape[0]"

.L.str.47:
	.asciz	"up.byte_offset"

.L.str.48:
	.asciz	"T_multiply.shape[0]"

.L.str.49:
	.asciz	"T_multiply.byte_offset"

	.section	.drectve,"yni"
	.ascii	" /EXPORT:__tvm_ffi_contract_silu"
	.ascii	" /EXPORT:__tvm_ffi_multiply"
	.section	.debug$S,"dr"
	.p2align	2, 0x0
	.long	4
	.long	241
	.long	.Ltmp255-.Ltmp254
.Ltmp254:
	.short	.Ltmp257-.Ltmp256
.Ltmp256:
	.short	4353
	.long	0
	.byte	0
	.p2align	2, 0x0
.Ltmp257:
	.short	.Ltmp259-.Ltmp258
.Ltmp258:
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
.Ltmp259:
.Ltmp255:
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
	.quad	.Ltmp48-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp49-.Lfunc_begin0
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
	.quad	.Ltmp46-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp57-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Ltmp67-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp67-.Lfunc_begin0
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
	.quad	.Ltmp48-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp50-.Lfunc_begin0
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
	.quad	.Ltmp48-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	89
	.byte	159
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp51-.Lfunc_begin0
	.short	1
	.byte	89
	.quad	.Ltmp51-.Lfunc_begin0
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
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Ltmp62-.Lfunc_begin0
	.short	1
	.byte	90
	.quad	0
	.quad	0
.Ldebug_loc6:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.short	2
	.byte	116
	.byte	0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp80-.Lfunc_begin0
	.short	2
	.byte	116
	.byte	0
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp90-.Lfunc_begin0
	.short	2
	.byte	116
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc7:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp27-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp80-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp90-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc8:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.short	1
	.byte	85
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp80-.Lfunc_begin0
	.short	1
	.byte	85
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp90-.Lfunc_begin0
	.short	1
	.byte	85
	.quad	0
	.quad	0
.Ldebug_loc9:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp29-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp68-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp70-.Lfunc_begin0
	.quad	.Ltmp71-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp72-.Lfunc_begin0
	.quad	.Ltmp73-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp75-.Lfunc_begin0
	.quad	.Ltmp76-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp77-.Lfunc_begin0
	.quad	.Ltmp78-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp83-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp84-.Lfunc_begin0
	.quad	.Ltmp85-.Lfunc_begin0
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
	.quad	0
	.quad	0
.Ldebug_loc10:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp30-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.short	2
	.byte	123
	.byte	0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp80-.Lfunc_begin0
	.short	2
	.byte	123
	.byte	0
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp90-.Lfunc_begin0
	.short	2
	.byte	123
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc11:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp80-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp90-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc12:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp67-.Lfunc_begin0
	.quad	.Ltmp69-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp70-.Lfunc_begin0
	.quad	.Ltmp74-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp75-.Lfunc_begin0
	.quad	.Ltmp80-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp82-.Lfunc_begin0
	.quad	.Ltmp90-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc13:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin1-.Lfunc_begin0
	.quad	.Ltmp95-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp95-.Lfunc_begin0
	.quad	.Ltmp162-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	.Ltmp162-.Lfunc_begin0
	.quad	.Ltmp163-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp163-.Lfunc_begin0
	.quad	.Ltmp166-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	82
	.byte	159
	.quad	.Ltmp166-.Lfunc_begin0
	.quad	.Ltmp167-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp167-.Lfunc_begin0
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
	.quad	.Ltmp135-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp135-.Lfunc_begin0
	.quad	.Ltmp158-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	.Ltmp158-.Lfunc_begin0
	.quad	.Ltmp170-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp170-.Lfunc_begin0
	.quad	.Ltmp171-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	81
	.byte	159
	.quad	.Ltmp171-.Lfunc_begin0
	.quad	.Ltmp190-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp190-.Lfunc_begin0
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
	.quad	.Ltmp101-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp101-.Lfunc_begin0
	.quad	.Ltmp162-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	.Ltmp162-.Lfunc_begin0
	.quad	.Ltmp164-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp164-.Lfunc_begin0
	.quad	.Ltmp166-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	88
	.byte	159
	.quad	.Ltmp166-.Lfunc_begin0
	.quad	.Ltmp168-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	.Ltmp168-.Lfunc_begin0
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
	.quad	.Ltmp99-.Lfunc_begin0
	.short	1
	.byte	89
	.quad	.Ltmp99-.Lfunc_begin0
	.quad	.Ltmp162-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	89
	.byte	159
	.quad	.Ltmp162-.Lfunc_begin0
	.quad	.Ltmp165-.Lfunc_begin0
	.short	1
	.byte	89
	.quad	.Ltmp165-.Lfunc_begin0
	.quad	.Ltmp166-.Lfunc_begin0
	.short	4
	.byte	243
	.byte	1
	.byte	89
	.byte	159
	.quad	.Ltmp166-.Lfunc_begin0
	.quad	.Ltmp169-.Lfunc_begin0
	.short	1
	.byte	89
	.quad	.Ltmp169-.Lfunc_begin0
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
	.quad	.Ltmp95-.Lfunc_begin0
	.quad	.Ltmp100-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	0
	.quad	0
.Ldebug_loc18:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp101-.Lfunc_begin0
	.quad	.Ltmp108-.Lfunc_begin0
	.short	1
	.byte	88
	.quad	0
	.quad	0
.Ldebug_loc19:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp105-.Lfunc_begin0
	.quad	.Ltmp132-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp160-.Lfunc_begin0
	.quad	.Ltmp161-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp171-.Lfunc_begin0
	.quad	.Ltmp173-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp174-.Lfunc_begin0
	.quad	.Ltmp176-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp177-.Lfunc_begin0
	.quad	.Ltmp178-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp179-.Lfunc_begin0
	.quad	.Ltmp180-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp181-.Lfunc_begin0
	.quad	.Ltmp182-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp184-.Lfunc_begin0
	.quad	.Ltmp186-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp187-.Lfunc_begin0
	.quad	.Ltmp189-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	0
	.quad	0
.Ldebug_loc20:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp129-.Lfunc_begin0
	.quad	.Ltmp157-.Lfunc_begin0
	.short	2
	.byte	127
	.byte	0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.short	2
	.byte	127
	.byte	0
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp237-.Lfunc_begin0
	.short	2
	.byte	127
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc21:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp130-.Lfunc_begin0
	.quad	.Ltmp157-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp237-.Lfunc_begin0
	.short	2
	.byte	115
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc22:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp131-.Lfunc_begin0
	.quad	.Ltmp157-.Lfunc_begin0
	.short	1
	.byte	86
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.short	1
	.byte	86
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp237-.Lfunc_begin0
	.short	1
	.byte	86
	.quad	0
	.quad	0
.Ldebug_loc23:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp132-.Lfunc_begin0
	.quad	.Ltmp156-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp191-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp194-.Lfunc_begin0
	.quad	.Ltmp195-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp197-.Lfunc_begin0
	.quad	.Ltmp198-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp201-.Lfunc_begin0
	.quad	.Ltmp202-.Lfunc_begin0
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
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp220-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp222-.Lfunc_begin0
	.quad	.Ltmp223-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp225-.Lfunc_begin0
	.quad	.Ltmp226-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp228-.Lfunc_begin0
	.quad	.Ltmp229-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp231-.Lfunc_begin0
	.quad	.Ltmp232-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	.Ltmp234-.Lfunc_begin0
	.quad	.Ltmp235-.Lfunc_begin0
	.short	2
	.byte	114
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc24:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp133-.Lfunc_begin0
	.quad	.Ltmp157-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp237-.Lfunc_begin0
	.short	2
	.byte	126
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc25:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp134-.Lfunc_begin0
	.quad	.Ltmp157-.Lfunc_begin0
	.short	2
	.byte	125
	.byte	0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.short	2
	.byte	125
	.byte	0
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp237-.Lfunc_begin0
	.short	2
	.byte	125
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc26:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp135-.Lfunc_begin0
	.quad	.Ltmp156-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp193-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp194-.Lfunc_begin0
	.quad	.Ltmp200-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp201-.Lfunc_begin0
	.quad	.Ltmp210-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp211-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp237-.Lfunc_begin0
	.short	2
	.byte	113
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc27:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp136-.Lfunc_begin0
	.quad	.Ltmp138-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp139-.Lfunc_begin0
	.quad	.Ltmp157-.Lfunc_begin0
	.short	4
	.byte	119
	.byte	208
	.byte	0
	.byte	6
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.short	4
	.byte	119
	.byte	208
	.byte	0
	.byte	6
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp237-.Lfunc_begin0
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
	.quad	.Ltmp137-.Lfunc_begin0
	.quad	.Ltmp157-.Lfunc_begin0
	.short	2
	.byte	124
	.byte	0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp217-.Lfunc_begin0
	.short	2
	.byte	124
	.byte	0
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp237-.Lfunc_begin0
	.short	2
	.byte	124
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc29:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp138-.Lfunc_begin0
	.quad	.Ltmp156-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp190-.Lfunc_begin0
	.quad	.Ltmp192-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp194-.Lfunc_begin0
	.quad	.Ltmp196-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp197-.Lfunc_begin0
	.quad	.Ltmp199-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp201-.Lfunc_begin0
	.quad	.Ltmp203-.Lfunc_begin0
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
	.quad	.Ltmp219-.Lfunc_begin0
	.quad	.Ltmp221-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp222-.Lfunc_begin0
	.quad	.Ltmp224-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp225-.Lfunc_begin0
	.quad	.Ltmp227-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp228-.Lfunc_begin0
	.quad	.Ltmp230-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp231-.Lfunc_begin0
	.quad	.Ltmp233-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	.Ltmp234-.Lfunc_begin0
	.quad	.Ltmp236-.Lfunc_begin0
	.short	2
	.byte	120
	.byte	0
	.quad	0
	.quad	0
.Ldebug_loc30:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin4-.Lfunc_begin0
	.quad	.Ltmp241-.Lfunc_begin0
	.short	1
	.byte	82
	.quad	.Ltmp241-.Lfunc_begin0
	.quad	.Ltmp245-.Lfunc_begin0
	.short	1
	.byte	85
	.quad	.Ltmp245-.Lfunc_begin0
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
	.quad	.Ltmp241-.Lfunc_begin0
	.short	1
	.byte	81
	.quad	.Ltmp241-.Lfunc_begin0
	.quad	.Ltmp246-.Lfunc_begin0
	.short	1
	.byte	84
	.quad	.Ltmp246-.Lfunc_begin0
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
	.quad	.Ltmp240-.Lfunc_begin0
	.quad	.Ltmp241-.Lfunc_begin0
	.short	3
	.byte	17
	.byte	0
	.byte	159
	.quad	.Ltmp241-.Lfunc_begin0
	.quad	.Ltmp242-.Lfunc_begin0
	.short	6
	.byte	115
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	159
	.quad	.Ltmp242-.Lfunc_begin0
	.quad	.Ltmp243-.Lfunc_begin0
	.short	9
	.byte	115
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
.Ldebug_loc33:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp241-.Lfunc_begin0
	.quad	.Ltmp243-.Lfunc_begin0
	.short	9
	.byte	115
	.byte	0
	.byte	17
	.byte	32
	.byte	27
	.byte	17
	.byte	8
	.byte	30
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc34:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp248-.Lfunc_begin0
	.quad	.Ltmp249-.Lfunc_begin0
	.short	10
	.byte	112
	.byte	0
	.byte	17
	.byte	192
	.byte	0
	.byte	27
	.byte	17
	.byte	2
	.byte	30
	.byte	159
	.quad	.Ltmp249-.Lfunc_begin0
	.quad	.Ltmp250-.Lfunc_begin0
	.short	5
	.byte	112
	.byte	0
	.byte	49
	.byte	33
	.byte	159
	.quad	.Ltmp250-.Lfunc_begin0
	.quad	.Ltmp251-.Lfunc_begin0
	.short	13
	.byte	112
	.byte	0
	.byte	17
	.byte	192
	.byte	0
	.byte	27
	.byte	17
	.byte	2
	.byte	30
	.byte	17
	.byte	2
	.byte	34
	.byte	159
	.quad	0
	.quad	0
.Ldebug_loc35:
	.quad	-1
	.quad	.Lfunc_begin0
	.quad	.Ltmp248-.Lfunc_begin0
	.quad	.Ltmp249-.Lfunc_begin0
	.short	10
	.byte	112
	.byte	0
	.byte	17
	.byte	192
	.byte	0
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	159
	.quad	.Ltmp249-.Lfunc_begin0
	.quad	.Ltmp251-.Lfunc_begin0
	.short	13
	.byte	112
	.byte	0
	.byte	17
	.byte	192
	.byte	0
	.byte	27
	.byte	17
	.byte	16
	.byte	30
	.byte	17
	.byte	8
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
	.byte	5
	.byte	0
	.byte	2
	.byte	24
	.byte	3
	.byte	14
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

	.long	641
	.byte	3
	.secrel32	.Ldebug_loc0
	.secrel32	.Linfo_string8
	.long	648
	.byte	3
	.secrel32	.Ldebug_loc1
	.secrel32	.Linfo_string9
	.long	648
	.byte	3
	.secrel32	.Ldebug_loc2
	.secrel32	.Linfo_string10
	.long	641
	.byte	3
	.secrel32	.Ldebug_loc3
	.secrel32	.Linfo_string11
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc4
	.secrel32	.Linfo_string12
	.long	641
	.byte	4
	.secrel32	.Ldebug_loc5
	.secrel32	.Linfo_string13
	.long	641
	.byte	4
	.secrel32	.Ldebug_loc6
	.secrel32	.Linfo_string14
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc7
	.secrel32	.Linfo_string15
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc8
	.secrel32	.Linfo_string16
	.long	641
	.byte	4
	.secrel32	.Ldebug_loc9
	.secrel32	.Linfo_string17
	.long	649
	.byte	4
	.secrel32	.Ldebug_loc10
	.secrel32	.Linfo_string19
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc11
	.secrel32	.Linfo_string20
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc12
	.secrel32	.Linfo_string21
	.long	649
	.byte	0
	.byte	2
	.quad	.Lfunc_begin1
	.long	.Lfunc_end1-.Lfunc_begin1
	.byte	1
	.byte	87
	.secrel32	.Linfo_string5

	.long	641
	.byte	3
	.secrel32	.Ldebug_loc13
	.secrel32	.Linfo_string8
	.long	648
	.byte	3
	.secrel32	.Ldebug_loc14
	.secrel32	.Linfo_string9
	.long	648
	.byte	3
	.secrel32	.Ldebug_loc15
	.secrel32	.Linfo_string10
	.long	641
	.byte	3
	.secrel32	.Ldebug_loc16
	.secrel32	.Linfo_string11
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc17
	.secrel32	.Linfo_string22
	.long	641
	.byte	4
	.secrel32	.Ldebug_loc18
	.secrel32	.Linfo_string23
	.long	641
	.byte	4
	.secrel32	.Ldebug_loc19
	.secrel32	.Linfo_string24
	.long	641
	.byte	4
	.secrel32	.Ldebug_loc20
	.secrel32	.Linfo_string25
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc21
	.secrel32	.Linfo_string26
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc22
	.secrel32	.Linfo_string16
	.long	641
	.byte	4
	.secrel32	.Ldebug_loc23
	.secrel32	.Linfo_string27
	.long	649
	.byte	4
	.secrel32	.Ldebug_loc24
	.secrel32	.Linfo_string28
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc25
	.secrel32	.Linfo_string29
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc26
	.secrel32	.Linfo_string30
	.long	649
	.byte	4
	.secrel32	.Ldebug_loc27
	.secrel32	.Linfo_string31
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc28
	.secrel32	.Linfo_string32
	.long	648
	.byte	4
	.secrel32	.Ldebug_loc29
	.secrel32	.Linfo_string33
	.long	649
	.byte	0
	.byte	5
	.quad	.Lfunc_begin4
	.long	.Lfunc_end4-.Lfunc_begin4
	.byte	1
	.byte	87
	.secrel32	.Linfo_string6

	.byte	3
	.long	641
	.byte	3
	.secrel32	.Ldebug_loc30
	.secrel32	.Linfo_string17
	.long	649
	.byte	3
	.secrel32	.Ldebug_loc31
	.secrel32	.Linfo_string21
	.long	649
	.byte	4
	.secrel32	.Ldebug_loc32
	.secrel32	.Linfo_string34
	.long	641
	.byte	4
	.secrel32	.Ldebug_loc33
	.secrel32	.Linfo_string35
	.long	641
	.byte	0
	.byte	5
	.quad	.Lfunc_begin5
	.long	.Lfunc_end5-.Lfunc_begin5
	.byte	1
	.byte	87
	.secrel32	.Linfo_string7

	.byte	3
	.long	641
	.byte	6
	.byte	1
	.byte	82
	.secrel32	.Linfo_string27
	.long	649
	.byte	6
	.byte	1
	.byte	81
	.secrel32	.Linfo_string30
	.long	649
	.byte	6
	.byte	1
	.byte	88
	.secrel32	.Linfo_string33
	.long	649
	.byte	4
	.secrel32	.Ldebug_loc34
	.secrel32	.Linfo_string36
	.long	641
	.byte	4
	.secrel32	.Ldebug_loc35
	.secrel32	.Linfo_string35
	.long	641
	.byte	0
	.byte	7
	.secrel32	.Linfo_string4
	.byte	5
	.byte	4
	.byte	8
	.byte	9
	.long	654
	.byte	7
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
	.asciz	"i00_0"
.Linfo_string35:
	.asciz	"cse_v1"
.Linfo_string36:
	.asciz	"ax00_0"
	.section	.debug_pubnames,"dr"
	.long	.LpubNames_end0-.LpubNames_start0
.LpubNames_start0:
	.short	2
	.secrel32	.Lcu_begin0
	.long	662
	.long	42
	.asciz	"__tvm_ffi_contract_silu"
	.long	235
	.asciz	"__tvm_ffi_multiply"
	.long	480
	.asciz	"contract_silu_compute_"
	.long	557
	.asciz	"multiply_compute_"
	.long	0
.LpubNames_end0:
	.section	.debug_pubtypes,"dr"
	.long	.LpubTypes_end0-.LpubTypes_start0
.LpubTypes_start0:
	.short	2
	.secrel32	.Lcu_begin0
	.long	662
	.long	641
	.asciz	"int32"
	.long	654
	.asciz	"float32"
	.long	0
.LpubTypes_end0:
	.globl	_fltused
	.section	.debug_line,"dr"
.Lline_table_start0:
