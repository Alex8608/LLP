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
;   short s1;  
;   short s2;         
;   float s3;      
;}; 
;extern "C" void access7(short a, bool b, S c){
;    if (( ( (float)c.s2 || (c.s1 << 16) ) == c.s3 ) && b>a){
;       puts("Access granted");
;       return;
;    }           
;    puts("Access denied");
;    return;
;}

main:
    push rbp 
    push rsi
    mov rbp, rsp 
    sub rsp, 40
    
    lea r8, [a]
    mov dl, 1
    mov ecx, 0
    
    call access7 
           
    xor rax, rax
    mov rsp, rbp
    pop rsi 
    pop rbp
    ret