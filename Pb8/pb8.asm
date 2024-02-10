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
    ;call _closeFile
    mov r10,0;rez

    xor rax,rax
    ;loop for iterating through the digits
    _loop:
        mov [bufferPos],rcx
        mov rcx,[bufferPos]
        mov al,[rcx]
        inc rcx
        cmp al,0
        je _close
        cmp al,10
        je _loop
        jmp _loop
    
    ;print rez
    mov rax,r10
    call _printNumber
    
    call _closeFile
    _close:
    
    ;exit call
    mov rax,60
    mov rdi,0
    syscall

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
        jge _printString

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