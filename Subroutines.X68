*------------------------------------------------------------------
* Title      : GROUP B10 SUBROUTINES
* Written by : YESEUL AN, CHANDLER FORD, CATHERINE SANTOS
* Date       : 6/1/18
* Description: PROGRAM THAT CONTAINS SUBROUTINES FOR DISASSEMBLER
*------------------------------------------------------------------
*------------------------------------------------------------------
* CONVERT ASCII INPUT TO HEXADECIMAL
*------------------------------------------------------------------
CONVERT_TO_HEX          MOVE.B    (A1)+, D2
                        JSR       CONVERT
                        ADD.L     D2, D3                                 
                        CMPI.B    #$00, (A1)
                        BEQ       Go_Back
                        LSL.L     #4, D3
                        BRA       CONVERT_TO_HEX                                 

CONVERT                 CMPI.B    #$30, D2
                        BLT       FLAG_INVALID
                                 
                        CMPI.B    #$39, D2
                        BLE       NUMBER
                                 
                        CMPI.B    #$40, D2
                        BLE       FLAG_INVALID
                                 
                        CMPI.B    #$46, D2
                        BLE       UPPER
                                 
                        CMPI.B    #$60, D2
                        BLE       FLAG_INVALID
                                 
                        CMPI.B    #$66, D2
                        BLE       LOWER
                                                                                                   
NUMBER                  SUBI      #$30, D2
                        RTS

UPPER                   SUBI      #$37, D2
                        RTS

LOWER                   SUBI      #$57, D2
                        RTS

FLAG_INVALID            MOVE.B    #$01, Flag
                        BRA       Go_Back

Go_Back                 RTS                       

*------------------------------------------------------------------
* Printing the address in A2
* A2 initially holds the starting address and move forward 
*------------------------------------------------------------------
PRINT_ADDRESS    CLR.L       D3
                 MOVE.L      A2, D3
                 MOVE.L      #8, D6
                 JSR         PRINT_HEX
                        
                 JSR         PRINT_TAB
                        
                 RTS

*--------------------------------------------------------
* Print Hexadecimal 
* A2 is the original address that we should print out.
* D3 has copy of the address that should be printed out. 
*--------------------------------------------------------
PRINT_HEX        MOVEM.L     D2/D4-D6, -(SP)
                 LEA         JMP_HEX, A5
                
                 MULU.W      #4, D6
                 MOVE.L      #32, D5
                 SUB.L       D6, D5
                 MOVE.L      #28, D4

HEX_LOOP         MOVE.L      D3, D2
                 LSL.L       D5, D2
                 LSR.L       D4, D2

                 MULU        #2, D2
                 LEA         0(A5, D2),A1
                 MOVE.B      #14, D0
                 TRAP        #15

                 ADD.B       #4, D5
                 CMP.B       #32, D5
                 BNE         HEX_LOOP

                 MOVEM.L     (SP)+, D2/D4-D6

                 RTS

*--------------------------------------------------------
* Print Immediate Addresses 
* D6 is Immediate Address we should print out.
*--------------------------------------------------------
PRINT_IADDR      MOVEM.L     D2-D5/D7, -(SP)
                 LEA         JMP_HEX, A5
                 
                 CMP.B       #0, Address_Size
                 BEQ         CHECK_SIZE
                                                 
IADDR_LOOP1      MULU.W      #4, D7
                 MOVE.L      #32, D5
                 SUB.L       D7, D5
                 MOVE.L      #28, D4

IADRR_LOOP2      MOVE.L      D6, D2
                 LSL.L       D5, D2
                 LSR.L       D4, D2

                 MULU        #2, D2
                 LEA         0(A5, D2),A1
                 MOVE.B      #14, D0
                 TRAP        #15

                 ADD.B       #4, D5
                 CMP.B       #32, D5
                 BNE         IADRR_LOOP2
               
IADDR_RETURN     MOVEM.L     (SP)+,D2-D5/D7
                 RTS 
                 
