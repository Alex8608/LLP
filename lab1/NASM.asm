%include "io.inc"

section .data
    input db 256 dup(0)
    crc_table dd 256 dup(0)
    format db "CRC32: ", 0

section .bss
    crc resd 1
    i resd 1
    j resd 1
    index resd 1
    len resb 1

section .text
    global main

main:
    mov dword [i], 0

generate_crc_table:
    mov eax, [i]
    cmp eax, 256
    jge input_str

    mov ebx, eax
    mov dword [j], 0
    mov dword [crc], ebx

compute_crc:
    mov eax, [j]
    cmp eax, 8
    jge store_crc

    mov eax, [crc]
    test eax, 1
    jnz crc_update
    shr eax, 1
    jmp crc_done

crc_update:
    shr eax, 1
    xor eax, 0xEDB88320
    jmp crc_done

crc_done:
    mov [crc], eax
    inc dword [j]
    jmp compute_crc

store_crc:
    mov eax, [crc]
    mov dword [crc_table + ebx*4], eax
    inc dword [i]
    jmp generate_crc_table

input_str:
    GET_STRING input, 256

    mov ecx, 0
    mov eax, input
    call strlen
    mov [len], ecx

    mov al, [input + ecx - 1]
    cmp al, 10
    jne skip_newline
    dec ecx
    mov [len], ecx
    mov byte [input + ecx], 0

skip_newline:
    mov dword [crc], 0xFFFFFFFF
    mov dword [index], 0

calculate_crc:
    mov eax, [index]
    cmp eax, [len]
    jge finalize_crc

    movzx ebx, byte [input + eax]
    mov eax, [crc]
    xor eax, ebx
    and eax, 0xFF
    mov ebx, [crc_table + eax*4]
    mov eax, [crc]
    shr eax, 8
    mov [crc], eax
    xor [crc], ebx
    inc dword [index]
    jmp calculate_crc

finalize_crc:
    xor dword [crc], 0xFFFFFFFF
    push dword [crc]
    PRINT_STRING format
    PRINT_HEX 4, crc
    add esp, 4
    ret

strlen:
    xor ecx, ecx
.next_char:
    cmp byte [eax + ecx], 0
    je .done
    inc ecx
    jmp .next_char
.done:
    ret
