section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start

_start:
    ;https://projecteuler.net/problem=10
    ;sum of primes
    mov rax,10
    call _print
    ;exit call
    mov rax,60
    mov rdi,0
    syscall


_print:
    mov rcx,digitSpace
    mov rbx,10
    mov [rcx],rbx
    inc rcx 
    mov [digitSpacePos],rcx

    _stringMakeLoop:
        mov rcx,[digitSpacePos]
        xor rdx,rdx
        div rbx