CHECK_SIZE       MOVE.W      D6, D1
                 MOVE.B      #16, D2
                 LSL.L       D2, D1
                 MOVE.B      #28, D2
                 LSR.L       D2, D1
                 
                 CMP.B       #0, D1
                 BNE         IADDR_LOOP1
                 
                 MOVE.W      D6, D1
                 MOVE.B      #20, D2
                 LSL.L       D2, D1
                 MOVE.B      #28, D2
                 LSR.L       D2, D1
                 
                 CMP.B       #0, D1
                 BNE         IADDR_LOOP1
                 
                 BRA         B_ADDR
                 
B_ADDR          MOVE.B       #1, D3
                MOVE.B       D6, D1
                MOVE.L       #24, D2
                LSL.L        D2, D1
                MOVE.L       #28, D2
                LSR.L        D2, D1

                CMP.B        #9, D1
                BLE          UNTIL_9

                CMP.B        #9, D1
                BGT          OVER_9
                
B_ADDR_LOOP     CMP.B        #2, D3
                BEQ          IADDR_RETURN 
                
                MOVE.B       D6, D1
                MOVE.L       #28, D2
                LSL.L        D2, D1
                MOVE.L       #28, D2
                LSR.L        D2, D1
                ADDQ         #1, D3

                CMP.B        #9, D1
                BLE          UNTIL_9

                CMP.B        #9, D1
                BGT          OVER_9   

UNTIL_9         JSR          EVALUATE_NUM 
                
                BRA          B_ADDR_LOOP
                
OVER_9          JSR          EVALUATE_CHAR
            
                BRA          B_ADDR_LOOP                              
                 

*-----------------------------------------------------------------
* Print Data (Byte, Word, Long)
* D5 - size of the data
* D6 - data to be printed
*-----------------------------------------------------------------                        
PRINT_DATA      MOVEM.L      D0-D4/A0-A7, -(SP)
                CMP.B        #0, D5
                BEQ          PRINT_IB
                
                LEA          JMP_HEX, A5
                MULU.W       #4, D7
                MOVE.L       #32, D3
                SUB.L        D7, D3
                MOVE.L       #28, D4
                     
WL_LOOP         MOVE.L       D6, D2
                LSL.L        D3, D2
                LSR.L        D4, D2
                
                MULU         #2, D2
                LEA          0(A5,D2),A1
                MOVE.B       #14, D0
                TRAP         #15
                
                ADD.B        #4, D3
                CMP.B        #32, D3
                BNE          WL_LOOP
                
RETURN          MOVEM.L      (SP)+, D0-D4/A0-A7                
                RTS

PRINT_IB        MOVE.B       #1, D3
                MOVE.B       D6, D1
                MOVE.L       #24, D2
                LSL.L        D2, D1
                MOVE.L       #28, D2
                LSR.L        D2, D1

                CMP.B        #9, D1
                BLE          TIL_9

                CMP.B        #9, D1
                BGT          SURPASS_9
                
B_LOOP          CMP.B        #2, D3
                BEQ          RETURN 
                
                MOVE.B       D6, D1
                MOVE.L       #28, D2
                LSL.L        D2, D1
                MOVE.L       #28, D2
                LSR.L        D2, D1
                ADDQ         #1, D3

                CMP.B        #9, D1
                BLE          TIL_9

                CMP.B        #9, D1
                BGT          SURPASS_9   

TIL_9           JSR          EVALUATE_NUM 
                
                BRA          B_LOOP
                
SURPASS_9       JSR          EVALUATE_CHAR
            
                BRA          B_LOOP                               
*------------------------------------------------------------------
* Evaluating bits subroutines
*------------------------------------------------------------------
Bit_11to9               MOVE.W       (A2),D3
                        LSL.W        #4, D3
                        MOVE.B       #13, D0
                        LSR.W        D0, D3
                   
                        RTS   

Bit_11to8               MOVE.W       (A2),D3
                        LSL.W        #4, D3
                        MOVE.B       #12, D0
                        LSR.W        D0, D3
                   
                        RTS 

Bit_11to6               MOVE.W       (A2),D3
                        LSL.W        #4, D3
                        MOVE.B       #10, D0
                        LSR.W        D0, D3
            
                        RTS  

Bit_8to8                MOVE.W       (A2),D3    
                        LSL.W        #7,D3
                        MOVE.B       #15, D0
                        LSR.W        D0, D3  
                   
                        RTS  

