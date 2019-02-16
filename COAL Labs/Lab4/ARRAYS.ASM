.MODEL SMALL
.STACK 100H
.DATA
        DISPLAY1 DB 10,13, "CONTENTS OF ARR1 ARE: "
        ARR1 DB "FIRST-$"
        DISPLAY2 DB 10, 13, "CONTENTS OF ARR2 ARE: "
        ARR2 DB "SECOND$"
.CODE
MAIN PROC
        MOV AX, @DATA
        MOV DS, AX

        MOV SI, OFFSET ARR1
        MOV DI, OFFSET ARR2
        MOV CX, 6
AGAIN:
        MOV AL,[SI]
        MOV BL,[DI]
        MOV [DI], AL
        MOV [SI], BL
        INC SI
        INC DI
        DEC CX
        JNZ AGAIN

        MOV DX, OFFSET DISPLAY1
        MOV AH, 09
        INT 21H

        MOV DX, OFFSET DISPLAY2
        MOV AH,09
        INT 21H

        MOV AH,4CH
        INT 21H
MAIN ENDP
END MAIN        

