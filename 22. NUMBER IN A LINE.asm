; PROGRAM TO COUNT NUMBER OF CHARACTERS IN A INPUT LINE

.MODEL SMALL

.STACK 100H

.DATA 
     CR EQU 0DH
     MSG DB 0AH, 0DH, "COUNT: $"
     INPUT_MSG DB 0AH, 0DH, "ENTER INPUTS: $"
     
.CODE
    MAIN PROC
        
        ; INITIALIZE DATA SEGMENT
        MOV AX, @DATA
        MOV DS, AX
        
        ; INPUT
        MOV AH, 9
        LEA DX, INPUT_MSG
        INT 21H
        MOV AH, 1
        INT 21H
        
        ; COUNTER INITIALIZE
        MOV CX, '0'
        
        LOOP_TO_COUNT:
            CMP AL, CR
            JE END_COUNT
            
            INC CX
            INT 21H
            JMP LOOP_TO_COUNT
            
        END_COUNT:
            MOV AH, 9
            LEA DX, MSG
            INT 21H            
            
            MOV AH, 2
            MOV DX, CX
            INT 21H
            
        ; RETURN TO DOS
        MOV AH, 4CH
        INT 21H
    MAIN ENDP
END MAIN