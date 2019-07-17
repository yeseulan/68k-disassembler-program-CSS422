*-----------------------------------------------------------
* Title      : GROUP B10 OPCODES
* Written by : YESEUL AN, CHANDLER FORD, CATHERINE SANTOS
* Date       : 6/1/18
* Description: PROGRAM THAT PRINTS AND DISASSEMBLE OPCODES
*-----------------------------------------------------------
*-----------------------------------------------------------
* Disassembling process of Op-codes
*-----------------------------------------------------------
*-----------------------------------------------------------
* SUBI
*----------------------------------------------------------- 
SUBI               LEA          PRINT_SUBI, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Bit_7to6

                   JSR          Evaluate_Size
                   
                   MOVE.W       #7, Source_Mode         ;Mode 111 for immediate data
                   MOVE.W       #4, Source_Reg          ;Reg 100 for immediate data
                   
                   JSR          Bit_5to3
                   MOVE.W       D3, Des_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                  
                   JSR          PRINT_EA
                   
                   RTS

*-----------------------------------------------------------
* ADDI
*-----------------------------------------------------------                   
ADDI               LEA          PRINT_ADDI, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                        
                   JSR          Bit_7to6

                   JSR          Evaluate_Size
                  
                   MOVE.W       #7, Source_Mode         ;Mode 111 for immediate data
                   MOVE.W       #4, Source_Reg          ;Reg 100 for immediate data

                   JSR          Bit_5to3
                   MOVE.W       D3, Des_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                  
                   JSR          PRINT_EA

                   RTS
                  
*-------------------------------------------------------------------
* NOP 
*-------------------------------------------------------------------              
NOP                LEA          PRINT_NOP, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                    
                   JSR          PRINT_BLANK

                   RTS
                   
*-------------------------------------------------------------------
* RTS
*-------------------------------------------------------------------
                   
RTS                LEA          PRINT_RTS, A1
                   MOVE.B       #14, D0
                   TRAP         #15

                   JSR          PRINT_BLANK

                   RTS

*-------------------------------------------------------------------
* CLR
*-------------------------------------------------------------------
CLR                LEA          PRINT_CLR, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                        
                   JSR          Bit_7to6            ;Find size

                   JSR          Evaluate_Size
                   
                   JSR          PRINT_TAB
                  
                   JSR          Bit_5to3
                   MOVE.B       D3, D4
                   
                   JSR          Bit_2to0
                   MOVE.B       D3, D5
                  
                   JSR          DECODE_EA
                    
                   JSR          PRINT_BLANK
                   
                   RTS
                   

*----------------------------------------------------------------        
*LEA
*----------------------------------------------------------------        
LEA                LEA          PRINT_LEA, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                                      
                   JSR          PRINT_TAB
                   
                   JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg         
                                    
                   MOVE.W       #1, Des_Mode 

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   JSR          PRINT_EA
                   
                   RTS 

                   
*----------------------------------------------------------------        
*ADDQ
*----------------------------------------------------------------        
ADDQ               LEA          PRINT_ADDQ, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Bit_7to6

                   JSR          Evaluate_Size
                   
                   JSR          PRINT_TAB
                   
                   JSR          PRINT_POUND
                   
                   JSR          PRINT_DOLLAR
 
                   JSR			Bit_11to9           ;Check if value equals eight
				   MOVE.W		D3, D1                   
                   CMP.B		#$0000, D1
                   BEQ			EQUAL_EIGHT
                   
PRINT_OUT          MOVE.B		#3, D0
                   TRAP			#15
                   
                   JSR          PRINT_COMMA
                   
                   JSR          Bit_5to3
                   MOVE.W       D3, D4

                   JSR          Bit_2to0
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   
                   JSR          PRINT_BLANK
                   
                   RTS
                   
EQUAL_EIGHT		   MOVE.W		#8, D1                    

                   BRA			PRINT_OUT                  
*-------------------------------------------------------------------
* JSR
*-------------------------------------------------------------------
                   
JSR                LEA          PRINT_JSR, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          PRINT_TAB
                  
                   JSR          Bit_5to3
                   MOVE.W       D3, D4
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, D5
                  
                   JSR          DECODE_EA
                    
                   JSR          PRINT_BLANK

                   RTS
                   
