;; Name : Govher Saparduryyeva
;; Class: CSC 314
;; Assignment N4
;; Due: Oct 28, 2024
;;
;;
;; Description: This program converts
;;              Fahrenheit into Celcius
;; 
;; Formula for the conversion:              
;;	Celcius = (5/9) * (Fahrenheit - 32)


INCLUDE PCMAC .INC
.MODEL SMALL
.586
.STACK 100h
.DATA

userInput DB "Please enter the temperature in Fahrenheit: ", "$"
outputMsg DB "The temperature in Celcius is: " , "$"

Fahrenheit DW ? ;;to store value entered by the user
Celsius DW ? ;;to store the calculated Celsius value

.CODE

	extrn PutDec:near
	extrn GetDec:near
	
Assign4		PROC
		_begin
		_putStr userInput 
		call GetDec		 ;;gets the value entered by the user
		 
		 
		 ;;subtract 32 from Fahrenheit
		 sub ax, 32
		 
		 ;;multiply the result by 5
		 mov bx, 5
		 imul bx
		 
		;;divide by 9
		mov dx, 0  ;;clear the register
		mov cx, 9
		cwd       ;;expand the bits to 32
		idiv cx  ;;divide by 9
		mov Celsius, ax  ;;store the value in Celsius variable
		 
		;;display final the answer in Celcius
		_putStr outputMsg
		mov ax, Celsius
		call PutDec
		 
	_Exit 0
Assign4 ENDP

End Assign4
