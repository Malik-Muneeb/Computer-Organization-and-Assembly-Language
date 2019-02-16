.MODEL SMALL
.STACK 100H
.DATA
        PROMPT1 DB 10,13,"FIRST CHARACTER: $ "
        PROMPT2 DB 10,13,"SECOND CHARACTER: $ "
        ALPHA DB 6FH
        BETA DB 4DH
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        MOV AL,ALPHA
        MOV BL,BETA
        ADD AL,BL
        NEG BL
        ADD BL,AL
        SUB AL,BL

        MOV ALPHA,AL
        MOV BETA,BL

        MOV DX,OFFSET PROMPT1
        MOV AH,09
        INT 21H

        MOV DL,ALPHA
        MOV AH,02
        INT 21H

        MOV DX,OFFSET PROMPT2
        MOV AH,09
        INT 21H

        MOV DL,BETA
        MOV AH,02
        INT 21H

        MOV AH,4CH
        INT 21H

MAIN ENDP
END MAIN
