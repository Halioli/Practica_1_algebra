; * Aniol Barnada, 2021 (ENTI-UB)

; *************************************************************************
; Our data section. Here we declare our strings for our console message
; *************************************************************************

SGROUP 		GROUP 	CODE_SEG, DATA_SEG
			ASSUME 	CS:SGROUP, DS:SGROUP, SS:SGROUP

    TRUE  EQU 1
    FALSE EQU 0

; EXTENDED ASCII CODES
    ASCII_SPECIAL_KEY EQU 00
    ASCII_LEFT        EQU 04Bh
    ASCII_RIGHT       EQU 04Dh
    ASCII_UP          EQU 048h
    ASCII_QUIT        EQU 071h ; 'q'

;	ASCII / ATTR CODES TO DRAW BLANK
		ASCII_BLANK     	EQU 00h
		ATTR_BLANK      	EQU 00h

; ASCII / ATTR CODES TO DRAW THE SNAKE
    ASCII_SNAKE     	EQU 02Ah
    ATTR_SNAKE      	EQU 00Ah
		MAX_LENGHT_SNAKE	EQU 00Ah

; ASCII / ATTR CODES TO DRAW THE PLAYER
		ASCII_PLAYER		EQU 058h
		ATTR_PLAYER			EQU 009h

; ASCII / ATTR CODES TO DRAW THE BULLET
		ASCII_BULLET		EQU 021h
		ATTR_BULLET			EQU 00Eh

; ASCII / ATTR CODES TO DRAW THE FIELD
    ASCII_FIELD    EQU 020h
    ATTR_FIELD     EQU 070h

    ASCII_NUMBER_ZERO EQU 030h

; CURSOR
    CURSOR_SIZE_HIDE EQU 02607h  ; BIT 5 OF CH = 1 MEANS HIDE CURSOR
    CURSOR_SIZE_SHOW EQU 00607h

; ASCII
    ASCII_YES_UPPERCASE      EQU 059h
    ASCII_YES_LOWERCASE      EQU 079h

; COLOR SCREEN DIMENSIONS IN NUMBER OF CHARACTERS
    SCREEN_MAX_ROWS EQU 25
    SCREEN_MAX_COLS EQU 80

; FIELD DIMENSIONS
    FIELD_R1 EQU 1
    FIELD_R2 EQU SCREEN_MAX_ROWS-2
    FIELD_C1 EQU 1
    FIELD_C2 EQU SCREEN_MAX_COLS-2

; *************************************************************************
; Our executable assembly code starts here in the .code section
; *************************************************************************
CODE_SEG	SEGMENT PUBLIC
			ORG 100h

MAIN 	PROC 	NEAR

  MAIN_GO:
      CALL REGISTER_TIMER_INTERRUPT

      CALL INIT_GAME
      CALL INIT_SCREEN
      CALL HIDE_CURSOR
      CALL DRAW_FIELD

      MOV DH, SCREEN_MAX_ROWS/2
      MOV DL, SCREEN_MAX_COLS/2

      CALL MOVE_CURSOR

  MAIN_LOOP:
      CMP [END_GAME], TRUE
      JZ END_PROG

      ; Check if a key is available to read
      MOV AH, 0Bh
      INT 21h
      CMP AL, 0
      JZ MAIN_LOOP

      ; A key is available -> read
      CALL READ_CHAR

      ; End game?
      CMP AL, ASCII_QUIT
      JZ END_PROG

      ; Is it an special key?
      CMP AL, ASCII_SPECIAL_KEY
      JNZ MAIN_LOOP

      CALL READ_CHAR

      CMP AL, ASCII_RIGHT
      JZ RIGHT_KEY
      CMP AL, ASCII_LEFT
      JZ LEFT_KEY
      CMP AL, ASCII_UP
      JZ UP_KEY

			; The game is on!
			MOV [START_GAME], TRUE

      JMP MAIN_LOOP

  RIGHT_KEY:
			; Move right
      MOV [INC_COL_PLAYER], 1

      CALL MOVE_PLAYER

      JMP END_KEY

  LEFT_KEY:
			; Move left
      MOV [INC_COL_PLAYER], -1

      CALL MOVE_PLAYER

      JMP END_KEY

  UP_KEY:
			; Check if already fired
			CMP [BULLET_FIRED], TRUE
      JZ 	END_KEY

			; Set bullet movement
      MOV [INC_ROW_BULLET], -1

			; Set spawn position
			MOV AH, [POS_COL_PLAYER]
			MOV AL, [POS_ROW_PLAYER]
			ADD AL, -1

			; Spawn bullet
			MOV [POS_COL_BULLET], AH
      MOV [POS_ROW_BULLET], AL

			MOV [BULLET_FIRED], TRUE
			CALL MOVE_BULLET

      JMP END_KEY

  END_KEY:
      JMP MAIN_LOOP

  END_PROG:
      CALL RESTORE_TIMER_INTERRUPT
      CALL SHOW_CURSOR
      CALL PRINT_SCORE_STRING
      CALL PRINT_SCORE
      CALL PRINT_PLAY_AGAIN_STRING

      CALL READ_CHAR

      CMP AL, ASCII_YES_UPPERCASE
      JZ MAIN_GO
      CMP AL, ASCII_YES_LOWERCASE
      JZ MAIN_GO

			INT 20h

