.MODEL SMALL
.STACK 100H
.DATA
        PROMPT1 DB 10,13, "ENTER FIRST ALPHABET: $"
        PROMPT2 DB 10,13, "ENTER SECOND SECOND: $"
        PROMPT3 DB 10,13, "THE DIFFERENCE IS $"
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
        
        SUB BL,BH
        ADD BL,48
        MOV DL,BL
        MOV AH, 02
        INT 21H

        MOV AH,4CH
        INT 21H
MAIN ENDP
END MAIN
