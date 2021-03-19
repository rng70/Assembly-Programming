
; THIS IS A SIMPLE PROGRAM TO CONVERT A LOWERCASE LETTER 
; TO AN UPPERCASE LETTER

           
.MODEL SMALL

.STACK 100H


.DATA
    CR EQU 0DH
    LF EQU 0AH
    
    LET DB ?
    
    MSG DB 'ENTER THE LOWERCASE LETTER: $'
    MSG1 DB CR, LF, 'IN UPPERCASE: $'  
    
 .CODE
    MAIN PROC 
      
      ; INITIALIZE DS
      
      MOV AX, @DATA
      MOV DS, AX
      
      ; PRINT THE MESSAGE
      
      LEA DX, MSG
      MOV AH, 9
      INT 21H
      
      ; TAKE INPUT
      
      MOV AH, 1
      INT 21H
      
      ; CONVERT THE LETTER 

      SUB AL, 20H
      MOV LET, AL
      
      ; PRINT THE MESSAGE
      
      LEA DX, MSG1
      MOV AH, 9
      INT 21H
      
      ; PRINT THE LETTER
      MOV DL, LET
      MOV AH, 2
      INT 21H
      
      ; DOS EXIT
      MOV AH, 4CH
      INT 21H
      
    ; END MAIN PROC                   
    MAIN ENDP
    
END MAIN