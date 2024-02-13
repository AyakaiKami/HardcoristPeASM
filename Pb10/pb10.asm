section .bss
    digitSpace resb 100
    digitSpacePos resb 8
    primes resb 1024
    primesPos resb 8
    primesSize resb 8
section .text
    global _start

_start:
    ;https://projecteuler.net/problem=10
    ;sum of primes
    mov rbx,0
    mov [primesSize],rbx
    mov rax,10
    call _print
    ;exit call
    mov rax,60
    mov rdi,0
    syscall

_addPrime:;we will add rax
    mov r13,[primesSize]
    mov rcx,primes
    mov [primesPos],rcx

    _loopPrime:
        mov rbx,[rcx]
        cmp bl,0
        je _endLoopPrime


    _endLoopPrime:
        push rax
        add rax,48
        mov [rcx],al
    ret

_print:
    mov rcx,digitSpace
    mov rbx,10
    mov [rcx],rbx
    inc rcx 
    mov [digitSpacePos],rcx

    mov rbx,10
    _stringMakeLoop:
        ;put character in place
        xor rdx,rdx
        div rbx
        add rdx,48
        mov rcx,[digitSpacePos]
        mov [rcx],dl
        ;move index
        inc rcx
        mov [digitSpacePos],rcx
        cmp rax,0
        jne _stringMakeLoop

    _printString:
        mov rcx,[digitSpacePos]
        mov rax,1
        mov rsi,rcx
        mov rdi,1
        mov rdx,1
        syscall

        mov rcx,[digitSpacePos]
        dec rcx
        mov [digitSpacePos],rcx
        cmp rcx,digitSpace
        jge _printString

ret

    
