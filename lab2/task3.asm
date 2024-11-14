section .rodata
    a: dd 1.0
    b: dd 0.0

section .text
    global main

main:
    mov rbp, rsp; for correct debugging
    ;x=arctg(2^b)-a
    fld dword [b]
    fld1
    fscale
    fld1
    fpatan
    fsub dword [a]
    fstp st0
    ret
