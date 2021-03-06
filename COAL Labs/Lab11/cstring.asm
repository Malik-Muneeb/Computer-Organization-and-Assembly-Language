.CODE

;STRINP START
STRINP PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	PUSH BP
	MOV BP,SP
	MOV SI,[BP+14+4]
	MOV CX,[BP+14+2]
	
	MOV AH,01H
STRINP_INPUT:
		INT 21H
		CMP AL,0DH
		JE STRINP_END
		MOV [SI],AL
		INC SI
		LOOP STRINP_INPUT
		
STRINP_END:
		MOV AL,0
		MOV [SI],AL
		POP BP
		POP DI
		POP SI
		POP DX
		POP CX
		POP BX
		POP AX
		RET 4
STRINP ENDP
;STRINP END


;START STROUT
STROUT PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	PUSH BP
	MOV BP,SP
	MOV SI,[BP+14+4]
	MOV CX,[BP+14+2]
	
	MOV AH,02H
STROUT_OUTPUT:
		MOV DL,[SI]
		CMP DL,0
		JE STROUT_END
		INT 21H
		INC SI
		LOOP STROUT_OUTPUT
		
STROUT_END:	
		POP BP
		POP DI
		POP SI
		POP DX
		POP CX
		POP BX
		POP AX
		RET 4
STROUT ENDP
;STROUT END

;STRLEN START
STRLEN PROC
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	PUSH BP
	MOV BP,SP
	MOV SI,[BP+12+2]
	
	XOR BL,BL
	MOV AL,0
STRLEN_COUNT:
		CMP [SI],AL
		JE STRLEN_END
		INC SI
		INC BL
		JMP STRLEN_COUNT
		
STRLEN_END:
		POP BP
		POP DI
		POP SI
		POP DX
		POP CX
		POP AX
		RET 2
STRLEN ENDP
;STRLEN END


;STRCMP START
STRCMP PROC
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	PUSH BP
	MOV BP,SP
	MOV SI,[BP+12+4]
	MOV DI,[BP+12+2]
	
	PUSH SI
	CALL STRLEN
	MOV AL,BL
	PUSH DI
	CALL STRLEN
	CMP AL,BL
	JNE STRCMP_NOTEQUAL
	
STRCMP_COMPARE:
		MOV AL,[SI]
		MOV BL,[DI]
		CMP AL,BL
		JNE STRCMP_NOTEQUAL
		INC SI
		INC DI
		CMP AL,0H
		JNE STRCMP_COMPARE
		XOR AL,AL
		JMP STRCMP_END
		
STRCMP_NOTEQUAL:
		SUB AL,BL
		
STRCMP_END:
		POP BP
		POP DI
		POP SI
		POP DX
		POP CX
		POP BX
		RET 4
		
STRCMP ENDP
;STRCMP END


;SUBSTRING START
SUBSTRING PROC
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	PUSH BP
	MOV BP,SP
	MOV SI,[BP+12+4]
	MOV DI,[BP+12+2]
	
	PUSH SI
	CALL STRLEN
	MOV AL,BL
	PUSH DI
	CALL STRLEN
	CMP AL,BL
	JL SUBSTRING_NOT_SUBSTR
	MOV CL,BL
	MOV AL,0
	MOV BL,0
	
SUBSTRING_COMPARE:
		CMP [SI],BL
		JE SUBSTRING_END
		CMP [DI],BL
		JE SUBSTRING_END
		MOV DX,[DI]
		CMP [SI],DX
		JNE SUBSTRING_INNER_IF
		INC DI
		MOV AL,1
		JMP SUBSTRING_COMPARE
		

SUBSTRING_INNER_IF:
		DEC DI
		MOV BX,[DI]
		CMP [SI],BX
		JNE SUBSTRING_INNER_ELSE
		INC DI
		MOV AL,1
		JMP SUBSTRING_COMPARE
		
SUBSTRING_INNER_ELSE:
		MOV DI,[BP+12+2]
		MOV AL,0
		INC SI
		JMP SUBSTRING_COMPARE
	
SUBSTRING_NOT_SUBSTR:
		MOV AL,0
SUBSTRING_END:
		POP BP
		POP DI
		POP SI
		POP DX
		POP CX
		POP BX
		RET 4	

SUBSTRING ENDP
;SUBSTRING END