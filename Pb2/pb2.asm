section .bss
    digitSpace resb 100 ;space for string
    digitSpacePos resb 8 ;index
section .text
    global _start
_start:
    ;https://projecteuler.net/problem=2
    ;sum of even-valued Fibonnacci under an n

    ;rez initializaion
    mov r10,0

    ;setting upper limit
    mov r9,10

    mov r11,1 ;varFib1  last position
    mov r12,2 ;varFib2 current position

    ;When the upper limit is less then 2
    cmp r9,2
    jge _loop
    jmp _end

    ;At least one even number
    _loop:
    mov rax,r12 ;div prep
    xor rdx,rdx ;clearing left
    mov ebx,2   ;div by 2
    div ebx
    
    cmp rdx,0
    jne _next
    add r10,r12 ;if even add to rez
    _next:
    xor r13,r13 ;third var used for next element
    mov r13,r11 ;sum of the last 2 elements in the Fib seq
    add r13,r12

    mov r11,r12 ;updating iterators
    mov r12,r13

    cmp r12,r9
    jle _loop

    ;print rez
    _end:

    mov rax,r10
    call _print

    ;exit iwth code 0
    mov rax,60
    mov rdi,0
    syscall


_print:
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

   ret