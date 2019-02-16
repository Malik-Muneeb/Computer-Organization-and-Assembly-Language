.MODEL SMALL
.STACK 100H
.DATA
        STR1 DB 10,13,"ENTER FIRST CHARACTER: $"
        STR2 DB 10,13,"ENTER SECOND CHARACTER: $"
        STR3 DB 10,13,"ENTER THIRD CHARACTER: $"
        STR4 DB 10,13,"THE OTHER REMAINING CHARACTER IS: $"

.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        MOV DX, OFFSET STR1
        MOV AH,09
        INT 21H

        MOV AH,01                                                                                                                                                                                                                                                                                                                                                                       
        INT 21H

        MOV BL,AL

        MOV DX, OFFSET STR2
        MOV AH,09
        INT 21H

        MOV AH,01                                                                                                                                                                                                                                                                                                                                                                       
        INT 21H

        MOV BH,AL

        MOV DX, OFFSET STR3
        MOV AH,09
        INT 21H

        MOV AH,01                                                                                                                                                                                                                                                                                                                                                                       
        INT 21H

        ADD BL,BH

        MOV DX, OFFSET STR4
        MOV AH,09
        INT 21H

        MOV AH,02
        SUB BL,AL
        MOV DL,BL
        INT 21H

        MOV AH,4CH
        INT 21H

MAIN ENDP
END MAIN
