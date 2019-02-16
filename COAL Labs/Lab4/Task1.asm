.MODEL SMALL
.STACK 100H
.DATA
        PROMPT1 DB 10,13, "ENTER A LOWER CASE LETTER: $"                                                                                                                                                                                      
        OUTPUT DB 10,13, "UPPER CASE LETTER: $"
.CODE
MAIN PROC
        MOV AX, @DATA
        MOV DS, AX

        MOV DX, OFFSET PROMPT1
        MOV AH,09
        INT 21H
                                                        
        MOV AH,01
        INT 21H

        MOV DX, OFFSET OUTPUT
        MOV AH,09
        INT 21H

        SUB AL,32
        MOV DL,Al
        MOV AH,02
        INT 21H

       MOV AH, 4CH
       INT 21H

MAIN ENDP
END MAIN 