*-------------------------------------------------------------------
* MOVE_B
*-------------------------------------------------------------------        
          
MOVE_B             LEA          PRINT_MOVE, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Size_Byte

                   JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg         
                   
                   JSR          Bit_8to6                  
                   MOVE.W       D3, Des_Mode

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   JSR          PRINT_EA
                   
                   RTS  
  
*-------------------------------------------------------------------
* MOVE_W
*------------------------------------------------------------------- 
MOVE_W             LEA          PRINT_MOVE, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Size_Word
 
                   JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg
                   
                   JSR          Bit_8to6                  
                   MOVE.W       D3, Des_Mode

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   JSR          PRINT_EA
                   
                   RTS
*-------------------------------------------------------------------
* MOVE_L
*------------------------------------------------------------------- 
MOVE_L             LEA          PRINT_MOVE, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Size_Long

                   JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg
                   
                   JSR          Bit_8to6                  
                   MOVE.W       D3, Des_Mode

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   JSR          PRINT_EA
                   
                   RTS 

*-------------------------------------------------------------------
* MOVEA_W
*-------------------------------------------------------------------    
MOVEA_W            LEA          PRINT_MOVEA, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Size_Word                   

                   JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg
                                    
                   MOVE.W       #1, Des_Mode 

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   JSR          PRINT_EA
                   
                   RTS 

*-------------------------------------------------------------------
* MOVEA_L
*------------------------------------------------------------------- 
MOVEA_L            LEA          PRINT_MOVEA, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Size_Long
                   
                   JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg
                                    
                   MOVE.W       #1, Des_Mode 

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   JSR          PRINT_EA
                   
                   RTS

*-------------------------------------------------------------------
* MOVEM
* A2 - current pointer location
* A6 - temporary loaded register of A2
* D6 - temporary loaded contents of A6
*-------------------------------------------------------------------
MOVEM              LEA          PRINT_MOVEM, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   MOVEA.L      A2, A6
                   MOVE.W       (A6),D6
                   
                   BTST         #6, D6
                   BEQ          MOVEM_WORD
                   
                   BRA          MOVEM_LONG
                   
MOVEM_WORD         JSR          Size_Word

                   MOVE.B       #1, Opcode_Size
                   
                   BRA          CHECK_DIR

MOVEM_LONG         JSR          Size_Long

                   MOVE.B       #2, Opcode_Size

CHECK_DIR          MOVE.B       #10, D2
                   BTST         D2, D6
                   BEQ          REG_TO_MEM
                    
                   BTST         D2, D6
                   BNE          MEM_TO_REG

REG_TO_MEM         ADDA.W       #2, A6
                   CLR.L        D6
                   MOVE.W       (A6),D6     ; read out registers
                                     
                   JSR          PRINT_TAB
                   
                   JSR          Bit_5to3
                   CMP.B        #4, D3
                   BEQ          MODE_PREDECRE
                   
                   CMP.B        #4, D3
                   BNE          MODE_GENERAL
                   
MODE_PREDECRE      JSR          PRE_REG_A

                   JSR          PRE_REG_D 

                   BRA          PRINT_NEXT
                   
MODE_GENERAL       JSR          REG_A
            
                   JSR          REG_D
                   
                   BRA          PRINT_NEXT
                   
PRINT_NEXT         JSR          PRINT_BSCOMMA
                   
                   JSR          Bit_5to3
                   MOVE.W       D3, D4
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, D5
                   
                   CMP.B        #7, D4
                   BEQ          MM_Imm
                   BRA          SKIP
                   
MM_Imm             ADDA.W       #2, A2
                   JSR          DECODE_EA
                   JSR          PRINT_BLANK
                   BRA          MM_BACK                  
                                      
SKIP               JSR          DECODE_EA 
                 
                   JSR          PRINT_BLANK
                   
                   ADDA.W       #2, A2
                   
                   BRA          MM_BACK
                   
MM_BACK            RTS

