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
	call	puts@PLT
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
	movl	$0, %eax
	call	printf@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	weight_pre_malloc, .-weight_pre_malloc
	.section	.rodata
	.align 8
.LC2:
	.string	"Allocating arrays of size %d elements.\n"
	.align 8
.LC3:
	.string	"allocated address: a:%x b:%x c:%x\n"
.LC4:
	.string	"Done allocating arrays."
.LC7:
	.string	"Sum of arrays is: %f\n"
.LC8:
	.string	"Freeing arrays..."
.LC9:
	.string	"Done."
	.text
	.globl	main
	.type	main, @function
main:
.LFB17:
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
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$2000, -44(%rbp)
	call	ariel_enable
	movl	$2000, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	call	weight_pre_malloc
	movl	$16000, %edi
	call	malloc@PLT
	movq	%rax, -40(%rbp)
	movl	$16000, %edi
	call	malloc@PLT
	movq	%rax, -32(%rbp)
	movl	$16000, %edi
	call	malloc@PLT
	movq	%rax, -24(%rbp)
	leaq	-24(%rbp), %rcx
	leaq	-32(%rbp), %rdx
	leaq	-40(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC4(%rip), %rdi
	call	puts@PLT
	movl	$0, -48(%rbp)
.L5:
	cmpl	$1999, -48(%rbp)
	jg	.L4
	movq	-40(%rbp), %rax
	movl	-48(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	cvtsi2sdl	-48(%rbp), %xmm0
	movsd	%xmm0, (%rax)
	movl	$2000, %eax
	subl	-48(%rbp), %eax
	movl	%eax, %ecx
	movq	-32(%rbp), %rax
	movl	-48(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	cvtsi2sdl	%ecx, %xmm0
	movsd	%xmm0, (%rax)
	movq	-24(%rbp), %rax
	movl	-48(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	pxor	%xmm0, %xmm0
	movsd	%xmm0, (%rax)
	addl	$1, -48(%rbp)
	jmp	.L5
.L4:
	movl	$0, -48(%rbp)
.L7:
	cmpl	$1999, -48(%rbp)
	jg	.L6
	movq	-40(%rbp), %rax
	movl	-48(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	movapd	%xmm0, %xmm1
	addsd	%xmm0, %xmm1
	movq	-32(%rbp), %rax
	movl	-48(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movsd	(%rax), %xmm2
	movsd	.LC6(%rip), %xmm0
	mulsd	%xmm2, %xmm0
	movq	-24(%rbp), %rax
	movl	-48(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%rax)
	addl	$1, -48(%rbp)
	jmp	.L7
.L6:
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -16(%rbp)
	movl	$0, -48(%rbp)
.L9:
	cmpl	$1999, -48(%rbp)
	jg	.L8
	movq	-24(%rbp), %rax
	movl	-48(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	movsd	-16(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
	addl	$1, -48(%rbp)
	jmp	.L9
.L8:
	movq	-16(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC7(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	leaq	.LC8(%rip), %rdi
	call	puts@PLT
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	leaq	.LC9(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC6:
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
