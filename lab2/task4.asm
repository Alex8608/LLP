%include "io64.inc"

section .rodata
    x dd 1.0
    y dd 1.0
    a dd 1.0

section .text
    global main

main:
    mov rbp, rsp; for correct debugging
    fld1
    fld dword [a]
    fld dword [x]

    fsin
    faddp
    
    fyl2x
    fldl2t
    fdivp
    fld st0
    fmul

    fld dword[y]
    fcomip st0, st1
    jae .true
    PRINT_DEC 4, 0
    jmp .end
    
.true:
    PRINT_DEC 4, 1
    jmp .end
    
.end:
    fstp st0
    ret