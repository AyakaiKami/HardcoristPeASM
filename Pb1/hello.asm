section .bss
   digitSpace resb 100
   digitSpacePos resb 8
section .text
   global _start
;https://projecteuler.net/problem=1
_start:
   mov r13,15
   dec r13
   
   xor r10,r10 ;clear variable where sum is stored
   ;sum of all multiples of 3 and 5 bellow n
   ;sum multiples of 3 + sum multiples of 5 - sum multiples of 15 
   
   ;sum multiples of 3
      ;how many multiples of 3
      mov rax,r13 
      xor rdx,rdx   ;making sure rdx = 0 , the rest of the division is saved here
      mov ebx,3
      div ebx 
      ;sum of multiples of 3
      mov r8,rax
      inc r8
      mul r8
      mov ebx,2
      div ebx
      mov ebx,3
      mul ebx
      ;adding that sum to the result
      add r10,rax

      ;how many multiples of 5
      mov rax,r13
      xor rdx,rdx
      mov ebx,5
      div ebx
      ;sum of multiples of 5
      mov r8,rax
      inc r8
      mul r8
      mov ebx,2
      div ebx
      mov ebx,5
      mul ebx
      ;adding that sum to the result
      add r10,rax

      ;how many multiples of 15
      mov rax,r13
      xor rdx,rdx
      mov ebx,15
      div ebx
      ;sum of multiples of 15
      mov r8,rax
      inc r8
      mul r8
      mov ebx,2
      div ebx
      mov ebx,15
      mul ebx
      ;-multiples of 15 to eliminate duplicates
      sub r10,rax

   ;print result
   mov rax,r10 
   call _printRAX
   
   mov rax,60 ;exit call
   mov rdi,0
   syscall


_printRAX:
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