*-----------------------------------------------------------
* Title      : GROUP B10 DEFINITIONS
* Written by : YESEUL AN, CHANDLER FORD, CATHERINE SANTOS
* Date       : 6/1/18
* Description: DEFINITIONS AND PRINTING/CONSOLE MESSAGES
*                   FOR DISASSEMBLER
*-----------------------------------------------------------
*------------------------------------------------------------
* Definitions
*-----------------------------------------------------------
               
CR              EQU             $0D     ; Carriage Return
LF              EQU             $0A     ; Line fed
BS              EQU             $08     ; backspace
COUNTER         DS.B            1       ; Counter for the output lines
INPUT           DS.L            1       ; Save input address from the user
Stack           EQU             $B000
StartAddr       EQU             $00002000 
EndAddr         EQU             $000FFFFE
Flag            DS.B            1
Source_Mode     DS.W            1
Source_Reg      DS.W            1
Des_Mode        DS.W            1
Des_Reg         DS.W            1
Opcode_Size     DS.B            1
Address_Size    DS.B            1
COUNT_LOOP      DS.B            1
ANSWER          DS.L            1

*------------------------------------------------------------------
* CONSOLE MESSAGES
*------------------------------------------------------------------   
WELCOME         DC.B            'Welcome to the team B10 68K disassembler.', CR, LF, 0
START_MESSAGE   DC.B            'Please enter the starting address (length of 4): ',0
END_MESSAGE     DC.B            'Please enter the ending address (length of 4): ',0
LENGTH_MESSAGE  DC.B            'The address has over 8 characters. Enter less than 8 characters.', CR,LF,0 
INVALID_MESSAGE DC.B            'The address contains invalid character. Please input 0-9, A-F(a-f) for address.', CR,LF,0
ODD_MESSAGE     DC.B            'An odd address is not allowed. Enter an even address.',CR,LF,0
AGAIN_MESSAGE   DC.B            'All data in the range is disassembled.', CR, LF, CR, LF
                DC.B            'Do you want to run the program again?(yes/no)', 0
PAUSE_MESSAGE   DC.B            'To continue the output press the enter.', CR, LF, 0
END_POINT       DC.B            'The program reaches the end. Do you want to restart the program?(yes/no)?', 0
INVALID         DC.B            'DATA', 0                
*-------------------------------------------------------------------
* Messages for Op-Codes
*-------------------------------------------------------------------
PRINT_NOP       DC.B    'NOP',0
PRINT_MOVE      DC.B    'MOVE',0
PRINT_MOVEA     DC.B    'MOVEA',0
PRINT_MOVEQ     DC.B    'MOVEQ',0
PRINT_MOVEM     DC.B    'MOVEM',0
PRINT_ADD       DC.B    'ADD',0
PRINT_ADDA      DC.B    'ADDA',0
PRINT_ADDI      DC.B    'ADDI',0
PRINT_ADDQ      DC.B    'ADDQ',0
PRINT_SUB       DC.B    'SUB',0
PRINT_SUBI      DC.B    'SUBI',0
PRINT_MULS      DC.B    'MULS',0
PRINT_MULU      DC.B    'MULU',0
PRINT_DIVU      DC.B    'DIVU',0
PRINT_LEA       DC.B    'LEA',0
PRINT_CLR       DC.B    'CLR',0
PRINT_AND       DC.B    'AND',0
PRINT_OR        DC.B    'OR',0
PRINT_LSL       DC.B    'LSL',0
PRINT_LSR       DC.B    'LSR',0
PRINT_ASR       DC.B    'ASR',0
PRINT_ASL       DC.B    'ASL',0
PRINT_ROL       DC.B    'ROL',0
PRINT_ROR       DC.B    'ROR',0
PRINT_CMP       DC.B    'CMP',0
PRINT_BCC       DC.B    'BCC',0
PRINT_BGT       DC.B    'BGT',0
PRINT_BLE       DC.B    'BLE',0
PRINT_JSR       DC.B    'JSR',0
PRINT_RTS       DC.B    'RTS',0

*-------------------------------------------------------------------
* Messages for Sizes
*-------------------------------------------------------------------

