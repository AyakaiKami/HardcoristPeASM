section .bss
    digitSpace resb 100
    digitSpacePos resb 8
    fd_read resb 8
    buffer resb 1024
section .data
    path db 'Pb8/input.txt', 0
    lenfilename equ $ - path
section .text
    global _start

_start:
    ;https://projecteuler.net/problem=8   
    mov rax,10
    call _openFile
    call _readFile
    mov rdi,1
    _loop:
        mov al,[rcx+rdi*8]
        inc rdi
        cmp rax,0
        je _close
        sub rax,48
        call _printNumber
        jmp _loop
    _close:
    call _closeFile
    
    ;exit call
    mov rax,60
    mov rdi,0
    syscall

_readFile:
    push rax
    mov rax,0
    pop rdi
    mov rsi,buffer
    mov rdx,16
    syscall

    lea rcx,buffer
    ret

_printNumber:
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