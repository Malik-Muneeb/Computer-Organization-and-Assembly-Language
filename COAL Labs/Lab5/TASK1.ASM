.MODEL SMALL
.STACK 100H
.DATA
        PROMPT DB 10,13,"Seems like I can display a string. Let's try. $"
.CODE
MAIN PROC
        MOV AX, @DATA
        MOV DS,AX

        MOV DX, OFFSET PROMPT
        MOV AH, 09
        INT 21H

        MOV AH,4CH
        INT 21H
MAIN ENDP
END MAIN