MAIN	ENDP

; ****************************************
; Reset internal variables
; Entry:
;		-
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   INC_ROW memory variable
;   INC_COL memory variable
;   DIV_SPEED memory variable
;   NUM_TILES memory variable
;   START_GAME memory variable
;   END_GAME memory variable
; Calls:
;   -
; ****************************************
					PUBLIC  INIT_GAME
INIT_GAME		PROC		NEAR

    MOV [INC_ROW_SNAKE_HEAD], 0
    MOV [INC_COL_SNAKE_HEAD], 0

    MOV [INC_COL_PLAYER], 0

		MOV [INC_ROW_BULLET], 0

    MOV [DIV_SPEED], 10

    MOV [NUM_TILES], 0

    MOV [START_GAME], FALSE
    MOV [END_GAME], FALSE

    RET

INIT_GAME	ENDP

; ****************************************
; Reads char from keyboard
; If char is not available, blocks until a key is pressed
; The char is not output to screen
; Entry:
;		-
; Returns:
;   AL: ASCII CODE
;   AH: ATTRIBUTE
; Modifies:
;		-
; Uses:
;		-
; Calls:
;		-
; ****************************************
					PUBLIC  READ_CHAR
READ_CHAR		PROC		NEAR

    MOV AH, 8
    INT 21h

    RET

READ_CHAR ENDP

; ****************************************
; Read character and attribute at cursor position, page 0
; Entry:
;		-
; Returns:
;   AL: ASCII CODE
;   AH: ATTRIBUTE
; Modifies:
;		-
; Uses:
;		-
; Calls:
;   int 10h, service AH=8
; ****************************************
					PUBLIC READ_SCREEN_CHAR
READ_SCREEN_CHAR		PROC		NEAR

    PUSH BX

    MOV AH, 8
    XOR BH, BH
    INT 10h

    POP BX
    RET

READ_SCREEN_CHAR  ENDP

; ****************************************
; Draws the rectangular field of the game
; Entry:
;		-
; Returns:
;		-
; Modifies:
;		-
; Uses:
;   Coordinates of the rectangle:
;    left - top: (FIELD_R1, FIELD_C1)
;    right - bottom: (FIELD_R2, FIELD_C2)
;   Character: ASCII_FIELD
;   Attribute: ATTR_FIELD
; Calls:
;   PRINT_CHAR_ATTR
; ****************************************
					PUBLIC DRAW_FIELD
DRAW_FIELD		PROC		NEAR

    PUSH AX
    PUSH BX
    PUSH DX

    MOV AL, ASCII_FIELD
    MOV BL, ATTR_FIELD

    MOV DL, FIELD_C2

  UP_DOWN_SCREEN_LIMIT:
    MOV DH, FIELD_R1
    CALL MOVE_CURSOR
    CALL PRINT_CHAR_ATTR

    MOV DH, FIELD_R2
    CALL MOVE_CURSOR
    CALL PRINT_CHAR_ATTR

    DEC DL
    CMP DL, FIELD_C1
    JNS UP_DOWN_SCREEN_LIMIT

    MOV DH, FIELD_R2

  LEFT_RIGHT_SCREEN_LIMIT:
    MOV DL, FIELD_C1
    CALL MOVE_CURSOR
    CALL PRINT_CHAR_ATTR

    MOV DL, FIELD_C2
    CALL MOVE_CURSOR
    CALL PRINT_CHAR_ATTR

    DEC DH
    CMP DH, FIELD_R1
    JNS LEFT_RIGHT_SCREEN_LIMIT

    POP DX
    POP BX
    POP AX
    RET

