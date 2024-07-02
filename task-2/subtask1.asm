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

section .bss
    aux_request: resb request_size
section .text
    global sort_requests
    extern printf

sort_requests:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; requests
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    dec ecx
    xor eax, eax
    xor edx, edx
    mov eax, ecx
    mov edi, request_size
    mul edi
    mov ecx, eax

    ; in ecx am offset-ul ultimului element din array-ul de requests
    ; ecx = request_size * (length - 1)
bubble_loop:
    ; acest loop se executa cat timp in inner_loop se fac swapuri
    xor edi, edi
    xor esi, esi
    ; in esi tin offsetul elementului curent
    ; in edi pun 1 daca se face un swap
inner_loop:
    ; compar elementul curent cu elementul urmator
    ; mai intai compar valoarea din admin
    mov al, byte[ebx + esi + request.admin]
    add esi, request_size
    mov ah, byte[ebx + esi + request.admin]
    sub esi, request_size

    ; daca au aceeasi valoare in admin, compar prioritatile
    cmp al, ah
    je test_prio

    ; altfel, daca elementul curent e admin (si deci urmatorul nu e), fac swap
    test al, 1
    jz do_swap

    ; altfel, elementele sunt in ordinea buna, merg mai departe
    jmp next_inner
test_prio:
    mov al, byte[ebx + esi + request.prio]
    add esi, request_size
    mov ah, byte[ebx + esi + request.prio]
    sub esi, request_size

    ; daca prioritatea elementului curent e un numar mai mare, fac swap
    ; daca sunt egale, compar username
    ; altfel merg mai departe
    cmp al, ah
    ja do_swap
    je test_username
    jmp next_inner
test_username:
    ; adresa byte-ului curent din username
    lea edx, [ebx + esi + request.login_creds + 2]
loop_username:
    mov al, byte[edx]
    add edx, request_size
    mov ah, byte[edx]
    sub edx, request_size

    ; compar pe rand bytii username-ului elementului curent cu ai urmatorului
    ; pana gasesc o diferenta, caz in care fac swap sau merg mai departe
    cmp al, ah
    jg do_swap
    jl next_inner
    inc edx
    jmp loop_username
do_swap:
    ; marchez in edi ca am facut un swap
    mov edi, 1
    xor edx, edx
copy_loop:
    ; copiez byte cu byte elementul curent in aux
    ; si elementul urmator in elementul curent
    add esi, edx
    mov al, byte[ebx + esi]
    sub esi, edx
    mov byte[aux_request + edx], al
    
    add esi, request_size
    add esi, edx
    mov al, byte[ebx + esi]
    sub esi, request_size
    mov byte[ebx + esi], al
    sub esi, edx

    inc edx
    cmp edx, request_size
    jl copy_loop
    
    xor edx, edx
    add esi, request_size
copy_loop2:
    ; copiez byte cu byte aux in elementul urmator
    mov al, byte[aux_request + edx]
    add esi, edx
    mov byte[ebx + esi], al
    sub esi, edx

    inc edx
    cmp edx, request_size
    jl copy_loop2
    
    sub esi, request_size
next_inner:
    ;ma mut la urmatorul element din vector (pana la penultimul)
    add esi, request_size
    cmp esi, ecx
    jl inner_loop

    ; daca au mai fost swapuri, continui
    test edi, 1
    jnz bubble_loop

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY