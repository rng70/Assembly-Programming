; PRINT THE SUM OF AN ARITHMATIC SERIES

; 1 + 2 + 3 + 4 + 5 + ........ = SUM

.MODEL SMALL

.STACK 100H

.CODE
    MAIN PROC
        MOV AL, '0'  ; HOLDS SUM
        MOV AH, '1'  ; HOLDS X .i.e X = 1
        MOV BL, 1  ; HOLDS I .i.e I = 0
        MOV BH, 3  ; HOLDS N=10
        MOV CL, '1'  ; HOLDS COMMON DIFFERENCE D .i.e D=1
        
        LOOP1:
            ADD AL, AH
            SUB AL, '0'
            ADD AH, CL
            SUB AH, '0'
            INC BL
            CMP BL, BH
            JNG LOOP1
        
        ; PRINT
        MOV DL, AL
        ;SUB DL, '0'
        MOV AH, 2
        INT 21H
        ; RETURN TO DOS
        MOV AH, 4CH
        INT 21H
    MAIN ENDP
END MAIN