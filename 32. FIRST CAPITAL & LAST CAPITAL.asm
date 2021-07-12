.MODEL SMALL 

.STACK 100H

.DATA
    PROMPT DB 'TYPE A LINE OF TEXT',0DH,0AH,'$'
    NO_CAPMSG DB 0DH,0AH,'NO CAPITALS $'
    CAP_MSG DB 0DH,0AH,'FIRST CAPITAL = '
    FIRST DB '['
        DB 0DH,0AH
        DB 'LAST CAPITAL = '
    LAST DB '@ $'

.CODE      

    MAIN PROC
        ;INITIALIZE DS   
        MOV AX,@DATA
        MOV DS,AX

        ;DISPLAY OPENING MESSAGE
        MOV AH,9
        LEA DX,PROMPT
        INT 21H

        ;READ CHARACTER FUNCTION
        MOV AH,1
        INT 21H

        ;WHILE CHARACTER IS NOT A CARRIAGE RETURN
        WHILE_:
            CMP AL,0DH ;IF CARRIAGE_RETURN
            JE EXIT_WHILE ; YES, EXIT LOOP

            ;IF CHARACTER IS A CAPITAL LETTER
            CMP AL,'A'  ;IS CHARACTER CAPITAL?
            JNGE END_IF ;IF NOT,END IF
            CMP AL,'Z' ;IS CHARACTER CAPITAL AND BELOW 'Z'
            JNLE END_IF ;IF NOT, END IF
   
            ;THEN
            CMP AL,FIRST ; IS CHAR<FIRST
            JNL CHECK_LAST ;IF NOT THEN CHECK FOR LAST CHARACTER
            
            ;THEN
            MOV FIRST,AL ;FIRST = CHAR

       CHECK_LAST:   
            CMP AL,LAST ;IS CHAR>LAST
            JNG END_IF
            
            ;THEN
            MOV LAST,AL ;LAST = AL
            
       END_IF:
            INT 21H
            JMP WHILE_
            
       EXIT_WHILE:
            MOV AH,9
    
            ;IF NO CAPITALS WERE 
            CMP FIRST,'['
            JNE CAPITAL
            ;THEN
            LEA DX,NO_CAPMSG ;NO CAPITALS
            JMP DISPLAY
    
       CAPITAL:
            LEA DX,CAP_MSG   ;CAPITAL MESSAGE
            
       DISPLAY:
            INT 21H
    
        MOV AH,4CH
        INT 21H  
   
    MAIN ENDP
END MAIN