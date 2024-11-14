section .rodata
    x: dd 0.5

section .bss
    result: resd 1

section .text
    global main
main:
    mov rbp, rsp; for correct debugging
    fld1
    fld dword[x]
    fyl2x
    fstp dword [result]
    ret