.MODEL SMALL
.STACK 100H
.DATA
        PROMPT1 DB 10,13, "Enter first alphabet:  $"
		PROMPT2 DB 10,13, "Enter second alphabet:  $"	
        OUTPUT DB 10,13, "The difference between them is  $"
.CODE
MAIN PROC
        MOV AX, @DATA
        MOV DS, AX

        MOV DX, OFFSET PROMPT1
        MOV AH,09
        INT 21H
		
        MOV AH,01
        INT 21H

		MOV BH,AL
		
        MOV DX, OFFSET PROMPT2
        MOV AH,09
        INT 21H

		MOV AH,01
        INT 21H
		MOV BL,AL
		
		MOV DX, OFFSET OUTPUT
        MOV AH,09
        INT 21H

		MOV AH,02
		SUB BH,BL
		ADD BH,48
		MOV DL,BH
		INT 21H
       MOV AH, 4CH
       INT 21H

MAIN ENDP
END MAIN 
