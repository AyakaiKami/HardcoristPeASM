section .text
    global _start
_start:
    ;sum of even-valued Fibonnacci under an n
    
    ;exit iwth code 0
    mov rax,60
    mov rdi,0
    syscall