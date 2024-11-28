section .rodata
    a: dd 1.0
    b: dd 1.5

section .bss
    result: resd 1

section .text
    global main

main:
    mov rbp, rsp; for correct debugging
    ;x=arctg(2^b)-a
    fld dword [b]
    fld1
    fld st1
    fprem
    f2xm1
    fadd
    fscale
    fld1
    fpatan
    fsub dword [a]
    fstp dword [result]
    ret
