section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .text  
    global _start

_start:
    ;https://projecteuler.net/problem=6
    ;Find the difference between the sum of the squares of the first one hundred 
    ;natural numbers and the square of the sum.

    ;sum of i^2
    mov r9,100;upper limit
    mov r8,1;iterator
    mov r10,0;sum
    
    _loopPSum:;sum of powers
        mov rax,r8
        mul r8
        add r10,rax
        inc r8
        cmp r8,r9
        jle _loopPSum

    ;power of sum
    mov rax,r9
    inc rax
    mul r9
    mov rbx,2
    div rbx
    mul rax

    sub rax,r10
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
        jne _stringMakeLoop

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
        jge _printString

    ret