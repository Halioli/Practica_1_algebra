SGROUP 		GROUP 	CODE_SEG, DATA_SEG
			ASSUME 	CS:SGROUP, DS:SGROUP, SS:SGROUP

; DEFINE YOUR CONSTANTS HERE
		INIT_MASK   EQU 8000h ; 1000 0000 0000 0000
		ASCII_0     EQU '0'   ;-> ASCII del caracter 0
		BASE_NUM    EQU 2h
		MAX_SQR	EQU 8h


; *************************************************************************
; The code starts here
; *************************************************************************
CODE_SEG	SEGMENT PUBLIC
		ORG 100h

; ****************************************
; The main function, as stated by the directive: END MAIN
; ****************************************
MAIN 	PROC 	NEAR

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
;   ; NUMB
;   ; RES
;   ; SQR
; Calls:
;   ; CALCULATE_SQR_BASE_NUM
; ****************************************
            PUBLIC  DIVIDE_LOOP
DIVIDE_LOOP 	PROC    NEAR
	
      PUSH AX
      PUSH BX
      PUSH DX
		
DIVISION_LOOP:
	CALL CALCULATE_SQR_BASE_NUM
			
			
	MOV BX, AX
	MOV AX, NUMB
	DIV BX	; AX = NUMB(AX)/BX(2^x)

	ADD RES, AX

	INC SQR
	CMP SQR, MAX_SQR
	JNE DIVISION_LOOP

      POP DX
      POP BX
      POP AX

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
;   ; BASE_NUM
;   ; SQR
; Calls:
;   -
; ****************************************
            PUBLIC  CALCULATE_SQR_BASE_NUM
CALCULATE_SQR_BASE_NUM 	PROC    NEAR
	PUSH CX
	PUSH DX
	PUSH SQR_RES

CALCULATE_SQR_LOOP:
	MOV AX, SQR_RES
	MOV BX, BASE_NUM
	MUL BX
	MOV SQR_RES, AX

	INC CX
	CMP SQR, CX
	JNE CALCULATE_SQR_LOOP

	POP SQR_RES
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
      ADD DL, ASCII_0	; dl = dl + ASCII_0; Si dl = 0 -> dl = ASCII_0 ; Si dl = 1 -> dl = ASCII_0 + 1 = ASCII_1
      MOV AH, 2
      INT 21h

      RET

DISPLAY_BINARY_DIGIT	ENDP

CODE_SEG 	ENDS

; *************************************************************************
; The data starts here
; *************************************************************************
DATA_SEG	SEGMENT	PUBLIC
		NUMB		DB 1 DUP (20h)
		RES		DW 1 DUP (0h)
		SQR		DW 1 DUP (0h)
		SQR_RES	DW 1 DUP (1h)
DATA_SEG	ENDS

	END MAIN
