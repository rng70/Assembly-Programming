
; SUM OF TWO NUMBERS
; SUM OF THE NUMBERS MUST BE LESS THAN 10

.MODEL SAMLL

.STACK 100H

.DATA     

    MSG1 DB 'ENTER THE FIRST NUMBER: $'
    MSG2 DB 0AH, 0DH, 'ENTER THE SECOND NUMBER: $'
    
    MSG DB 0AH, 0DH, 'THE SUM OF ' 
    C1 DB ?, ' AND ' 
    C2 DB ?, ' IS ',
     SUM DB ?, '$'
    
.CODE
    
    MAIN PROC
        ; INITIALIZE DS
        MOV AX, @DATA
        MOV DS, AX
    
        ; READ FIRST DIGIT 
        LEA DX, MSG1
        MOV AH, 9
        INT 21H
        MOV AH, 1
        INT 21H
        MOV C1, AL
    
        ; READ SECOND DIGIT
        LEA DX, MSG2
        MOV AH, 9
        INT 21H
        MOV AH, 1
        INT 21H
        MOV C2, AL
    
        ADD AL, C1
        SUB AL, 30H
        MOV SUM, AL
    
        LEA DX, MSG
        MOV AH, 9
        INT 21H
    
        ; DOS EXIT
        MOV AH, 4CH
        INT 21H
        
   MAIN ENDP
    
END MAIN