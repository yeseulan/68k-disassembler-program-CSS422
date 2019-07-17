*-----------------------------------------------------------
* Title      : GROUP B10 DISASSEMBLER
* Written by : YESEUL AN, CHANDLER FORD, CATHERINE SANTOS
* Date       : 6/1/18
* Description: MAIN PROGRAM OF DISASSEMBLER
*-----------------------------------------------------------
*------------------------------------------------------------
* Usage of address registers and data registers
* A2 - holds starting address
* A3 - holds ending address
* D3 - temporary data read from A2
*------------------------------------------------------------
*------------------------------------------------------------
* Main program
*------------------------------------------------------------

START           ORG              $1000
                        
                LEA              Stack, SP
                
                LEA              WELCOME, A1
                MOVE.B           #13, D0
                TRAP             #15                

*------------------------------------------------------------
* Get starting address
*------------------------------------------------------------
                
START_ADDR      LEA              START_MESSAGE, A1
                MOVE.B           #14, D0
                TRAP             #15
                
                LEA              INPUT, A1      ; INPUT WILL STORE THE USER INPUT
                MOVE.B           #2, D0         ; LENGTH WILL STORE TO D1
                TRAP             #15
                
                CMPI             #4, D1         ; check the length of the address
                BGT              START_LENGTH
                
                CLR.L            D2
                CLR.L            D3  
                JSR              CONVERT_TO_HEX  
                
                CMPI.B           #$01, Flag     ; check whether the address contains invalid character
                BEQ              START_INVALID
                
                MOVE.L           D3, StartAddr

                BTST             #0, D3         ; check whether the input address is odd
                BNE              START_ODD

                JSR              PRINT_BLANK
                            
*------------------------------------------------------------------
* Get ending address
*------------------------------------------------------------------                                 
                               
END_ADDR        LEA              END_MESSAGE, A1 
                MOVE.B           #14, D0
                TRAP             #15               
                
                LEA              INPUT, A1
                MOVE.B           #2, D0
                TRAP             #15
                
                CMPI             #4, D1         ; check the length of the address
                BGT              END_LENGTH

                CLR.L            D2
                CLR.L            D3        
                JSR              CONVERT_TO_HEX
                
                CMPI.B           #$01, Flag     ; check whether the address contains invalid character
                BEQ              END_INVALID
                  
                MOVE.L           D3, EndAddr

                BTST             #0, D3         ; check whether the input address is odd
                BNE              END_ODD

                MOVEA.L          StartAddr, A2
                MOVEA.L          EndAddr, A3                

                CMP.L            A3, A2
                BGE              RUN_AGAIN
                
                BRA              Op_Decode
                                                                                                                                                                                                              
*-----------------------------------------------------------
* A0: Jump table for op-code
* A2: Points to the starting address
* A3: Points to the ending address
* D3: Data register that is used to find op-code
*----------------------------------------------------------- 
  
Op_Decode       LEA             JMP_TABLE, A0        
                
LOOP            CMP.W           #$FFFF, (A2)      ; solution to stop the permanent looping
                BEQ             RUN_AGAIN

                CMPI.B          #20, COUNTER
                BEQ             ASK_CONTINUE      

CONTINUE        JSR             PRINT_ADDRESS
                ADDQ.B          #1, COUNTER

                CLR.L           D3
                CLR.L           D0
                MOVE.W          (A2),D3 
                MOVE.B          #12, D0
                LSR.W           D0, D3           ; locate first 4 bits 
                MULU            #6, D3
                JSR             0(A0, D3) 
                
                CMP.L           A3, A2
                BGE             RUN_AGAIN

                ADDA.W          #2, A2          ; increment starting address by word size
               
                BRA             LOOP
                    

ASK_CONTINUE    LEA             PAUSE_MESSAGE, A1
                MOVE.B          #14, D0
                TRAP            #15

                MOVE.B          #5, D0
                TRAP            #15
                MOVE.B          #0, COUNTER
                BRA             CONTINUE

RUN_AGAIN       MOVEM.L         D0/D1/D2/A1, -(SP)
                MOVE.L          #0, A5
                
                LEA             END_POINT, A1
                MOVE.B          #14, D0
                TRAP            #15
                
                LEA             INPUT, A1
                MOVE.B          #2, D0
                TRAP            #15
                
                MOVE.B          #0, COUNTER

                MOVE.L          INPUT, D7
                CMPI.L          #$79657300, D7
                BEQ             ANSWER_YES

                CMPI.L          #$6E6F0030, D7
                BEQ             ANSWER_NO

                BRA             RUN_AGAIN

ANSWER_YES      MOVEM.L         (SP)+, D0/D1/D2/A1
                MOVE.L          #1, A5
                
                BRA             START_ADDR

ANSWER_NO       MOVEM.L         (SP)+, D0/D1/D2/A1
                
                BRA             DONE

*----------------------------------------------------------- 
* Included Files
*-----------------------------------------------------------        
                INCLUDE         'Definitions.x68',0
                INCLUDE         'Subroutines.x68',0
                INClUDE         'Branches.x68',0
                INCLUDE         'Op-code.x68',0
                INCLUDE         'EAs.x68',0

DONE              
                END     START



































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
