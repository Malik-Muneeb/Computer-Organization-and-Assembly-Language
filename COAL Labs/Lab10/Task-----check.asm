.MODEL SMALL
.386
.STACK 100H
.DATA
	INPSTR DB 10,13, "ENTER AN INFIX EXPRESSION: $"
	OUTPUT_ DB 10,13,"POSTFIX EQUIALENT: $"
	STR1 DB 100 DUP ('$')
	VAR1 DW ?

.CODE
MAIN PROC	
	MOV AX,@DATA
	MOV DS,AX

	MOV AH,09
	LEA DX,INPSTR
	INT 21H

	MOV CH,0
	LEA DI,STR1
	CALL STRINP

	MOV AH,09
	LEA DX,OUTPUT_
	INT 21H
	CALL POSTFIX


	MOV AH,4CH
	INT 21H
MAIN ENDP




STRINP PROC
	PUSH DI 
	PUSH AX
	MOV CX,99
	MOV AH,01
INPUT_:
	INT 21H
	CMP AL,13
	JE END_INPUT

	MOV [DI],AL
	INC DI
	LOOP INPUT_

END_INPUT:
	POP AX
	POP DI
	RET
STRINP ENDP 



STRLEN PROC
	PUSH AX
	PUSH SI
	MOV CL,0
AGAIN:
	MOV AL,[SI]
	CMP AL,'$'
	JE END_COUNT
	INC CL
	INC SI
	JMP AGAIN
END_COUNT:

	POP SI
	POP AX
	RET
STRLEN ENDP


IS_MATH_OPERATOR PROC

	CMP AL,'+'
	JE ONE
	CMP AL,'-'
	JE ONE
	CMP AL,'*'
	JE ONE
	CMP AL,'/'
	JE ONE
	CMP AL,'%'
	JE ONE
ZERO:
	MOV AH,0
	JMP END_PROC
ONE:
	MOV AH,1
END_PROC:
	RET
IS_MATH_OPERATOR ENDP



PRECEDENCE PROC
	CMP AL,'+'
	JE ONE
	CMP AL,'-'
	JE ONE
	CMP AL,'*'
	JE TWO
	CMP AL,'%'
	JE TWO
	CMP AL,'/'
TWO:
	MOV AH,2
	JMP END_PRECEDENCE
ONE:
	MOV AH,1
END_PRECEDENCE:
	RET
PRECEDENCE ENDP



READ_TOP PROC
	MOV VAR1,AX
	POP AX
	POP BX
	PUSH BX
	PUSH AX
	MOV AX,VAR1
	RET
READ_TOP ENDP



DISPLAY PROC
	PUSH AX
	MOV AH,02
	INT 21H
	POP AX
	RET
DISPLAY ENDP



POSTFIX PROC
	
	LEA SI,STR1
	CALL STRLEN

DO_:
	MOV AL,[SI]
	CMP AL,'('
	JE OPEN_BRACE

	CMP AL,')'
	JE EQUAL_BRACE



	CALL IS_MATH_OPERATOR

	CMP AH,0
	JE DISPLAY_AL


	CALL READ_TOP
	CALL PRECEDENCE
	PUSH AX
	INC CH
	MOV AL,BL
	CALL PRECEDENCE
	MOV BH,AH
	POP AX
	DEC CH

	CMP CH,0
	JE PUSH_AX
	CMP BL,'('
	JE PUSH_AX
	CMP AH,BH
	JG PUSH_AX 

WHILE_:
	CMP CH,0
	JE END_WHILE
	CMP BL,'('
	JE END_WHILE
	CMP AH,BH
	JG END_WHILE
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
	JMP WHILE_

END_WHILE:
	PUSH AX
	INC CH
	JMP END_DO

PUSH_AX:
	PUSH AX
	INC CH
	JMP END_DO

DISPLAY_AL:

	MOV DL,AL
	CALL DISPLAY
	JMP END_DO

OPEN_BRACE:

	PUSH AX
	INC CH
	JMP END_DO

EQUAL_BRACE:

	POP DX
	DEC CH
	CMP DL,')'
	JE END_IF
	CALL DISPLAY
	JMP EQUAL_BRACE
END_IF:

END_DO:
	
	INC SI
	DEC CL
	CMP CL,0
	JNE DO_


WHILE2:

	CMP CH,0
	JE END__
	DEC CH
	POP DX
	CALL DISPLAY
	JMP WHILE2

END__:

RET

POSTFIX ENDP

END MAIN