MEM_TO_REG         ADDA.W       #2, A6
                   CLR.L        D6
                   
                   JSR          PRINT_TAB

                   JSR          Bit_5to3
                   MOVE.W       D3, D4
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, D5
                   
                   CMP.B        #7, D4
                   BEQ          MM_Imm2
                   BRA          SKIP2
                   
MM_Imm2            ADDA.W       #2, A2
                   
                   CLR.L        D3
                   MOVE.W       (A2),D3
                   
                   JSR          DECODE_EA
                   
                   JSR          PRINT_COMMA
                   
                   MOVE.W       D3,D6
                   
                   JSR          REG_A
                   
                   JSR          REG_D
                   
                   JSR          PRINT_BSSPACE
                   
                   JSR          PRINT_BLANK
                                                    
                   BRA          MM_BACK       
                                      
SKIP2              JSR          DECODE_EA

                   JSR          PRINT_COMMA
                   
                   MOVE.W       (A6),D6

                   JSR          REG_A

                   JSR          REG_D
                   
                   JSR          PRINT_BSSPACE

                   JSR          PRINT_BLANK
                   
                   ADDA.W       #2, A2 
                                    
                   BRA          MM_BACK                      
                   
*-------------------------------------------------------------------
* MOVEQ
*-------------------------------------------------------------------                    
MOVEQ              LEA          PRINT_MOVEQ, A1
                   MOVE.B       #14, D0
                   TRAP         #15

                   JSR          Size_Long
                   
                   JSR          PRINT_TAB
                   
                   JSR          PRINT_POUND
                   
                   JSR          PRINT_DOLLAR                         
                   
                   MOVE.B       D3, D7
                   JSR          MOVEQ_DATA
     
                   JSR          PRINT_COMMA
                   
                   MOVE.W       #$0, D4
                   
                   JSR          Bit_11to9
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   
                   JSR          PRINT_BLANK
                   
                   RTS    
                   
**-------------------------------------------------------------------
** BCC BGT BLE
**-------------------------------------------------------------------                    

BCC                LEA          PRINT_BCC, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   
                                      
                   JSR          Bit_7to0
                   CMP.B        #$00, D3
                   BEQ          DISP16BIT
                   CMP.B        #$FF, D3
                   BEQ          DISP32BIT
                   CMP.B        #$FF, D3
                   BNE          DISP8BIT

                   RTS
                  
BGT                LEA          PRINT_BGT, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   
                                      
                   JSR          Bit_7to0
                   CMP.B        #$00, D3
                   BEQ          DISP16BIT
                   CMP.B        #$FF, D3
                   BEQ          DISP32BIT
                   CMP.B        #$FF, D3
                   BNE          DISP8BIT

                   RTS

BLE                LEA          PRINT_BLE, A1
                   MOVE.B       #14, D0
                   TRAP         #15

                   
                   
                   JSR          Bit_7to0
                   CMP.B        #$00, D3
                   BEQ          DISP16BIT
                   CMP.B        #$FF, D3
                   BEQ          DISP32BIT
                   CMP.B        #$FF, D3
                   BNE          DISP8BIT
                   
                   RTS
                   
DISP8BIT           JSR      Size_Byte
                   JSR      PRINT_TAB
                   JSR      PRINT_DOLLAR

                   MOVEA.L  A2, A4
                   ADD.W    #$2, A4
                   
                   CLR.L    D6
                   MOVE.B   D3,D6 
                   ADDA.W   D6,A4
                   MOVE.L   A4,D3
                   MOVE.L   #4,D6

                   JSR      PRINT_HEX       
                   JSR      PRINT_BLANK 
                   ADDA.W   #2, A2
                   BRA      LOOP

                   JMP      BCCRTS
                  
                   
DISP16BIT          JSR      Size_Word
                   JSR      PRINT_TAB
                   JSR      PRINT_DOLLAR

                   MOVEA.L  A2, A4
                   ADDA.W   #2, A4
                   ADD.W    #$2, A4
                   
                   MOVEA.L  A2, A6
                   ADD.W    #$2, A6
                   CLR.L    D6
                   MOVE.W   (A6),D6

                   MULS     #-1,D6
                   SUBA.W   D6,A4
                   MOVE.W   A4,D3
                   SUBI.B   #$2,D3
                   MOVE.L   #4, D6

                   JSR      PRINT_HEX      
                   JSR      PRINT_BLANK 
                   ADDA.w   #4, A2
                   BRA      LOOP

                   JMP      BCCRTS
                   
