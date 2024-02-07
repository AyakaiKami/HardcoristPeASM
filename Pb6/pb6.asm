section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .text  
    global _start

_start:
    ;https://projecteuler.net/problem=6
    ;Find the difference between the sum of the squares of the first one hundred 
    ;natural numbers and the square of the sum.


    mov rax,60
    mov rdi,0
    syscall