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
;extern "C" void access7(double a1, int a2, __int16 a3, double a4)
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
    ;push rbp 
    ;push rsi
    ;push rdi
    ;mov rbp, rsp 
    ;sub rsp, 32
    movups xmm0, [a1]
    mov edx, [a2]
    mov r8w, [a3]
    movups xmm3, [a4]
    ;call access7
    
         
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 38h
    movaps  [rbp-20h], xmm6
    movapd  xmm1, xmm0
    pxor    xmm0, xmm0
    cvtsi2sd xmm0, edx
    addsd   xmm0, xmm1
    movsd   xmm1, [cs_qword_406050]
    mov     ecx, 0
    comisd  xmm1, xmm0
    jbe     short loc_401802
    
    mov     ebx, r8d
    movapd  xmm6, xmm3
    movsx   eax, r8w
    sub     edx, eax
    mov     ecx, edx
    pxor    xmm0, xmm0
    cvtsi2sd xmm0, ecx
    mov     ecx, 0
    comisd  xmm0, [cs_qword_406058]
    jbe     short loc_401802
    
    cmp     bx, 41h
    setz    cl
    ucomisd xmm6, [cs_qword_406060]
    setp    al
    mov     edx, 1
    cmovnz  eax, edx
    and     ecx, eax
    
loc_401802:
    movzx   ecx, cl
    call    _ZL5checkb
    movaps  xmm6, [rbp-20h]
    mov     rbx, [rbp-8]
    leave
    ret

_ZL5checkb:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    test    cl, cl
    jz      short loc_40159A
    lea     rcx, [Buffer]     ; "Access granted"
    call    puts
    leave
    ret
    
loc_40159A:
    lea     rcx, [aAccessDenied] ; "Access denied"
    call    puts
    mov     ecx, 0FFFFFFFFh ; Code       
                            
    ;xor rax, rax 
    ;leave    
    ;ret
   