DISP32BIT          JSR      Size_Word
                   JSR      PRINT_TAB
                   JSR      PRINT_DOLLAR

                   MOVEA.L  A2, A4
                   ADD.W    #$2, A4
                   MULS     #-1,D3
                   
                   CLR.L    D5
                   MOVE.B   D3,D5 
                   SUBA.W   D5,A4
                   MOVE.L   A4,D3
                   MOVE.L   #4, D6

                   JSR      PRINT_HEX       
                   JSR      PRINT_BLANK 
                   ADDA.W   #4, A2
                   BRA      LOOP

                   JMP      BCCRTS
                   
BCCRTS             RTS                   

*-------------------------------------------------------------------
* DIVU
*-------------------------------------------------------------------
DIVU               LEA          PRINT_DIVU, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                  
                   LEA          PRINT_WORD, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg
                   
                   MOVE.W       #0, Des_Mode 

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                    
                   JSR          PRINT_EA
                   

                   RTS

*-------------------------------------------------------------------
* OR
*-------------------------------------------------------------------
OR                 LEA          PRINT_OR, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Bit_7to6

                   JSR          Evaluate_Size
                   
                   JSR          Bit_8to8            ;Find DDD: 0 means <ea> then Dn -> Dn, 1 means Dn then <ea> -> <ea>
                      
                   CMP.B        #0, D3              ;Need two branches, if DDD is 0
                   BEQ          DDD_0

                   CMP.B        #1, D3              ;If DDD is 1
                   BEQ          DDD_1

DDD_0              JSR          Bit_11to9           ;Find destination and source information
                   MOVE.W       D3, Des_Reg
                  
                   JSR          Bit_5to3
                   MOVE.W       D3, Source_Mode
                   
                   MOVE.W       #0, Des_Mode 
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   JSR          PRINT_EA
                   
                   JMP          GOTO_RTS
                   
DDD_1              JSR          Bit_11to9
                   MOVE.W       D3, Source_Reg
                   
                   MOVE.W       #0, Source_Mode 

                   JSR          Bit_5to3
                   MOVE.W       D3, Des_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                   
                   JSR          PRINT_EA
                   
                   JMP          GOTO_RTS

GOTO_RTS           RTS

*-------------------------------------------------------------------
* SUB
*-------------------------------------------------------------------
SUB                LEA          PRINT_SUB, A1
                   MOVE.B       #14, D0
                   TRAP         #15

                   JSR          Bit_7to6

                   JSR          Evaluate_Size
                   
                   JSR          Bit_8to8
                   
                   CMP.B        #0, D3
                   BEQ          DDD2_0
                   
                   CMP.B        #1, D3
                   BEQ          DDD2_1
                   
DDD2_0             JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   MOVE.W       #0, Des_Mode        ;Find destination information

                   JSR          Bit_11to9
                   MOVE.W       D3, Des_Reg                  

                   JSR          PRINT_EA                  
                   
                   BRA          GOTO2_RTS
                                                        
DDD2_1             MOVE.W       #0, Source_Mode     ;Find source information

                   JSR          Bit_11to9
                   MOVE.W       D3, Source_Reg
                                      
                   JSR          Bit_5to3            ;Find destination information
                   MOVE.W       D3, Des_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg

                   JSR          PRINT_EA 

                   BRA          GOTO2_RTS                 
                   
GOTO2_RTS          RTS

*-------------------------------------------------------------------
* CMP 
*-------------------------------------------------------------------
CMP                LEA          PRINT_CMP, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Bit_7to6

                   JSR          Evaluate_Size
                   
                   JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg
                   
                   MOVE.W       #0, Des_Mode 

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                    
                   JSR          PRINT_EA
                   
                   RTS
                   
*-------------------------------------------------------------------
* MULU
*-------------------------------------------------------------------
MULU               LEA          PRINT_MULU, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   LEA          PRINT_WORD, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   MOVE.B       #1, Opcode_Size

                   JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg
                   
                   MOVE.W       #0, Des_Mode 

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                    
                   JSR          PRINT_EA
                   
                   RTS

