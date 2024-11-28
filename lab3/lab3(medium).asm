section .rodata
    a: dw 1
       dw 6
       dd 65542.0
        
section .text
    global main
    extern access7

;-l:D:\LLP\lab3\medium.a

;namespace var7 { 
;struct S { 
;   int16 s1;  
;   int16 s2;         
;   float s3;      
;}; 
;extern "C" void access7(int16 a, bool b, S c){
;    if (( ( (float)c.s2 || (c.s1 << 16) ) == c.s3 ) && b>a){
;       puts("Access granted");
;       return;
;    }           
;    puts("Access denied");
;    return;
;}

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    lea r8, [a]
    mov dl, 1
    mov ecx, 0
    
    call access7 
           
    leave
    xor rax, rax
    ret