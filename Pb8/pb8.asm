section .bss
    digitSpace resb 100
    digitSpacePos resb 8
    fd_read resb 8
    buffer resb 1024
    bufferPos resb 8
section .data
    path db 'Pb8/input.txt', 0
    lenfilename equ $ - path
section .text
    global _start

_start:
    ;https://projecteuler.net/problem=8   

    ;list of digits will be stored in input.txt
    ;we read the digits in a buffer
    call _openFile
    call _readFile
    call _closeFile
    mov r10,0;rez

    ;loop for iterating through the digits
    mov [bufferPos],rcx
    _loop:
        ;call _prod
        xor rax,rax
        mov al,[rcx]
        call _printNumber
        mov rcx,[bufferPos]
        inc rcx
        mov [bufferPos],rcx
        cmp rax,0
        je _close
        jmp _loop
    ;print rez
    mov rax,r10
    ;call _printNumber
    
    _close:
    
    ;exit call
    mov rax,60
    mov rdi,0
    syscall


_prod:
    push rcx
    mov rbx,0;iterator
    mov r9,1;produs

    _loopP:
        mov rcx,[bufferPos]
        mov al,[rcx]
        inc rcx
        mov [bufferPos],rcx
        cmp rax,0
        je _endProd
        sub al,48
        xor r12,r12
        mov r12,rax
        mov rax,r9
        mul r12
        mov r9,rax
        inc rbx
        cmp rbx,4
        jl _loopP

    mov rax,r9
    call _printNumber
    cmp r9,r10
    jle _endProd
    mov r10,r9

    _endProd:
    pop rcx
ret
_readFile:
    push rax
    mov rax,0
    pop rdi
    mov rsi,buffer
    mov rdx,1024
    syscall

    mov rcx,buffer
    ret

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
        mov rdi,1
        mov rsi,rcx
        mov rdx,1
        syscall

        mov rcx,[digitSpacePos]
        dec rcx
        mov [digitSpacePos],rcx
        cmp rcx,digitSpace
        jg _printString

    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret


_openFile:
    mov rax,2
    mov rdi,path
    mov rsi,0
    mov rdx,0
    syscall
    ;test rax,rax
    ;js _error 
    mov [fd_read],rax
ret

_closeFile:
    mov rax,3
    mov rdi,[fd_read]
    syscall

ret
_error:
    mov rax,60
    mov rdi,1
    syscall
ret