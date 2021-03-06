.MODEL SMALL
.STACK 100H
.DATA
		PROMPT1 DB 10, 13,"Enter an infix expression: $"
		PROMPT2 DB 10, 13,"Postfix equivalent: $"
		STRING1 DB 100 DUP('$')
		VAR1 DW ?
.CODE
MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	
	LEA DX,PROMPT1
	MOV AH,09
	INT 21H
	
	;INPUT
	LEA DI,STRING1
	CALL STRINP
	
	;OUTPUT
	LEA DX,PROMPT2
	MOV AH,09
	INT 21H
	;POSTFIX
	CALL POSTFIX
	
	MOV AH,4CH
	INT 21H
	
MAIN ENDP
;END MAIN FUNCTION

; START STRING INPUT FUNCTION
STRINP PROC
	MOV AH, 01H
	MOV CX, 99D
INPUT: 
	INT 21H
	CMP AL, 0DH
	JE TERMINATE
	MOV [DI], AL
	INC DI
	LOOP INPUT
TERMINATE:
	RET
STRINP ENDP
; END STRING INPUT FUNCTION


; START STRING LENGTH FUNCTION
STRLEN PROC
	PUSH AX
	PUSH SI
	MOV AL, '$'
	XOR CL, CL
LENGTH_:
	CMP [SI],AL
	JE EXIT
	INC SI
	INC CL
	JMP LENGTH_
EXIT:
	POP SI
	POP AX
	RET
STRLEN ENDP
; END STRING LENGTH FUNCTION


;START IS_MATH_OPERATOR
IS_MATH_OPERATOR PROC
	
	CMP AL,'+'
	JE YES
	CMP AL,'-'
	JE YES
	CMP AL,'*'
	JE YES
	CMP AL,'/'
	JE YES
	CMP AL,'%'
	JE YES
	MOV AH,0H
	JMP TERMINATE_END1
YES:
	MOV AH,1H
TERMINATE_END1:
	RET
	
IS_MATH_OPERATOR ENDP
;END IS_MATH_OPERATOR	


;START PRECEDENCE
PRECEDENCE PROC
	
	CMP AL,'+'
	JE ONE
	CMP AL,'-'
	JE ONE
	CMP AL, '*'
	JE TWO
	CMP AL, '/'
	JE TWO
	CMP AL, '%'
	JE TWO
TWO:
	MOV AH,2H
	JMP TERMINATE_END2
ONE:
	MOV AH,1H
TERMINATE_END2:
	RET
	
PRECEDENCE ENDP
;END PRECEDENCE


;START READ_TOP
READ_TOP PROC

	MOV VAR1,AX
	POP AX
	POP BX
	PUSH BX
	PUSH AX
	MOV AX,VAR1
	RET	

READ_TOP ENDP
;END READ_TOP	



;START DISPLAY
DISPLAY PROC
	
	PUSH AX
	MOV DL,AL
	MOV AH,02H
	INT 21H
	POP AX
	RET
	
DISPLAY ENDP
;END DISPLAY


;START POSTFIX 
POSTFIX PROC

	MOV CH,0H			;TO CHECK STACK
	
	; LENGTH CALCULATION	
	LEA SI, STRING1
	CALL STRLEN
	
	
DO:
	MOV AL,[SI]
	CMP AL,'('
	JNE ELSE_IF
	PUSH AX
	INC CH
	JMP END_WHILE
	
ELSE_IF:
	
	CMP AL,')'
	JNE ELSE_MAIN
	POP DX
	DEC CH

CHECK_LEFT_BRACE:
	CMP DL,'('
	JE END_WHILE
	CALL DISPLAY
	POP DX
	DEC CH
	JMP CHECK_LEFT_BRACE
	
ELSE_MAIN:	

	CALL IS_MATH_OPERATOR
	CMP AH,1H
	JE INNER_ELSE_1
	MOV DL,AL
	CALL DISPLAY
	JMP END_WHILE
	
INNER_ELSE_1:
	
	CALL READ_TOP
	CALL PRECEDENCE
	PUSH AX
	INC CH
	MOV AL,BL
	
	CALL IS_MATH_OPERATOR
	CMP AH,0H
	JE NOT_MATH_OPERATOR
	CALL PRECEDENCE
NOT_MATH_OPERATOR:
	MOV BH,AH
	POP AX
	DEC CH
	
	
	CMP CH,0				;IS STACK IS EMPTY
	JE STORE_CONDITION
	CMP BL,'('
	JE STORE_CONDITION
	CMP AH,BH
	JG STORE_CONDITION
	JMP INNER_ELSE_2
	
STORE_CONDITION:
	PUSH AX
	INC CH
	JMP END_INNER_ELSE_1
	
INNER_ELSE_2:

	CMP CH,0
	JE END_INNER_ELSE_1
	CMP BL,'('
	JE END_INNER_ELSE_1
	CMP AH,BH
	JG END_INNER_ELSE_1
	
	POP DX
	DEC CH
	CALL DISPLAY
	CALL READ_TOP
	PUSH AX
	INC CH
	MOV AL,BL
	CALL PRECEDENCE
	MOV BH,AH
	POP AX
	DEC CH
	JMP INNER_ELSE_2
	
END_INNER_ELSE_1:

	PUSH AX
	INC CH
	
END_WHILE:
	INC SI
	DEC CL
	CMP CL,0H
	JNE DO
	
	CMP CH,0H
	JE TERMINATE_POSTFIX
	POP DX
	DEC CH
	CALL DISPLAY
	
TERMINATE_POSTFIX:	
	RET
POSTFIX ENDP
;END POSTFIX

END MAIN