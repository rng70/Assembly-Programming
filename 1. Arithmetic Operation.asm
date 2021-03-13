
; GIVEN TWO NUMBER X AND Y
; PRINT THE VALUE OF X-2Y
; PRINT THE VALUE OF 25-(X+Y)
; PRINT THE VALUE OF 2X-3Y
; PRINT THE VALUE OF Y-X+1





.MODEL SMALL


.STACK 100H


.DATA
    CLR EQU 0DH
    LRF EQU 0AH        
    
    X DB ?
    Y DB ?
    Z DB ?
    A DB ?
    MSG1 DB 'ENTER THE VALUE OF X: $'
    MSG2 DB CLR, LRF, 'ENTER THE VALUE OF Y: $'
    RSLT1 DB CLR, LRF, 'THE VALUE OF X-2Y IS: $'
    RSLT2 DB CLR, LRF, 'THE VALUE OF 25-(X+Y) IS: $'
    RSLT3 DB CLR, LRF, 'THE VALUE OF 2X-3Y IS: $'
    RSLT4 DB CLR, LRF, 'THE VALUE OF Y-X+1 IS: $'


.CODE

    MAIN PROC
    ;DATA SEGMENT INITIALIZATION
        MOV AX, @DATA
        MOV DS, AX
    
    ;PRINT ON CONSOLE FOR INPUT
        LEA DX, MSG1
        MOV AH, 9
        INT 21H
    
    ;TAKE INPUT FOR `X`
        MOV AH, 1
        INT 21H
        SUB AL, 30H 
        MOV X, AL
    
    ;PRINT ON CONSOLE FOR INPUT
        LEA DX, MSG2
        MOV AH, 9
        INT 21H
    
    ;TAKE INPUT FOR `Y`
        MOV AH, 1
        INT 21H
        SUB AL, 30H
        MOV Y, AL
    
    ;THIS PART IS FOR CALCULATING Z=X-2Y
    ;FIRST OF ALL COUNT THE VALUE
    
        MOV BL, X
        MOV BH, Y
        SUB BL, BH
        SUB BL, BH
        MOV Z, BL
        ADD Z, 30H 
    
    ;PRINT THE MESSAGE BEFORE PRINTING THE VALUE OF X-2Y
        LEA DX, RSLT1
        MOV AH, 9
        INT 21H
    ;PRINT THE VALUE OF X-2Y
        MOV AH, 2
        MOV DL, Z
        INT 21H
    
    ;THIS PART IS FOR CALCULATING X Z=25-(X+Y)
    ;FIRST OF ALL COUNT THE VALUE
    
        MOV BL, X
        MOV BH, Y
        ADD BL, BH
        MOV AH, 25
        MOV Z, AH
        ADD Z, 30H
        ADD BL, '0'
        SUB Z, BL
        ADD Z, 30H 
    
    ;PRINT THE MESSAGE BEFORE PRINTING THE VALUE OF Z=25-(X+Y)
        LEA DX, RSLT2
        MOV AH, 9
        INT 21H
    ;PRINT THE VALUE OF Z=25-(X+Y)
        MOV AH, 2
        MOV DL, Z
        INT 21H
    
    ;THIS PART IS FOR CALCULATING Z=2X-3Y
    ;FIRST OF ALL COUNT THE VALUE 
        MOV BL, X
        MOV BH, Y
        ADD BL, BL
        ADD BH, BH
        MOV Z, BH
        MOV BH, Y
        ADD BH, Z
        SUB BL, BH
        ADD BL, 30H
        MOV Z, BL
    
    
    ;PRINT THE MESSAGE BEFORE PRINTING THE VALUE OF Z=2X-3Y
        LEA DX, RSLT3
        MOV AH, 9
        INT 21H
    ;PRINT THE VALUE OF 2X-3Y
        MOV AH, 2
        MOV DL, Z
        INT 21H
           
    
    ;THIS PART IS FOR CALCULATING X Z=Y-X+1
    ;FIRST OF ALL COUNT THE VALUE
    
        MOV BL, Y
        MOV BH, X
        SUB BL, BH
        INC BL
        ADD BL, 30H
        MOV Z, BL
    
    
    ;PRINT THE MESSAGE BEFORE PRINTING THE VALUE OF Z=Y-X+1
        LEA DX, RSLT4
        MOV AH, 9
        INT 21H
    ;PRINT THE VALUE OF Y-X+1
        MOV AH, 2
        MOV DL, Z
        INT 21H
    
    
    ;DOS EXIT
        MOV AH, 4CH
        INT 21H
    
    
    MAIN ENDP
END MAIN