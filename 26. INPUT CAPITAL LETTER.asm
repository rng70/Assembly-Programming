.MODEL SMALL

.STACK 100H

.DATA
    
    MSG DB 0AH, 0DH, 'WRONG INPUT GIVEN$'
    
.CODE
    MAIN PROC
        MOV AX, @DATA  
        MOV DS, AX
    
        ;TAKING INPUT
        MOV AH,1
        INT 21H
    
        CMP AL,'A'
        JNGE EXIT_
        CMP AL,'Z'
        JNBE EXIT_
    
        JMP RESULT
    
        EXIT_:
    
            LEA DX, MSG
            MOV AH, 9
            INT 21H
    
            MOV AH,4CH
            INT 21H 
    
        RESULT:
            MOV AH, 2
            MOV DL, 0DH
            INT 21H
            MOV DL, 0AH
            INT 21H   
        
        MOV DL,AL
        INT 21H
        
      MOV AH,4CH
      INT 21H       
    MAIN ENDP
END MAIN