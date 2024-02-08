section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start

_start:
    ;https://projecteuler.net/problem=8   
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
        xor rdx,rdx
        div rbx
        add rdx,48

        mov rcx,[digitSpacePos]
        mov [rcx],dl
        inc rcx
        mov [digitSpacePos],rcx

        cmp rax,0
        jg _stringMakeLoop

    _printString:
        mov rcx,[digitSpacePos]
        mov rax,1
        mov rdi,1
        mov rsi,rcx
        mov rdx,1
        syscall

        mov rcx,[digitSpacePos]
        dec rcx
        mov [digitSpacePos],rcx
        cmp rcx,digitSpace
        jg _printString
    ret