DRAW_FIELD       ENDP

; ****************************************
; Prints an empty tile
; Entry:
;		-
; Returns:
;		-
; Modifies:
;		-
; Uses:
;   ASCII_BLANK
;   ATTR_BLANK
; Calls:
;   PRINT_CHAR_ATTR
; ****************************************
					PUBLIC PRINT_BLANK
PRINT_BLANK		PROC		NEAR

    PUSH AX
    PUSH BX
    MOV AL, ASCII_BLANK
    MOV BL, ATTR_BLANK
    CALL PRINT_CHAR_ATTR

    POP BX
    POP AX
    RET

PRINT_BLANK        ENDP

; ****************************************
; Prints a new tile of the snake, at the current cursos position
; Entry:
;		-
; Returns:
;		-
; Modifies:
;		-
; Uses:
;   character: ASCII_SNAKE
;   attribute: ATTR_SNAKE
; Calls:
;   PRINT_CHAR_ATTR
; ****************************************
					PUBLIC PRINT_SNAKE
PRINT_SNAKE		PROC		NEAR

    PUSH AX
    PUSH BX
    MOV AL, ASCII_SNAKE
    MOV BL, ATTR_SNAKE
    CALL PRINT_CHAR_ATTR

    POP BX
    POP AX
    RET

PRINT_SNAKE        ENDP

; ****************************************
; Moves the snake's head
; Entry:
;		-
; Returns:
;   -
; Modifies:
;   NUM_TILES
;		DL
;		HL
; Uses:
;   INC_COL
;		INC_ROW
;		ATTR_SNAKE
;		NUM_TILES
; Calls:
;   MOVE_CURSOR
;		READ_SCREEN_CHAR
;		PRINT_SNAKE
; ****************************************
					PUBLIC  MOVE_SNAKE_HEAD
MOVE_SNAKE_HEAD		PROC		NEAR

		PUSH AX
		PUSH DX

		; Load snake coordinates
		MOV DL, [POS_COL_SNAKE_HEAD]
		MOV DH, [POS_ROW_SNAKE_HEAD]

		; Increment snake coordinates
		ADD DL, [INC_COL_SNAKE_HEAD]
		ADD DH, [INC_ROW_SNAKE_HEAD]

		; Move snake on the screen
		CALL MOVE_CURSOR

		; Check if snake collided with the player
		CALL READ_SCREEN_CHAR
		CMP AH, ATTR_PLAYER
		JZ END_SNAKE

		; Set snake's head position
		MOV [POS_COL_SNAKE_HEAD], DL
		MOV [POS_ROW_SNAKE_HEAD], DH

		; Check if snake collided with the field
		CMP AH, ATTR_FIELD
		JNZ EXIT

		MOV [POS_COL_SNAKE_HEAD], 02h		; Set to starting column
		ADD [POS_ROW_SNAKE_HEAD], 01h		; Move to the next row

	EXIT:
		CALL PRINT_SNAKE

		POP DX
		POP AX
		RET

	END_SNAKE:
		POP DX
		POP AX
	  MOV [END_GAME], TRUE

    RET

MOVE_SNAKE_HEAD	ENDP

; ****************************************
; Moves the snake's tail
; Entry:
;		-
; Returns:
;   -
; Modifies:
;   NUM_TILES
;		DL
;		HL
; Uses:
;   INC_COL
;		INC_ROW
;		ATTR_SNAKE
;		NUM_TILES
; Calls:
;   MOVE_CURSOR
;		READ_SCREEN_CHAR
;		PRINT_SNAKE
; ****************************************
					PUBLIC  MOVE_SNAKE_TAIL
MOVE_SNAKE_TAIL		PROC		NEAR

		PUSH AX
		PUSH DX

		MOV DL, [POS_COL_SNAKE_TAIL]
		MOV DH, [POS_ROW_SNAKE_TAIL]

		; Clear previous position
		CALL MOVE_CURSOR
		CALL PRINT_BLANK

		; Load snake's tail coordinates
		ADD DL, [INC_COL_SNAKE_TAIL]
		ADD DH, [INC_ROW_SNAKE_TAIL]

		; Move the snake's tail on the screen
		CALL MOVE_CURSOR

		; Check if the snake's tail collided with the field
		CALL READ_SCREEN_CHAR
		CMP AH, ATTR_FIELD
		JZ NEXT_ROW_TAIL

		; Set snale's tail position
		MOV [POS_COL_SNAKE_TAIL], DL
		MOV [POS_ROW_SNAKE_TAIL], DH

		; Increment the length of the snake
		INC [NUM_TILES]
		CALL PRINT_SNAKE

		POP DX
		POP AX
		RET

	NEXT_ROW_TAIL:
		MOV [POS_COL_SNAKE_TAIL], 02h		; Set to starting column
		ADD [POS_ROW_SNAKE_TAIL], 01h		; Move to the next row

		POP DX
		POP AX
		RET

	END_SNAKE:
		POP DX
		POP AX
	  MOV [END_GAME], TRUE

    RET

