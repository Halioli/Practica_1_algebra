SGROUP 		GROUP 	CODE_SEG, DATA_SEG
			ASSUME 	CS:SGROUP, DS:SGROUP, SS:SGROUP

;(E6) Dissenya, codifica en llenguatge ensamblador i testeja un algorisme que:
;   Admeti un primer dígit decimal per teclat 
;   Admeti un segon dígit decimal per teclat
;   Sumi el primer dígit al segon 
;   Mostri el resultat per pantalla en binari (pots usar el codi que vam resoldre a classe i està penjat al campus; veure DIS_N_B.rar)

; DEFINE YOUR CONSTANTS HERE
    CONSTANT_1     EQU 04Bh

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
    CALL    READ_INPUT
    CALL    HEX_TO_BIN
   
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
    INT 21

    ; We check the input
    CMP   AL, 3Ah
    JG    INPUT_ERROR
        CMP   AL, 2Fh
        JL    INPUT_ERROR
        CALL  PRINT_INPUT
        MOV   AH, 0h
        ADD   BX, AX
    RET
      
    INPUT_ERROR:
        MOV AH, 2h
        MOV DL, 46h
        INT 21
        INT 20
        
    RET
READ_INPUT	ENDP

            PUBLIC  PRINT_INPUT
PRINT_INPUT	PROC    NEAR

      MOV AH, 2h
      MOV DL, 6Eh
      INT 21
      INT 20

	RET
PRINT_INPUT	ENDP

            PUBLIC  HEX_TO_BIN
HEX_TO_BIN	PROC    NEAR


	RET
HEX_TO_BIN	ENDP

CODE_SEG 	ENDS

; *************************************************************************
; The data starts here
; *************************************************************************
DATA_SEG	SEGMENT	PUBLIC
    ; DEFINE YOUR MEMORY HERE
	DATA		DB 20 DUP (0)
DATA_SEG	ENDS

	END MAIN