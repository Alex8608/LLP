section .rodata
    x: dd -0.5
    num: dd 30
    ln2: dd 0.6931471805599

section .bss
    temp: resd 1
    result: resd 1

section .text
    global main
    
main:
    mov rbp, rsp; for correct debugging
    fldz
    
    mov ecx, 1

.start_loop:
    cmp ecx, dword [num]
    jge .end_loop
    fld dword [x]
    fld dword [x]
    mov eax, ecx

.loop_power:
    cmp eax, 1
    jle .skip_power
    fmul st1, st0
    dec eax
    jmp .loop_power

.skip_power:
    fstp st0
    mov [temp], ecx
    fild dword [temp]
    fdiv st1, st0
    fstp st0
    
    test ecx, 1
    jnz .add_term
    fsub st1, st0
    jmp .next_iter

.add_term:
    fadd st1, st0

.next_iter:
    inc ecx
    fstp st0
    jmp .start_loop

.end_loop:
    fld dword [ln2]
    fdiv st1, st0
    fstp st0
    fstp dword [result]
    ret
