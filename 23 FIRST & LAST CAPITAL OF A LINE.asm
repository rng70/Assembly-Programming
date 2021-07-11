; THIS PROGRAM TAKES A LINE AS INPUT 
; AND TELLS THE FIRST AND LAST CAPITAL LETTER

.MODEL SMALL

.STACK 100H

.DATA 
    FOUND_FIRST DB ?
    FOUND_LAST DB ?
    MSG DB 'TYPE A LINE OF TEXT: $'
    MSG_NO_CAP DB 0AH, 0DH, 'NO CAPITAL LETTER FOUND$'
    MSG_TO_SHOW_OUTPUT DB 0AH, 0DH, 'FIRST CAPITAL = '
    FIRST DB ?, 0AH, 0DH, 'LAST CAPITAL = ',
    LAST DB ?, "$"
    
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        MOV AH, 9
        LEA DX, MSG
        INT 21H
        
        MOV FOUND_FIRST, 0
        MOV AH, 1
        
        WHILE:
            INT 21H
            CMP AL, 0DH
            JE EXIT_WHILE
            
            CMP AL, 'A'
            JNGE WHILE
            CMP AL, 'Z'
            JNLE WHILE
            
            CMP FOUND_FIRST, 1
            JNE F_FIRST
            
            MOV LAST, AL
            MOV FOUND_LAST, 1
            JMP WHILE
            
        F_FIRST:
            MOV FOUND_FIRST, 1
            MOV FIRST, AL
            JMP WHILE
            
        EXIT_WHILE:
            CMP FOUND_FIRST, 1
            JNE FALSE_FIRST
            JMP FALSE_LAST
            
        FALSE_FIRST:
            MOV FIRST, '-'
            JMP FALSE_LAST_2
            
        FALSE_LAST:
            CMP FOUND_LAST, 1
            JNE LAST_NOT_FOUND
            
        FALSE_LAST_2:
            CMP FOUND_LAST, 1
            JNE NO_OUTPUT
            JMP OUTPUT_MSG
            
        LAST_NOT_FOUND:
            MOV LAST, '-'
            JMP OUTPUT_MSG
            
        NO_OUTPUT:
            MOV AH, 9
            LEA DX, MSG_NO_CAP
            INT 21H
            JMP DOS
        OUTPUT_MSG:     
            MOV AH, 9
            LEA DX, MSG_TO_SHOW_OUTPUT
            INT 21H
        
        ; RETURN TO DOS
        DOS:
            MOV AH, 4CH
            INT 21H

    MAIN ENDP
END MAIN    