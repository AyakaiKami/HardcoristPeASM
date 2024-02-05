section .bss
    digitSpace resb 100
    digitSpacePos resb 8
section .text
    global _start
_start:
    ;largest prime factor of n
    
    ;last prime factor found variable initialization
    xor r10,r10

    ;n initialization
    xor r9,r9
    mov r9,600851475143

    ;loop iterator
    mov r8,2

    ;loop  
    _loop:
        ;check if iterator is a factor of n
        mov rax,r9;copy n in rax for div
        xor rdx,rdx;making sure rdx is empty
        div r8  ;n copy div iterator  
        
        cmp rdx,0 ;if it s not a factor we go on to the next iterator
        jne _incIterator
        ;if it is then update the last prime factor found variable
        mov r10,r8
        ;and n div factor/iterator until rdx not 0
        _divLoop:
        mov rax,r9
        xor rdx,rdx
        div r8
        
        ;loop condition
        cmp rdx,0
        jne _incIterator
        
        mov r9,rax;changing n
        jmp _divLoop


        _incIterator:
        ;increment iterator
        inc r8
        ;check loop condition
        cmp r8,r9
        jle _loop

    ;print rez
    mov rax,r10
    call _print

    ;exit call
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