PRINT_BYTE      DC.B    '.B',0
PRINT_WORD      DC.B    '.W',0
PRINT_LONG      DC.B    '.L',0
  
*-------------------------------------------------------------------
* Messages for other symbols
*-------------------------------------------------------------------
TAB       DC.B    '   ',0
COMMA     DC.B    ',',0
BLANK     DC.B    CR, LF, 0
DOLLAR    DC.B    '$',0
POUND     DC.B    '#',0
OPENP     DC.B    '(',0
CLOSEP    DC.B    ')',0
PLUS      DC.B    '+',0
DECRE     DC.B    '-',0
SLASH     DC.B    '/',0
BSCOMMA   DC.B    BS, ',',0
BSSPACE   DC.B    BS, ' ',0
*--------------------------------------------------------------------
* Messages for hexadecimals
*--------------------------------------------------------------------
HEX_0       DC.B        '0',0
HEX_1       DC.B        '1',0
HEX_2       DC.B        '2',0
HEX_3       DC.B        '3',0
HEX_4       DC.B        '4',0
HEX_5       DC.B        '5',0
HEX_6       DC.B        '6',0
HEX_7       DC.B        '7',0
HEX_8       DC.B        '8',0
HEX_9       DC.B        '9',0
HEX_A       DC.B        'A',0
HEX_B       DC.B        'B',0
HEX_C       DC.B        'C',0
HEX_D       DC.B        'D',0
HEX_E       DC.B        'E',0
HEX_F       DC.B        'F',0

*--------------------------------------------------------------------
* Messages for Address/Data Registers
*--------------------------------------------------------------------
A_0         DC.B        'A0',0
A_1         DC.B        'A1',0
A_2         DC.B        'A2',0
A_3         DC.B        'A3',0
A_4         DC.B        'A4',0
A_5         DC.B        'A5',0
A_6         DC.B        'A6',0
A_7         DC.B        'A7',0
D_0         DC.B        'D0',0
D_1         DC.B        'D1',0
D_2         DC.B        'D2',0
D_3         DC.B        'D3',0
D_4         DC.B        'D4',0
D_5         DC.B        'D5',0
D_6         DC.B        'D6',0
D_7         DC.B        'D7',0

*-------------------------------------------------------------------
* Printing Special Characters
*-------------------------------------------------------------------
PRINT_OPENP     LEA             OPENP, A1
                MOVE.B          #14, D0
                TRAP            #15
                
                RTS
                
PRINT_CLOSEP    LEA             CLOSEP, A1
                MOVE.B          #14, D0
                TRAP            #15
                
                RTS
             
PRINT_PLUS      LEA             PLUS, A1
                MOVE.B          #14, D0
                TRAP            #15
                              
                RTS
                
PRINT_DECRE     LEA             DECRE, A1
                MOVE.B          #14, D0
                TRAP            #15 

                RTS               

PRINT_INVALID   LEA             INVALID, A1
                MOVE.B          #14, D0
                TRAP            #15
                
                RTS
                
PRINT_TAB       LEA             TAB, A1
                MOVE.B          #14, D0
                TRAP            #15

                RTS       
    

PRINT_BLANK     LEA           BLANK, A1
                MOVE.B        #14, D0
                TRAP          #15
                
                RTS


PRINT_DOLLAR    LEA             DOLLAR, A1
                MOVE.B          #14, D0
                TRAP            #15
                
                RTS

PRINT_POUND     LEA             POUND, A1
                MOVE.B          #14, D0
                TRAP            #15
                
                RTS

PRINT_COMMA     LEA             COMMA, A1
                MOVE.B          #14, D0
                TRAP            #15
                
                RTS
                
PRINT_SLASH     LEA             SLASH, A1
                MOVE.B          #14, D0
                TRAP            #15
                
                RTS

PRINT_BSCOMMA   LEA             BSCOMMA, A1
                MOVE.B          #14, D0
                TRAP            #15
                
                RTS

PRINT_BSSPACE   LEA             BSSPACE, A1
                MOVE.B          #14, D0
                TRAP            #15

                RTS                
