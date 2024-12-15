;;*************************************************************
;; Name : Govher Saparduryyeva                                *
;; Class: CSC 314                                             *
;; Assignment N6                                              *
;; Due: Dec 2, 2024                                           *
;;                                                            *
;;                                                            *
;; Description: This program asks users to enter 2 number     *
;;				and displays its gcd using the seperate       * 
;;				gcd procedure. It also asks users if they     *
;;				want to continue finding gcd for different    *
;;				numbers. The prompt for it is designed        *
;;				to be not case sensitive, so it doesn't matter*
;;				if y and n are upper or lower case            *
;;************************************************************
INCLUDE PCMAC.INC
        .MODEL  SMALL
        .586
        .STACK  100h
        .DATA
MSG1  DB  10, 13, "Please enter the 1st number to calculate the GCD: " , '$'
MSG2  DB  10, 13, "Please enter the 2nd number to calculate the GCD: ", '$'
MSG3  DB  10, 13, "Do you want to run again? Please enter Y or N: ", '$'
num1   DW ?
num2   DW ?		
        .CODE
		EXTRN GSGCD : near  ;;proc that calculates GCD
		EXTRN GetDec:near
		
Main   PROC
		_Begin	


while_1:		 
		_putStr MSG1    
		call GetDec
		mov num1, ax
		_putStr MSG2     ;;gets the user input and stores in ax and bx
		call GetDec
		mov num2, ax
		mov ax, num1
		mov bx, num2
		call GSGCD      ;;call the GSGCD proc, to calculate the GCD
		_putStr MSG3
		
		;;prompt user if they want to calculate gcd again
		;;compare the input, if lowercase convert to uppercase
		_GetCh
		cmp al, 'a'     ;;check if the input is lowercase
		jb skip ;;if less than a skip conversion
		cmp al, 'z'     ;;check is greater than z
		ja skip  ;;if greater, skip conversion
		sub al, 32      ;;convert to uppercase by subtracting 32 ('y' is 121 - 32 = 89 'Y')

		skip:
		cmp al, 'Y'     ;;compare to Y
		je while_1       ;;if Y, repeat the loop
		cmp al, 'N'     ;;compare to N
		je end_while_1   ;;exit the loop

 end_while_1:
		
		_Exit 0
Main   ENDP

        END Main