*-------------------------------------------------------------------
* MULS
*-------------------------------------------------------------------                   
MULS               LEA          PRINT_MULS, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   LEA          PRINT_WORD, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   MOVE.B       #1, Opcode_Size

                   JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg
                   
                   MOVE.W       #0, Des_Mode 

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                    
                   JSR          PRINT_EA
                   
                   RTS

*-------------------------------------------------------------------
* AND
*-------------------------------------------------------------------  
AND                LEA          PRINT_AND, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Bit_7to6

                   JSR          Evaluate_Size
                   
                   JSR          Bit_8to8            ;Find DDD: 0 means <ea> then Dn -> Dn, 1 means Dn then <ea> -> <ea>
                      
                   CMP.B        #0, D3              ;Need two branches, if DDD is 0
                   BEQ          DDD3_0
    
                   CMP.B        #1, D3              ;If DDD is 1
                   BEQ          DDD3_1

DDD3_0             JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   MOVE.W       #0, Des_Mode        ;Find destination information
                   
                   JSR          Bit_11to9
                   MOVE.W       D3, Des_Reg
                   
                   BRA          GOTO3_RTS
    
DDD3_1             MOVE.W       #0, Source_Mode     ;Find source information

                   JSR          Bit_11to9
                   MOVE.W       D3, Source_Reg
                   
                   JSR          Bit_5to3            ;Find destination information
                   MOVE.W       D3, Des_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                   
                   BRA          GOTO3_RTS

GOTO3_RTS          JSR          PRINT_EA  
                   RTS

*-------------------------------------------------------------------
* ADD
*------------------------------------------------------------------- 
ADD                LEA          PRINT_ADD, A1
                   MOVE.B       #14, D0
                   TRAP         #15

                   JSR          Bit_7to6

                   JSR          Evaluate_Size
                   
                   JSR          Bit_8to8            ;Find DDD: 0 means <ea> then Dn -> Dn, 1 means Dn then <ea> -> <ea>
                      
                   CMP.B       #0, D3               ;Need two branches, if DDD is 0
                   BEQ          DDD4_0

                   CMP.B       #1, D3               ;If DDD is 1
                   BEQ          DDD4_1

DDD4_0             JSR          Bit_5to3
                   MOVE.W       D3, Source_Mode     ;Find source information
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   MOVE.W       #0, Des_Mode        ;Find destination information

                   JSR          Bit_11to9
                   MOVE.W       D3, Des_Reg
                                     
                   BRA          GOTO4_RTS
                   
DDD4_1             MOVE.W       #0, Source_Mode     ;Find source information
                   
                   JSR          Bit_11to9
                   MOVE.W       D3, Source_Reg
                   
                   JSR          Bit_5to3
                   MOVE.W       D3, Des_Mode        ;Find destination information
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                   
                   BRA          GOTO4_RTS
                   
GOTO4_RTS          JSR          PRINT_EA
                   RTS


*-------------------------------------------------------------------
* ADDA
*------------------------------------------------------------------- 
ADDA               LEA          PRINT_ADDA, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   JSR          Bit_8to8            ;Find SS: 0 means <ea> then Dn -> Dn, 1 means Dn then <ea> -> <ea>
                      
                   CMP.B        #0, D3              ;Need two branches, if SS is 0
                   BEQ          SS_0

                   CMP.B        #1, D3              ;If SS is 1
                   BEQ          SS_1
                   
SS_0               LEA          PRINT_WORD, A1
                   MOVE.B       #14, D0
                   TRAP         #15

                   MOVE.B       #1, Opcode_Size   

                   JMP          GOTO_HERE
                   
SS_1               LEA          PRINT_LONG, A1
                   MOVE.B       #14, D0
                   TRAP         #15  

                   MOVE.B       #2, Opcode_Size 

                   JMP          GOTO_HERE

GOTO_HERE          JSR          Bit_11to9           ;Find destination information
                   MOVE.W       D3, Des_Reg
                   
                   MOVE.W       #1, Des_Mode 

                   JSR          Bit_5to3            ;Find source information
                   MOVE.W       D3, Source_Mode
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Source_Reg
                   
                   JSR          PRINT_EA    

                   RTS          
               
