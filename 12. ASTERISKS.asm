
; A SIMPLE PROGRAM TO DISPLAY A 10x10 SOLID BOX OF ASTERISKS


.MODEL SMALL

.DATA
    
    ASTERISKS DB 0AH, 0DH, "**********$"

.CODE
    
    MAIN PROC   
        
        ; INITIALIZE DATA SEGMENT
        MOV AX, @DATA
        MOV DS, AX               
        
        MOV AH, 9
        LEA DX, ASTERISKS
        
        ; DISPLAY 10 TIMES
        
        INT 21H
        INT 21H
        INT 21H
        INT 21H
        INT 21H
        INT 21H
        INT 21H
        INT 21H
        INT 21H
        INT 21H
        
        ; DOS EXIT
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
    
END MAIN        