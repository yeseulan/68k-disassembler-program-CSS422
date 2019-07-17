*-----------------------------------------------------------
* Title      : GROUP B10 BRANCHES
* Written by : YESEUL AN, CHANDLER FORD, CATHERINE SANTOS
* Date       : 6/1/18
* Description: PROGRAM THAT USES FIRST 4 BITS TO DETERMINE 
*                   CORRECT BRANCH FOR DISASSEMBLER
*-----------------------------------------------------------
      
JMP_TABLE       JMP     CODE_0  ;SUBI, ADDI
                JMP     CODE_1  ;MOVE.B  
                JMP     CODE_2  ;MOVE.L, MOVEA 
                JMP     CODE_3  ;MOVE.W 
                JMP     CODE_4  ;NOP, RTS
                JMP     CODE_5  ;ADDQ     
                JMP     CODE_6  ;Bcc
                JMP     CODE_7  ;MOVEQ  
                JMP     CODE_8  ;DIVU, OR
                JMP     CODE_9  ;SUB
                JMP     CODE_A  ; Unassigned
                JMP     CODE_B  ;CMP 
                JMP     CODE_C  ;MULU, MULS, AND
                JMP     CODE_D  ;ADD, ADDA
                JMP     CODE_E  ;Rotation
; FIRST 4 BITS = 0000                                        
CODE_0          JSR     Bit_11to8  
                       
                CMP.B   #$4, D3
                BEQ     SUBI
                       
                CMP.B   #$6, D3
                BEQ     ADDI

                BRA     OP_INVALID
                
;; FIRST 4 BITS = 0001         
CODE_1          JSR     MOVE_B
                
                RTS
                
;; FIRST 4 BITS = 0010
CODE_2          JSR     Bit_8to6
                CMP.B   #%001, D3
                BEQ     MOVEA_L
                
                CMP.B   #%001, D3
                BNE     MOVE_L

                RTS

;; FIRST 4 BITS = 0011
CODE_3          JSR     Bit_8to6
                CMP.B   #%001, D3
                BEQ     MOVEA_W

                CMP.B   #%001, D3
                BNE     MOVE_W

                RTS

;; FIRST 4 BITS = 0100
CODE_4          JSR     Bit_11to8                               
                CMP.B   #$2, D3 
                BEQ     CLR
                
                CMP.B   #$E, D3
                BEQ     CODE_4E
                
                JSR     Bit_11to6
                ANDI.B  #%00101110,D3
                
                CMP.B   #%00100010,D3
                BEQ     MOVEM
                                          
                JSR     Bit_8to6
                  
                CMP.B   #%111, D3 
                BEQ     LEA

                BRA     OP_INVALID
                
;; FIRST 4 BITS = 0101
CODE_5          MOVE.W  (A2),D3
                BTST    #8, D3
                BEQ     ADDQ

                BRA     OP_INVALID
                
;; FIRST 4 BITS = 0110
CODE_6          JSR     Bit_11to8       
                
                CMP.B   #$4,D3
                BEQ     BCC     
         
                CMP.B   #$E,D3
                BEQ     BGT  
            
                CMP.B   #$F,D3
                BEQ     BLE              
                
                BRA     OP_INVALID
                RTS 

;; FIRST 4 BITS = 0111
CODE_7          MOVE.W  (A2),D3
                BTST    #8, D3
                BEQ     MOVEQ

                BRA     OP_INVALID
                RTS

;; FIRST 4 BITS = 1000
CODE_8          ;DIVU, OR
                JSR     Bit_8to6   
                
                CMP.B   #$3, D3
                BEQ     DIVU
                
                CMP.B   #$3, D3
                BNE     OR  
                
;; FIRST 4 BITS = 1001
CODE_9          JSR     Bit_7to6         

                CMP.B   #%11,D3         ; handles SUBA
                BEQ     OP_INVALID             

                JSR     Bit_8to4        
                ANDI.B  #%00010011,D3
                
                CMP.B   #%00010000,D3
                BEQ     OP_INVALID          
                
                BRA     SUB 
                RTS  
           
