.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC
        MOV AL, 10
        MOV BL, 10
        
                fshahsd

        MOV AH,4CH
        INT 21H

MAIN ENDP
END MAIN
