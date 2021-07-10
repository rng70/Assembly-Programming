; PROGRAM TO TAKE TWO SMALL NUMBERS, ADD THEM, DISPLAY RESULT

.MODEL SMALL

.STACK 100H

.DATA
    NUM1 DB ?
    NUM2 DB ?
    SUM DB ?
    
.CODE
    MAIN PROC
        
        ; INITIALIZE DS
        MOV AX, @DATA
        MOV DS, AX
        
        ; TAKE INPUT FOR NUM1
        MOV AH, 1
        INT 21H
        SUB AL, '0'
        MOV NUM1, AL
        
        ; TAKE INPUT FOR NUM2
        MOV AH, 1
        INT 21H
        SUB AL, '0'
        MOV NUM2, AL
        
        ; ADD THEM
        MOV BL, NUM1
        MOV BH, NUM2
        ADD BL, BH
        ADD BL, '0'
        MOV SUM, BL
        
        ; PRINT RESULT
        MOV AH, 2
        MOV DL, SUM
        INT 21H
        
        ; RETURN TO DOS
        MOV AH, 4CH
        INT 21H

    MAIN ENDP
    
END MAIN