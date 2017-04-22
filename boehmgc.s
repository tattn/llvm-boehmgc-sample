	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 12
	.p2align	4, 0x90
_my_malloc:                             ## @my_malloc
	.cfi_startproc
## BB#0:
	pushq	%rax
Lcfi0:
	.cfi_def_cfa_offset 16
	callq	_GC_malloc
	popq	%rcx
	retq
	.cfi_endproc

	.p2align	4, 0x90
_finalizer:                             ## @finalizer
	.cfi_startproc
## BB#0:
	pushq	%rax
Lcfi1:
	.cfi_def_cfa_offset 16
	movl	_finalizer.count(%rip), %esi
	leal	1(%rsi), %eax
	movl	%eax, _finalizer.count(%rip)
	leaq	L_finalizer.str.freed(%rip), %rdi
	xorl	%eax, %eax
                                        ## kill: %ESI<def> %ESI<kill> %RSI<kill>
	callq	_printf
	popq	%rax
	retq
	.cfi_endproc

	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbx
Lcfi2:
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
Lcfi3:
	.cfi_def_cfa_offset 32
Lcfi4:
	.cfi_offset %rbx, -16
	callq	_GC_init
	movl	$8, %edi
	callq	_my_malloc
	movq	$1234567890, (%rax)     ## imm = 0x499602D2
	leaq	l_main.str.format(%rip), %rdi
	movl	$1234567890, %esi       ## imm = 0x499602D2
	xorl	%eax, %eax
	callq	_printf
	movl	$0, 4(%rsp)
	leaq	_finalizer(%rip), %rbx
	cmpl	$99, 4(%rsp)
	jg	LBB2_3
	.p2align	4, 0x90
LBB2_2:                                 ## %for_body
                                        ## =>This Inner Loop Header: Depth=1
	movl	$128, %edi
	callq	_my_malloc
	movq	%rax, 8(%rsp)
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	_GC_register_finalizer
	incl	4(%rsp)
	cmpl	$99, 4(%rsp)
	jle	LBB2_2
LBB2_3:                                 ## %for_end
	callq	_GC_gcollect
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbx
	retq
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_finalizer.str.freed:                  ## @finalizer.str.freed
	.asciz	"freed %d\n"

.zerofill __DATA,__bss,_finalizer.count,4,2 ## @finalizer.count
	.section	__TEXT,__const
l_main.str.format:                      ## @main.str.format
	.asciz	"%ld\n"


.subsections_via_symbols