Bit_8to6                MOVE.W       (A2),D3
                        LSL.W        #7,D3
                        MOVE.B       #13, D0
                        LSR.W        D0, D3  
                   
                        RTS 

Bit_8to4                MOVE.W       (A2),D3
                        LSL.W        #7, D3
                        MOVE.B       #11, D0
                        LSR.W        D0, D3

                        RTS 
                        
Bit_8to3                MOVE.W       (A2),D3
                        LSL.W        #7, D3
                        MOVE.B       #10, D3
                        LSR.W        D0, D3
                        
                        RTS

Bit_7to6                MOVE.W       (A2),D3
                        LSL.W        #8,D3
                        MOVE.B       #14, D0
                        LSR.W        D0, D3  
                   
                        RTS   

Bit_7to4                MOVE.W       (A2),D3
                        LSL.W        #8, D3
                        MOVE.B       #12, D0
                        LSR.W        D0, D3

                        RTS
                        
Bit_7to0                MOVE.W       (A2),D3
                        MOVE.B       #8, D0
                        LSL.W        D0, D3
                        LSR.W        D0, D3  

                        RTS  
                        
Bit_6                   MOVE.W       (A2),D3
                        MOVE.B       #9, D0
                        LSL.W        D0, D3
                        MOVE.B       #15, D0
                        LSR.W        D0,D3
                        
                        RTS
                        
Bit_5to5                MOVE.W       (A2),D3    
                        MOVE.B       #10, D0
                        LSL.W        D0, D3
                        MOVE.B       #15, D0
                        LSR.W        D0, D3  
                   
                        RTS  

Bit_5to3                MOVE.W       (A2),D3
                        MOVE.B       #10, D0
                        LSL.W        D0, D3
                        MOVE.B       #13, D0
                        LSR.W        D0, D3

                        RTS 
                        
Bit_4to3                MOVE.W       (A2),D3
                        MOVE.B       #11, D0
                        LSL.W        D0,D3
                        MOVE.B       #14, D0
                        LSR.W        D0, D3
                        
                        RTS   

Bit_3to0                MOVE.W       (A2),D3
                        MOVE.B       #12,D0
                        LSL.W        D0, D3
                        LSR.W        D0, D3

                        RTS  

Bit_2to0                MOVE.W       (A2),D3
                        MOVE.B       #13, D0
                        LSL.W        D0, D3
                        LSR.W        D0, D3  

                        RTS 
        
*--------------------------------------------------------
* Printing sizes of a op-code
*--------------------------------------------------------                 

Size_Byte       LEA          PRINT_BYTE, A1
                MOVE.B       #14, D0
                TRAP         #15
                
                MOVE.B       #0, Opcode_Size
   
                RTS

Size_Word       LEA          PRINT_WORD, A1
                MOVE.B       #14, D0
                TRAP         #15
                
                MOVE.B       #1, Opcode_Size
                   
                RTS

Size_Long       LEA          PRINT_LONG, A1
                MOVE.B       #14, D0
                TRAP         #15
                
                MOVE.B       #2, Opcode_Size
                   
                RTS

*--------------------------------------------------------
* Evaluate sizes of a op-code
*--------------------------------------------------------

Evaluate_Size   CMPI.B       #$0, D3
                BEQ          Size_Byte
                
                   
                CMPI.B       #$1, D3
                BEQ          Size_Word
                
                   
                CMPI.B       #$2, D3
                BEQ          Size_Long           

                BRA          SIZE_INVALID

*--------------------------------------------------------
* Evaluate sizes of a op-code
*--------------------------------------------------------

Evaluate_Size2  CMPI.B       #$0, D3
                BEQ          Size_Word

                CMPI.B       #$1, D3
                BEQ          Size_Long   

                BRA          SIZE_INVALID         
                                
*--------------------------------------------------------
* Print Over-Length Message for starting address
*--------------------------------------------------------
START_LENGTH    LEA            LENGTH_MESSAGE, A1
                MOVE.B         #14, D0
                TRAP           #15                    

                BRA            START_ADDR
                
