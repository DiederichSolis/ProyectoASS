;Universidad del Valle de Guatemala
;Diederich Solis 22952
;Brandon Reyes
;Carlos Valladares 
;
;Descripcion: Simulacion del juego de black jack
;
;Proyecto Final
;
;Catedratico: Roger Fuentes
;Fecha de entrega: -/05/2023


.386 ; Corregido
.model flat, stdcall, c ; Corregido
.stack 4096

.data 
	fmt db "%s",0
	fmt1 db "%c",0
	msgBienvenida BYTE "| Bienvenido a 'Spotify simulation'| ", 0Ah,0

	msgMenu1 BYTE "Seleccione alguna opcion", 0Ah,0
	msgMenu2 BYTE "1. Lista de reproduccion 'Me gustan'", 0Ah,0
	msgMenu3 BYTE "2. Lista de reproduccion 'Para pasar el rato'", 0Ah,0
	strOP BYTE 255 DUP(?);

	comparador word ?

	msgM2msg BYTE "Selecciono la opción 1 - Lista de reproduccion 'Me gustan'", 0Ah,0
	msgM2ms2 BYTE "Selecciono la opción 2 - Lista de reproduccion 'Para pasar el rato'", 0Ah,0
	
	msgM2ms2 BYTE "Selecciona alguna opción \n", 0Ah,0


	arr BYTE "cancion 1","cancion 2","cancion 3","cancion 4"


.code
	includelib libucrt.lib
	includelib legacy_stdio_definitions.lib
	includelib libcmt.lib
	includelib libvcruntime.lib

	extrn printf:near
	extrn scanf:near

	extrn exit:near

public main
main proc

	push offset msgBienvenida
	call printf

	call menu

main ENDP

menu proc
	push offset msgMenu1
	call printf

	push offset msgMenu2
	call printf

	push offset msgMenu3
	call printf

	;obtener menu 
	push ebp
	mov ebp, esp

	lea eax, strOP
	push eax
	push offset fmt
	call scanf
	
	mov ax, '1' ; Corregido
	mov bx, '2' ; Corregido
	
	cmp ax, word ptr strOP ; Comparar ax con strOP
	je opcion1 ; Saltar si son iguales
	cmp bx, word ptr strOP ; Comparar bx con strOP
	je opcion2 ; Saltar si son iguales
	
	RET

opcion1:
	push offset msgM2msg
	call printf


	jmp opcion1


opcion2:
	push offset msgM2ms2 ; Corregido
	call printf
	jmp fin_menu

fin_menu:
	RET

menu endp

end
