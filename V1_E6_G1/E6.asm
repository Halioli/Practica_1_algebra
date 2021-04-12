SGROUP 		GROUP 	CODE_SEG, DATA_SEG
			ASSUME 	CS:SGROUP, DS:SGROUP, SS:SGROUP

;(E6) Dissenya, codifica en llenguatge ensamblador i testeja un algorisme que:
;   Admeti un primer dígit decimal per teclat 
;   Admeti un segon dígit decimal per teclat
;   Sumi el primer dígit al segon 
;   Mostri el resultat per pantalla en binari (pots usar el codi que vam resoldre a classe i està penjat al campus; veure DIS_N_B.rar)

; DEFINE YOUR CONSTANTS HERE
    INIT_MASK     EQU 8000h ; 1000 0000 0000 0000
    ASCII_0		  EQU '0' ; -> ASCII del carÃ cter 0

; *************************************************************************
; The code starts here
; *************************************************************************
CODE_SEG	SEGMENT PUBLIC
		ORG 100h

; ****************************************
; The main function, as stated by the directive: END MAIN
; ****************************************

MAIN 	PROC 	NEAR

    MOV     BX, 0h
    CALL    READ_INPUT
    MOV   AH, 0h
    ADD   BX, AX
    CALL    READ_INPUT
    MOV   AH, 0h
    ADD   BX, AX
    CALL    DISPLAY_BINARY_NUMBER
   
    INT 20			; terminate program
MAIN	ENDP	

; ****************************************
; An example of a function definition
; Returns:
;   ; values returned by the function
;   ; Ex: AH: number of hits
; Modifies:
;   ; registers modified by the function and not restored
; Uses: 
;   ; constants used by the function
;   ; Ex: CONSTANT_1 
; Calls:
;   ; functions calls
; ****************************************

            PUBLIC  READ_INPUT
READ_INPUT 	PROC    NEAR

    MOV AH, 8h
    INT 21h

    ; We check the input
    CMP   AL, 3Ah
    JG    INPUT_ERROR
        CMP   AL, 2Fh
        JL    INPUT_ERROR
        CALL  PRINT_INPUT
        SUB   AL, 30h
     
    RET
      
    INPUT_ERROR:
        MOV AH, 2h
        MOV DL, 46h
        INT 21h
        INT 20h
        CALL READ_INPUT
        
    RET
READ_INPUT	ENDP

            PUBLIC  PRINT_INPUT
PRINT_INPUT	PROC    NEAR

      MOV AH, 2h
      MOV DL, AL
      INT 21h
      INT 20h

	RET
PRINT_INPUT	ENDP


            PUBLIC  DISPLAY_BINARY_NUMBER
DISPLAY_BINARY_NUMBER PROC NEAR
					    ; BL: number
      MOV DX, INIT_MASK ; The mask

NEW_DIGIT:	  
	  MOV DL, DH	; Initial mask (DH) -> (DL)
	  AND DL, BL	; DL = DL & BL
	  JZ IS_ZERO
	  MOV DL, 1

IS_ZERO:	  
      CALL DISPLAY_BINARY_DIGIT

	SHR DH, 1		; Shift mask right (to less significant bits): 1st iteration: 1000 0000 -> 0100 0000
      CMP DH, 0		; A la novena vegada, DH = 0000 0000 (0h)
      JNZ NEW_DIGIT

      RET
DISPLAY_BINARY_NUMBER ENDP


            PUBLIC  DISPLAY_BINARY_DIGIT
DISPLAY_BINARY_DIGIT 	PROC    NEAR
						  ; DL may be: 0 / 1
      add dl, ASCII_0	; dl = dl + ASCII_0   ; Si dl = 0 -> dl = ASCII_0 ; Si dl = 1 -> dl = ASCII_0 + 1 = ASCII_1
      mov ah, 2
      int 21h      

      RET
      
DISPLAY_BINARY_DIGIT	ENDP

CODE_SEG 	ENDS

; *************************************************************************
; The data starts here
; *************************************************************************
DATA_SEG	SEGMENT	PUBLIC
    ; DEFINE YOUR MEMORY HERE
	DATA		DB 20 DUP (0)
DATA_SEG	ENDS

	END MAIN