*--------------------------------------------------------
* Print Over-Length Message for ending address
*--------------------------------------------------------
END_LENGTH      LEA            LENGTH_MESSAGE, A1
                MOVE.B         #14, D0
                TRAP           #15                    

                BRA            END_ADDR
*--------------------------------------------------------
* Print Invalid-character Message for start address
*--------------------------------------------------------
START_INVALID   LEA            INVALID_MESSAGE, A1
                MOVE.B         #14, D0
                TRAP           #15

                BRA            START_ADDR

*--------------------------------------------------------
* Print Invalid-character Message for end address
*--------------------------------------------------------
END_INVALID     LEA            INVALID_MESSAGE, A1
                MOVE.B         #14, D0
                TRAP           #15

                BRA            END_ADDR

*--------------------------------------------------------
* Print Odd address Message for starting address
*--------------------------------------------------------
START_ODD       LEA            ODD_MESSAGE, A1
                MOVE.B         #14, D0
                TRAP           #15
        
                BRA            START_ADDR  

*--------------------------------------------------------
* Print Odd address Message for end address
*-------------------------------------------------------- 
END_ODD         LEA            ODD_MESSAGE, A1
                MOVE.B         #14, D0
                TRAP           #15
        
                BRA            END_ADDR      

*--------------------------------------------------------
* Print Effective Address
* D4 is passing parameter to the DECODE_EA
* D5 is passing parameter to the DECODE_EA
*--------------------------------------------------------
Print_EA        JSR           PRINT_TAB

                MOVE.W        Source_Mode, D4
                MOVE.W        Source_Reg, D5
                
                JSR           DECODE_EA
                
                JSR           PRINT_COMMA

                CLR           D4
                CLR           D5

                MOVE.W        Des_Mode, D4
                MOVE.W        Des_Reg, D5
                
                JSR           DECODE_EA 

                JSR           PRINT_BLANK
                RTS 

*------------------------------------------------------------
* Dealing with invalid size
*------------------------------------------------------------
SIZE_INVALID	JSR           PRINT_INVALID

                JSR           PRINT_TAB

                JSR           PRINT_DOLLAR
                
                MOVE.B        #1, Opcode_Size
                MOVE.B        Opcode_Size, D5
                
                MOVE.W        (A2),D6
                MOVE.L        #4, D7
                JSR           PRINT_DATA
                
                JSR           PRINT_BLANK
                                
                ADDA.W		  #2, A2
                
                BRA           LOOP  

*--------------------------------------------------------------
* Print MOVEQ Data- that is always byte size
*--------------------------------------------------------------
MOVEQ_DATA      MOVEM.L       D1-D6/A1-A7, -(SP)
                MOVE.B        #0, D3
                MOVE.B        D7, D1
                MOVE.B        #8, D2
                LSL.W         D2, D1
                MOVE.B        #12, D2
                LSR.W         D2, D1

                CMP.B         #$9, D1
                BGT           GREATER_THAN_9
                
                BRA           UP_TO_9
                
LOOPING         CMP.B         #8, D3
                BEQ           BACK
                
                CLR.L         D1
                MOVE.B        D7, D1
                MOVE.B        #12, D2
                LSL.W         D2, D1
                MOVE.B        #12, D2
                LSR.W         D2, D1
               
                CMP.B         #$9, D1
                BGE           GREATER_THAN_9
                
                BRA           UP_TO_9
                
BACK            MOVEM.L       (SP)+, D1-D6/A1-A7               
                RTS  
                

UP_TO_9         MOVE.B        #3, D0
                TRAP          #15 
                ADDQ          #4, D3   

                BRA           LOOPING            

GREATER_THAN_9  JSR           EVALUATE_CHAR

                ADDQ          #4, D3
            
                BRA           LOOPING


*-------------------------------------------------------------------
* Subroutine to evaluate Hexadecimal number
*-------------------------------------------------------------------
EVALUATE_NUM    CMP.B         #$1, D1
                BEQ           PRINT_1
                
                CMP.B         #$2, D1
                BEQ           PRINT_2
                
                CMP.B         #$3, D1
                BEQ           PRINT_3
                
                CMP.B         #$4, D1
                BEQ           PRINT_4
                
                CMP.B         #$5, D1
                BEQ           PRINT_5
                
                CMP.B         #$6, D1
                BEQ           PRINT_6
                
                CMP.B         #$3, D1
                BEQ           PRINT_7
                
                CMP.B         #$4, D1
                BEQ           PRINT_8
                
                CMP.B         #$9, D1
                BEQ           PRINT_8
                
