
; GIVEN THERE NUMBERS 
; PRINT THE SECOND MAXIMUM NUMBER 

; INPUT FORMAT: 
;               NUMBER_1,NUMBER_2,NUMBER_3
 
; NO SPACE BETWEEN TWO NUMBERS IN INPUT FORMAT


.MODEL SMALL

.STACK 100H


.DATA
      CR EQU 0DH
      LF EQU 0AH
      
      X DB ?
      Y DB ?
      Z DB ?
      SECOND_HIGHEST_NUMBER DB ?
      SAME_VALUE DB ? 
                                     
      MSG DB 'ENTER THE NUMBERS: $'
      MSG1 DB CR, LF, 'THE SECOND MAXIMUM IS: $'
      EQL_MSG DB CR, LF, 'ALL NUMBERS ARE SAME$'
      
.CODE
    
    MAIN PROC
        
        ; DATA SEGMENT INITIALIZATION
            MOV AX, @DATA
            MOV DS, AX
        
        ; PRINT THE MESSAGE ON CONSOLE TO TAKE INPUT 
            LEA DX, MSG
            MOV AH, 9
            INT 21H
            
        ; TAKING INPUT EVERY TIME USING (AH, 1) INSTEAD OF USING LOOP             
            MOV AH, 1                   
            INT 21H   
            
        ; MOVE THE VALUE TO X   
            MOV X, AL
            ;MOV AH, 1
            INT 21H
            ;MOV AH, 1
            INT 21H   
            
        ; MOVE THE VALUE TO Y
            MOV Y, AL
            ;MOV AH, 1
            INT 21H
            ;MOV AH, 1
            INT 21H   
            
        ; MOVE THE VALUE TO Z
            MOV Z, AL
            
            JMP FIND_SECOND_MIN
        
        ; CALL FIND_SECOND_MIN TO FIND ANS
        
        FIND_SECOND_MIN:
            ; COMPARE X AND Y FIRST
            
            MOV AL, X
            CMP AL, Y
            
            ; X EQUAL TO Y (X == Y)
            JE EQUAL      
            
            ; X GREATER THAN Y (X > Y)
            JG GREATER 
            
            ; X LESS THAN Y (X < Y)
            JL SMALLER          
                      
        EQUAL:
            CMP AL, Z 
            
            ; X GREATER THAN Z ( X==Y>Z )
            JG PRINT_Z                   
            
            ; X EQUAL TO Z ( X==Y==Z )
            JE PRINT_EQUAL            
            
            ; X LESS THAN Z ( X==Y<Z )
            JL PRINT_X
            
        GREATER:
            CMP AL, Z
            
            ; X EQUAL TO Z ( X==Z>Y )   
            JE PRINT_Y
            
            ; X LESS THAN Z ( Z>X>Y ) 
            JL PRINT_X 
            
            ; X GREATER THAN Z ( X>Y AND X>Z )
            JG COMPARE_Y_Z
            
        SMALLER:
            CMP AL, Z
            
            ; X LESS THAN Z ( X<Y AND X<Z )
            JL COMPARE_Y_Z_2
            
            ; X EQUAL TO Z ( X==Z<Y )
            JE PRINT_X
            
            ; X GREATER THAN Z ( Y>X>Z )
            JG PRINT_X
        
        COMPARE_Y_Z:
            MOV AL, Y
            CMP AL, Z
            
            ; Y GREATER THAN Z ( X>Y>Z )
            JG PRINT_Y
            
            ; Y LESS THAN Z
            JL PRINT_Z 
            
            ; Y EQUAL TO Z
            JE PRINT_Z
            
        COMPARE_Y_Z_2:
            MOV AL, Y
            CMP AL, Z
            
            ; Y GREATER THAN Z ( X<Z<Y )
            JG PRINT_Z
            
            ; Y LESS THAN Z
            JL PRINT_Y 
            
            ; Y EQUAL TO Z
            JE PRINT_X
            
        PRINT_X:
            LEA DX, MSG1
            MOV AH, 9
            INT 21H
            MOV DL, X
            MOV AH, 2
            INT 21H
            JMP JUMP_END
        PRINT_Y:
            LEA DX, MSG1
            MOV AH, 9
            INT 21H
            MOV DL, Y 
            MOV AH, 2
            INT 21H
            JMP JUMP_END
        PRINT_Z:
            LEA DX, MSG1
            MOV AH, 9
            INT 21H
            MOV DL, Z
            MOV AH, 2
            INT 21H
            JMP JUMP_END
        PRINT_EQUAL:
            LEA DX, EQL_MSG
            MOV AH, 9
            INT 21H
            
                        
                        
        JUMP_END:    
            ; DOS INTERRUPT AND EXIT
            MOV AH, 4CH 
            INT 21H
    
    MAIN ENDP
END MAIN
              
        
      
       