*-------------------------------------------------------------------
* Printing Hexadecimals
*-------------------------------------------------------------------  
PRINT_0         LEA             HEX_0, A1
                MOVE.B          #14, D0
                TRAP            #15
                RTS
                
PRINT_1         LEA             HEX_1, A1
                MOVE.B          #14, D0
                TRAP            #15
                RTS
                
PRINT_2         LEA             HEX_2, A1
                MOVE.B          #14, D0
                TRAP            #15
                RTS  

PRINT_3         LEA             HEX_3, A1
                MOVE.B          #14, D0
                TRAP            #15
                RTS          
            
PRINT_4         LEA             HEX_4, A1
                MOVE.B          #14, D0
                TRAP            #15
                RTS
                
PRINT_5         LEA             HEX_5, A1
                MOVE.B          #14, D0
                TRAP            #15
                RTS  

PRINT_6         LEA             HEX_6, A1
                MOVE.B          #14, D0
                TRAP            #15
                RTS           
      
PRINT_7         LEA             HEX_7, A1
                MOVE.B          #14, D0
                TRAP            #15
                RTS
                
PRINT_8         LEA             HEX_8, A1
                MOVE.B          #14, D0
                TRAP            #15
                RTS  

PRINT_9         LEA             HEX_9, A1
                MOVE.B          #14, D0
                TRAP            #15
                RTS
                
PRINT_A     LEA         HEX_A, A1
                 MOVE.B   #14, D0
                 TRAP        #15
                 
                 RTS
                 
PRINT_B     LEA         HEX_B, A1
                 MOVE.B   #14, D0
                 TRAP        #15
                 
                 RTS

PRINT_C     LEA         HEX_C, A1
                 MOVE.B   #14, D0
                 TRAP        #15
                 
                 RTS

PRINT_D     LEA         HEX_D, A1
                 MOVE.B   #14, D0
                 TRAP        #15
                 
                 RTS
                 
PRINT_E     LEA         HEX_E, A1
                 MOVE.B   #14, D0
                 TRAP        #15
                 
                 RTS

PRINT_F    LEA         HEX_F, A1
                 MOVE.B   #14, D0
                 TRAP        #15
                 
                 RTS

*-------------------------------------------------------------------
* Printing Address/Data registers
*-------------------------------------------------------------------
P_D0               LEA          D_0, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   RTS
                  
P_D1               LEA         D_1, A1
                   MOVE.B      #14, D0
                   TRAP        #15
                   
                   RTS
                   
P_D2               LEA         D_2, A1
                   MOVE.B      #14, D0
                   TRAP        #15
                   
                   RTS
                   
P_D3               LEA         D_3, A1
                   MOVE.B      #14, D0
                   TRAP        #15
                   
                   RTS
                   
P_D4               LEA         D_4, A1
                   MOVE.B      #14, D0
                   TRAP        #15                   
                   
                   RTS
                   
P_D5               LEA          D_5, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                                      
                   RTS
                   
P_D6               LEA          D_6, A1
                   MOVE.B      #14, D0
                   TRAP        #15
                   
                   RTS
                

P_D7               LEA         D_7, A1
                   MOVE.B      #14, D0
                   TRAP        #15
                   
                   RTS
                                   
P_A0               LEA          A_0, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                   
                   RTS
                
P_A1               LEA         A_1, A1
                   MOVE.B      #14, D0
                   TRAP        #15
                   
                   RTS
                   
P_A2               LEA         A_2, A1
                   MOVE.B      #14, D0
                   TRAP        #15
                   
                   RTS
                   
P_A3               LEA         A_3, A1
                   MOVE.B      #14, D0
                   TRAP        #15
                   
                   RTS
                   
P_A4               LEA         A_4, A1
                   MOVE.B      #14, D0
                   TRAP        #15                   
                   
                   RTS
                   
P_A5               LEA          A_5, A1
                   MOVE.B       #14, D0
                   TRAP         #15
                                      
                   RTS
                   
P_A6               LEA          A_6, A1
                   MOVE.B      #14, D0
                   TRAP        #15
                   
                   RTS
                

P_A7               LEA         A_7, A1
                   MOVE.B      #14, D0
                   TRAP        #15
                   
                   RTS














































*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
