.MODEL SMALL
.STACK 100H
.DATA
        PROMPT1 DB 10,13,"ENTER A LOWER CASE ALPHABET: $"
        PROMPT2 DB 10,13,"UPPER CASE LETTER IS: $"
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS, AX

        MOV DX, OFFSET PROMPT1
        MOV AH, 09
        INT 21H

        MOV AH,01
        INT 21H

        MOV DX, OFFSET PROMPT2
        MOV AH, 09
        INT 21H

        MOV DL,AL
        SUB DL,32
        MOV AH,02
        INT 21H

        MOV AH,4CH
        INT 21H



                                                                                                                                                                                                                                                                                                                                                                                              

MAIN ENDP
END MAIN