*-------------------------------------------------------------------
* Subroutine to evaluate Hexadecimal character
*-------------------------------------------------------------------
EVALUATE_CHAR   CMP.B         #$A, D1
                BEQ           PRINT_A
                
                CMP.B         #$B, D1
                BEQ           PRINT_B
                
                CMP.B         #$C, D1
                BEQ           PRINT_C
                
                CMP.B         #$D, D1
                BEQ           PRINT_D
                
                CMP.B         #$E, D1
                BEQ           PRINT_E
                
                CMP.B         #$F, D1
                BEQ           PRINT_F
                
*-------------------------------------------------------------------
* Subroutine to print out address registers for MOVEM general mode
*-------------------------------------------------------------------                
REG_A           MOVE.B        #8, D2
                BTST          D2, D6
                BNE           PRINT_A0
                BRA           TST9
                
PRINT_A0        JSR           P_A0
                JSR           PRINT_SLASH
                
TST9            MOVE.B        #9, D2
                BTST          D2, D6
                BNE           PRINT_A1
                BRA           TST10
                
PRINT_A1        JSR           P_A1
                JSR           PRINT_SLASH
                
TST10           MOVE.B        #10, D2
                BTST          D2,D6
                BNE           PRINT_A2
                BRA           TST11

PRINT_A2        JSR           P_A2
                JSR           PRINT_SLASH

TST11           MOVE.B        #11, D2
                BTST          D2, D6
                BNE           PRINT_A3
                BRA           TST12

PRINT_A3        JSR           P_A3
                JSR           PRINT_SLASH
            
TST12           MOVE.B        #12, D2
                BTST          D2, D6
                BNE           PRINT_A4
                BRA           TST13
                
PRINT_A4        JSR           P_A4
                JSR           PRINT_SLASH
                
TST13           MOVE.B        #13,D2
                BTST          D2, D6
                BNE           PRINT_A5
                BRA           TST14
               
PRINT_A5        JSR           P_A5
                JSR           PRINT_SLASH
                
TST14           MOVE.B        #14,D2
                BTST          D2,D6
                BNE           PRINT_A6
                BRA           TST15
                
PRINT_A6        JSR           P_A6
                JSR           PRINT_SLASH
                
TST15           MOVE.B        #15,D2
                BTST          D2, D6
                BNE           PRINT_A7
                RTS
                
PRINT_A7        JSR           P_A7
                JSR           PRINT_SLASH
                RTS

*-------------------------------------------------------------------
* Subroutine to print out data registers for MOVEM general mode
*------------------------------------------------------------------- 
REG_D           MOVE.B        #0,D2
                BTST          D2,D6
                BNE           PRINT_D0
                BRA           TST1
                
PRINT_D0        JSR           P_D0
                JSR           PRINT_SLASH
                
TST1            MOVE.B        #1,D2
                BTST          D2,D6
                BNE           PRINT_D1
                BRA           TST2
                
PRINT_D1        JSR           P_D1
                JSR           PRINT_SLASH
                
TST2            MOVE.B        #2,D2
                BTST          D2,D6
                BNE           PRINT_D2
                BRA           TST3
                
PRINT_D2        JSR           P_D2
                JSR           PRINT_SLASH
                
TST3            MOVE.B        #3,D2
                BTST          D2,D6
                BNE           PRINT_D3
                BRA           TST4
                
PRINT_D3        JSR           P_D3
                JSR           PRINT_SLASH
                
TST4            MOVE.B        #4,D2
                BTST          D2,D6
                BNE           PRINT_D4
                BRA           TST5
                
PRINT_D4        JSR           P_D4
                JSR           PRINT_SLASH
                
TST5            MOVE.B        #5,D2
                BTST          D2,D6
                BNE           PRINT_D5
                BRA           TST6
                
