section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start

_start:


    ;exit call
    mov rax,60
    mov rdi,0
    syscall