MOVE_SNAKE_TAIL	ENDP

; ****************************************
; Prints the player
; Entry:
;		-
; Returns:
;		-
; Modifies:
;		-
; Uses:
;   character: ASCII_PLAYER
;   attribute: ATTR_PLAYER
; Calls:
;   PRINT_CHAR_ATTR
; ****************************************
					PUBLIC PRINT_PLAYER
PRINT_PLAYER		PROC		NEAR

    PUSH AX
    PUSH BX
    MOV AL, ASCII_PLAYER
    MOV BL, ATTR_PLAYER
    CALL PRINT_CHAR_ATTR

    POP BX
    POP AX
    RET

PRINT_PLAYER        ENDP

; ****************************************
; Moves the player based on input
; Entry:
;		-
; Returns:
;   -
; Modifies:
;   NUM_TILES
;		DL
;		HL
; Uses:
;   INC_COL
;		INC_ROW
;		ATTR_PLAYER
;		NUM_TILES
; Calls:
;   MOVE_CURSOR
;		READ_SCREEN_CHAR
;		PRINT_SNAKE
; ****************************************
					PUBLIC  MOVE_PLAYER
MOVE_PLAYER		PROC		NEAR

		PUSH AX
		PUSH DX

		MOV DL, [POS_COL_PLAYER]
		MOV DH, [POS_ROW_PLAYER]

		; Clear previous position
		CALL MOVE_CURSOR
		CALL PRINT_BLANK

		; Load player coordinates
		ADD DL, [INC_COL_PLAYER]

		; Move player on the screen
		CALL MOVE_CURSOR

		; Check if player collided with the field or with itself
		CALL READ_SCREEN_CHAR
		CMP AH, ATTR_FIELD
		JZ PLAYER_HIT_CORNER

		CALL PRINT_PLAYER

		MOV [POS_COL_PLAYER], DL
		MOV [POS_ROW_PLAYER], DH

		POP DX
		POP AX
		RET

	PLAYER_HIT_CORNER:
		MOV DL, 00h
		MOV [INC_COL_PLAYER], DL

		POP DX
		POP AX
    RET

MOVE_PLAYER	ENDP

; ****************************************
; Prints the bullet
; Entry:
;		-
; Returns:
;		-
; Modifies:
;		-
; Uses:
;   character: ASCII_BULLET
;   attribute: ATTR_BULLET
; Calls:
;   PRINT_CHAR_ATTR
; ****************************************
					PUBLIC PRINT_BULLET
PRINT_BULLET		PROC		NEAR

    PUSH AX
    PUSH BX
    MOV AL, ASCII_BULLET
    MOV BL, ATTR_BULLET
    CALL PRINT_CHAR_ATTR

    POP BX
    POP AX
    RET

PRINT_BULLET        ENDP

; ****************************************
; Moves the player based on input
; Entry:
;		-
; Returns:
;   -
; Modifies:
;   NUM_TILES
;		DL
;		HL
;		BULLET_FIRED
; Uses:
;   INC_COL
;		INC_ROW
;		ATTR_PLAYER
;		NUM_TILES
;		BULLET_FIRED
; Calls:
;   MOVE_CURSOR
;		READ_SCREEN_CHAR
;		PRINT_SNAKE
; ****************************************
					PUBLIC  MOVE_BULLET
