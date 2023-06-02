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
	strOP2 BYTE 255 DUP(?);
	strDatosCancion BYTE 255 DUP(?);


	comparador word ?

	msgM2msg BYTE "Selecciono la opción 1 - Lista de reproduccion 'Me gustan'", 0Ah,0
	msgM2ms2 BYTE "Selecciono la opción 2 - Lista de reproduccion 'Para pasar el rato'", 0Ah,0
	
	msgMenu3A BYTE "Selecciona alguna opción", 0Ah,0
	msgMenu3B BYTE "1. Escuchar musica", 0Ah,0
	msgMenu3C BYTE "2. Agregar cancion", 0Ah,0
	msgMenu3D BYTE "3. Eliminar ultima cancion", 0Ah,0
	msgAgregarCancion BYTE "Ingrese el nombre de la canción: ", 0
	msgNoHayCanciones BYTE "No hay canciones en la lista.", 0

	msgIngresoCancion BYTE "Ingresa el Nombre del Artista: | Nombre Canción | Duración Total | Letra.", 0





	arr BYTE "Nombre Artista: Bad Bunny y Grupo Frontera | Nombre Canción: un x100to | Duracion Total: 3:14 min","Nombre Artista: Lil Durk | Nombre Canción: All My Life| Duracion Total: 4:04 min","Nombre Artista: Manuel Turizo y Marshmello | Nombre Canción: El merengue | Duracion Total: 2 min","Nombre Artista: Alan Walker | Nombre Canción: Alone | Duración Total: 2:44 min","Nombre Artista: Kendrick Lamar ft. SZA | Nombre Canción: All the Stars | Duración Total: 3:52 min"," "," "," "," "




	longitud equ ($ - arr) / ($ - arr[0])                     ; Número de canciones en el array
	contador dword 4	

	texto BYTE "hola soy nuevo" 

	strBuff1 BYTE "Nombre Artista: Bad Bunny y Grupo Frontera | Nombre Canción: un x100to | Duracion Total: 3:14 min "
	strBuff2 BYTE "Nombre Artista: Lil Durk | Nombre Canción: All My Life| Duracion Total: 4:04 min"
	strBuff3 BYTE "Nombre Artista: Manuel Turizo y Marshmello | Nombre Canción: El merengue | Duracion Total:4MIN"
	strBuff4 BYTE "Nombre Artista: Alan Walker | Nombre Canción: Alone | Duración Total: 2:44 min"
	strBuff5 BYTE "Nombre Artista: Kendrick Lamar ft. SZA | Nombre Canción: All the Stars | Duración Total: 3 miN"
	strBuff6 BYTE 255 DUP(?)
	strBuff7 BYTE 255 DUP(?)

	resultMsg BYTE 'La nueva canción es: %s', 0Ah, 0
	resultMsg1 BYTE 'Se elimino con exito la cancion: %s', 0Ah, 0


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
		
	push offset msgMenu3A
	call printf
	push offset msgMenu3B
	call printf
	push offset msgMenu3C
	call printf
	push offset msgMenu3D
	call printf
	
	;obtener dato menu 2 
	push ebp
	mov ebp, esp

	lea eax, strOP2
	push eax
	push offset fmt
	call scanf

	mov cx, '1' ; Corregido
	mov dx, '2' ; Corregido
	mov ax, '3' ; Corregido

	cmp cx, word ptr strOP2 ; Comparar cx con strOP2
	je opcion1Menu2 ; Saltar si son iguales

	cmp dx, word ptr strOP2 ; Comparar dx con strOP2
	je opcion1Menu2Agregar ; Saltar si son iguales

	cmp ax, word ptr strOP2 ; Comparar dx con strOP2
	je opcion1Menu2Eliminar ; Saltar si son iguales

	;jmp opcion1
	jmp fin_menu

opcion1Menu2:
	 ; Recorrer el array de canciones

	push offset strBuff6 	; Empujar formato a la pila
	push offset resultMsg 	; Empujar formato a la pila
    call printf 

    mov esi, offset arr      ; Cargar la dirección base del array en ESI
    
    mov ecx, longitud        ; Cargar el número de canciones en ECX
    mov edx, 0               ; Contador de posición inicial en el array
    
    bucle:
        mov eax, edx         ; Cargar el índice actual del array en EAX
        imul eax, 8          ; Multiplicar el índice por 8 (cada canción ocupa 8 bytes)
        add eax, esi         ; Calcular la dirección del elemento actual del array
        
        ; Aquí puedes realizar alguna operación con la canción actual, como imprimirla
        ; utilizando la función printf, por ejemplo.
        ; Por ejemplo, imprimir la canción actual:
        push eax             ; Guardar la dirección de la canción en la pila
        push offset fmt      ; Cargar la cadena de formato para printf
        call printf          ; Llamar a la función printf
        add esp, 8           ; Ajustar el puntero de pila después de llamar a printf
        
        inc edx              ; Incrementar el contador de posición
        loop bucle           ; Repetir el bucle hasta que se recorra todo el array
    
    ; Fin del recorrido
    ; ...

	jmp opcion1


opcion1Menu2Agregar:
;opcion1Menu2Agregar:
	
    ; Agregar canción
	push offset msgIngresoCancion
	call printf


	;obtener dato de canción 
	;push ebp
	;mov ebp, esp

    lea  eax, strBuff6 		; Obtener dirección del buffer
    push eax 				; Empujar dirección a la pila
    push offset fmt 		; Empujar formato a la pila
    call scanf 				; Leer cadena desde la entrada estándar

    push offset strBuff6 	; Empujar cadena a la pila
    push offset resultMsg 	; Empujar formato a la pila
    call printf 			; Imprimir resultado

    add esp, 8 				; Limpiar la pila

    mov esp, ebp
    pop ebp
    
	push 0
    jmp opcion1




    ;jmp fin_menu
