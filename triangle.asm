ORG 0x7C00

    ; edi - pixel placement: no y values; only x values that wrap around to the next y value
    ; ecx - width counter

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov al, 0x13
    int 0x10

    mov edi, 0xA0000
    call draw_triangle

    jmp $


draw_triangle:
    mov edi, DRAW_START
    mov eax, [triangle_y]
    mov ebx, 320
    mul ebx
    add eax, edi
    mov edi, eax
    add edi, [triangle_x]
    xor ebx, ebx
    xor eax, eax
    mov ebx, [triangle_width]

    jmp .put_pixel

.move_down:
    xor ecx, ecx
    dec ebx
    inc eax
    push eax
    add eax, 320
    add edi, eax
    pop eax
    sub edi, 40
    
.put_pixel:
    mov byte [edi], COLOR_RED
    inc edi
    inc ecx
    cmp ecx, ebx
    jl .put_pixel

    inc edx
    cmp edx, [triangle_height]
    jl .move_down
.done:
    ret


begin_draw dd 0

triangle_x dd 100
triangle_y dd 50
triangle_width dd 40
triangle_height dd 40
DRAW_START equ 0xA0000
COLOR_RED equ 0x04

times 510-($-$$) db 0
dw 0xAA55