MOVE_BULLET		PROC		NEAR

		PUSH AX
		PUSH DX

		MOV DH, [POS_ROW_BULLET]
		MOV DL, [POS_COL_BULLET]

		; Clear previous position
		CALL MOVE_CURSOR
		CALL PRINT_BLANK

		; Increment the bullet's row
		ADD DH, [INC_ROW_BULLET]

		; Move bullet on the screen
		CALL MOVE_CURSOR

		; Check if bullet collided with the field or with the snake
		CALL READ_SCREEN_CHAR
		CMP AH, ATTR_FIELD
		JZ END_BULLET
		CMP AH, ATTR_SNAKE
		JZ END_BULLET_HIT

		CALL PRINT_BULLET

		MOV [POS_ROW_BULLET], DH
		MOV [POS_COL_BULLET], DL

		POP DX
		POP AX
		RET

	END_BULLET_HIT:
		MOV [BULLET_FIRED], FALSE
		ADD [CURR_LENGHT_SNAKE], -1
		POP DX
		POP AX

		CALL MOVE_SNAKE_TAIL
		CALL CHECK_SNAKE_LENGHT

		RET

	END_BULLET:
		MOV [BULLET_FIRED], FALSE

		POP DX
		POP AX
    RET

MOVE_BULLET	ENDP

; ****************************************
; Check if the snake still has length
; Entry:
;   -
; Returns:
;		-
; Modifies:
;		-
; Uses:
;		CURR_LENGHT_SNAKE
;		END_GAME
; Calls:
;   -
; ****************************************

					PUBLIC CHECK_SNAKE_LENGHT
CHECK_SNAKE_LENGHT		PROC		NEAR

		MOV AH, 00h
		CMP AH, [CURR_LENGHT_SNAKE]
		JE WIN_GAME

		RET

	WIN_GAME:
		MOV [END_GAME], TRUE
		RET

CHECK_SNAKE_LENGHT        ENDP

; ****************************************
; Prints character and attribute in the
; current cursor position, page 0
; Keeps the cursor position
; Entry:
;   AL: ASCII to print
;   BL: ATTRIBUTE to print
; Returns:
;
; Modifies:
;
; Uses:
;
; Calls:
;   int 10h, service AH=9
; Nota:
;   Compatibility problem when debugging
; ****************************************
					PUBLIC PRINT_CHAR_ATTR
PRINT_CHAR_ATTR		PROC		NEAR

    PUSH AX
    PUSH BX
    PUSH CX

    MOV AH, 9
    MOV BH, 0
    MOV CX, 1
    INT 10h

    POP CX
    POP BX
    POP AX
    RET

PRINT_CHAR_ATTR        ENDP

; ****************************************
; Prints character and attribute in the
; current cursor position, page 0
; Cursor moves one position right
; Entry:
;    AL: ASCII code to print
; Returns:
;
; Modifies:
;
; Uses:
;
; Calls:
;   int 21h, service AH=2
; ****************************************
					PUBLIC PRINT_CHAR
PRINT_CHAR		PROC		NEAR

    PUSH AX
    PUSH DX

    MOV AH, 2
    MOV DL, AL
    INT 21h

    POP DX
    POP AX
    RET

PRINT_CHAR        ENDP

; ****************************************
; Set screen to mode 3 (80x25, color) and
; clears the screen
; Entry:
;   -
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   Screen size: SCREEN_MAX_ROWS, SCREEN_MAX_COLS
; Calls:
;   int 10h, service AH=0
;   int 10h, service AH=6
; ****************************************
					PUBLIC INIT_SCREEN
INIT_SCREEN		PROC		NEAR

      PUSH AX
      PUSH BX
      PUSH CX
      PUSH DX

      ; Set screen mode
      MOV AL,3
      MOV AH,0
      INT 10h

      ; Clear screen
      XOR AL, AL
      XOR CX, CX
      MOV DH, SCREEN_MAX_ROWS
      MOV DL, SCREEN_MAX_COLS
      MOV BH, 7
      MOV AH, 6
      INT 10h

      POP DX
      POP CX
      POP BX
      POP AX
			RET

INIT_SCREEN		ENDP

; ****************************************
; Hides the cursor
; Entry:
;   -
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   -
; Calls:
;   int 10h, service AH=1
; ****************************************
					PUBLIC  HIDE_CURSOR
HIDE_CURSOR		PROC		NEAR

      PUSH AX
      PUSH CX

      MOV AH, 1
      MOV CX, CURSOR_SIZE_HIDE
      INT 10h

      POP CX
      POP AX
      RET

HIDE_CURSOR       ENDP

; ****************************************
; Shows the cursor (standard size)
; Entry:
;   -
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   -
; Calls:
;   int 10h, service AH=1
; ****************************************
					PUBLIC SHOW_CURSOR
SHOW_CURSOR		PROC		NEAR

    PUSH AX
    PUSH CX

    MOV AH, 1
    MOV CX, CURSOR_SIZE_SHOW
    INT 10h

    POP CX
    POP AX
    RET