PRINT_D5        JSR           P_D5
                JSR           PRINT_SLASH
                
TST6            MOVE.B        #6,D2
                BTST          D2,D6
                BNE           PRINT_D6
                BRA           TST7
                
PRINT_D6        JSR           P_D6
                JSR           PRINT_SLASH
                
TST7            MOVE.B        #7,D2
                BTST          D2,D6
                BNE           PRINT_D7
                RTS
       
PRINT_D7        JSR           P_D7
                JSR           PRINT_SLASH
                RTS
                                
*----------------------------------------------------------------------
* Subroutine to print out address registers for MOVEM predecrement mode
*----------------------------------------------------------------------
PRE_REG_A       MOVE.B        #7, D2
                BTST          D2, D6
                BNE           PR_A0
                BRA           TEST6
                
PR_A0           JSR           P_A0
                JSR           PRINT_SLASH
                
TEST6           MOVE.B        #6, D2
                BTST          D2, D6
                BNE           PR_A1
                BRA           TEST5
                
PR_A1           JSR           P_A1
                JSR           PRINT_SLASH
                
TEST5           MOVE.B        #5, D2
                BTST          D2, D6
                BNE           PR_A2
                BRA           TEST4
                
PR_A2           JSR           P_A2
                JSR           PRINT_SLASH
                
TEST4           MOVE.B        #4, D2
                BTST          D2, D6
                BNE           PR_A3
                BRA           TEST3
                
PR_A3           JSR           P_A3
                JSR           PRINT_SLASH
                
TEST3           MOVE.B        #3, D2
                BTST          D2, D6
                BNE           PR_A4
                BRA           TEST2
                
PR_A4           JSR           P_A4
                JSR           PRINT_SLASH
                
TEST2           MOVE.B        #2, D2
                BTST          D2, D6
                BNE           PR_A5
                BRA           TEST1
                
PR_A5           JSR           P_A5
                JSR           PRINT_SLASH
                
TEST1           MOVE.B        #1, D2
                BTST          D2, D6
                BNE           PR_A6
                BRA           TEST0
                
PR_A6           JSR           P_A6
                JSR           PRINT_SLASH
                
TEST0           MOVE.B        #0, D2
                BTST          D2, D6
                BNE           PR_A7
                RTS

PR_A7           JSR           P_A7
                JSR           PRINT_SLASH
                RTS

*----------------------------------------------------------------------
* Subroutine to print out data registers for MOVEM predecrement mode
*----------------------------------------------------------------------
PRE_REG_D       MOVE.B        #15, D2
                BTST          D2, D6
                BNE           PR_D0
                BRA           TEST14
               
PR_D0           JSR           P_D0
                JSR           PRINT_SLASH

TEST14          MOVE.B        #14, D2
                BTST          D2, D6
                BNE           PR_D1
                BRA           TEST13
                
PR_D1           JSR           P_D1
                JSR           PRINT_SLASH
                
TEST13          MOVE.B        #13, D2
                BTST          D2, D6
                BNE           PR_D2
                BRA           TEST12
                
PR_D2           JSR           P_D2
                JSR           PRINT_SLASH
                
TEST12          MOVE.B        #12, D2
                BTST          D2, D6
                BNE           PR_D3
                BRA           TEST11
                
PR_D3           JSR           P_D3
                JSR           PRINT_SLASH
                
TEST11          MOVE.B        #11, D2
                BTST          D2, D6
                BNE           PR_D4
                BRA           TEST10
                
PR_D4           JSR           P_D4
                JSR           PRINT_SLASH
                
TEST10          MOVE.B        #10, D2
                BTST          D2, D6
                BNE           PR_D5
                BRA           TEST9
                
PR_D5           JSR           P_D5
                JSR           PRINT_SLASH
                
TEST9           MOVE.B        #9, D2
                BTST          D2, D6
                BNE           PR_D6
                BRA           TEST8
                
PR_D6           JSR           P_D6
                JSR           PRINT_SLASH
                
TEST8           MOVE.B        #8, D2
                BTST          D2, D6
                BNE           PR_D7
                RTS
                
PR_D7           JSR           P_D7
                JSR           PRINT_SLASH
                RTS


































*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
