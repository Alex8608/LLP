section .rodata 
    a1 dq -61.2
    a2 dd 133
    a3 dw 65
    a4 dq 8.3
    cs_qword_406050 dq 73.0
    cs_qword_406058 dq 66.0
    cs_qword_406060 dq 83.0
    Buffer db "Access granted", 0
    aAccessDenied db "Access denied", 0
    var_20 dq -20h
    var_8  dd -8

section .text
    global main
    extern access7, puts

;-l:D:\LLP\lab3\easy.a
;a1=-61.2 a2=133 a3=65 a4=8.3
;extern "C" void access7(double a1, int a2, short a3, double a4)
;{
;  bool v4;
;  double v6;
;
;  v4 = 0;
;  if ( (double)a2 + a1 < 73.0 )
;  {
;    v6 = (double)((unsigned int)(a2 - a3));
;    v4 = 0;
;    if ( v6 > 66.0 )
;      v4 = a4 != 83.0 && a3 == 65;
;  }
;  return check(v4);
;}

main:
    push rbp 
    push rsi
    mov rbp, rsp 
    sub rsp, 40
    movq xmm0, [a1]
    mov edx, [a2]
    mov r8d, [a3]
    movq xmm3, [a4] ; 
    call access7 ; movaps
           
                            
    xor rax, rax 

    mov rsp, rbp
    pop rsi 
    pop rbp
    ret
   
