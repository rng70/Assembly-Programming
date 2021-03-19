
; TAKE INPUT OF TWO NUMBER AND PRINT THEIR SUM


.MODEL SMALL

.STACK 100H

.DATA
    
    A DB ?
    B DB ?
    
    MSG DB 0DH, 0AH, 'THE SUM OF $' 
    MSG1 DB ' AND $'
    MSG2 DB ' IS $';
    
.CODE 
    
    MAIN PROC
        
        ; INITIALIZE DATA SEGMENT
        MOV AX, @DATA
        MOV DS, AX
        
        ; TAKE INPUT
        MOV DL, '?'
        MOV AH, 2
        INT 21H
        
        MOV AH, 1
        INT 21H
        
        MOV A, AL
        
        INT 21H
        
        MOV B, AL
        
        ; SHOW MESSAGE
        
        LEA DX, MSG
        MOV AH, 9
        INT 21H
        
        MOV AH, 2
        MOV DL, A
        INT 21H
        LEA DX, MSG1
        MOV AH, 9
        INT 21H
        MOV AH, 2
        MOV DL, B
        INT 21H
        LEA DX, MSG2
        MOV AH, 9
        INT 21H
        
        MOV AL, B
        ADD A, AL
        SUB A, 30H
        
        MOV AH, 2
        MOV DL, A
        INT 21H
        
        ; DOS EXIT
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
END MAIN