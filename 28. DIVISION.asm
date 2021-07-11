.MODEL SMALL

.STACK 100H

.DATA
    NEWLINE DB 0DH,0AH,"$"

.CODE 
    MAIN PROC
    
        MOV AX, @DATA
        MOV DS, AX 
            
        MOV CL, 0D
        MOV AX, 56
        MOV BX, 10
        MOV DX, BX
   
        WHILE:
            CMP AX, BX
            JL END_WHILE
            INC CL
            SUB AX, BX
            JMP WHILE
                
        END_WHILE:
            ; DISPLAYS THE REMAINDER
            ADD AL, 48
            MOV AH, 2
            MOV DL, AL
            INT 21H
        
            ; CODE FOR NEW LINE
            MOV AH, 9
            LEA DX, NEWLINE
            INT 21H
        
            MOV AH, 2
            ADD CL, 48
            MOV DL, CL
            INT 21H

        MOV AH, 4CH
        INT 21H
   
    MAIN ENDP
END MAIN