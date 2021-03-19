

; READ A ASCII CHARACTER A-F
; THEN DISPLAY AS DECIMAL 

; ASCII OF A-F IS 41H-46H
; ASCII OF 0 IS 30H
; THE DIFFERENCE IS 11H
; SO WHEN WE SUBTRACT 11H FROM THE INPUT DIGIT WE GOT THE LAST DIGIT EQUIVALENT 
; TO IT'S DECIMAL REPRESENTATION
; SO IN MSG2 WE ADDED A 1 BEFORE PRINTING THE VALUE
; THAT'S GIVES US THA RESULT

    ; ASCII OF A --> 41H
    ; SUBTRACT   --> 11H
    
    ;--------------------
    
    ; RESULT     --> 30H
    
    ; ASCII OF 0 --> 30H
                        
    ; ADDING A '1' BEFORE THE RESULT WE HAVE 10                    
    ; WHICH IS EQUIVALENT OF A AS A=10H
    ; SO WE INCLUDED '1' IS THE SECOND MESSAGE



.MODEL SMALL

.STACK 100H

.DATA
    MSG DB 'ENTER A HEX DIGIT: $'
    MSG2 DB 0AH, 0DH, 'IN DECIMAL IT IS 1'
    
    C1 DB ?, '$'
    
.CODE 
    MAIN PROC
        
        ; INITIALIZE DS
        
        MOV AX, @DATA
        MOV DS, AX
        
        ; DISPLAY THE MESSAGE
        MOV AH, 9
        LEA DX, MSG
        INT 21H
        
        ; TAKE INPUT
        MOV AH, 1
        INT 21H
        
        SUB AL, 11H
        
        ; STORE
        MOV C1, AL
        
        MOV AH, 9
        LEA DX, MSG2
        INT 21H
        
        ; DOS EXIT
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
    
END MAIN