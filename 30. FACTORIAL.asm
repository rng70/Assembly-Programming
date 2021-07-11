; THIS PROGRAM SHOW OUTPUT OF FACTORIAL N(n!)

.MODEL SMALL

.STACK 100H

.CODE    
    MAIN PROC
        MOV AL, 4 ; FACTORIAL OF 3
        MOV AH, 2
        MOV BL, 1 ; HOLDS THE VALUE OF n!
        MOV BH, 2
        
        LOOP1:
            MOV BH, AL
            INC BH
            MOV CL, 1
            JNE LOOP2
            JMP EXIT
            
        LOOP2:
            ADD BL, BL
            INC CL
            CMP CL, BH
            JNG LOOP2
            MOV BL, BH
            INC AH
            CMP AH, AL
            JNG LOOP1
        EXIT:      
            MOV AH, 2
            MOV DL, BL
            ; ADD DL, '0'
            INT 21H
        
        ; RETURN TO OS
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
END MAIN