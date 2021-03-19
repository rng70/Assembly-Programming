
; THIS PROGRAM ADD TO NUMBER A AND B
; AND STORE THEM IN SUM 
; AND THEN PRINT THE SUMMATION


.MODEL SMALL

.STACK 100H

.DATA
    A DW 2
    B DW 5
    SUM DW ?
    
    MSG DB 'THE SUM IS: $'
    
.CODE 

    MAIN PROC
        
        ; INITIALIZE DATA SECGENT  
        
        MOV AX, @DATA
        MOV DS, AX
        
        ; ADD THE NUMBERS 
                     
        MOV AX, A
        ADD AX, B 
        ADD AX, 30H
        MOV SUM, AX
        
        
        ; PRINT THE SUM
        LEA DX, MSG
        MOV AH, 9
        INT 21H
        MOV DX, SUM
        MOV AH, 2
        INT 21H
        
        ; EXIT TO DOS
        MOV AX, 4C00H
        INT 21H
          
      MAIN ENDP
    END MAIN