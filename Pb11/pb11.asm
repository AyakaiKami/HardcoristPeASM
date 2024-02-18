section .data
    path db "Pb11/input.txt",0
section .bss
    digitSpace resb 100
    digitSpacePos resb 8
    fd resb 8
section .text
    global _start

_start:
    mov rax,10
    call _print

    ;exit call
    mov rax,60
    mov rdi,0
    syscall

_openFile:
    mov rax,2
    mov rdi,path
    mov rsi,0
    mov rdx,0
    ret

_print:
    mov rcx,digitSpace
    mov rbx,10
    mov [rcx],bl
    inc rcx
    mov [digitSpacePos],rcx
    mov rbx,10
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
        mov rdx,1
        mov rsi,rcx
        syscall

        mov rcx,[digitSpacePos]
        dec rcx
        mov [digitSpacePos],rcx
        cmp rcx,digitSpace
        jge _printString

ret
