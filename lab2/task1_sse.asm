%include "io64.inc"

section .rodata:
    x: dd -2.9
    
section .text
    global main
    
main:
    mov rbp, rsp 
    movss xmm0, dword[x]
    roundss xmm0, xmm0, 1
    cvtss2si eax, xmm0
    PRINT_DEC 4, eax
    xor eax, eax
    ret