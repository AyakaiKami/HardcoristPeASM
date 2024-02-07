section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start
_start:
    ;https://projecteuler.net/problem=5
    ;smallest number evenly divisible by all numbers 
    ;from 1 to 20
    mov r9,1 ;result

    mov r8,2
    mov rcx,20
    _loopIterate:
        xor rax,rax
        mov rax,r8
        call _maxPower
        call _isInRez
    mov rax,r9
    call _print

    mov rax,60
    mov rdi,0
    syscall

_isInRez:;0 means rax is in r9 already
         ;1 means rax is not in r9 
    push rax
    mov rbx,rax
    mov rax,r9
    xor rdx,rdx
    div rbx

    cmp rdx,0
    je _return
    mov rdx,1
    _return:
        pop rax
        ret

_maxPower:;used to determine the n in 2^n<=m where m is the upper limit
    ;this will return 2^n
    ;rax will hold 2
    ;rcx will hold m
    
    push rbx

    mov rbx,rax
    
    _loopPower:
        mul rbx
        cmp rax,rcx
        jle _loopPower
    div rbx

    pop rbx

    ret
_print:
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

    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret