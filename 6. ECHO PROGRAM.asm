
; READ A CHARACTER AND DISPLAY IN NEXT LINE


.MODEL SAMLL


.STACK 100H

.CODE
    MAIN PROC
        
        ; DISPLAY ? SIGN 
        
        MOV AH, 2
        MOV DL, '?'
        INT 21H
        
        ; INPUT A CHARACTER
        
        MOV AH, 1
        INT 21H
        MOV BL, AL
        
        ; GO TO A NEW LINE
        
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        
        ; DISPLAY THE CHARACTER
        MOV DL, BL
        INT 21H
        
        ; DOS INTERRUPT
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
 END MAIN