*----------------------------------------------------------------               
* LSL
*----------------------------------------------------------------                   
LSL                MOVEM.L      A0/A1/A3-A7/D0-D7, -(SP)
                   LEA          PRINT_LSL, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                    
                   JSR          Bit_7to6
                   
                   CMP.B        #$3, D3
                   BEQ          Mem_LSL
                   
                   JSR          Evaluate_Size

                   MOVE.W       (A2),D7
                   BTST         #5, D7
                   BEQ          Imm_LSL
                    
                   BRA          Reg_LSL  
                   
Imm_LSL            JSR          PRINT_TAB
                   JSR          PRINT_POUND

                   JSR          Bit_11to9
                   CLR.L        D1
                   MOVE.B       D3, D1
                   
                   CMP.B        #0, D1
                   BEQ          Imm_Zero
                   
Display_LSL        MOVE.B       #3, D0
                   TRAP         #15
                   
                   JSR          PRINT_COMMA
                   
                   JSR          Bit_2to0
                   
                   MOVE.W       #0, D4
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   
                   JSR          PRINT_BLANK
                   
                   BRA          LSL_DONE                  

Reg_LSL            MOVE.W       #0, Source_Mode         ;Find source information
                
                   JSR          Bit_11to9
                   MOVE.W       D3, Source_Reg
                   
                   MOVE.W       #0, Des_Mode            ;Find destination information
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                   
                   JSR          PRINT_EA
                   
                   BRA          LSL_DONE                  

Mem_LSL            JSR          Size_Word
                   
                   JSR          PRINT_TAB
                   
                   JSR          Bit_5to3
                   MOVE.W       D3, D4
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   
                   JSR          PRINT_BLANK
                   
                   BRA          LSL_DONE
                   
LSL_DONE           MOVEM.L      (SP)+, A0/A1/A3-A7/D0-D7
                   RTS

Imm_Zero           MOVE.W       #8, D1
                   BRA          Display_LSL

*----------------------------------------------------------------               
* LSR
*----------------------------------------------------------------              
LSR                MOVEM.L      A0/A1/A3-A7/D0-D7, -(SP)
                   LEA          PRINT_LSR, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                    
                   JSR          Bit_7to6
                   
                   CMP.B        #$3, D3
                   BEQ          Mem_LSR
                   
                   JSR          Evaluate_Size

                   MOVE.W       (A2),D7
                   BTST         #5, D7
                   BEQ          Imm_LSR
                    
                   BRA          Reg_LSR  
                   
Imm_LSR            JSR          PRINT_TAB

                   JSR          PRINT_POUND

                   JSR          Bit_11to9
                   CLR.L        D1
                   MOVE.B       D3, D1
                   
                   CMP.B        #0, D1
                   BEQ          LSR_Imm_Zero
                   
Display_LSR        MOVE.B       #3, D0
                   TRAP         #15
                   
                   JSR          PRINT_COMMA
                   
                   JSR          Bit_2to0
                   
                   MOVE.W       #0, D4
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   JSR          PRINT_BLANK

                   BRA          LSR_DONE                  

Reg_LSR            MOVE.W       #0, Source_Mode         ;Find source information
                
                   JSR          Bit_11to9
                   MOVE.W       D3, Source_Reg
                   
                   MOVE.W       #0, Des_Mode            ;Find destination information
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                   
                   JSR          PRINT_EA
                   
                   BRA          LSR_DONE                  

Mem_LSR            JSR          Size_Word
                   
                   JSR          PRINT_TAB
                   
                   JSR          Bit_5to3
                   MOVE.W       D3, D4
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   
                   JSR          PRINT_BLANK
                   
                   BRA          LSR_DONE
                   
LSR_DONE           MOVEM.L      (SP)+, A0/A1/A3-A7/D0-D7
                   RTS

LSR_Imm_Zero       MOVE.W       #8, D1
                   BRA          Display_LSR
  

