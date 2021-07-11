; PROGRAM TO DETERMINE EVEN AND ODD

.MODEL SMALL

.STACK 100H

.DATA    
    MSG1 DB 0AH, 0DH, "ENTER NUMBER: $"
    MSG2 DB 0AH, 0DH,
    NUM DB ?, " IS EVEN$"
    MSG3 DB 0AH, 0DH,
    NUM1 DB ?, " IS ODD$"
    
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        ; TAKE INPUT
        MOV AH, 9
        LEA DX, MSG1
        INT 21H
        MOV AH, 1
        INT 21H
        MOV NUM, AL
        MOV NUM1, AL
        
        ; NOW DEVIDE NUMBER
        MOV BL, 2
        DIV BL
        
        ; CHECK FOR EVEN ODD
        CMP AH, 0
        JE EVEN
        JMP ODD
        
        EVEN:
            MOV AH, 9
            LEA DX, MSG2
            INT 21H
            JMP DOS
        ODD:
            MOV AH, 9
            LEA DX, MSG3
            INT 21H
        
        ; RETURN TO DOS
        DOS:
            MOV AH, 4CH
            INT 21H
 
    MAIN ENDP
END MAIN