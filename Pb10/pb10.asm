section .bss
    digitSpace resb 100
    digitSpacePos resb 8
    primes resb 65536
    primesPos resb 64
    primesSize resb 64
section .text
    global _start

_start:
    ;https://projecteuler.net/problem=10
    ;sum of primes
    ;rez in r10
    mov rax,0
    mov [primesSize],rax


    xor r10,r10
    mov r11,4;limit/n
    xor rcx,rcx
    mov ecx,2;iterator
    _loop:
        call _isPrim 
        cmp rax,1
        jne _next
        add r10,rcx
        _next:
        inc ecx 
        cmp rcx,r11
        jle _loop

    mov rax,r10
    call _print
    
    ;exit call
    mov rax,60
    mov rdi,0
    syscall

;is Prim function input in rax
_isPrim:
        push r10
        push r11
        push rcx
        
        mov rbx,0
        mov r10,0
        cmp [primesSize],rbx
        je _primTrue

        _loopPrim:
            xor rax,rax 
            xor rdx,rdx
            ;mov rax,rcx
            mov rdi,[primes+rbx]
            div rdi
            cmp rdx,0
            jne _nextLoopPrim
            jmp _primFalse
            _nextLoopPrim:
            add rbx,32
            inc r10
            cmp r10,[primesSize]
            jle _loopPrim

        _primTrue:
            mov rax,1
            mov [primes+rbx],ecx
            mov rbx,[primesSize]
            inc rbx
            mov [primesSize],rbx
            pop rcx
            pop r11
            pop r10
            ret
        _primFalse:
            mov rax,0
            pop rcx
            pop r11
            pop r10
            ret


;print function  
_print:
    push rax
    push rcx
    push rbx
    push rdx
    push rdi
    push rsi
    push r10
    push r11
    push r12
    push r15

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

    pop r15
    pop r12
    pop r11
    pop r10
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax
ret

    
