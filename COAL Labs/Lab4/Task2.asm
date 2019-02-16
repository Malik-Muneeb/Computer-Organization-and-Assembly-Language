.MODEL SMALL
.STACK 100H
.DATA
        PROMPT1 DB 10,13, "ENTER FIRST NUMBER: $"
        PROMPT2 DB 10,13, "ENTER SECOND NUMBER: $"
        PROMPT3 DB 10,13, "THE SUM IS $"
.CODE
MAIN PROC
        MOV AX, @DATA                                                                                                                                                                                                                                                                                                                                                                                                   
        MOV DS,AX

        MOV DX, OFFSET PROMPT1
        MOV AH,09
        INT 21H

        MOV AH,01
        INT 21H
		
        MOV BL,AL

        MOV DX, OFFSET PROMPT2
        MOV AH,09
        INT 21H

        MOV AH,01
        INT 21H

        MOV BH,AL

        MOV DX, OFFSET PROMPT3
        MOV AH,09
        INT 21H
        
        ADD BH,BL
        SUB BH,48
        MOV DL,BH
        MOV AH, 02
        INT 21H

        MOV AH,4CH
        INT 21H
MAIN ENDP
END MAIN
