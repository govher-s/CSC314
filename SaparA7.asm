;;************************************************************
;; Name : Govher Saparduryyeva                               *
;; Class: CSC 314                                            *
;; Assignment N7                                             *
;; Due: Dec 18, 2024                                         *
;;                                                           *
;; Description: This program asks users' full name and prints*
;;              it in "last name, first name [middle name]"  *
;;              order.                                       *
;; Also added loop to prompt users if they want to run again *
;; (Makes testing easier)                                    *
;;************************************************************

INCLUDE PCMAC.INC
.MODEL SMALL
.586
.STACK 100h
.DATA
userPrompt DB 10, 13, "Please enter your full name: ", '$'
errorMsg DB "Nothing was entered to display.", '$'
MSG  DB  10, 13, "Do you want to run again? Please enter Y or N: ", '$'
count DW ?
count1 DW ?
count2 DW ?
arry DB 80 dup(?)

.CODE
EXTRN Putdec:near
EXTRN Getdec:near

;;****************************************
;; Procedure to ask for user's full name *
;;****************************************
userInput PROC
   call clearArray    
   sub si, si
   mov count, 0

check_while:
    _putStr userPrompt          ;;print the prompt

do_while1:
    _GetCh                      
    cmp al, 13                  ;;check if enter key is pressed
    je end_do_while1
    mov byte ptr [bx], al       ;;store ch in araay
    inc bx
    inc count
    jmp do_while1

end_do_while1:
    cmp count, 0                   ;;check if no input was given
    je noCharacter
    jmp enduserinp       

noCharacter:
    _putCh 13
    _putCh 10
    _putStr errorMsg            ;;print the error message
    _putCh 13
    _putCh 10
    jmp check_while             ;;retry 
	
enduserinp:
		  ret
userInput ENDP

;;*********************************
;; Procedure to display the output*
;;*********************************
output PROC
    
    mov bx, offset arry         ;; bx points to array
    mov cx, count               ;; set cx to count
	mov count2, cx

                                ;;find the last space
for1:
	inc bx
	dec cx
	jnz for1
find_space:                     ;;loop to find space
	dec bx
	inc count1
	dec count2
	jz noSpace                 ;;if only one name is entered
	cmp byte ptr[bx], 32
	jne find_space
for0:                          ;;loop to display last name
	mov dl, byte ptr[bx]
	_putCh
	inc bx
	inc cx
	cmp cx, count1
	jne for0
	_putCh','                  ;;comma after last name
	_putCh' '
	mov bx, offset arry
	mov ax, count             ;;stop the count when last name is found
	sub ax, count1
	mov count, ax
	
for3:                        ;;loop for first and middle name
	mov dl, byte ptr[bx]
	_putCh
	inc bx
	dec count
	jnz for3
	jmp endAll
noSpace:					;;when space isn't found: user entered one name
	mov bx, offset arry

while_noSpace:              ;;print the name
	mov dl, byte ptr[bx]
	_putCh
	inc bx
	dec count
	jnz while_noSpace
	
endAll:
	ret
output ENDP

;;****************************************
;; Procedure to clear the input array    *
;;****************************************
;;after user reruns the program, the array needs to be cleared
clearArray PROC
    mov di, offset arry   ;;mov start of array to destination reg
    mov cx, 80                
clearLoop:
    mov byte ptr [di], 0  ;;clear array element    
    inc di
    loop clearLoop
    ret
clearArray ENDP


;;****************
;; Main Procedure*
;;****************
Main PROC
	_Begin
	call clearArray   
    mov bx, offset arry         ;;initialize array pointer

mainLoop:
    call userInput            ;;call user input proc
    call output               ;;call output proc
    _putStr MSG               ;;prompt user if they want to rerun
		
run_while:
    _GetCh
    cmp al, 'a'               ;;check if input is lowercase
    jb skip                   ;;if less than a, skip conversion
    cmp al, 'z'               ;;check if greater than z
    ja skip                   ;;if greater than z, skip conversion
    sub al, 32                ;;convert to uppercase (y -> Y)

skip:
    cmp al, 'Y'               ;;compare to Y
    je rerun                  ;;if Y rerun
    cmp al, 'N'               ;;compare to N
    je end_run_while          ;;if N, exit
    jmp run_while             ;;if other input, prompt the user again

rerun:
    call clearArray           ;;clear the array
    mov bx, offset arry       ;;reser the pointer
    mov count, 0              ;;reset count
    mov count1, 0
    mov count2, 0
    jmp mainLoop              ;;rerun the program

end_run_while:
    _Exit 0
Main ENDP

END Main
