
; THIS ASSEMBLY PROGRAM IS FOR CHECKING VALID PASSWORD

; A PASSWORD IS VALID WHEN IT FITS THE FOLLOWING CRITERIA

        ; AT LEAST:
            ; 1. ONE UPPERCASE LETTER ( ascii: 41H-5AH )
            ; 2. ONE LOWERCASE LETTER ( ascii: 61H-7AH )
            ; 3. AT LEAST ONE DIGIT ( ascii: 30H-39H )   
            
; SCANNING FOR INPUT IS TERMINATED WHEN A ASSCII VALUE IS FOUND OUTSIDE THE RANGE ( 21H-7EH )
            
.MODEL SMALL

.STACK 100H

.DATA
    VALID_UPPERCASE DB 0H
    VALID_LOWERCASE DB 0H
    VALID_DIGIT DB 0H
    
    CR EQU 0DH
    LF EQU 0AH
    
    MSG DB 'ENTER THE PASSWORD: $'
    VALID_PASS_MSG DB CR, LF, 'Valid Password$'
    INVALID_PASS_MSG DB CR, LF, 'Invalid Password$'

.CODE
    MAIN PROC      
        
        ; DATA SEGMENT INITIALIZATION
        MOV AX, @DATA
        MOV DS, AX
        
        ; LOOP FOR TAKING INPUT UNTIL A UNACCEPTABLE CHARACTER IS FOUND
        
        LEA DX, MSG
        MOV AH, 9
        INT 21H
        DO_LOOP:
            MOV AH, 1
            INT 21H
            ;MOV CHAR, AL
                         
            ; CHECH FOR UPPERCASE LETTER
                         
            UPPERCASE:
                
                ; CHECK IF THE CHARACTER IS IN 'A-Z'
                CMP AL, 'A'                         
                
                ; IF LESS THAN 'A' THEN CHECK FOR DIGIT
                JL DIGIT 
                
                CMP AL, 'Z' 
                                          
                ; IF GREATER THAN 'Z' THEN CHECK FOR LOWERCASE LETTER
                JG LOWERCASE
                        
                ; IF IN RANGE 'A-Z' SET VALID_UPPERCASE TO 1        
                MOV DL, 1H
                MOV VALID_UPPERCASE, DL 
                JMP DO_LOOP
                
            ; CHECH FOR LOWERCASE LETTER
                         
            LOWERCASE:
                
                ; CHECK IF THE CHARACTER IS IN 'A-Z'
                CMP AL, 'a'                         
                
                ; IF LESS THAN 'A' THEN CHECK FOR DIGIT
                JL DIGIT 
                
                CMP AL, 'z' 
                                          
                ; IF GREATER THAN 'Z' THEN CHECK FOR LOWERCASE LETTER
                JG OTHERS
                        
                ; IF IN RANGE 'A-Z' SET VALID_UPPERCASE TO 1        
                MOV DL, 1H
                MOV VALID_LOWERCASE, DL 
                JMP DO_LOOP
            
            ; CHECK FOR VALID DIGIT  
            
            DIGIT:
            
                ; IF IT IS IN RANCE '0-9'    
                CMP AL, '0'
                JL OTHERS
                CMP AL, '9'
                JG OTHERS
                MOV DL, 1H
                MOV VALID_DIGIT, DL
                JMP DO_LOOP
            
            ; CHECK FOR AT LEAST THE CHARACTER IS VALID
            OTHERS:
                CMP AL, 21H
                JL CHECK_VALIDITY
                CMP AL, 7EH
                JG CHECK_VALIDITY
                JMP DO_LOOP
       
        ; AFTER SCANNING THE PASSWORD SUCCESSFULLY CHECK PASSWORD VALIDITY         
        CHECK_VALIDITY:                                                  
                
            ; CHECK IF VALID_UPPERCASE IS NOT '0H'
            CMP VALID_UPPERCASE, 0H
            JE INVALID_PASSWORD  
            
            ; CHECK IF VALID_UPPERCASE IS NOT '0H'
            CMP VALID_LOWERCASE, 0H
            JE INVALID_PASSWORD
            
            ; CHECK IF VALID_UPPERCASE IS NOT '0H'
            CMP VALID_DIGIT, 0H
            JE INVALID_PASSWORD
            
            ; AT THAT POINT PASSWORD IS VALID
            JMP VALID_PASSWORD
        
        ; SHOW MESSAGE FOR INVALID PASSWORD
        INVALID_PASSWORD:
            LEA DX, INVALID_PASS_MSG
            MOV AH, 9
            INT 21H
            JMP DOS_INTERRUPT_EXIT
        
        ; SHOW MESSAGE FOR VALID PASSWORD 
        VALID_PASSWORD:
            LEA DX, VALID_PASS_MSG
            MOV AH, 9
            INT 21H
                
         
        ; DOS INTERRUPT WITH EXIT AND GIVE CONTROL TO OPERATING SYSTEM
        DOS_INTERRUPT_EXIT:
            MOV AH, 4CH
            INT 21H
        
    MAIN ENDP
END MAIN       
            
        