SHOW_CURSOR       ENDP

; ****************************************
; Get cursor properties: coordinates and size (page 0)
; Entry:
;   -
; Returns:
;   (DH, DL): coordinates -> (row, col)
;   (CH, CL): cursor size
; Modifies:
;   -
; Uses:
;   -
; Calls:
;   int 10h, service AH=3
; ****************************************
					PUBLIC GET_CURSOR_PROP
GET_CURSOR_PROP		PROC		NEAR

      PUSH AX
      PUSH BX

      MOV AH, 3
      XOR BX, BX
      INT 10h

      POP BX
      POP AX
      RET

GET_CURSOR_PROP       ENDP

; ****************************************
; Set cursor properties: coordinates and size (page 0)
; Entry:
;   (DH, DL): coordinates -> (row, col)
;   (CH, CL): cursor size
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   -
; Calls:
;   int 10h, service AH=2
; ****************************************
					PUBLIC SET_CURSOR_PROP
SET_CURSOR_PROP		PROC		NEAR

      PUSH AX
      PUSH BX

      MOV AH, 2
      XOR BX, BX
      INT 10h

      POP BX
      POP AX
      RET

SET_CURSOR_PROP       ENDP

; ****************************************
; Move cursor to coordinate
; Cursor size if kept
; Entry:
;   (DH, DL): coordinates -> (row, col)
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   -
; Calls:
;   GET_CURSOR_PROP
;   SET_CURSOR_PROP
; ****************************************
					PUBLIC MOVE_CURSOR
MOVE_CURSOR		PROC		NEAR

      PUSH DX
      CALL GET_CURSOR_PROP  ; Get cursor size
      POP DX
      CALL SET_CURSOR_PROP
      RET

MOVE_CURSOR       ENDP

; ****************************************
; Moves cursor one position to the right
; If the column limit is reached, the cursor does not move
; Cursor size if kept
; Entry:
;   -
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   SCREEN_MAX_COLS
; Calls:
;   GET_CURSOR_PROP
;   SET_CURSOR_PROP
; ****************************************
					PUBLIC  MOVE_CURSOR_RIGHT
MOVE_CURSOR_RIGHT		PROC		NEAR

    PUSH CX
    PUSH DX

    CALL GET_CURSOR_PROP
    ADD DL, 1
    CMP DL, SCREEN_MAX_COLS
    JZ MOVE_CURSOR_RIGHT_END

    CALL SET_CURSOR_PROP

  MOVE_CURSOR_RIGHT_END:
    POP DX
    POP CX
    RET

MOVE_CURSOR_RIGHT       ENDP

; ****************************************
; Print string to screen
; The string end character is '$'
; Entry:
;   DX: pointer to string
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   SCREEN_MAX_COLS
; Calls:
;   INT 21h, service AH=9
; ****************************************
					PUBLIC PRINT_STRING
PRINT_STRING		PROC		NEAR

    PUSH DX

    MOV AH,9
    INT 21h

    POP DX
    RET

PRINT_STRING       ENDP

; ****************************************
; Print the score string, starting in the cursor
; (FIELD_C1, FIELD_R2) coordinate
; Entry:
;   DX: pointer to string
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   SCORE_STR
;   FIELD_C1
;   FIELD_R2
; Calls:
;   GET_CURSOR_PROP
;   SET_CURSOR_PROP
;   PRINT_STRING
; ****************************************
					PUBLIC PRINT_SCORE_STRING
PRINT_SCORE_STRING		PROC		NEAR

    PUSH CX
    PUSH DX

    CALL GET_CURSOR_PROP  ; Get cursor size
    MOV DH, FIELD_R2+1
    MOV DL, FIELD_C1
    CALL SET_CURSOR_PROP

    LEA DX, SCORE_STR
    CALL PRINT_STRING

    POP DX
    POP CX
    RET

PRINT_SCORE_STRING       ENDP

; ****************************************
; Print the score string, starting in the
; current cursor coordinate
; Entry:
;   -
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   PLAY_AGAIN_STR
;   FIELD_C1
;   FIELD_R2
; Calls:
;   PRINT_STRING
; ****************************************
					PUBLIC PRINT_PLAY_AGAIN_STRING
PRINT_PLAY_AGAIN_STRING		PROC		NEAR

    PUSH DX

    LEA DX, PLAY_AGAIN_STR
    CALL PRINT_STRING

    POP DX
    RET

