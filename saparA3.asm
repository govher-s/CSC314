;; Name : Govher Saparduryyeva
;; Class: CSC 314
;; Assignment N3
;; Due: Oct 16, 2024
;;
;;
;; Description: This program displays
;;              the current date in
;;              European format.
;;Requirements:
;; getDate mov ah, 2Ah
;;         int 21h can be used only once
;;			DH = month (1 to 12)
;;			DL = day (1 to 31)
;;			CX = year (4 digit number)
;;			AL = day of week (0 to 6)
;; 

.MODEL SMALL
.586
.STACK 100h
.DATA
Message DB "Today's European format date is: $"

.CODE

	extrn PutDec:near
	;;extrn GetDec:near
date PROC
	mov ax, @data
    mov ds, ax
	
	;; get current date
	mov ah, 2Ah
    int 21h
	
	mov ah, 9
    mov dx, offset Message
    int 21h
	
	mov ax, 0
    mov al, dl ;;move day dl to al
    call PutDec 
	
	;; display dash
	mov dl, '-'
    mov ah, 2
    int 21h
	
	mov ax, 0               
    mov al, dh   ;;month dh to al           
    call PutDec
	
	;; display dash
	mov dl, '-'
    mov ah, 2
    int 21h
	
	mov ax, cx   ;;year cx to ax
    call PutDec
	
	mov ah, 4Ch
    int 21h
date ENDP

END date
