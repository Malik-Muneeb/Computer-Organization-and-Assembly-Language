.MODEL SMALL
.STACK 100H
.DATA
	INPUTMSG1 DB 10,13,"Enter a string: $"
	INPUTMSG2 DB 10,13,"Enter another string: $"
	EQUALSTRINGS DB 10,13,"Both strings are equal.$" 
	NOTEQUALSTRINGS DB 10,13,"Both strings are not equal.$" 
	NEWLINE DB 10,13,"$"
	STR1 DB 100 DUP('$')
	STR2 DB 100 DUP('$') 
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	MOV ES,AX
	
	;INPUT MESSEGE
	LEA DX,INPUTMSG1
	MOV AH,09H
	INT 21H
	
	;INPUT A STRING
	LEA DI,STR1
	MOV CX,99

INPUT_STRING1:	
	MOV AH,01H
	INT 21H
	CMP AL,0DH
	JE TERMINATE_INPUT1
	CMP AL,'a'
	JL ENTER_STRING1
	CMP AL,'z'
	JG ENTER_STRING1
	SUB AL,20H

ENTER_STRING1:
    STOSB
	LOOP INPUT_STRING1
	
TERMINATE_INPUT1:

	;INPUT MESSEGE
	LEA DX,INPUTMSG2
	MOV AH,09H
	INT 21H
	
	LEA DI,STR2
	MOV CX,99

INPUT_STRING2:	
	MOV AH,01H
	INT 21H
	CMP AL,0DH
	JE TERMINATE_INPUT2
	CMP AL,'a'
	JL ENTER_STRING2
	CMP AL,'z'
	JG ENTER_STRING2
	SUB AL,20H

ENTER_STRING2:
    STOSB
	LOOP INPUT_STRING2

TERMINATE_INPUT2:	
	
	LEA SI,STR1
	LEA DI,STR2
	MOV CX,99
	
COMPARISON:	
	MOV BX,[SI]
	CMP BX,[DI]
	JNE NOTEQUAL
	CMPSB
	LOOP COMPARISON
	
	LEA DX,EQUALSTRINGS
	MOV AH,09H
	INT 21H
	JMP TERMINATE
NOTEQUAL:
	LEA DX,NOTEQUALSTRINGS
	MOV AH,09H
	INT 21H
	
TERMINATE:	
	MOV AH,4CH
	INT 21H
	
MAIN ENDP
END MAIN