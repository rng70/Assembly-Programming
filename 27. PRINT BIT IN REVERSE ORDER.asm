; THIS PROGRAM PRINT BIT(BInary digiT) IN REVERSE ORDER

.MODEL SMALL

.STACK 100H

.DATA
    BIT DB ?
    
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        MOV CX, 7
        MOV BL, 1101101B
        
        PRINT_BIT_LOOP:
            MOV BIT, BL
            SHR BL, 1
            AND BIT, 1B
            ADD BIT, 48
            
            MOV AH, 2
            MOV DL, BIT
            INT 21H
            LOOP PRINT_BIT_LOOP
            
    ; RETURN TO OS
    MOV AH, 4CH
    INT 21H
        
    MAIN ENDP
END MAIN