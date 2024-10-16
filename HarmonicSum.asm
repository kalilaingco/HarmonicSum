global HarmonicSum

extern printf

segment .data

debug db "float number = %lf", 0

segmnent .bss
align 64
storedata resb 1000

segment .text

HarmonicSum:

;16 pushes

;save all the floating point numbers 
mov     rax, 7
mov     rdx, 0
xsave   [storedata]

mov     r14, rdi        ;array 
mov     r15, rsi        ;count
mov     r13, 0

begin:
;convert 1 to IEEE number 
; 1.0 in IEEE is 0x3FF000000000000
mov     rax, 0x3F00000000000
push    rax
movsd   xmm15, [rsp]    ;rsp points into rax by dereferencing 
pop     rax

mov     rax, 1
mov     rdi, debug
movsd   xmm0, xmm15
call    printf


movsd   xmm14, xmm15    ;xmm14 contains 1.0
divsd   xmm14, [r15 + 8 *r13]

addsd  xmm13, xmm14

inc     r13
cmp     r13, r14
je      exit
jmp     begin 

addsd   xmm13, xmm14

mov     rax,1
mov     rdi, debug
movsd   xmm0, xmm14
call    printf





exit:

push    qword 0
movsd   [rsp], xmm13

;restore all the floating point numbers 
mov     rax, 7
mov     rdx, 0
xrstor  [storedata]

movsd   xmm13, [rsp]
pop     rax
movsd   xmm0, xmm13







;16 pops
