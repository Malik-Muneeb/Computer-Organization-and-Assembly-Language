.MODEL SMALL
.STACK 100H
.DATA
        STR1 DB 10,13,"**********$"
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        MOV CX,5
BACK:
        MOV DX, OFFSET STR1
        MOV AH,09
        INT 21H
        DEC CX
        JNZ BACK

        MOV AH,4CH
        INT 21H

MAIN ENDP
END MAIN
