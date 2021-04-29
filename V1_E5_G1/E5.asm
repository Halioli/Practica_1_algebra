SGROUP 		GROUP 	CODE_SEG, DATA_SEG
			ASSUME 	CS:SGROUP, DS:SGROUP, SS:SGROUP

; DEFINE YOUR CONSTANTS HERE
		INIT_MASK   EQU 8000h ; 1000 0000 0000 0000
		ASCII_0		  EQU '0' ;-> ASCII del caracter 0
		BASE_NUM		EQU 2h
		MAX_SQR			EQU 8h


; *************************************************************************
; The code starts here
; *************************************************************************
CODE_SEG	SEGMENT PUBLIC
		ORG 100h

; ****************************************
; The main function, as stated by the directive: END MAIN
; ****************************************
MAIN 	PROC 	NEAR

      ; INSERT YOUR CODE HERE
      CALL DIVIDE_LOOP

			MOV BX, RES	; Any number
			CALL DISPLAY_BINARY_NUMBER

	int 20h			; terminate program
MAIN	ENDP

; ****************************************
; Loops NUMB divided by BASE_NUM squared to SQR untill SQR == 8
; Returns:
;   -
; Modifies:
;   ; RES
;   ; SQR
; Uses:
;   ; BASE_NUM
;		; NUMB
;		; RES
;		; SQR
; Calls:
;   ; CALCULATE_SQR_BASE_NUM
; ****************************************
            PUBLIC  DIVIDE_LOOP
DIVIDE_LOOP 	PROC    NEAR

			CALL CALCULATE_SQR_BASE_NUM
			INC SQR
			CMP SQR, MAX_SQR+1
			JE END_LOOP

			MOV AX, BASE_NUM
			DIV NUMB
			MOV RES, AX

END_LOOP:
			RET

DIVIDE_LOOP	ENDP

; ****************************************
; Calculates the base number
; Returns:
;   -
; Modifies:
;   ; AX 
; Uses:
;   ; SQR_RES
;		; BASE_NUM
;		; SQR
; Calls:
;   -
; ****************************************
            PUBLIC  CALCULATE_SQR_BASE_NUM
CALCULATE_SQR_BASE_NUM 	PROC    NEAR
			PUSH CX
			PUSH DX

CALCULATE_SQR_LOOP:
			MOV AX, SQR_RES
			MUL BASE_NUM
			MOV SQR_RES, AX

			INC CX
			CMP SQR, CX
			JNE CALCULATE_SQR_LOOP

			POP DX
			POP CX
			RET

CALCULATE_SQR_BASE_NUM	ENDP

; ****************************************
; Displays in binary in stdout the 8-bit number in BL
; Entry:
;   - BX: the 8-bit number (in BL)
; Returns:
;   -
; Modifies:
;   DX
; Uses:
;   -
; Calls:
;   DISPLAY_BINARY_DIGIT
; ****************************************
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

; ****************************************
; Displays in stdout a binary digit (0/1 raw) in AL
; Entry:
;   - DL: binary digit
; Returns:
;   -
; Modifies:
;   - AH, DL
; Uses:
;   -
; Calls:
;   - int21h, service ah=2
; ****************************************
            PUBLIC  DISPLAY_BINARY_DIGIT
DISPLAY_BINARY_DIGIT 	PROC    NEAR
						; DL may be: 0 / 1
      add dl, ASCII_0	; dl = dl + ASCII_0; Si dl = 0 -> dl = ASCII_0 ; Si dl = 1 -> dl = ASCII_0 + 1 = ASCII_1
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
		NUMB				DB 1 DUP (20h)
		RES					DB 1 DUP (0)
		SQR					DB 1 DUP (1)
		SQR_RES			DB 1 DUP (1)
DATA_SEG	ENDS

	END MAIN
