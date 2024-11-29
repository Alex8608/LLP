section .rodata

section .text
    global main
    extern access1
    
;__int64 __fastcall access1(int a1, __int64 a2)
;{
;  char v2; // al
;  int v4; // [rsp+30h] [rbp+10h] BYREF
;  __int64 v5; // [rsp+38h] [rbp+18h]
;
;  v4 = a1;
;  if ( !a1 )
;  {
;    v5 = a2;
;    check(0);
;  }
;  v2 = hard::var1::C::check(&v4);
;  return check(v2);
;}    
    
main:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    call access1
    
    leave
    xor rax, rax
    ret 