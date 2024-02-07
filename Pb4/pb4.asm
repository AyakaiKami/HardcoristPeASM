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
    
    mov r9,99
    mov r8,99
    ;when r8 goes lower then 100 r9 shoul decrease
    _findPalindrome:
        ;cmp r8,99
        ;jg _stillGood
        ;dec r9
        ;mov r8,r9
        _stillGood:
            mov rax,r9
            mul r8
            dec r8
            push rax
            call _isPlaindrome
        cmp rax,1
        jne _findPalindrome

    pop rax
    ;print result
    call _print

    mov rax,60
    mov rdi,0
    syscall
    

_isPlaindrome:;lets say the parameter will be in rax
    ;we will need to make a reverse version of that number
   
   ;save data
   push rax ;save argument
   
   xor rcx,rcx;here we ll save the reversed number

    mov rbx,10

   _loopReverse:
        xor rdx,rdx
        div rbx
        push rax
        
        add rcx,rdx
        mov rax,rcx
        mul rbx
        mov rcx,rax
        pop rax
        cmp rax,0
        jne _loopReverse
    mov rax,rcx
    div rbx
    mov rcx,rax
    pop rax
    cmp rax,rcx
    jne _false
        mov rax,1
        ret

    _false:
        mov rax,0
        ret
    

_print:
    ;saving registeres
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
   mov rdx,0
   mov rbx,10
   div rbx
   push rax
   add rdx,48 

   mov rcx,[digitSpacePos]
   mov [rcx],dl
   inc rcx
   mov [digitSpacePos],rcx

   pop rax
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

   ;seting back the registeres
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax
   ret