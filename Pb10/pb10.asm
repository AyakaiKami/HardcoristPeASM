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
    ;rez in r10
    xor r10,r10
    mov r11,10;limit/n

    mov rcx,2;iterator
    _loop:
        call _isPrim
        cmp rax,1
        jne _next
        add r10,rcx
        _next:
        cmp rcx,r11
        jle _loop

    mov rax,r10
    call _print
    
    ;exit call
    mov rax,60
    mov rdi,0
    syscall
_isPrim:
    
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

    
