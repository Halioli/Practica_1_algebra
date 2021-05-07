SGROUP 		GROUP 	CODE_SEG, DATA_SEG
			ASSUME 	CS:SGROUP, DS:SGROUP, SS:SGROUP

; DEFINE YOUR CONSTANTS HERE
		INIT_MASK   EQU 8000h ; 1000 0000 0000 0000
		ASCII_0     EQU '0'   ;-> ASCII del caracter 0
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

	MOV BX, [RES]	; Any number
	CALL DISPLAY_BINARY_NUMBER

	int 20h			; terminate program
MAIN	ENDP

; ****************************************
; Loops NUMB divided by BASE_NUM squared to SQR untill SQR == MAX_SQR
; Returns:
;   -
; Modifies:
;   ; RES
;   ; SQR
; Uses:
;   ; NUMB
;   ; RES
;   ; SQR
;   ; MAX_SQR
; Calls:
;   -
; ****************************************
            PUBLIC  DIVIDE_LOOP
DIVIDE_LOOP 	PROC    NEAR
	
      PUSH AX
      PUSH BX
      PUSH DX
		
DIVISION_LOOP:
      MOV AX, [NUMB]         ; AX = 0014 (20d)
      MOV CL, [SQR]          ; CL = from 0 to 8 (exp 2^x)
      SHR AX, CL             ; 20d = 10100 / 2^CL

	ADD [RES], AX

	INC [SQR]
	CMP [SQR], [MAX_SQR]   ; Compare SQR == MAX_SQR
	JL DIVISION_LOOP       ; If not equal jump to DIVISION_LOOP
                             ; End loop
      POP DX
      POP BX
      POP AX

	RET

DIVIDE_LOOP	ENDP

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
		NUMB		DW 1 DUP (14h)  ; NUMB = N
		SQR		DB 1 DUP (0h)
		RES		DW 1 DUP (0h)
DATA_SEG	ENDS

	END MAIN
