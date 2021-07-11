; THIS PROGRAM IS TO CALCULATE WEIGHTED SUM
; WHEN A VALUE IS 2 AND WEIGHT IS 6 THEN
; WEIGHTED SUM IS 2*6 = 12
; TOTAL SUM MUST BE LESS THAN 10 TO SEE OUTPUT CORRECTLY

.MODEL SMALL

.STACK 100H

.DATA
    VALUE DB ?
    DATA1 DB ?
    MSG DB 0AH, 0DH, "WEIGHTED SUM: $", 
    SUM DW ?
    
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        MOV CX, 3
        
        COUNT_GRADE:
            MOV AH, 1
            INT 21H
            
            SUB AL, 48
            MOV VALUE, AL
            INT 21H
            
            SUB AL, 48
            MOV DATA1, AL
            MOV AL, VALUE
            MUL DATA1
            ADD SUM, AX
            DEC CX
            JNZ COUNT_GRADE
         
         MOV AH, 9
         LEA DX, MSG
         INT 21H
         MOV AH, 2
         MOV DX, SUM
         ADD DX, '0'
         INT 21H
         
         ; RETURN TO OS
         MOV AH, 4CH
         INT 21H
    MAIN ENDP
END MAIN