.MODEL SMALL
.STACK 100H
.DATA
        PROMPT1 DB 10,13, "ENTER A NUMBER IN HEXA-DECIMAL : $ "
        PROMPT2 DB 10,13, "ITS BINARY EQUIVALENT IS : $ "
        PROMPT3 DB 10,13, "IT IS PALINDROME IN BINARY.$"
        PROMPT4 DB 10,13, "IT IS NOT A PALINDROME IN BINARY.$"
.CODE
.386
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
		LEA DX,PROMPT1
		MOV AH,09
		INT 21H
		
		MOV CX,02
		MOV BL,0
		MOV AH,01
INPUT:	
		INT 21H
		CMP AL,30H
		JB INPUT
		CMP AL,39H
		JA LETTER
		
		SUB AL,30H
		JMP ASSIGN
LETTER:
		CMP AL,'A'
		JB INPUT
		CMP AL,'F'
		JA INPUT
		SUB AL,37H
ASSIGN:
		SHL BL,4
		OR BL,AL
		LOOP INPUT
		
		LEA DX,PROMPT2
		MOV AH,09
		INT 21H
		
		MOV CX,08
OUTPUT:
		ROL BL,1
		JC ONE
		
ZERO:
		MOV DL,30H
		JMP PRINT
ONE:
		MOV DL,31H
PRINT:
		MOV AH,02
		INT 21H
		LOOP OUTPUT
		
		MOV CX,08
		XOR DL,DL
CHECK:		
		ROL BL,1
		ROR DL,1
		JC ONE1
		OR DL,0
		JMP REMAIN
ONE1:
		OR DL,1
REMAIN:
		LOOP CHECK
		CMP BL,DL
		JNE NOTPALINDROME
		
		LEA DX,PROMPT3
		MOV AH,09
		INT 21H
		JMP TERMINATE

NOTPALINDROME:
		LEA DX,PROMPT4
		MOV AH,09
		INT 21H
TERMINATE:
		MOV AH,4CH
		INT 21H
		
MAIN ENDP
END MAIN
