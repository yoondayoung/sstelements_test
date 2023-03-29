	.file	"opal_test.c"
	.text
	.section	.rodata
.LC0:
	.string	"Inside Ariel"
	.text
	.globl	ariel_enable
	.type	ariel_enable, @function
ariel_enable:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	ariel_enable, .-ariel_enable
	.section	.rodata
	.align 8
.LC1:
	.string	"weight pre malloc calling in opal_test.c"
	.text
	.globl	weight_pre_malloc
	.type	weight_pre_malloc, @function
weight_pre_malloc:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	weight_pre_malloc, .-weight_pre_malloc
	.globl	weight_post_malloc
	.type	weight_post_malloc, @function
weight_post_malloc:
.LFB17:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	weight_post_malloc, .-weight_post_malloc
	.section	.rodata
.LC2:
	.string	"ZERO BYTE MALLOC"
	.align 8
.LC3:
	.string	"Performing a mlm Malloc for size %llu\n"
	.text
	.globl	mlm_malloc
	.type	mlm_malloc, @function
mlm_malloc:
.LFB18:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$544, %rsp
	movq	%rdi, -536(%rbp)
	movl	%esi, -540(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpq	$0, -536(%rbp)
	jne	.L5
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	movl	$-1, %edi
	call	exit@PLT
.L5:
	movq	-536(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-536(%rbp), %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	mlm_malloc, .-mlm_malloc
	.section	.rodata
	.align 8
.LC4:
	.string	"Allocating arrays of size %d elements.\n"
	.align 8
.LC5:
	.string	"allocated address: a:%x b:%x c:%x\n"
.LC6:
	.string	"Done allocating arrays."
.LC9:
	.string	"Sum of arrays is: %f\n"
.LC10:
	.string	"Done."
	.text
	.globl	main
	.type	main, @function
main:
.LFB19:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	movl	$2000, -36(%rbp)
	call	ariel_enable
	movl	$2000, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %esi
	movl	$16000, %edi
	call	mlm_malloc
	movq	%rax, -24(%rbp)
	movl	$16000, %edi
	call	malloc@PLT
	movq	%rax, -16(%rbp)
	movl	$1, %esi
	movl	$16000, %edi
	call	mlm_malloc
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rcx
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC6(%rip), %rdi
	call	puts@PLT
	movl	$0, -44(%rbp)
.L10:
	cmpl	$1999, -44(%rbp)
	jg	.L9
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	cvtsi2sdl	-44(%rbp), %xmm0
	movsd	%xmm0, (%rax)
	movl	$2000, %eax
	subl	-44(%rbp), %eax
	movl	%eax, %ecx
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	cvtsi2sdl	%ecx, %xmm0
	movsd	%xmm0, (%rax)
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	pxor	%xmm0, %xmm0
	movsd	%xmm0, (%rax)
	addl	$1, -44(%rbp)
	jmp	.L10
.L9:
	movl	$0, -44(%rbp)
.L12:
	cmpl	$1999, -44(%rbp)
	jg	.L11
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	movapd	%xmm0, %xmm1
	addsd	%xmm0, %xmm1
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm2
	movsd	.LC8(%rip), %xmm0
	mulsd	%xmm2, %xmm0
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%rax)
	addl	$1, -44(%rbp)
	jmp	.L12
.L11:
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -32(%rbp)
	movl	$0, -44(%rbp)
.L14:
	cmpl	$1999, -44(%rbp)
	jg	.L13
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	movsd	-32(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -32(%rbp)
	addl	$1, -44(%rbp)
	jmp	.L14
.L13:
	movq	-32(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC9(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, -40(%rbp)
.L16:
	cmpl	$9999, -40(%rbp)
	jg	.L15
	addl	$1, -40(%rbp)
	jmp	.L16
.L15:
	leaq	.LC10(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC8:
	.long	0
	.long	1073217536
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
