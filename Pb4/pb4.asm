section .bss
    digitSpace resb 100
    digitSpacePos resb 8
section .text
    global _start
_start:
    ;https://projecteuler.net/problem=4
    ;largest palindrom number that is a product of 2
    ;3 digit numberes

    ;we will need a function that checks if a number is a plaindrome
    
    
    
    ;print result
    mov r8,11
    call _isPlaindrome
    call _print

    mov rax,60
    mov rdi,0
    syscall
    

_isPlaindrome:;lets say the parameter will be in r8
    ;we will need to make a reverse version of that number

    ;number in reverse
    xor r9,r9
    
    ;we make a copy of the number
    mov  rax,r8
    mov rbx,10

    _reverseLoop:
        xor rdx,rdx
        div rbx
        push rax
        mov rax,r9
        mul rbx
        add rax,rdx
        mov r9,rax
        pop rax
        cmp rax,0
        jne _reverseLoop

    mov rax,r9
    call _print
    cmp r8,r9
    jne _return
    
    mov rax,1
    
    _return:
        ret
    

_print:
    mov rcx,digitSpace
    mov rbx,10
    mov [rcx],rbx
    inc rcx
    mov [digitSpacePos],rcx

    _stringMakeLoop:
        mov rdx,0
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