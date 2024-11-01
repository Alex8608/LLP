#include <stdio.h>
#include <stdint.h>
#include <string.h>

int main() {
    unsigned char input[256];
    uint_least32_t crc_table[256];
    uint_least32_t crc;
    int i, j;

    for (i = 0; i < 256; i++) {
        crc = i;
        for (j = 0; j < 8; j++) {
            crc = crc & 1 ? (crc >> 1) ^ 0xEDB88320UL : crc >> 1;
        }
        crc_table[i] = crc;
    }

    printf("Enter the string: ");
    fgets((char *)input, sizeof(input), stdin);
    size_t len = strlen((char *)input);
    
    if (len > 0 && input[len - 1] == '\n') {
        input[len - 1] = '\0';
        len--;
    }

    crc = 0xFFFFFFFFUL;

    for (size_t index = 0; index < len; index++) {
        crc = crc_table[(crc ^ input[index]) & 0xFF] ^ (crc >> 8);
    }

    printf("CRC32: %08X\n", crc ^ 0xFFFFFFFFUL);
    return 0;
}