*----------------------------------------------------------------               
* ASL
*----------------------------------------------------------------
ASL                MOVEM.L      A0/A1/A3-A7/D0-D7, -(SP)
                   LEA          PRINT_ASL, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                    
                   JSR          Bit_7to6
                   
                   CMP.B        #$3, D3
                   BEQ          Mem_ASL
                   
                   JSR          Evaluate_Size

                   MOVE.W       (A2),D7
                   BTST         #5, D7
                   BEQ          Imm_ASL
                    
                   BRA          Reg_ASL  
                   
Imm_ASL            JSR          PRINT_TAB

                   JSR          PRINT_POUND

                   JSR          Bit_11to9
                   CLR.L        D1
                   MOVE.B       D3, D1
                   
                   CMP.B        #0, D1
                   BEQ          ASL_Imm_Zero
                   
Display_ASL        MOVE.B       #3, D0
                   TRAP         #15
                   
                   JSR          PRINT_COMMA
                   
                   JSR          Bit_2to0
                   
                   MOVE.W       #0, D4
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   JSR          PRINT_BLANK
                   BRA          ASL_DONE                  

Reg_ASL            MOVE.W       #0, Source_Mode         ;Find source information
                
                   JSR          Bit_11to9
                   MOVE.W       D3, Source_Reg
                   
                   MOVE.W       #0, Des_Mode            ;Find destination information
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                   
                   JSR          PRINT_EA
                   
                   BRA          ASL_DONE                  

Mem_ASL            JSR          Size_Word
                   
                   JSR          PRINT_TAB
                   
                   JSR          Bit_5to3
                   MOVE.W       D3, D4
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   
                   JSR          PRINT_BLANK
                   
                   BRA          ASL_DONE
                   
ASL_DONE           MOVEM.L      (SP),A0/A1/A3-A7/D0-D7
                   RTS

ASL_Imm_Zero       MOVE.W       #8, D1
                   BRA          Display_ASL
*--------------------------------------------------------
* ASR
*--------------------------------------------------------
ASR                MOVEM.L      A0/A1/A3-A7/D0-D7, -(SP)
                   LEA          PRINT_ASR, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                    
                   JSR          Bit_7to6
                   
                   CMP.B        #$3, D3
                   BEQ          Mem_ASR
                   
                   JSR          Evaluate_Size

                   MOVE.W       (A2),D7
                   BTST         #5, D7
                   BEQ          Imm_ASR
                    
                   BRA          Reg_ASR  
                   
Imm_ASR            JSR          PRINT_TAB

                   JSR          PRINT_POUND

                   JSR          Bit_11to9
                   CLR.L        D1
                   MOVE.B       D3, D1
                   
                   CMP.B        #0, D1
                   BEQ          ASR_Imm_Zero
                   
Display_ASR        MOVE.B       #3, D0
                   TRAP         #15
                   
                   JSR          PRINT_COMMA
                   
                   JSR          Bit_2to0
                   
                   MOVE.W       #0, D4
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   JSR          PRINT_BLANK

                   BRA          ASR_DONE                  

Reg_ASR            MOVE.W       #0, Source_Mode         ;Find source information
                
                   JSR          Bit_11to9
                   MOVE.W       D3, Source_Reg
                   
                   MOVE.W       #0, Des_Mode            ;Find destination information
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                   
                   JSR          PRINT_EA
                   
                   BRA          ASR_DONE                  

Mem_ASR            JSR          Size_Word
                   
                   JSR          PRINT_TAB
                   
                   JSR          Bit_5to3
                   MOVE.W       D3, D4
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   
                   JSR          PRINT_BLANK
                   
                   BRA          ASR_DONE
                   
ASR_DONE           MOVEM.L      (SP)+,A0/A1/A3-A7/D0-D7

                   RTS

ASR_Imm_Zero       MOVE.W       #8, D1
                   BRA          Display_ASR 

*--------------------------------------------------------
* ROL
*--------------------------------------------------------
ROL                MOVEM.L      A0/A1/A3-A7/D0-D7, -(SP)
                   LEA          PRINT_ROL, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                    
                   JSR          Bit_7to6
                   
                   CMP.B        #$3, D3
                   BEQ          Mem_ROL
                   
                   JSR          Evaluate_Size

                   MOVE.W       (A2),D7
                   BTST         #5, D7
                   BEQ          Imm_ROL
                    
                   BRA          Reg_ROL  
                   