;; FIRST 4 BITS = 1010
CODE_A          BEQ     OP_INVALID 

;; FIRST 4 BITS = 1011
CODE_B          JSR     Bit_8to6         ;Reads A2, Returns D7

                CMP.B   #%000,D3
                BEQ     CMP              ;%000
                CMP.B   #%001,D3
                BEQ     CMP              ;%001
                CMP.B   #%010,D3
                BEQ     CMP              ;%010
                
                BRA     OP_INVALID          ;No matches found

;; FIRST 4 BITS = 1100
CODE_C          JSR     Bit_8to6 
                CMP.B   #$3, D3
                BEQ     MULU
                CMP.B   #$7, D3
                BEQ     MULS

                JSR     Bit_8to4      
                ANDI.B  #%00011111,D3       
                
                CMP.B   #%00010000,D3
                BEQ     OP_INVALID         
                
                JSR     Bit_8to4        
                ANDI.B  #%00010011,D3       
                
                CMP.B   #%00010000,D3
                BEQ     OP_INVALID         
                BRA     AND

;; FIRST 4 BITS = 1101
CODE_D          JSR     Bit_7to6   
                
                CMP.B   #$3, D3
                BEQ     ADDA 
                BNE     ADD


                RTS

;; Rotation FIRST 4 BITS = 1110
CODE_E          CLR.L   D3
                JSR     Bit_7to6
                MOVE.L  D3, D1
                
                CMP.B   #%00000011, D1
                BEQ     CODE_E_MEM

                CMP.B   #%00000000, D1
                BEQ     CODE_E_REG
                
                CMP.B   #%00000001, D1
                BEQ     CODE_E_REG
                
                CMP.B   #%00000010, D1
                BEQ     CODE_E_REG

CODE_E_REG      CLR.L       D3
                JSR     Bit_4to3
                MOVE.L  D3, D1
                
                CMP.B   #%00000000, D1
                BEQ     CODE_E_ASd
                
                CMP.B   #%00000001, D1
                BEQ     CODE_E_LSd         
                
                CMP.B   #%00000011, D1
                BEQ     CODE_E_ROd  

                BRA     OP_INVALID
                
CODE_E_MEM      CLR.L       D3
                JSR     Bit_11to9
                MOVE.L  D3, D1

                CMP.B   #%00000000, D1
                BEQ     CODE_E_ASd
                
                CMP.B   #%00000001, D1
                BEQ     CODE_E_LSd
                
                CMP.B   #%00000011, D1
                BEQ     CODE_E_ROd
                
                BRA     OP_INVALID
                          
               
CODE_E_LSd      CLR.L       D3
                JSR     Bit_8to8
                MOVE.L  D3, D1
                
                CMP.B   #%00000001, D1
                BEQ     LSL
                
                CMP.B   #%00000000, D3
                BEQ     LSR

                BRA     OP_INVALID
 
                
CODE_E_ASd      CLR.L       D3
                JSR     Bit_8to8
                MOVE.L  D3, D1
                
                CMP.B   #%00000001, D1
                BEQ     ASL
                
                CMP.B   #%00000000, D1
                BEQ     ASR
                
                BRA     OP_INVALID


CODE_E_ROd      CLR.L   D3
                JSR     Bit_8to8
                MOVE.L  D3, D1
                
                CMP.B   #%00000001, D1
                BEQ     ROL
                
                CMP.B   #000000000,D1
                BEQ     ROR

                BRA     OP_INVALID
                        

;; SUB-GROUP OF CODE4
CODE_4E         JSR     Bit_7to6
                
                CMP.B   #$2, D3
                BEQ     JSR 
                
                JSR     Bit_7to4

                CMP.B   #$7, D3
                BEQ     CODE_4E7
                BRA     OP_INVALID

;; SUB-GROUP OF CODE4
CODE_4E7        JSR     Bit_3to0

                CMP.B   #$1, D3 
                BEQ     NOP
                
                CMP.B   #$5, D3 
                BEQ     RTS
                BRA		OP_INVALID







































































*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
