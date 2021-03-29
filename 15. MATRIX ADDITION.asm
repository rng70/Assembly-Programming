
; THIS SIMPLE PROGRAM IS FOR ADDING TWO 2x2 MATRIX
; IF TWO 2x2 MATRIX IS PROVIDED THEN IT CALCULATE THEIR SUR
; FOR EXAMPLE IF
                ; 2 -1               ; 1 0
                           ; AND 
                ; 1 -2               ; 0 1
                
                ; IS  GIVEN THEN IT SHOW THE FOLLOWIN RESLUT
                
                ; 2 -1     ; 1 0    ; 3 -1      
                ; 1 -2  +  ; 0 1  = ; 1 -1

.MODEL SMALLL

.STACK 100H

.DATA  
    SIZE DW 2
    ROW DW 2
    COL DW 2
    CURRENT_MATRIX DB ?

    MATRIX1 DW 2 DUP (?) 
            DW 2 DUP (?)

    MATRIX2 DW 2 DUP (?)
            DW 2 DUP (?)
    
    RESULT DW 2 DUP (?)
           DW 2 DUP (?)
    
    CLEAR DB 0AH, 0DH, '$'
    MSG1 DB ' ENTER FIRST MATRIX:  ', 0AH, 0DH, '$'
    MSG2 DB 0AH, 0DH, ' ENTER SECOND MATRIX: ', 0AH, 0DH, '$'
    MSG3 DB 0AH, 0DH, ' RESULTANT MATRIX IS: ', 0AH, 0DH, '$'
    
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
    
    OUTPUTMATRIX PROC
        ; STORE REGISTERS
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV CX, ROW
        MOV SI, 0
        
        @ROW:
            MOV BX, 0
            @COL:
                CMP BX, 4
                JE END_PRINTING_OUTPUT
                
                MOV AX, RESULT[SI+BX]
                CALL OUTDEC
                
                MOV DL, ' '
                MOV AH, 2
                INT 21H
            
                ADD BX, 2
                JMP @COL 
                END_PRINTING_OUTPUT:
                    ADD SI, 4
                    
                    ; PRINT A NEW LINE HERE
                    PUSH AX
                    PUSH BX
                    PUSH CX
                    PUSH DX
                    
                    LEA DX, CLEAR
                    MOV AH, 9
                    INT 21H
                    
                    POP DX
                    POP CX
                    POP BX
                    POP AX
                    
                    LOOP @ROW
            
        ; RESTORE REGISTERS
        POP DX
        POP CX
        POP BX
        POP AX
        
        RET
    OUTPUTMATRIX ENDP
    
    INPUTMATRIX PROC
        ; STORE REGISTERS  
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        ; CHECK HOW MANY TIMES INPUT TO TAKE
        MOV CX, ROW
        MOV SI, 0
        
        @@ROW:
            MOV BX, 0
            @@COL:
                MOV AX, 4
                CMP BX, AX
                JE END_TAKING_INPUT
                CALL INDEC
                
                CMP CURRENT_MATRIX, 2
                JE @MATRIX2
                
                MOV MATRIX1[SI+BX], AX
                JMP @NEXT
                
                @MATRIX2:
                    MOV MATRIX2[SI+BX], AX
                @NEXT:
                    ADD BX, 2
                    JMP @@COL
                END_TAKING_INPUT:
                    ADD SI, 4
                    
                    ; PRINT A NEW LINE HERE
                    PUSH AX
                    PUSH BX
                    PUSH CX
                    PUSH DX
                    
                    LEA DX, CLEAR
                    MOV AH, 9
                    INT 21H
                    
                    POP DX
                    POP CX
                    POP BX
                    POP AX
                    
                    LOOP @@ROW     
        POP DX
        POP CX
        POP BX
        POP AX
        ; RESTORE REGISTERS FINISHED
        RET
    INPUTMATRIX ENDP
    
    MATRIXADDITION PROC
        ; STORE REGISTERS
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV CX, ROW
        MOV SI, 0
        
        @ROW1:
            MOV BX, 0
            @COL1:
                MOV AX, COL
                IMUL SIZE
                CMP BX, AX
                JE END_COL
                
                MOV AX, MATRIX1[SI+BX]
                ADD AX, MATRIX2[SI+BX]
                
                MOV RESULT[SI+BX], AX
                
                ADD BX, 2
                JMP @COL1
            END_COL:
                ADD SI, 4  
                LOOP @ROW1
             
        ; RESTORE REGISTERS
        POP DX
        POP CX
        POP BX
        POP AX
        
        RET
    MATRIXADDITION ENDP
    
    
    MAIN PROC
        ; INITIALIZE DS
        MOV AX, @DATA
        MOV DS, AX
        
        LEA DX, MSG1
        MOV AH, 9
        INT 21H
    
        MOV CURRENT_MATRIX, 1
        CALL INPUTMATRIX
    
        LEA DX, MSG2
        MOV AH, 9
        INT 21H
   
        MOV CURRENT_MATRIX, 2
        CALL INPUTMATRIX
        
        ; CALL MATRIX ADDITION IN THIS POSITION
        CALL MATRIXADDITION 
    
        LEA DX, MSG3
        MOV AH, 9
        INT 21H
    
        CALL OUTPUTMATRIX   
    
        ; DOS EXIT
        MOV AX, 4CH
        INT 21H
    MAIN ENDP
END MAIN
    
    