; UVA 11121 - "BASE -2" SOLUTION

.MODEL SMALL

.STACK 100H

.DATA
    TESTCASES DW ?
    
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        XOR BX, BX
        
        MOV AH, 1
        INT 21H
        
        LOOP_TO_TAKE_INPUT:
            CMP AL, '0'
            JNGE NOT_DIGIT
            CMP AL, '9'
            JNLE NOT_DIGIT
            
            ; CHARACTER TO INTEGER
            AND AX, 000FH
            MOV TESTCASES, AX
            
            ; TOTAL = TOTAL*10 + DIGIT
            MOV AX, 10
            MUL BX
            ADD TESTCASES, AX
            MOV BX, TESTCASES
            
            MOV AH, 1
            INT 21H
            CMP AL, 0DH
            JNE LOOP_TO_TAKE_INPUT
            
            MOV TESTCASES, BX
            JMP EXIT
            
        NOT_DIGIT:
            MOV AH, 2
            MOV DL, 0DH
            INT 21H
            MOV DL, 0AH
            INT 21H
            JMP LOOP_TO_TAKE_INPUT
            
            
        EXIT:
            MOV AH, 2
            MOV DL, 0DH
            INT 21H
            MOV CL, 0AH
            INT 21H
            
        START:
            MOV TOTAL, 0
            MOV 