.MODEL SMALL
.STACK 100H
.DATA
	INPUTMSG DB 10,13,"Enter a string: $"
	OUTPUTMSG DB 10,13,"Resultant string: $" 
	NEWLINE DB 10,13,"$"
	STR1 DB 100 DUP('$')
	STR2 DB 100 DUP('$')
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	MOV ES,AX
	
	;INPUT MESSEGE
	LEA DX,INPUTMSG
	MOV AH,09H
	INT 21H
	
	;INPUT A STRING
	LEA DI,STR1
	MOV CX,99

INPUT_STRING:	
	MOV AH,01H
	INT 21H
	CMP AL,0DH
	JE TERMINATE_INPUT
    STOSB
	LOOP INPUT_STRING

	
TERMINATE_INPUT:
	
	LEA SI, STR1
	LEA DI, STR2
	MOV CX,99
	XOR BL,BL
CONVERSION:	
	LODSB	;SI TO AL
	CMP CX,99
	JE UPPERCASE
	CMP BL,' '
	JNE STORE

UPPERCASE:	
	CMP AL,'a'
	JG CONVERT
	CMP AL, 'z'
	JL CONVERT

CONVERT:	
	SUB AL,20H
	
STORE:	
	STOSB	;AL TO DI
	MOV BL,AL
	LOOP CONVERSION
	
	LEA DX,OUTPUTMSG
	MOV AH,09H
	INT 21H
	
	LEA DX,STR2
	MOV AH,09H
	INT 21H
	
	MOV AH,4CH
	INT 21H
	
MAIN ENDP
END MAIN