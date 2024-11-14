%include "io64.inc" 

section .rodata: 
    x: dd 2.9 
    
section .bss 
    result: resd 1 
section .text 
    global main 
    
set_round_down: 
    sub rsp, 8
    fstcw [rsp]
    mov al, [rsp+1]
    and al, 0xF3
    or al, 4
    mov [rsp+1], al 
    fldcw [rsp]
    add rsp, 8
    ret 
main: 
    fld dword[x] 
    fist dword[result] 
    mov eax, [result] 
    PRINT_DEC 4, eax 
    NEWLINE 
    call set_round_down 
    fist dword[result]
    mov eax, [result] 
    PRINT_DEC 4, eax 
    xor eax, eax 
    ret 