PRINT_PLAY_AGAIN_STRING       ENDP

; ****************************************
; Prints the score of the player in decimal, on the screen,
; starting in the cursor position
; NUM_TILES range: [0, 9999]
; Entry:
;   -
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   NUM_TILES memory variable
; Calls:
;   PRINT_CHAR
; ****************************************
					PUBLIC PRINT_SCORE
PRINT_SCORE		PROC		NEAR

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    ; 1000'
    MOV AX, [NUM_TILES]
    XOR DX, DX
    MOV BX, 1000
    DIV BX            ; DS:AX / BX -> AX: quotient, DX: remainder
    ADD AL, ASCII_NUMBER_ZERO
    CALL PRINT_CHAR

    ; 100'
    MOV AX, DX        ; Remainder
    XOR DX, DX
    MOV BX, 100
    DIV BX            ; DS:AX / BX -> AX: quotient, DX: remainder
    ADD AL, ASCII_NUMBER_ZERO
    CALL PRINT_CHAR

    ; 10'
    MOV AX, DX          ; Remainder
    XOR DX, DX
    MOV BX, 10
    DIV BX            ; DS:AX / BX -> AX: quotient, DX: remainder
    ADD AL, ASCII_NUMBER_ZERO
    CALL PRINT_CHAR

    ; 1'
    MOV AX, DX
    ADD AL, ASCII_NUMBER_ZERO
    CALL PRINT_CHAR

    POP DX
    POP CX
    POP BX
    POP AX
    RET

PRINT_SCORE        ENDP

; ****************************************
; Game timer interrupt service routine
; Called 18.2 times per second by the operating system
; Calls previous ISR
; Manages the movement of the snake:
;   position, direction, speed, length, display, collisions
; Entry:
;   -
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   OLD_INTERRUPT_BASE memory variable
;   START_GAME memory variable
;   END_GAME memory variable
;   INT_COUNT memory variable
;   DIV_SPEED memory variable
;   INC_COL memory variable
;   INC_ROW memory variable
;   ATTR_SNAKE constant
;   NUM_TILES memory variable
;   NUM_TILES_INC_SPEED
; Calls:
;   MOVE_CURSOR
;   READ_SCREEN_CHAR
;   PRINT_SNAKE
;		MOVE_SNAKE
; ****************************************
					PUBLIC NEW_TIMER_INTERRUPT
NEW_TIMER_INTERRUPT		PROC		NEAR

    ; Call previous interrupt
    PUSHF
    CALL DWORD PTR [OLD_INTERRUPT_BASE]

    PUSH AX

    ; Do nothing if game is stopped
    CMP [START_GAME], TRUE
    JNZ END_ISR

		CMP [BULLET_FIRED], TRUE
		JNZ	SNAKE

		CALL MOVE_BULLET

	SNAKE:
		CALL MOVE_SNAKE_HEAD
		CALL MOVE_SNAKE_TAIL

    ; Increment INC_COUNT and check if snake position must be updated (INT_COUNT == DIV_COUNT)
    INC [INT_COUNT]
    MOV AL, [INT_COUNT]
    CMP [DIV_SPEED], AL
    JNZ END_ISR
    MOV [INT_COUNT], 0

    ; Check if it is time to increase the speed of the snake
    CMP [DIV_SPEED], 1
    JZ END_ISR
    MOV AX, [NUM_TILES]
    DIV [NUM_TILES_INC_SPEED]
    CMP AH, 0                 ; REMAINDER
    JNZ END_ISR
    DEC [DIV_SPEED]

    JMP END_ISR

END_ISR:
      POP AX
      IRET

NEW_TIMER_INTERRUPT ENDP

; ****************************************
; Replaces current timer ISR with the game timer ISR
; Entry:
;   -
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   OLD_INTERRUPT_BASE memory variable
;   NEW_TIMER_INTERRUPT memory variable
; Calls:
;   int 21h, service AH=35 (system interrupt 08)
; ****************************************
					PUBLIC REGISTER_TIMER_INTERRUPT
