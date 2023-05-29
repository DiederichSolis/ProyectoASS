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


.386 ; 
.model flat, stdcall, c ; 
.stack 4096 ; 

ExitProcess proto,dwExitCode:dword ;

.data

;MENSAJES

	fmt db "%s",0
	fmt1 db "%c",0
	msgBienvenida BYTE "| Bienvenido al juego ' Black Jack '| ", 0Ah,0
	msgespacio BYTE " ", 0Ah,0
	msgINS BYTE "INSTRUCCIONES: ", 0Ah,0
	msgInstrucciones BYTE "El jugador cuenta con $3000 en el cual con ese monto debe apostar",0Ah,0
	msgInstrucciones1 BYTE"seguidamente se le dara 2 carta, tendra la opcion de escoger otra carta",0Ah,0
	msgInstrucciones2 BYTE"- si el jugador suma un total de 21 gana o si el jugador tiene un numero mayor a la banca igual gana",0Ah,0
	msgInstrucciones3 BYTE"- si el jugador se pasa de 21 pierde o si el total es menor al de la banca",0Ah,0
	msgInstrucciones4 BYTE"- si gana el jugardor se le dara la misma cantidad de la que aposto y si pierde perdera ese dinero",0Ah,0
	msgInstrucciones5 BYTE"- si eljugador se queda sin dinero perdera",0Ah,0
	msg

	msgingNombre BYTE "Favor de ingresar su nombre: ",0Ah,0
	strName BYTE 255 DUP(?);


;VARIABLES
Montoini DWORD 3000

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

		push offset msgespacio
		call printf
		push offset msgINS
		call printf
		push offset msgInstrucciones
		call printf
		push offset msgInstrucciones1
		call printf
		push offset msgInstrucciones2
		call printf
		push offset msgInstrucciones3
		call printf
		push offset msgInstrucciones4
		call printf
		push offset msgInstrucciones5
		call printf
		
		push offset msgespacio
		call printf

		;OBTENER NOMBRE
		push ebp
		mov ebp, esp

		push offset msgingNombre
		call printf

		lea eax, strName
		push eax
		push offset fmt
		call scanf


main endp
end