section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start

_start:
    ;https://projecteuler.net/problem=7
    ; the n -th prime number
    ;iterate through numberes
    ;when we find the n-th prime number we stop

    mov r9,10001;n
    mov r8,2;iterator
    mov r10,0;prime number index

    _loopIterate:
        mov rax,r8
        call _isPrim
        cmp rax,0;is not prim
        je _next
        inc r10
        _next:
        cmp r10,r9
        je _out
        inc r8
        jmp _loopIterate

    _out:
    ;print result
    mov rax,r8
    
    call _print

    ;exit
    mov rax,60
    mov rdi,0
    syscall

_isPrim:;check if prim function
    
   mov rcx,rax
   mov rbx,2
   cmp rax,rbx
   je _true

   _loopP:
    xor rdx,rdx
    div rbx
    cmp rdx,0
    je _false
    inc rbx
    mov rax,rcx
    cmp rbx,rcx
    je _true
    jmp _loopP

    _false:
        mov rax,0
        ret

    _true:
        mov rax,1
        ret

_print:;print function
    mov rcx,digitSpace
    mov rbx,10
    mov [rcx],rbx
    inc rcx
    mov [digitSpacePos],rcx

    _stringMakeLoop:
        xor rdx,rdx
        mov rbx,10
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