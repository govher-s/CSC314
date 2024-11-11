;;************************************************************
;; Name : Govher Saparduryyeva                               *
;; Class: CSC 314                                            *
;; Assignment N5                                             *
;; Due: Nov 13, 2024                                         *
;;                                                           *
;;                                                           *
;; Description: This program displays the character          *
;;				user chose on the screen moving it from      *
;;				left to right. It will be displayed the      *
;;				the amount of times user chose to display    *
;;************************************************************
INCLUDE PCMAC.INC
.MODEL SMALL
.586
.STACK 100h
.DATA

    Msg1 DB "Please enter the character you want to display: ", '$'
    Msg2 DB "Please enter the number of times you want to display (1-3): ", '$'
    Msg3 DB "You can only enter numbers less than 4 and greater than 0.", '$'
   ;;variables to store the data
    userChar DB ?
    userNum DW ?
    newLine DB 13, 10, '$'

.CODE

    extrn GetDec:near
MAIN PROC
        _Begin
        call GetChar ;;call to get the character from the user
        call GetNum  ;;call to get number from user
        call Display ;;call display procedure show the character moving
        _Exit 0 
MAIN ENDP
    
Delay PROC
        push cx
        mov cx, 65535 ;;large value to set the delay
for_2:  nop
        dec cx
        jnz for_2	;;jump back to for_2 if not zero
        pop cx
        ret
Delay ENDP

GetChar PROC
        ;;get and store the character that the user entered
        _PutStr Msg1
        _GetCh
        mov userChar, al
        ret
GetChar ENDP

GetNum PROC
do_while_1:
        _PutStr newLine
        _PutStr Msg2
        call GetDec
        mov userNum, ax
        cmp ax, 3
        jg wrong_input ;;if the entered number is greater than three, prompt user to Msg3
        cmp ax, 1
        jl wrong_input ;;if entered number is less than 1, prompt user to Msg3
        jmp endDo_while_1

wrong_input: 
        _PutStr newLine
        _PutStr Msg3
        jmp do_while_1
endDo_while_1:         
        ret
GetNum ENDP

Display PROC
        mov bx, 0  ;; empty
for_loop:
        ;;compare bx to userNum and end loop if bx >= userNum
        cmp bx, userNum
        jge endFor_loop
        mov cx, 79  ;; incrementable number for the inner loop
;;display the character forward
for_1:  mov dl, userChar
        _PutCh
        call Delay
        _PutCh 8
        _PutCh 32
        dec cx
        jnz for_1 ;;repeat the loop until cx is 0
;;display the character backwards
f_2:
        _PutCh 8 ;;backspace to move the cursor left
        mov dl, userChar
        _PutCh
        call Delay
        _PutCh 8
        _PutCh 32
        _PutCh 8
        inc cx
        cmp cx, 79
        jne f_2
        inc bx
        jmp for_loop
endFor_loop:
        ret
Display ENDP
    END MAIN
