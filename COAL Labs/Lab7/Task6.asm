.MODEL SMALL
.STACK 100H
.DATA
		PROMPT1 DB 10,13,"Enter first String: $"
		PROMPT2 DB 10,13,"Enter second String: $"
		PROMPT3 DB 10,13,"They are equal. $"
		PROMPT4 DB 10,13,"They are not equal. $"
		STR1 DB 100 DUP(?)
		STR2 DB 100 DUP(?)
.CODE
MAIN PROC
		MOV AX,@DATA
		MOV DS,AX
		
		MOV DX,OFFSET PROMPT1
		MOV AH,09
		INT 21H
		
		LEA SI, STR1
		MOV CX,100
AGAININPUT1:
		MOV AH,01
		INT 21H
		
		CMP AL,13
		JE REMAIN
		MOV [SI],AL
		INC SI
		LOOP AGAININPUT1
		
REMAIN:
		MOV DX,OFFSET PROMPT2
		MOV AH,09
		INT 21H
		
		MOV SI,0
		LEA SI, STR2
		MOV CX,100
		
AGAININPUT2:
		MOV AH,01
		INT 21H
		
		CMP AL,13
		JE REMAIN1
		MOV [SI],AL
		INC SI
		LOOP AGAININPUT2

REMAIN1:		
		MOV CX,LENGTH STR1
		MOV DX,LENGTH STR2
		CMP CX,DX
		JNE NOTEQUAL
		MOV SI,0
EQUAL:	
		MOV AL,STR1[SI]
		MOV BL,STR2[SI]
		CMP AL,BL
		JNE NOTEQUAL
		LOOP EQUAL
		
		MOV DX,OFFSET PROMPT3
		MOV AH,09
		INT 21H
		JMP HALT
		
NOTEQUAL:
		MOV DX,OFFSET PROMPT4
		MOV AH,09
		INT 21H

HALT:		
		MOV AH,4CH
		INT 21H
MAIN ENDP
END MAIN