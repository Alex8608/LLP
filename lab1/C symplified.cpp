#include <stdio.h>
#include <stdint.h>
#include <string.h>

int main() {
    unsigned char input[256];
    uint_least32_t crc_table[256];
    uint_least32_t crc;
    int i, j;
    i = 0;

generate_crc_table:
    if (i < 256) {
        crc = i;
        j = 0;
        goto compute_crc;
    }
    goto input_str;

compute_crc:
    if (j < 8) {
        if (crc & 1) {
            crc >>= 1;
            crc ^= 0xEDB88320UL;
            j++;
            goto compute_crc;
        }
        crc >>= 1;
        j++;
        goto compute_crc;
    }
    crc_table[i] = crc;
    i++;
    goto generate_crc_table;

input_str:
    fgets((char *)input, sizeof(input), stdin);
    size_t len = strlen((char *)input);
    
    if (len > 0) {
        if (input[len - 1] == '\n') {
            input[len - 1] = '\0';
            len--;
        }
    }

    crc = 0xFFFFFFFFUL;
    size_t index = 0;

calculate_crc:
    if (index < len) {
        uint_least32_t eax = crc ^ input[index];
        eax&=0xFF;
        eax=crc_table[eax];
        crc>>= 8;
        crc^=eax;
        index++;
        goto calculate_crc;
    }

    crc ^= 0xFFFFFFFFUL;
    printf("CRC32: %08X\n", crc);
    return 0;
}
