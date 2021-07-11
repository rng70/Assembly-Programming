; CHECK IF NUMBER IS POSITIVE OR NEGATIVE

INCLUDE 'EMU8086.INC'
.MODEL SMALL

.STACK 100H

.DATA
    MSG DB 'ENTER THE NUMBER: $'

.CODE
    MAIN PROC
        ; INITIALIZE DS
        MOV AX, @DATA
        MOV DS, AX
        
        MOV AH, 9
        LEA DX, MSG
        INT 21H
        
        MOV AH, 1
        INT 21H
        
        MOV AH, 2
        MOV DL, 0AH
        INT 21H
        MOV DL, 0DH
        INT 21H
        
        MOV BL, AL
        CMP BL, 0
        JL LESS_THAN_ZERO
        JMP GREATER_THAN_ZERO
        
        LESS_THAN_ZERO:
            PRINTN "THE NUMBER IS NEGATIVE"
            JMP DOS
        
        GREATER_THAN_ZERO:
            PRINTN "THE NUMBER IS POSITIVE"
        
        DOS:
            MOV AH, 4CH
            INT 21H
    MAIN ENDP
END MAIN      