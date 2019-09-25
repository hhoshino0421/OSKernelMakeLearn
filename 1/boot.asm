[org 0]
[bits 16]
    jmp 0x07C0:start

start:
    mov ax, cs
    mov es, ax

    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov ax, word [msgBack]
    mov cx, 0x7FF

paint:
    mov word [es:di], ax
    add di, 2
    dec cx
    jnz paint

    mov edi, 0
    mov byte [es:edi], 'A'
    inc edi
    mov byte [es:edi], 0x06
    inc edi
    mov byte [es:edi], 'B'
    inc edi
    mov byte [es:edi], 0x06
    inc edi
    mov byte [es:edi], 'C'
    inc edi
    mov byte [es:edi], 0x06
    inc edi
    mov byte [es:edi], '1'
    inc edi
    mov byte [es:edi], 0x06
    inc edi
    mov byte [es:edi], '2'
    inc edi
    mov byte [es:edi], 0x06
    inc edi
    mov byte [es:edi], '3'
    inc edi
    mov byte [es:edi], 0x06
    
    jmp $

msgBack db   '.', 0xE7

times   510-($-$$) db 0
        dw 0xAA55


