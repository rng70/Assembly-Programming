
; THIS SIMPLE PROGRAM READ THREE VALUE A PRINT THEM IN THE MIDDLE OF 
; 11x11 BOS OF ASTERISKS
; THE BEEP THE COMPUTER

; SUPPOSE THE INITIALS ARE A A T
; THE THE OUTPUT WILL BE 

     ; ***********
     ; ***********
     ; ***********
     ; ***********
     ; ***********
     ; *** AAT ***
     ; ***********
     ; ***********
     ; ***********
     ; ***********
     ; ***********


.MODEL SMALL

.DATA 
                 
    MSG DB "ENTER THE INITIALS", 0AH, 0DH, '$' 
    STARS DB '***********', 0AH, 0DH, '$'
    MID DB "*** "
    C1 DB ?
    C2 DB ?
    C3 DB ?, ' ***', 0AH, 0DH, "$"
    
.CODE 
    MAIN PROC
        
        ; INITIALIZE DATA SEGMENT
        MOV AX, @DATA
        MOV DS, AX
                  
        ; PRINT THE MESSAGE
        LEA DX, MSG
        MOV AH, 9
        INT 21H
        
        ; TAKE INPUT          
        MOV AH, 1
        INT 21H
        MOV C1, AL
        INT 21H
        MOV C2, AL
        INT 21H
        MOV C3, AL
         
        ; CARRIAGE RETURN TO CURRENT LINE 
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        
        ; DISPLAY FIRST 5 LINES OF ASTERISKS
        
        MOV AH, 9
        LEA DX, STARS
        INT 21H
        INT 21H
        INT 21H
        INT 21H
        INT 21H
        
        ; PRINT THE MID VALUE
        LEA DX, MID          
        INT 21H
        
        ; DISPLAY SECOND 5 LINES OF ASTERISKS
        LEA DX, STARS
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