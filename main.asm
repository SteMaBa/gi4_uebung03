SECTION .data

x DD 3		        ; Variable x mit 3 vorbelegt (Aufgabe 2; Aufgabe 3; Aufgabe 4)
ergebnis RESD 1	        ; Variable ergebnis (Aufgabe 2; Aufgabe 3; Aufgabe 4)
koeffizient DD 33,2,7   ; Array mit Variablen a, b, c (4 Bytes lang) (Aufgabe 3; Aufgabe 4)

komplexz DD 5,3         ; Array mit Variablen x=Re(z) (=5) und y=Im(z) (=3) (Aufgabe 6)
komplexc DD 4,-2        ; Array mit Variablen a=Re(c) (=4) und b=Im(c) (=-2) (Aufgabe 6)
real RESD 1             ; Variable real, Realteil des komplexen Ergebnisses (Aufgabe 6)
imag RESD 1             ; Variable imag, Imaginaerteil des komplexen Ergebnisses (Aufgabe 6)

SECTION .text

global main

main:	
		
push ebp	; Stack sichern
mov ebp, esp

; Aufgabenteil 1

		; 3x^2 + 4x -5 mit x = 2
mov eax, 2	; x=2 in EAX kopieren
mul eax         ; x quadrieren und in EAX speichern
mov ecx, 3	; 3 in ecx laden
mul ecx 	; mit 3 (ecx) multiplizieren und in EAX speichern
mov ebx,eax	; EAX in EBX zwischenspeichern
mov eax, 2	; x=2 in EAX kopieren
mov ecx,4	; 4 in ecx laden
mul ecx		; mit 4 (ecx) multiplizieren und in EAX speichern
add eax, ebx	; 4x + 3x^2, EBX zu EAX addieren
sub eax, 5	; 4x + 3x^2 - 5, 5 von EAX subtrahieren

; Aufgabenteil 2 (Zeile 35)

		;  3x^2 + 4x - 5 mit x variabel
mov eax, [x]	; x in EAX kopieren
mul eax         ; x quadrieren und in EAX speichern
mov ecx, 3	; 3 in ecx laden
mul ecx 	; mit 3 (ecx) multiplizieren und in EAX speichern
mov ebx,eax	; EAX in EBX zwischenspeichern
mov eax, [x]	; x in EAX kopieren
mov ecx,4	; 4 in ecx laden
mul ecx		; mit 4 (ecx) multiplizieren und in EAX speichern
add eax, ebx	; 4x + 3x^2, EBX zu EAX addieren
sub eax, 5	; 4x + 3x^2 - 5, 5 von EAX subtrahieren
mov [ergebnis], eax; EAX in ergebnis kopieren

; Aufgabenteil 3 (Zeile 50)
                
                        ; ax^2 + bx + c mit a=33, b=2, c=7 und x = 4
mov ebx, koeffizient    ; Zeiger auf Array in ebx kopieren
mov [x], dword 4        ; Variable x 4 zuweisen
mov eax, [x]            ; x in EAX kopieren
mul eax                 ; x quadrieren und in EAX speichern
mov edx, [ebx];         ; a (=33) in edx laden
mul edx                 ; mit a (edx) multiplizieren und in EAX speichern
mov ecx, eax            ; EAX in ECX zwischenspeichern
mov eax, [x]            ; x in EAX kopieren
mov edx, [ebx+4]        ; b (=2) in edx laden
mul edx                 ; mit b (edx) multiplizieren und in EAX speichern
add eax, ecx            ; bx + ax^2, ECX zu EAX addieren
add eax, [ebx+8]        ; bx + ax^2 + c, c zu EAX addieren 
mov [ergebnis], eax     ; EAX in ergebnis kopieren

; Aufgabenteil 4 (Zeile 67)

                        ; ax^2+bx+c = c+x*(b+(x*a)) mit a=33, b=2, c=7 und x=4
mov ebx, koeffizient    ; Zeiger auf Array in ebx kopieren
mov [x], dword 4        ; Variable x 4 zuweisen
mov eax, [x]            ; x in EAX kopieren
mov ecx, [ebx]          ; a (=33) in ecx laden
mul ecx                 ; x mit a (ecx) multiplizieren und in EAX speichern
add eax, [ebx+4]        ; b (=2) zu x*a addieren und in EAX speichern
mov ecx, [x]            ; x in ECX kopieren
mul ecx                 ; (b+(x*a)) mit x multiplizieren und in EAX speichern
add eax, [ebx+8]        ; c (=7) zu x*(b+(x*a)) addieren und in EAX speichern
mov [ergebnis], eax     ; EAX in ergebnis kopieren 

; Aufgabenteil 6 (Zeile 81)
                        
                        ; z=x+iy, c=a+ib, Re(z*c)=real, Im(z*c)=imag mit x=5, y=3, a=4, b=-2
                        ; z*c=(x+iy)*(a+ib)=(ax-by)+i(ay+bx)=Re(z*c)+i*Im(z*c)
mov ebx, komplexz       ; Zeiger auf z in ebx 
mov eax, [ebx]          ; x in eax
mov edx, komplexc       ; Zeiger auf c in edx
mov ecx, [edx]          ; a in ecx
mul ecx                 ; x*a in eax
mov ecx, eax            ; x*a in ecx
mov edx, komplexc       ; Zeiger auf c erneut in edx
mov eax, [edx+4]        ; b in eax
mov edx, [ebx+4]        ; y in edx
mul edx                 ; b*y in eax
mov edx, -1             ; -1 in edx
imul edx                ; -b*y in eax
add eax, ecx            ; ax-by in eax
mov [real], eax         ; ax-by in real

mov eax, [ebx+4]        ; y in eax
mov edx, komplexc       ; Zeiger auf c in edx
mov ecx, [edx]          ; a in ecx
mul ecx                 ; y*a in eax
mov ecx, eax            ; y*a in ecx
mov edx, komplexc       ; Zeiger auf c erneut in edx
mov eax, [edx+4]        ; b in eax
mov edx, [ebx]          ; x in edx
mul edx                 ; x*b in eax
add eax, ecx            ; a*y+bx in eax
mov [imag], eax         ; ay+bx in imag 

     

mov esp, ebp	; Stack wiederherstellen
pop ebp
mov ebx, 0	; exit code, 0 = normal
mov eax, 1	; exit command to kernel
int 0x80	; interrupt 0x80, call kernel
