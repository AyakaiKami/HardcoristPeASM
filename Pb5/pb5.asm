section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start
_start:
    ;https://projecteuler.net/problem=5
    ;smallest number evenly divisible by all numbers 
    ;from 1 to 20

    mov rax,10
    call _print




    mov rax,60
    mov rdi,0
    syscall


_print:
    push rax
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi

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
        jne _stringMakeLoop


    _printString:
        mov rcx,[digitSpacePos]
        mov rax,1
        mov rdi,1
        mov rsi,rcx
        mov rdx,1
        syscall

        dec rcx
        mov [digitSpacePos],rcx
        cmp rcx,digitSpace
        jge _printString

    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret