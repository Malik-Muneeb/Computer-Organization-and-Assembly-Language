; 8 DECEMBER 2016

.MODEL SMALL
.STACK 100H
.DATA
        PROMPT1 DB 10,13, "ENTER FIRST NUMBER: $"
        PROMPT2 DB 10,13, "ENTER SECOND NUMBER: $"
        PROMPT3 DB 10,13, "THE SUM IS: $"
		NUM1 DB 2 DUP(?)
		NUM2 DB 2 DUP(?)
.CODE
MAIN PROC
        MOV AX, @DATA                                                                                                                                                                                                                                                                                                                                                                                                   
        MOV DS,AX

        MOV DX, OFFSET PROMPT1
        MOV AH,09
        INT 21H
		
		LEA SI,NUM1
		MOV CX,2
		MOV AH,01
INPUT1:
       INT 21H
	   MOV [SI],AL
	   INC SI
	   LOOP INPUT1
	   
	   MOV DX, OFFSET PROMPT2
       MOV AH,09
       INT 21H
		
		LEA DI,NUM2
		MOV CX,2
		MOV AH,01
INPUT2:
       INT 21H
	   MOV [DI],AL
	   INC DI
	   LOOP INPUT2
	   
	   MOV DX, OFFSET PROMPT3
       MOV AH,09
       INT 21H
	   LEA SI,NUM1
	   LEA DI,NUM2
	   MOV CX,2
CALC:
		MOV DL,[SI]
		ADD DL,[DI]
		SUB DL,48
		MOV AH,02
		INT 21H
		INC SI
		INC DI
		LOOP CALC
	   
	   
	   
       MOV AH,4CH
       INT 21H
MAIN ENDP
END MAIN
