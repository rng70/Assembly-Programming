
; THIS SIMPLE PROGRAM TAKE A MULTI DIGIT NUMBER N AS INPUT 
; AND PRINTS ALL THE FIBONACCI NUMBER UPTO THE N-TH FIBONACCI NUMBER


.MODEL SMALL

.STACK 100H

.DATA
    
    MSG DB 0AH, 0DH, ' ENTER THE VALUE OF N: $'
    MSG2 DB 0AH, 0DH, 0AH, 0DH, ' THE FIBONACCI SEQUENCE: ', 0AH, 0DH, '$'
    N DW ?

.CODE   

    OUTDEC PROC 
        ; PROCEDURE FOR DECIMAL OUTPUT
        ; ALGORITHM:
                    ; IF AX < 0
                    ; THEN 
                    ; PRINT A MINUS SIGN
                    ; REPLACE AX BY IT'S 2's COMPLEMENT
                    ; THEN 
                    ; GET THE DIGITS IN AX's DECIMAL REPRESENTATION
                    ; CONVERT THE DIGITS TO CHARACTERS AND PRINT 
        
        ; PRINTS AX AS A SIGNED INTEGER
            PUSH AX
            PUSH BX
            PUSH CX
            PUSH DX
                         
        ; CHECKING FOR SIGN TO PRINT
            OR AX, AX
            JGE @END_IF1
            
        ; IF AX IS LESS THAN ZERO (AX<0)
            PUSH AX
            MOV DL, '-'
            MOV AH, 2
            INT 21H
            POP AX 
            
        ; TAKE 2's COMPLEMENT
            NEG AX
        
        ; JUMP HERE
        @END_IF1:
            ; PRINT IN DECIMAL 
                ; CX COUNTS DIGITS
                XOR CX, CX       
                ; SET THE DIVISOR
                MOV BX, 10D
                
        @REPEAT:
            XOR DX, DX
            
            ; NOW DIVIDE AX BY BX 
            ; AX HAS QUOTIENT AND DX HAS REMAINDER
            DIV BX
            PUSH DX
            INC CX
                     
            ; CHECK THAT IF AX = 0         
            OR AX, AX
            JNE @REPEAT
            
            ; CONVERT THE DIGITS TO CHARACTER AND PRINT
            MOV AH, 2
            
        @PRINT_LOOP:
            POP DX
            OR DL, 30H ; CONVERTING TO CHARACTER
            INT 21H            
            LOOP @PRINT_LOOP
        
        POP DX
        POP CX
        POP BX
        POP AX
        RET
    OUTDEC ENDP
    
    INDEC PROC
        ; PROCEDURE FOR DECIMAL INPUT
        ; ALGORITHM:
                    ; TOTAL = 0
                    ; READ AN ASCII DIGIT
                    ; REPEAT
                        ; CONVERT CHARACTER TO IT's BINARY VALUE
                        ; TOTAL = TOTAL*10 + VALUE
                        ; READ A CHARACTER
                    ; UNTIL CHARACTER IS A CARRIAGE RETURN OR WHITE SPACE 
        
        @BEGIN:
            ; SAVE THE REGISTERS
            PUSH BX
            PUSH CX
            PUSH DX
        
            ; BX HOLDS TOTAL
            XOR BX, BX
        
            ; CX HOLDS SIGN
            XOR CX, CX
        
            ; CHECK THE SIGN
            MOV AH, 1
            INT 21H
        
            ; TRACK THE SIGN
            CMP AL, '-'
            JE @MINUS
            CMP AL, '+'
            JE @PLUS
            JMP @REPEAT_2
            
        @MINUS:
            MOV CX, 1
        
        @PLUS:  
            
            ; READ A CHARACTER
            INT 21H
        
        @REPEAT_2:  
        
            ; CHECKING IF IT IS >= 0
            CMP AL, 20H
            JE @EXIT
            CMP AL, 0DH
            JE @EXIT
            CMP AL, '0'
            JNGE @NOT_DIGIT
            CMP AL, '9'
            JNLE @NOT_DIGIT
            
            ; CONVERT THE CHARACTER TO DIGIT
            AND AX, 000FH
            PUSH AX
            
            ; CALCULATE THE TOTAL
            MOV AX, 10
            MUL BX
            POP BX
            ADD BX, AX
            
            ; READ AGAIN
            MOV AH, 1
            INT 21H 
            
            ;CMP AL, 0DH
            JMP @REPEAT_2
            JE @EXIT
            NEG AX
            
       @EXIT: 
            MOV AX, BX
            OR CX, CX
            JE @EXIT_1
            NEG AX 
            
       @EXIT_1:
            POP DX
            POP CX
            POP BX
            RET 
            
       @NOT_DIGIT:
            MOV AH, 1
            INT 21H
            JMP @REPEAT_2     
    INDEC ENDP
    
    FIB PROC
        PUSH BP
        MOV BP, SP
        
        CMP BX, N
        JE RETURN
        
        ADD DX, CX
        INC BX
        MOV AX, CX
        
        ; SAVE REGISTERS AND INITIALIZE PRINT
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
          
        MOV AH, 2
        MOV DL, "," 
        INT 21H
        MOV DL, ' '
        INT 21H

        POP DX
        POP CX
        POP BX
        POP AX
        
        ; RESTORE INITIALIZED DATA FINISHED
        ; CALL OUTPUT PROCEDURE TO PRINT THE CURRENT VALUE
        CALL OUTDEC
        
        ; EXCHANGE THE VALUE AT THAT POINT
        XCHG CX, DX
        CALL FIB
        RETURN:
            POP BP
            RET 
                
    MAIN PROC
        
        ; INITIALIZE DATA SEGMENT
        MOV AX, @DATA
        MOV DS, AX
                   
        LEA DX, MSG
        MOV AH, 9
        INT 21H           
        ; TAKE INPUT 
        CALL INDEC
        MOV N, AX 
        
        ; PRINT THE MESSAGE
        LEA DX, MSG2
        MOV AH, 9
        INT 21H                   
        
        ; INITIALIZE COUNTER
        MOV CX, 1
        MOV DX, 0
        MOV BX, 1
        
        MOV AX, DX 
        CALL OUTDEC
        
        CALL FIB        
        
        ; DOS EXIT
        MOV AH, 4CH
        INT 21H
        
   MAIN ENDP
END MAIN