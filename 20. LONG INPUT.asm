; TAKING INPUT UNTIL ' '(EMPTY CHARACTER) NOT FOUND

.MODEL SMALL

.STACK 100H

.CODE
    MAIN PROC
        MOV AH, 1
        
        LOOP_TO_TAKE_INPUT:
            INT 21H
            
            MOV AH, 2
            MOV DL, AL
            INT 21H
            MOV AH, 1
            
            CMP AL, ' '
            JNE LOOP_TO_TAKE_INPUT
    ; RETURN TO DOS
    MOV AH, 4CH
    INT 21H
            
    MAIN ENDP
END MAIN