; PRINT A TRIANGLE OF NUMBER

;       1
;       1 2
;       1 2 3
;       1 2 3 4
;       1 2 3 4 5
;       1 2 3 4 5 6
;       1 2 3 4 5 6 7
;       1 2 3 4 5 6 7 8
;       1 2 3 4 5 6 7 8 9


.MODEL SMALL

.STACK 100H   

.DATA

    MSG DB ' $'

.CODE
    MAIN PROC
        ; INITIALIZATION
        MOV AX, @DATA
        MOV DS, AX
        
        MOV CL, 1 ; I = 1
        MOV BL, 9 ; N = 9
        
        LOOP1:
            MOV AH, 2
            MOV DL, '1'
            MOV BH, 1 ; J = 1
        
        LOOP2:
            INT 21H
            
            ; PRINT MSG
            LEA DX, MSG
            MOV AH, 9
            INT 21H
            
            MOV AH, 2
            INC DL
            INC BH
            CMP BH, CL
            JNG LOOP2
            
            MOV AH, 2
            MOV DL, 0DH
            INT 21H
            MOV DL, 0AH
            INT 21H
        
            INC CL
            CMP CL, BL
            JNG LOOP1
            
        ; RETURN TO DOS
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
        