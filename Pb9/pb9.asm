section .bss    
    digitSpace resb 100
    digitSpacePos resb 8
section .text
    global _start

_start:
    ;https://projecteuler.net/problem=9
    mov r10,1 ;a
    mov r11,2;b
    mov r12,3;c
    
    _loopA:
        _loopB:
            _loopC:
                xor rdx,rdx
                mov rax,r10
                mul r11
                mov rbx,500
                cmp rax,rbx
                jl _nextB
                div rbx
                cmp rdx,0
                jne _nextB

                mov rsi,rax ;temp a*b/500
                


    ;exit call
    mov rax,60
    mov rdi,0
    syscall

_printNumber:
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
        jg _stringMakeLoop

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
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax
ret