Imm_ROL            JSR          PRINT_TAB

                   JSR          PRINT_POUND

                   JSR          Bit_11to9
                   CLR.L        D1
                   MOVE.B       D3, D1
                   
                   CMP.B        #0, D1
                   BEQ          ROL_Imm_Zero
                   
Display_ROL        MOVE.B       #3, D0
                   TRAP         #15
                   
                   JSR          PRINT_COMMA
                   
                   JSR          Bit_2to0
                   
                   MOVE.W       #0, D4
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   JSR          PRINT_BLANK

                   BRA          ROL_DONE                  

Reg_ROL            MOVE.W       #0, Source_Mode         ;Find source information
                
                   JSR          Bit_11to9
                   MOVE.W       D3, Source_Reg
                   
                   MOVE.W       #0, Des_Mode            ;Find destination information
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                   
                   JSR          PRINT_EA
                   
                   BRA          ROL_DONE                  

Mem_ROL            JSR          Size_Word
                   
                   JSR          PRINT_TAB
                   
                   JSR          Bit_5to3
                   MOVE.W       D3, D4
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   
                   JSR          PRINT_BLANK
                   
                   BRA          ROL_DONE
                   
ROL_DONE           MOVEM.L      (SP)+,A0/A1/A3-A7/D0-D7
                   RTS

ROL_Imm_Zero       MOVE.W       #8, D1
                   BRA          Display_ROL
  

*--------------------------------------------------------
* ROR
*--------------------------------------------------------
ROR                MOVEM.L      A0/A1/A3-A7/D0-D7, -(SP)
                   LEA          PRINT_ROR, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                    
                   JSR          Bit_7to6
                   
                   CMP.B        #$3, D3
                   BEQ          Mem_ROR
                   
                   JSR          Evaluate_Size

                   MOVE.W       (A2),D7
                   BTST         #5, D7
                   BEQ          Imm_ROR
                    
                   BRA          Reg_ROR  
                   
Imm_ROR            JSR          PRINT_TAB

                   JSR          PRINT_POUND

                   JSR          Bit_11to9
                   CLR.L        D1
                   MOVE.B       D3, D1
                   
                   CMP.B        #0, D1
                   BEQ          ROR_Imm_Zero
                   
Display_ROR        MOVE.B       #3, D0
                   TRAP         #15
                   
                   JSR          PRINT_COMMA
                   
                   JSR          Bit_2to0
                   
                   MOVE.W       #0, D4
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   JSR          PRINT_BLANK

                   BRA          ROR_DONE                  

Reg_ROR            MOVE.W       #0, Source_Mode         ;Find source information
                
                   JSR          Bit_11to9
                   MOVE.W       D3, Source_Reg
                   
                   MOVE.W       #0, Des_Mode            ;Find destination information
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, Des_Reg
                   
                   JSR          PRINT_EA
                   
                   BRA          ROR_DONE                  

Mem_ROR            JSR          Size_Word
                   
                   JSR          PRINT_TAB
                   
                   JSR          Bit_5to3
                   MOVE.W       D3, D4
                   
                   JSR          Bit_2to0
                   MOVE.W       D3, D5
                   
                   JSR          DECODE_EA
                   
                   JSR          PRINT_BLANK
                   
                   BRA          ROR_DONE
                   
ROR_DONE           MOVEM.L      (SP)+, A0/A1/A3-A7/D0-D7
                   RTS

ROR_Imm_Zero       MOVE.W       #8, D1
                   BRA          Display_ROR

*--------------------------------------------------------
* Invalid Op-code handling
*--------------------------------------------------------

OP_INVALID      JSR           PRINT_INVALID

                JSR           PRINT_TAB
                
                JSR           PRINT_DOLLAR
                
                MOVE.B        #1, Opcode_Size
                MOVE.B        Opcode_Size, D5
                
                MOVE.W        (A2),D6
                MOVE.L        #4, D7
                JSR           PRINT_DATA
                     
                JSR           PRINT_BLANK
    
                RTS
































*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
