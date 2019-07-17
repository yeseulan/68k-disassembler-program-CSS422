*-----------------------------------------------------------
* Title      : GROUP B10 EAs
* Written by : YESEUL AN, CHANDLER FORD, CATHERINE SANTOS
* Date       : 6/1/18
* Description: PROGRAM THAT DECODES EFFECTIVE ADDRESS
*                   OF DISASSEMBLER
*-----------------------------------------------------------            
*-----------------------------------------------------------
* Effective address decode
* A4 loads the jump table of EA
* A5 loads the jump table of Hexadecimal
* D4(Mode), D5(Register)
*-----------------------------------------------------------
DECODE_EA  		LEA     JMP_EA, A4
                LEA     JMP_HEX, A5 
                MULU    #6, D4
                JSR     0(A4, D4)
                
                RTS
                
*-----------------------------------------------------------
* EA Jump table
*-----------------------------------------------------------
JMP_EA          JMP     M000    ; data register
                JMP     M001    ; address register
                JMP     M010    ; address indirect
                JMP     M011    ; address with post-increment
                JMP     M100    ; address with pre-decrement
                JMP     M101    ; not supported mode
                JMP     M110    ; not supported mode
                JMP     M111    ; absolute short, absolute long, immediate
                
*-----------------------------------------------------------
* Mode 000 - Data register
*-----------------------------------------------------------
M000            MOVE.L          #26, D6
                LEA             0(A5, D6),A1
                MOVE.B          #14, D0
                TRAP            #15 
                
                MULU            #2, D5
                LEA             0(A5, D5),A1
                MOVE.B          #14, D0
                TRAP            #15
                
                RTS

*-----------------------------------------------------------
* Mode 001 - Address Register Direct
*-----------------------------------------------------------                              
M001            MOVE.L          #20, D6
                LEA             0(A5, D6),A1
                MOVE.B          #14, D0
                TRAP            #15 
                
                MULU            #2, D5
                LEA             0(A5, D5),A1
                MOVE.B          #14, D0
                TRAP            #15

                RTS

*-----------------------------------------------------------
* Mode 010 - Address Register Indirect
*-----------------------------------------------------------   
M010            JSR             PRINT_OPENP
    
                MOVE.L          #20, D6
                LEA             0(A5, D6),A1
                MOVE.B          #14, D0
                TRAP            #15 
                
                MULU            #2, D5
                LEA             0(A5, D5),A1
                MOVE.B          #14, D0
                TRAP            #15

                JSR             PRINT_CLOSEP
                
                RTS

*-----------------------------------------------------------
* Mode 011 - Address Register Indirect with Post-Incrementing
*-----------------------------------------------------------   
M011            JSR				M010
				
                JSR             PRINT_PLUS
                              
                RTS


*-----------------------------------------------------------
* Mode 011 - Address Register Indirect with Pre-Decrementing
*-----------------------------------------------------------  
M100            JSR             PRINT_DECRE
    
                JSR             M010
                            
                RTS

*-----------------------------------------------------------
* Mode 101 - Not supported
*----------------------------------------------------------- 
M101            BRA             EA_INVALID

*-----------------------------------------------------------
* Mode 110 - Not supported
*----------------------------------------------------------- 
M110            BRA             EA_INVALID
*-----------------------------------------------------------
* Mode 111 - Absolute word/long address, immediate data
* A2 - starting address
* A6 - new Address register
*-----------------------------------------------------------
M111            MOVEA.L         A2, A6
                CMP.B           #%000, D5
                BEQ             Abs_Word
                
                CMP.B           #%001, D5
                BEQ             Abs_Long
                
                CMP.B           #%100, D5
                BEQ             Imm_Data
                

Abs_Word        ADDA.W          #2, A6
                MOVE.B          #0, Address_Size
                
                JSR             PRINT_DOLLAR
                
                CLR.L           D6
                MOVE.W          (A6),D6
                MOVE.W          #4,D7
                JSR             PRINT_IADDR

                ADDA.W          #2, A2
                
                RTS

Abs_Long        ADDA.W          #2, A6
                MOVE.B          #1, Address_Size

                JSR             PRINT_DOLLAR
                
                CLR.L           D6
                MOVE.L          (A6),D6
                MOVE.L          #8,D7
                JSR             PRINT_IADDR

                ADDA.W          #4, A2
                
                RTS

Imm_Data        JSR             PRINT_POUND

                JSR             PRINT_DOLLAR

                CLR.L           D5
                MOVE.B          Opcode_Size, D5
                
                CMP.B           #2,D5
                BEQ             Imm_Long               
                
                ADDA.W          #2, A6
                
                CLR.L           D6
                MOVE.W          (A6),D6
                MOVE.L          #4, D7
                JSR             PRINT_DATA
                
                ADDA.W          #2, A2
                
                RTS
                                

Imm_Long        ADDA.W          #2, A6
                
                CLR.L           D6
                MOVE.L          (A6),D6
                MOVE.L          #8,D7
                JSR             PRINT_DATA

                ADDA.W          #4, A2

                RTS

                BRA             EA_INVALID
*--------------------------------------------------------
* Invalid EA Handling
*--------------------------------------------------------
EA_INVALID      JSR           PRINT_INVALID

                JSR           PRINT_TAB

                JSR           PRINT_DOLLAR
                
                MOVE.B        #1, Opcode_Size
                MOVE.B        Opcode_Size, D5
                
                MOVE.W        (A2),D6
                MOVE.L        #4, D7
                JSR           PRINT_DATA
                
                JSR           PRINT_BLANK
                                
                ADDA.W		  #2, A2            * Skip the invalid data after printing out
 
                BRA           LOOP              * Branch back to the main program
*-------------------------------------------------------------------
* Table Hexadecimal
*-------------------------------------------------------------------
JMP_HEX         DC.B    '0',0
                DC.B    '1',0
                DC.B    '2',0
                DC.B    '3',0
                DC.B    '4',0
                DC.B    '5',0
                DC.B    '6',0
                DC.B    '7',0
                DC.B    '8',0
                DC.B    '9',0
                DC.B    'A',0
                DC.B    'B',0
                DC.B    'C',0
                DC.B    'D',0
                DC.B    'E',0
                DC.B    'F',0
                 
















































*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
