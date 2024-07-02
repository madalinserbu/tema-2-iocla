%include "../include/io.mac"

extern printf
extern position
global solve_labyrinth

; you can declare any helper variables in .data or .bss
section .bss
    m: resd 1
    n: resd 1
    out_line: resd 1
    out_col: resd 1

section .text

; void solve_labyrinth(int *out_line, int *out_col, int m, int n, char **labyrinth);
solve_labyrinth:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; unsigned int *out_line, pointer to structure containing exit position
    mov     ebx, [ebp + 12] ; unsigned int *out_col, pointer to structure containing exit position
    mov     ecx, [ebp + 16] ; unsigned int m, number of lines in the labyrinth
    mov     edx, [ebp + 20] ; unsigned int n, number of colons in the labyrinth
    mov     esi, [ebp + 24] ; char **a, matrix represantation of the labyrinth
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    ;pun parametrii in memorie ca sa pot folosi registrii la altceva
    mov dword[out_line], eax
    mov dword[out_col], ebx
    ; decrementez n si m pentru ca iteratia merge pana la n-1 respectiv m-1
    dec ecx
    dec edx
    mov dword[m], ecx
    mov dword[n], edx

    ; in eax tin linia curenta, in ebx coloana
    xor eax, eax
    xor ebx, ebx

check_sus:
    ; verific daca sunt pe marginea de sus
    cmp eax, 0
    je check_jos

    dec eax
    mov ecx, dword[esi + eax * 4]
    inc eax

    ; verific daca sus e zid
    cmp byte[ecx + ebx], '1'
    je check_jos

    ; pot merge in sus, pun 1 in poz curenta si ma mut
    mov ecx, dword[esi + eax * 4]
    mov byte[ecx + ebx], '1'
    dec eax
    jmp check_is_final
check_jos:
    ; verific daca sunt pe marginea de jos
    cmp eax, dword[m]
    je check_stanga
    inc eax
    mov ecx, dword[esi + eax * 4]
    dec eax
    xor edx, edx
    mov dl, byte[ecx + ebx]

    ;verific daca jos e zid
    cmp byte[ecx + ebx], '1'
    je check_stanga

    ; pot merge in jos, pun 1 in poz curenta si ma mut
    mov ecx, dword[esi + eax * 4]
    mov byte[ecx + ebx], '1'
    inc eax
    jmp check_is_final

check_stanga:
    ; verific daca sunt pe marginea din stanga
    cmp ebx, 0
    je check_dreapta
    mov ecx, dword[esi + eax * 4]
    dec ebx
    xor edx, edx
    mov dl, byte[ecx + ebx]
    inc ebx

    ; verific daca in stanga e zid
    cmp dl, '1'
    je check_dreapta

    ; pot merge in stanga, pun 1 in poz curenta si ma mut
    mov byte[ecx + ebx], '1'
    dec ebx
    jmp check_is_final

check_dreapta:
    ; verific daca sunt pe marginea din dreapta
    cmp ebx, dword[n]
    je check_is_final
    mov ecx, dword[esi + eax * 4]
    inc ebx
    mov dl, byte[ecx + ebx]
    dec ebx

    ; verific daca in dreapta e zid
    cmp dl, '1'
    je check_is_final

    ; pot merge in dreapta, pun 1 in poz curenta si ma mut
    mov byte[ecx + ebx], '1'
    inc ebx
check_is_final:

    ; verific daca pozitia curenta e pe marginea din dreapta sau de jos
    cmp eax, dword[m]
    je gata
    cmp ebx, dword[n]
    je gata

    ; altfel incerc sa ma mut mai departe, incepand iar cu prima directie
    jmp check_sus

gata:
    ; pun pozitia curenta (eax, ebx) in out_line si out_col
    mov edi, dword[out_line]
    mov dword[edi], eax
    mov edi, dword[out_col]
    mov dword[edi], ebx


    ;; Freestyle ends here
end:
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