REGISTER_TIMER_INTERRUPT		PROC		NEAR

        PUSH AX
        PUSH BX
        PUSH DS
        PUSH ES

        CLI                                 ;Disable Ints

        ;Get current 01CH ISR segment:offset
        MOV  AX, 3508h                      ;Select MS-DOS service 35h, interrupt 08h
        INT  21h                            ;Get the existing ISR entry for 08h
        MOV  WORD PTR OLD_INTERRUPT_BASE+02h, ES  ;Store Segment
        MOV  WORD PTR OLD_INTERRUPT_BASE, BX  ;Store Offset

        ;Set new 01Ch ISR segment:offset
        MOV  AX, 2508h                      ;MS-DOS serivce 25h, IVT entry 01Ch
        MOV  DX, offset NEW_TIMER_INTERRUPT ;Set the offset where the new IVT entry should point to
        INT  21h                            ;Define the new vector

        STI                                 ;Re-enable interrupts

        POP  ES                             ;Restore interrupts
        POP  DS
        POP  BX
        POP  AX
        RET

REGISTER_TIMER_INTERRUPT ENDP

; ****************************************
; Restore timer ISR
; Entry:
;   -
; Returns:
;   -
; Modifies:
;   -
; Uses:
;   OLD_INTERRUPT_BASE memory variable
; Calls:
;   int 21h, service AH=25 (system interrupt 08)
; ****************************************
					PUBLIC RESTORE_TIMER_INTERRUPT
RESTORE_TIMER_INTERRUPT		PROC		NEAR

      PUSH AX
      PUSH DS
      PUSH DX

      CLI                                 ;Disable Ints

      ;Restore 08h ISR
      MOV  AX, 2508h                      ;MS-DOS service 25h, ISR 08h
      MOV  DX, WORD PTR OLD_INTERRUPT_BASE
      MOV  DS, WORD PTR OLD_INTERRUPT_BASE+02h
      INT  21h                            ;Define the new vector

      STI                                 ;Re-enable interrupts

      POP  DX
      POP  DS
      POP  AX
      RET

RESTORE_TIMER_INTERRUPT ENDP

; CODE SEGMENT
CODE_SEG 	ENDS

DATA_SEG	SEGMENT	PUBLIC

    OLD_INTERRUPT_BASE DW 0, 0  ; Stores the current (system) timer ISR address

    ; (INC_ROW. INC_COL) may be (-1, 0, 1), and determine the direction of movement of the snake's head
    INC_ROW_SNAKE_HEAD DB 0
    INC_COL_SNAKE_HEAD DB 1
		; Position of the snake's head
		POS_ROW_SNAKE_HEAD DB 2
		POS_COL_SNAKE_HEAD DB MAX_LENGHT_SNAKE

		; (INC_ROW. INC_COL) may be (-1, 0, 1), and determine the direction of movement of the snake's tail
    INC_ROW_SNAKE_TAIL DB 0
    INC_COL_SNAKE_TAIL DB 1
		; Position of the snake's tail
		POS_ROW_SNAKE_TAIL DB 2
		POS_COL_SNAKE_TAIL DB 2

		CURR_LENGHT_SNAKE	 DB MAX_LENGHT_SNAKE

		; (INC_COL_PLAYER) may be (-1, 0, 1), and determine the direction of movement of the player
    INC_COL_PLAYER DB 0
		; Position of the player
		POS_ROW_PLAYER DB SCREEN_MAX_ROWS-3
		POS_COL_PLAYER DB SCREEN_MAX_ROWS/2

		; (INC_ROW_BULLET) may be (-1, 0, 1), and determine the direction of movement of the bullet
		INC_ROW_BULLET DB 0
		; Position of the bullet
		POS_ROW_BULLET DB 0
		POS_COL_BULLET DB 0
		; Set BULLET_FIRED to 1 when shooting and 0 when there is no bullet on screen
		BULLET_FIRED	 DB 0

    NUM_TILES DW 0              ; SNAKE LENGTH
    NUM_TILES_INC_SPEED DB 20   ; THE SPEED IS INCREASED EVERY 'NUM_TILES_INC_SPEED'

    DIV_SPEED DB 10             ; THE SNAKE SPEED IS THE (INTERRUPT FREQUENCY) / DIV_SPEED
    INT_COUNT DB 0              ; 'INT_COUNT' IS INCREASED EVERY INTERRUPT CALL, AND RESET WHEN IT ACHIEVES 'DIV_SPEED'

    START_GAME DB 0             ; 'MAIN' sets START_GAME to '1' when a key is pressed
    END_GAME DB 0               ; 'NEW_TIMER_INTERRUPT' sets END_GAME to '1' when a condition to end the game happens

    SCORE_STR           DB "Your score is $"
    PLAY_AGAIN_STR      DB ". Do you want to play again? (Y/N)$"

DATA_SEG	ENDS

		END MAIN
