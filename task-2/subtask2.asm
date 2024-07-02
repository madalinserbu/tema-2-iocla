%include "../include/io.mac"

; declare your structs here
struc creds
    .passkey: resw 1
    .username: resb 51
endstruc

struc request
    .admin: resb 1
    .prio: resb 1
    .login_creds: resb creds_size
endstruc
section .text
    global check_passkeys
    extern printf

check_passkeys:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov ebx, [ebp + 8]      ; requests
    mov ecx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ;
    ;; DO NOT MODIFY

    ;; Your code starts here
    mov edi, eax
    mov esi, ebx
    xor edx, edx
    mov eax, request_size
    dec ecx
    mul ecx
    add esi, eax
    xor edx, edx
    xor eax, eax
requests_loop:
    mov dx, word[esi + request.login_creds]
    mov ax, 1

    ; verific ultimul bit
    test dx, ax
    jz nu_e_hacker

    ; verific ultimul bit
    shl ax, 15
    test dx, ax
    jz nu_e_hacker

    ; numar bitii de 1 din cei mai semnificativi 7 ramasi
    shr ax, 1
    xor ebx, ebx
loop_semnificativi:
    test ah, dh
    jz next_semnificativ
    inc ebx
next_semnificativ:
    shr ax, 1
    test ah, ah
    jnz loop_semnificativi

    test ebx, 1
    jz nu_e_hacker

    ; numar bitii de 1 din cei mai nesemnificativi 7 ramasi
    xor ebx, ebx
loop_nesemnificativi:
    test al, dl
    jz next_nesemnificativ
    inc ebx
next_nesemnificativ:
    shr ax, 1
    cmp ax, 1
    jg loop_nesemnificativi

    test ebx, 1
    jnz nu_e_hacker

    ; daca am ajuns aici inseamna ca e hacker
    mov byte[edi + ecx], 1
    jmp next_request
nu_e_hacker:
    mov byte[edi + ecx], 0
next_request:
    sub esi, request_size
    
    dec ecx
    cmp ecx, 0
    jge requests_loop

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY