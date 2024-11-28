section .rodata
    string: db "CRC32: ", 0
    string_format: db "%s", 0
    output_format: db "%08X", 10, 0

section .text
    global main
    extern printf, scanf, malloc, free

main:
        
    push ebp
    mov ebp, esp
    sub esp, 32
    
    push string
    push string_format
    call printf
    add esp, 8
    
    push 257
    call malloc
    add esp, 4
    mov esi, eax

    push esi
    push string_format
    call scanf
    add esp, 8

    mov edx, 0xFFFFFFFF

calculate_crc:
    movzx eax, byte [esi]
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

    inc esi
    jmp calculate_crc

finalize_crc:
    xor edx, 0xFFFFFFFF
    
    push edx
    push output_format
    call printf
    add esp, 8
    
    push esi
    call free

    xor eax, eax
    mov esp, ebp
    pop ebp
    ret