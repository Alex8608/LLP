section .rodata
    string: db "CRC32: ", 0
    string_format: db "%s", 0
    output_format: db "%08X", 10, 0

section .text
    global main
    extern printf, scanf, malloc, free

main:
    push rsi
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    lea rcx, [string]
    call printf
    
    mov rcx, 257
    call malloc
    mov r12, rax

    lea rcx, [string_format]
    mov rdx, r12
    call scanf

    mov edx, 0xFFFFFFFF
    mov rsi, r12

calculate_crc:
    movzx eax, byte [rsi]
    test al, al
    jz finalize_crc

    xor edx, eax
    mov ecx, 0

.loop:
    mov eax, edx
    and eax, 1
    shr edx, 1
    test eax, eax
    jz .end
    xor edx, 0xEDB88320

.end:
    inc ecx
    cmp ecx, 8
    jl .loop

    inc rsi
    jmp calculate_crc

finalize_crc:
    xor edx, 0xFFFFFFFF
    
    lea rcx, [output_format]
    call printf
    
    mov rcx, r12
    call free
    xor eax, eax
    mov rsp, rbp
    pop rbp
    pop rsi
    ret