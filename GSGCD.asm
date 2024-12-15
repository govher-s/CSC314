;;************************************************************
;; Name : Govher Saparduryyeva                               *
;; Class: CSC 314                                            *
;; Assignment N6                                             *
;; Due: Dec 2, 2024                                          *
;;                                                           *
;;                                                           *
;; Description: This program calculates the GCD of numbers   *
;;				entered by the user                          *
;;************************************************************
INCLUDE PCMAC.INC
        .MODEL  SMALL
        .586
        .STACK  100h
        .DATA
		
Output    DB  "The greatest common divisor of the entered numbers is: ", '$'
GCD       DW  ?

        .CODE
        PUBLIC  GSGCD
		EXTRN PutDec:near
GSGCD  PROC
		
		cmp ax, 0 ;;when ax is zero
		je if_ax_zero
		
		cmp ax, -32768 ;;for -32768
		je if_ax_n
		
		cmp ax, 0 ;;when negative
		jl  if_ax_neg
		
		cmp bx, 0 ;;when bx is zero
		je if_bx_zero
		
		cmp bx, 0 ;;when bx is negative
		jl if_bx_neg
		
natural:
;;calculates gcd for natural numbers		
while_1:
		cmp ax, bx 		;; comapre ax and bx
		je end_while 	;; if equal gcd is found
		jg if_1 		;; if ax>bx, ax = ax - bx
		jl if_2			;; if ax<bx, bx = bx - ax
if_1:
	sub ax, bx 		;;ax = ax - bx
	jmp while_1
if_2:
	sub bx, ax		;;bx = bx - ax
	jmp while_1
		

end_while:	
	mov GCD, ax 
	jmp display
	
;;when ax is zero
if_ax_zero:
		
		cmp bx, 0 ;;compare bx with 0
		je if_bx_zero
		;;if not 0, store the value as GCD
		mov GCD, bx
		jmp display
if_bx_zero:
		;;when both are zero, gcd is 0
		mov GCD, ax
		jmp display

;;if ax is -32768		
if_ax_n:
		cmp bx, -32768
		je if_bx_n ;;if both of the registers are not -32768, assign them 16384 and 
				   ;; loop back to natural that calculates GCD
		mov ax, 16384
		jmp natural

if_bx_n:
		;;if both registers are -32768
		mov GCD, -32768
		cwd
		jmp display
		
if_ax_neg:
        neg ax       	;;make ax positive
		cmp bx, 0		;;check if bx is negative
		jl if_bx_neg	;; jump to handle negative 
		jmp natural		;; calculate gcd
if_bx_neg:
		neg bx		;;make bx positive
		jmp natural

display:
		;;Display the GCD
		_putStr Output
		mov ax, GCD
		call PutDec
        ret
GSGCD  ENDP
       END GSGCD