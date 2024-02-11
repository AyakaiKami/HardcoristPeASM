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
        mov r11,r10
        inc r11
        _loopB:
            mov r12,r11
            inc r12
            _loopC:
                xor rdx,rdx
                mov rax,r10
                mul r11
                mov rbx,1000
                cmp rax,rbx
                jl _nextB
                div rbx
                cmp rdx,0
                jne _nextB

                mov rsi,500 
                cmp r12,rsi
                jge _nextB

                sub rsi,r12
                cmp rax,rsi
                je _rez
                inc r12
                jmp _loopC
            _nextB:
            inc r11
            cmp r11,499
            jg _nextA
            jmp _loopB
        _nextA:
            inc r10
            cmp r10,498
            jg _rez
            jmp _loopA

                

    _rez:
        mov rax,r10
        call _printNumber
        mov rax,r11
        call _printNumber
        mov rax,r12
        call _printNumber
        xor rax,rax
        mov rax,r10
        mul r11
        mul r12
        call _printNumber
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