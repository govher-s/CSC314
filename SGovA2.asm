;; Govher Sapardurdyyeva
;; CSC 314
;; Assignment2
;; Due September 23, 2024
;; This program displays my name,
;; and the show I binge watched last summer.


.MODEL SMALL
.586
.STACK 100h
.DATA
Message1 DB 'Hello, my name is Govher Sapardurdyyeva!', 13, 10, '$'
Message2 DB 'The show I binge watched last summer was Silicon Valley on HBO.', 13, 10, '$'
.CODE
Assignment2 PROC
mov ax, @data
mov ds, ax
;; display the first message
mov dx, OFFSET Message1
mov ah, 9h 
int 21h 
;; display the second message
mov dx, OFFSET Message2
mov ah, 9h 
int 21h 

mov al, 0 ; Return code of 0
mov ah, 4ch ; Exit back to MS/PCDOS
int 21h
Assignment2 ENDP
END Assignment2