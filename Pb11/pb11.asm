section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start

_start:
    mov rax,10
    call _print

    ;exit call
    mov rax,60
    mov rdi,0
    syscall


_print:
    mov rcx,digitSpace
    mov rbx,10
    mov [rcx],bl
    mov [digitSpacePos],rcx

    _stringMakeLoop:
        xor rdx,rdx
        div rbx
        add rdx,48
        mov [rcx],dl

        mov rcx,[digitSpacePos]
        inc rcx
        mov [digitSpacePos],rcx
        cmp rax,0
        jne _stringMakeLoop

    _printString:
        mov rax,0
        mov rdi,1
        mov rdx,1
        mov rsi,rcx
        syscall

ret
