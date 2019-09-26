[org 0]
[bits 16]

start:
    mov     ax,     cs
    mov     ds,     ax
    xor     ax,     ax
    mov     ss,     ax

    cli

    lgdt    [gdtr]

    mov     eax,    cr0
    or      eax,    0x00000001
    mov     cr0,    eax

    jmp     $+2
    nop
    nop

    db      0x66
    db      0x67
    db      0xEA
    dd      PM_Start
    dw      SysCodeSelector

;
; start Protected Mode
;
[bits 32]

PM_Start:
    mov     bx,     SysDataSelector
    mov     ds,     bx
    mov     es,     bx
    mov     fs,     bx
    mov     gs,     bx
    mov     ss,     bx

    xor     eax,    eax
    mov     ax,     VideoSelector
    mov     es,     ax
    mov     edi,    80*2*10+2*10
    lea     esi,    [ds:msgPMode]
    call    printf

    jmp     $

;
; Sub routines
;
printf:
    push    eax

printf_loop:
    or      al,     al
    jz      printf_end
    mov     al,     byte [esi]
    mov     byte [es:edi],  al
    inc     edi
    mov     byte [es:edi],  0x06
    inc     esi
    inc     edi
    jmp     printf_loop

printf_end:
    pop     eax
    ret

msgPMode        db  "We are in Protected Mode", 0

;
; GDT Table
;
gdtr:
    dw      gdt_end - gdt - 1
    dd      gdt+0x10000

gdt:
    dw      0
    dw      0
    db      0
    db      0
    db      0
    db      0

;
; Code segment descriptor
;
SysCodeSelector     equ     0x08
    dw      0xFFFF
    dw      0x0000
    db      0x01
    db      0x9A
    db      0xCF
    db      0x00

;
; Data segment descriptor
;
SysDataSelector     equ     0x10
    dw      0xFFFF
    dw      0x0000
    db      0x01
    db      0x92
    db      0xCF
    db      0x00

;
; Video segment descriptor
;
VideoSelector       equ     0x18
    dw      0xFFFF
    dw      0x8000
    db      0x0B
    db      0x92
    db      0x40
    db      0x00

gdt_end:




        