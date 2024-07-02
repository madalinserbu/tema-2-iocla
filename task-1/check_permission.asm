%include "../include/io.mac"

extern ant_permissions

extern printf
global check_permission

section .text

check_permission:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; id and permission
    mov     ebx, [ebp + 12] ; address to return the result
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    mov edx, eax
    shr edx, 24
    ; acum in edx am id-ul furnicii
    ; in esi pun lista de sali pe care le poate accesa
    mov esi, dword[ant_permissions + 4 * edx]
    
    xor ecx, ecx
loop:
    ; daca furnica nu vrea sala, merg mai departe
    test eax, 1
    jz next
    ; daca furnica vrea sala dar nu are permisiune, intorc 0
    test esi, 1
    jz nu_poate
next:
    ; trec la urmatoarea sala din ambele liste
    shr eax, 1
    shr esi, 1
    inc ecx
    cmp ecx, 23
    jl loop

    ; am parcurs toate salile si totul e ok, intorc 1
    mov dword[ebx], 1
    jmp exit

nu_poate:
    mov dword[ebx], 0
exit:

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
