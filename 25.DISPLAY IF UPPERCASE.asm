; PROGRAM TO DISPLAY A CHARACTER IF UPPER CASE
.MODEL SMALL

.STACK 100H

.DATA
    VAR1 DB ?
    MSG1 DB 'ENTER A CHARACTER : $'
    MSG2 DB ' IS UPPERCASE.$'
    
.CODE
    MAIN PROC
        ; INITIALIZE DS
        MOV AX, @DATA
        MOV DS, AX
        
        ; PRINT MSG1
        LEA DX, MSG1
        MOV AH, 9
        INT 21H
        
        ; TAKE INPUT
        MOV AH, 1
        INT 21H
        MOV VAR1, AL
        
        ; CHECK IF UPPERCASE (BETWEEN A & Z)
        CMP VAR1, 'A'
        JNGE END_IF
        CMP VAR1, 'Z'
        JNLE END_IF
        
        ; DISPLAY CHARACTER 
        ; PRINT NEWLINE
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        
        ; PRINT VAR1
        MOV DL, VAR1 
        MOV AH, 2
        INT 21H
        LEA DX, MSG2
        MOV AH, 9
        INT 21H
        
        END_IF: 
            ; RETURN TO DOS
            MOV AH, 4CH
            INT 21H
    MAIN ENDP
END MAIN
        