    Task 1

Am calculat id-ul furnicii printr-o shiftare la dreapta cu 24 de biti,
apoi am salvat elementul corespunzator din ant_permissions.

Am iterat in paralel prin lista de sali dorite si lista cu permisiuni, verificand
la fiecare iteratie ultimul bit (sa vad daca furnica vrea/nu vrea sala si daca
are/nu are voie), trecand la urmatoarea sala prin shiftare la dreapta cu un bit.
Am tinut in ecx un contor, pentru a ma opri dupa 24 de iteratii (24 de sali).

Daca loop-ul se opreste din cauza contorului, inseamna ca toate salile dorite
pot fi rezervate, deci pun 1 in rezultat. Altfel, inseamna ca a fost gasita o sala
dorita care nu e disponibila, deci pun 0.

    Task 2

Pentru primul subtask, am implementat un bubble sort in care iterez prin vector si
daca 2 elemente alaturate nu sunt in ordinea buna, le interschimb, pana cand nu se mai fac
interschimbari. Pentru a verifica ordinea compar mai intai campul admin, apoi prioritatea,
apoi byte cu byte username-urile (pana la prima pereche de byti distincti).
Pentru swap, am definit o variabila aux in care copiez byte cu byte primul element, 
apoi il copiez la fel pe al doilea in primul, apoi pe aux in al doilea.

Pentru al doilea subtask, iterez prin array-ul de request-uri si aplic o serie de teste care
pot confirma ca request-ul nu e de la un hacker. Daca se trece de toate testele, request-ul este
de la un hacker. Mai intai verific primul si ultimul bit, apoi numar pe rand bitii de 1 dintre
cei mai semnificativi si nesemnificativi ramasi, verificand paritatea.

    Task 3

Atat pentru criptare cat si pentru decriptare am pus in ecx valoarea 10 (numarul de runde)
pentru a folosi instructiunea loop. Apoi am folosit un alt loop pentru i (de la 0 la 7, respectiv
de la 7 la 0). Am aplicat in loop operatiile descrise in enunt.
Pentru rotatii, am salvat mai intai bit-ul care se pierdea in urma shiftarii, apoi am shiftat, apoi
am setat bit-ul salvat in noua pozitie.

    Task 4

Am salvat in memorie out_line, out_col, n-1 si m-1, pentru a putea utiliza registrii la alte operatii.
Am folosit eax si ebx pentru a tine linia respectiv coloana curenta, initial 0,0.
Verific pe fiecare directie (sus, jos, stanga, dreapta) daca este posibila o mutare,
caz in care setez pozitia curenta ca zid si actualizez eax sau ebx, dupa caz.
Apoi verific daca sunt intr-o pozitie finala (pe marginea dreapta sau jos), iar in caz contrar verific
toate directiile din nou, pentru noua pozitie.
La final pun la adresele out_line si out_col valorile din eax si ebx.

