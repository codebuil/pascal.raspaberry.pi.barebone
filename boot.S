// AArch32 mode
 
// To keep this in the first portion of the binary.
.section ".text.boot"
.extern jit_code_start
// Make _start global.
.globl _starts
.globl FPC_LIB_EXIT
.globl PC_LIB_EXIT
.globl fpc_libinitializeunits
.globl THREADVARLIST_$SYSTEM$indirect
.globl INIT$_$SYSTEM
.globl FPC_LIBINITIALIZEUNITS
.globl THREADVARLIST_$SYSTEM
.extern P$KERNEL_$$_MAINS 
        .org 0x8000
// Entry point for the kernel.
// r15 -> should begin execution at 0x8000.
// r0 -> 0x00000000
// r1 -> 0x00000C42 - machine id
// r2 -> 0x00000100 - start of ATAGS
// preserve these registers as argument for kernel_main
_starts:
	// Setup the stack.
	mov sp, #0x8000
 
	// Clear out bss.
	ldr r4, =__bss_start
	ldr r9, =__bss_end
	mov r5, #0
	mov r6, #0
	mov r7, #0
	mov r8, #0
	b       2f
 
1:
	// store multiple at r4.
	stmia r4!, {r5-r8}
 
	// If we are still below bss_end, loop.
2:
	cmp r4, r9
	blo 1b
 
	// Call kernel_main
	ldr r3, =P$KERNEL_$$_MAINS
	blx r3
	// halt
    INIT$_$SYSTEM:
halt:
	b halt
THREADVARLIST_$SYSTEM$indirect:
FPC_LIB_EXIT:
PC_LIB_EXIT:
fpc_libinitializeunits:
FPC_LIBINITIALIZEUNITS:
THREADVARLIST_$SYSTEM:
pop {fp,pc}
