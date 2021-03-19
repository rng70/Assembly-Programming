
; THIS SIMPLE PROGRAM TAKES TWO NUMBER A AND B

; THE PERFORMS THE FOLLOWING OPERATIONS
    
    ; A = A-B
    ; A = -(A+B)
    ; C = A+B
    ; B = 3xB+7
    ; A = B-A-1   
    
    
.MODEL SMALL

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    
    MSG DB 'ENTER THE NUMBERS: $'
    MSG1 DB CR, LF, 'B-A: $'
    MSG2 DB CR, LF, '-(A+1): $'
    MSG4 DB CR, LF, '3xB+7: $'
    MSG5 DB CR, LF, 'B-A-1: $' 
    
    A DB ?
    B DB ?
    TEMP_A DB ?
    TEMP_B DB ?
    
.CODE 
    
    MAIN PROC
        
        ; INITIALIZE DATA
        
        MOV AX, @DATA
        MOV DS, AX
        
        ; PRINT THE MESSAGE
        
        LEA DX, MSG
        MOV AH, 9
        INT 21H
        
        ; TAKE INPUT 
        
        MOV AH, 1
        INT 21H  
        
        ; MOV THE VALUE TO A AND TEMP_A 
        
        MOV A, AL 
        MOV TEMP_A, AL
        
        
        ; MOV THE VALUE TO B AND TEMP_B 
        
        INT 21H
        MOV B, AL                      
        MOV TEMP_B, AL
        
        ; A=B-A CALCULATION
        
        MOV AL, A
        SUB B, AL
        ADD B, 30H
        MOV AL, B
        MOV A, AL
        
        ; PRINT THE VALUE WITH MESSAGE
        
        LEA DX, MSG1
        MOV AH, 9
        INT 21H
        MOV DL, A
        MOV AH, 2
        INT 21H
        
        ; A=-(A+1) 
        
        MOV AL, TEMP_A
        SUB AL, 30H
        MOV A, AL
        INC A
        NEG A
        
        ; PRINT THE VALUE WITH MESSAGE
        
        LEA DX, MSG2
        MOV AH, 9
        INT 21H
        MOV DL, A
        MOV AH, 2
        INT 21H
        
        ; 3xB+7
        MOV AL, TEMP_B
        SUB AL, 30H
        MOV B, 0
        ADD B, AL
        ADD B, AL
        ADD B, AL
        MOV AL, B
        ADD AL, 7H
        MOV A, AL
        
        ; PRINT THE VALUE WITH MESSAGE
        
        LEA DX, MSG4
        MOV AH, 9
        INT 21H
        MOV AH, 2
        MOV DL, A
        INT 21H
        
        ; B-A-1 --> B-(A+1)
        MOV AL, TEMP_A
        MOV A, AL
        INC A
        NEG A
        MOV AL, TEMP_B
        SUB AL, A
        
        ; PRINT THE VALUE WITH MESSAGE
        
        LEA DX, MSG5
        MOV AH, 9
        INT 21H
        MOV AH, 2
        INT 21H 
        
        ; DOS EXIT
        
        MOV AH, 4CH
        INT 21H 
        
    MAIN ENDP
END MAIN