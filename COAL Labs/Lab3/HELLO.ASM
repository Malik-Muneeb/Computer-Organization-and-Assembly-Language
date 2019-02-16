.MODEL SMALL
.STACK 100H
.DATA
        STR1 DB 10,13, "Hello World!",10,13,"$"
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS, AX

        MOV DX, OFFSET STR1
        MOV AH, 09
        INT 21H
        MOV AH,4CH
        INT 21H
MAIN ENDP
END MAIN

                
