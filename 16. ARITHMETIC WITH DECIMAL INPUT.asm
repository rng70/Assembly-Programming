
; THIS SIMPLE PROGRAM TAKE A MULTI DIGIT NUMBER AS INPUT 
; AND SHOW IT AS OUTPUT IN DECIMAL


.MODEL SMALL

.STACK 100H

.DATA
    CLR DB 0AH, 0DH, '$' 
    MSG DB 0AH, 0DH, '  ENTER THE NUMBERS ' , 0AH, 0DH, '$'
    MSG1 DB 0AH, 0DH, '  RESULT IS: $' 
    OPERAND1 DW ?
    OPERAND2 DW ?
    RESULT DW ?
    OPERATOR_VALIDITY DB ?
    INVALID_MSG DB 0AH, 0DH, "  UNKNOWN OPERATION FOUND. DON'T KNOW "
    OPERATOR DW ?, " SIGN $"
    CONTINUE DB 0AH, 0DH, 0AH, 0DH, "  CONTINUE? (enter 'Q'|'q' to quit) : $"
    WRONG_OPERATOR DB 0AH, 0DH, "  Wrong operator $"

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
    
    DO_ARITHMETIC PROC
        
        CMP CX, '+'
        JE @ADDITION
        CMP CX, '-'
        JE @SUBTRACTION
        CMP CX, '*'
        JE @MULTIPLY
        CMP CX, '/'
        JE @DIVISION   
     
     @ADDITION:
        ADD AX, BX
        MOV RESULT, AX
        RET  
        
     @SUBTRACTION:
        SUB AX, BX
        MOV RESULT, AX
        RET
        
     @MULTIPLY:
        IMUL BX 
        MOV RESULT, AX
        RET
        
     @DIVISION:
        CWD
        IDIV BX
        MOV RESULT, AX
        RET
        
    DO_ARITHMETIC ENDP
    
    CHECK_OPERATOR_VALIDITY PROC
        CMP CX, '+'
        JE @VALID_OPERATOR
        CMP CX, '-'
        JE @VALID_OPERATOR
        CMP CX, '*'
        JE @VALID_OPERATOR
        CMP CX, '/'
        JE @VALID_OPERATOR
        
        JMP @INVALID_OPERATOR
         
     @INVALID_OPERATOR:
        MOV AL, 'F'
        MOV OPERATOR_VALIDITY, AL
        RET
     @VALID_OPERATOR:
        MOV AL, 'Y'
        MOV OPERATOR_VALIDITY, AL
        RET
    CHECK_OPERATOR_VALIDITY ENDP
    
    CLEAR PROC
          ; GO TO NEXT LINE
            LEA DX, CLR
            MOV AH, 9
            INT 21H
            RET
    CLEAR ENDP
    
    lDASH PROC
        MOV AH, 2
        MOV DL, '['
        INT 21H
        RET
    lDASH ENDP
    
    rDASH PROC
        MOV AH, 2
        MOV DL, ']'
        INT 21H
        RET
    rDASH ENDP    
                
    MAIN PROC
        
        ; INITIALIZE DS
        MOV AX, @DATA
        MOV DS, AX
                             
        ; PRINT THE MESSAGE 
        @FIRST: 
            LEA DX, MSG
            MOV AH, 9
            INT 21H
                            
            ; CALL THE PROCEDURE
            CALL INDEC
            MOV OPERAND1, AX
            
            CALL CLEAR
        
            ; OPERATOR INPUT
            MOV AH, 1
            INT 21H
            MOV AH, 0
            MOV OPERATOR, AX
            MOV CX, OPERATOR
            
            ; CHECK IF 'Q' OR 'q'
            CMP OPERATOR, 'Q'
            JE @DOS_EXIT
            CMP OPERATOR, 'q'
            JE @DOS_EXIT
            
            CALL CHECK_OPERATOR_VALIDITY
            CMP OPERATOR_VALIDITY, 'F'
            JE @EXIT_PROGRAM
            
            CALL CLEAR
        
            ; CALL THE INPUT PROCEDURE AGAIN
            CALL INDEC
            MOV OPERAND2, AX
                          
            MOV AX, OPERAND1
            MOV BX, OPERAND2
            MOV CX, OPERATOR
                             
            CALL DO_ARITHMETIC
        
            CALL CLEAR 
          
            ; PRINT THE MESSAGE  
            LEA DX, MSG1
            MOV AH, 9
            INT 21H
        
            CALL lDASH
            MOV AX, OPERAND1
            CALL OUTDEC
            CALL rDASH
        
            MOV DX, OPERATOR
            MOV AH, 2
            INT 21H
                  
            CALL lDASH
            MOV AX, OPERAND2
            CALL OUTDEC
            CALL rDASH
         
            MOV AH, 2 
            MOV DL, '='
            INT 21H
        
            CALL lDASH
            MOV AX, RESULT
            CALL OUTDEC
            CALL rDASH
            JMP @CONTINUE_PROGRAM
        
        @EXIT_PROGRAM:
            LEA DX, WRONG_OPERATOR
            MOV AH, 9
            INT 21H
            JMP @DOS_EXIT
        
        @CONTINUE_PROGRAM:    
            LEA DX, CONTINUE
            MOV AH, 9
            INT 21H
            MOV AH, 1
            INT 21H
            
            CMP AL, 'Q'
            JE @DOS_EXIT
            CMP AL, 'q'
            JE @DOS_EXIT
            JNE @FIRST
        
        ; DOS EXIT
        @DOS_EXIT: 
            MOV AH, 4CH
            INT 21H
        
   MAIN ENDP
END MAIN