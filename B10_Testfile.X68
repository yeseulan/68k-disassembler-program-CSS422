*-----------------------------------------------------------
* Title      : GROUP B10 TESTFILE
* Written by : YESEUL AN, CHANDLER FORD, CATHERINE SANTOS
* Date       : 6/1/18
* Description: TESTFILE THAT IS USED FOR DISASSEMBLER PROGRAM
*                   FILE IS BASED ON THE deco_test FILE 
*----------------------------------------------------------

START   ORG     $7000
        
    ADDI.B    #$12,D1
    ADDI.B    #$12,(A0)
    ADDI.B    #$12,(A0)+
    ADDI.B    #$12,-(A0)
    ADDI.B    #$12,$1234
    ADDI.B    #$12,$12345678
    ADDI.W    #$1234,D1
    ADDI.W    #$1234,(A0)
    ADDI.W    #$1234,(A0)+
    ADDI.W    #$1234,-(A0)
    ADDI.W    #$1234,$1234
    ADDI.W    #$1234,$12345678
    ADDI.L    #$12345678,D1
    ADDI.L    #$12345678,(A0)
    ADDI.L    #$12345678,(A0)+
    ADDI.L    #$12345678,-(A0)
    ADDI.L    #$12345678,$1234
    ADDI.L    #$12345678,$12345678

    SUBI.B    #$12,D1
    SUBI.B    #$12,(A0)
    SUBI.B    #$12,(A0)+
    SUBI.B    #$12,-(A0)
    SUBI.B    #$12,$1234
    SUBI.B    #$12,$12345678
    SUBI.W    #$1234,D1
    SUBI.W    #$1234,(A0)
    SUBI.W    #$1234,(A0)+
    SUBI.W    #$1234,-(A0)
    SUBI.W    #$1234,$1234
    SUBI.W    #$1234,$12345678
    SUBI.L    #$12345678,D1
    SUBI.L    #$12345678,(A0)
    SUBI.L    #$12345678,(A0)+
    SUBI.L    #$12345678,-(A0)
    SUBI.L    #$12345678,$1234
    SUBI.L    #$12345678,$12345678
    
    MOVEA.W    D0,A0
    MOVEA.W    A0,A0
    MOVEA.W    (A0),A0
    MOVEA.W    (A0)+,A0
    MOVEA.W    -(A0),A0
    MOVEA.L    D0,A0
    MOVEA.L    A0,A0
    MOVEA.L    (A0),A0
    MOVEA.L    (A0)+,A0
    MOVEA.L    -(A0),A0 
    
    MOVE.B    D0,D1
    MOVE.B    D0,(A0)
    MOVE.B    D0,(A0)+
    MOVE.B    D0,-(A0)
    MOVE.B    (A0),D0
    MOVE.B    (A0),(A1)
    MOVE.B    (A0),(A1)+
    MOVE.B    (A0),-(A1)
    MOVE.B    (A0)+,D0
    MOVE.B    (A0)+,(A1)
    MOVE.B    (A0)+,(A1)+
    MOVE.B    (A0)+,-(A1)
    MOVE.B    -(A0),D0
    MOVE.B    -(A0),(A1)
    MOVE.B    -(A0),(A1)+
    MOVE.B    -(A0),-(A1)
    MOVE.W    D0,D1
    MOVE.W    D0,(A0)
    MOVE.W    D0,(A0)+
    MOVE.W    D0,-(A0)
    MOVE.W    A0,D0
    MOVE.W    A0,(A1)
    MOVE.W    A0,(A1)+
    MOVE.W    A0,-(A1)
    MOVE.W    (A0),D0
    MOVE.W    (A0),(A1)
    MOVE.W    (A0),(A1)+
    MOVE.W    (A0),-(A1)
    MOVE.W    (A0)+,D0
    MOVE.W    (A0)+,(A1)
    MOVE.W    (A0)+,(A1)+
    MOVE.W    (A0)+,-(A1)
    MOVE.W    -(A0),D0
    MOVE.W    -(A0),(A1)
    MOVE.W    -(A0),(A1)+
    MOVE.W    -(A0),-(A1)
    MOVE.L    D0,D1
    MOVE.L    D0,(A0)
    MOVE.L    D0,(A0)+
    MOVE.L    D0,-(A0)
    MOVE.L    A0,D0
    MOVE.L    A0,(A1)
    MOVE.L    A0,(A1)+
    MOVE.L    A0,-(A1)
    MOVE.L    (A0),D0
    MOVE.L    (A0),(A1)
    MOVE.L    (A0),(A1)+
    MOVE.L    (A0),-(A1)
    MOVE.L    (A0)+,D0
    MOVE.L    (A0)+,(A1)
    MOVE.L    (A0)+,(A1)+
    MOVE.L    (A0)+,-(A1)
    MOVE.L    -(A0),D0
    MOVE.L    -(A0),(A1)
    MOVE.L    -(A0),(A1)+
    MOVE.L    -(A0),-(A1)

    CLR.B     D0
    CLR.B     D7
    CLR.W     D0
    CLR.W     D7
    CLR.L     D0
    CLR.L     D7
    CLR.B     (A0)
    CLR.B     (A7)
    CLR.W     (A0)
    CLR.W     (A7)
    CLR.L     (A0)
    CLR.L     (A7)
    CLR.B     (A0)+
    CLR.B     (A7)+
    CLR.W     (A0)+
    CLR.W     (A7)+
    CLR.L     (A0)+
    CLR.L     (A7)+
    CLR.B     -(A0)
    CLR.B     -(A7)
    CLR.W     -(A0)
    CLR.W     -(A7)
    CLR.L     -(A0)
    CLR.L     -(A7)
    
    JSR       (A0)
    JSR       $1234
    JSR       $12345678
    JSR       label1
    JSR       label2
    JSR       label3
   
    MOVEM.W   A1-A7,-(A1)
    MOVEM.L   D1-D7,-(A1)
    MOVEM.W   A1/D7,-(A1)
    MOVEM.L   A1/D7,-(A1)
    MOVEM.W   A1-A7,(A1)
    MOVEM.L   D1-D7,(A1)
    MOVEM.W   A1/D7,(A1)
    MOVEM.L   A1/D7,(A1)
    MOVEM.W   (A1)+,A1-A7
    MOVEM.L   (A1)+,D1-D7
    MOVEM.W   (A1)+,A1/D7
    MOVEM.L   (A1)+,A1/D7
    MOVEM.W   (A1),A1-A7
    MOVEM.L   (A1),D1-D7
    MOVEM.W   (A1),A1/D7
    MOVEM.L   (A1),A1/D7
    
    LEA     (A0),A0
    LEA     (A5),A0
    LEA     (A7),A0
    LEA     (A0),A7
    LEA     (A5),A7
    LEA     (A7),A7
    LEA       $12,A0
    LEA       $1234,A0
    LEA       $12345678,A0
    
    ADDQ      #$1,D0
    ADDQ      #$3,D0
    ADDQ      #$8,D0
    
label1    
    NOP
label2    
    NOP
label3    
    NOP
    
    BCC         label1   
    BCC         label2
    BCC         label3
    BGT         label1   
    BGT         label2
    BGT         label3
    BLE         label1
    BLE         label2
    BLE         label3
    
    MOVEQ     #$12,D0
    MOVEQ     #$0,D0
    MOVEQ     #$FF,D0
    MOVEQ     #$DF,D0
    MOVEQ     #$40,D3
    MOVEQ     #$55,D7
    
    DIVU.W    D0,D1
    DIVU.W    (A0),D1
    DIVU.W    -(A0),D1
    DIVU.W    (A0)+,D1
    
    OR.B     D1,D2
    OR.B     D1,(A1)
    OR.B     D1,(A1)+
    OR.B     D1,-(A1)
    OR.B     (A1),D1
    OR.B     (A1)+,D1
    OR.B     -(A1),D1
    OR.W     D1,D2
    OR.W     D1,(A1)
    OR.W     D1,(A1)+
    OR.W     D1,-(A1)
    OR.W     (A1),D1
    OR.W     (A1)+,D1
    OR.W     -(A1),D1
    OR.L     D1,D2
    OR.L     D1,(A1)
    OR.L     D1,(A1)+
    OR.L     D1,-(A1)
    OR.L     (A1),D1
    OR.L     (A1)+,D1
    OR.L     -(A1),D1
    
    SUB.B     D1,D2
    SUB.B     D1,(A1)
    SUB.B     D1,(A1)+
    SUB.B     D1,-(A1)
    SUB.B     (A1),D1
    SUB.B     (A1)+,D1
    SUB.B     -(A1),D1
    SUB.W     D1,D2
    SUB.W     D1,A1
    SUB.W     D1,(A1)
    SUB.W     D1,(A1)+
    SUB.W     D1,-(A1)
    SUB.W     A1,D1
    SUB.W     (A1),D1
    SUB.W     (A1)+,D1
    SUB.W     -(A1),D1
    SUB.L     D1,D2
    SUB.L     D1,A1
    SUB.L     D1,(A1)
    SUB.L     D1,(A1)+
    SUB.L     D1,-(A1)
    SUB.L     A1,D1
    SUB.L     (A1),D1
    SUB.L     (A1)+,D1
    SUB.L     -(A1),D1  
    
    CMP.B    D0,D1
    CMP.B    (A0),D1
    CMP.B    -(A0),D1
    CMP.B    (A0)+,D1
    CMP.W    D0,D1
    CMP.W    A0,D1
    CMP.W    (A0),D1
    CMP.W    -(A0),D1
    CMP.W    (A0)+,D1
    CMP.L    D0,D1
    CMP.L    A0,D1
    CMP.L    (A0),D1
    CMP.L    -(A0),D1
    
    MULU.W    D0,D1
    MULU.W    (A0),D1
    MULU.W    -(A0),D1
    MULU.W    (A0)+,D1
    
    MULS.W    D0,D1
    MULS.W    (A0),D1
    MULS.W    -(A0),D1
    MULS.W    (A0)+,D1

    AND.B     D1,D2
    AND.B     D1,(A1)
    AND.B     D1,(A1)+
    AND.B     D1,-(A1)
    AND.B     (A1),D1
    AND.B     (A1)+,D1
    AND.B     -(A1),D1
    AND.W     D1,D2
    AND.W     D1,(A1)
    AND.W     D1,(A1)+
    AND.W     D1,-(A1)
    AND.W     (A1),D1
    AND.W     (A1)+,D1
    AND.W     -(A1),D1
    AND.L     D1,D2
    AND.L     D1,(A1)
    AND.L     D1,(A1)+
    AND.L     D1,-(A1)
    AND.L     (A1),D1
    AND.L     (A1)+,D1
    AND.L     -(A1),D1
    
    ADD.B     D1,D2
    ADD.B     D1,(A1)
    ADD.B     D1,(A1)+
    ADD.B     D1,-(A1)
    ADD.B     (A1),D1
    ADD.B     (A1)+,D1
    ADD.B     -(A1),D1
    ADD.W     D1,D2
    ADD.W     D1,(A1)
    ADD.W     D1,(A1)+
    ADD.W     D1,-(A1)
    ADD.W     (A1),D1
    ADD.W     (A1)+,D1
    ADD.W     -(A1),D1
    ADD.L     D1,D2
    ADD.L     D1,(A1)
    ADD.L     D1,(A1)+
    ADD.L     D1,-(A1)
    ADD.L     (A1),D1
    ADD.L     (A1)+,D1
    ADD.L     -(A1),D1
    
    ADDA.W        D1,A2
    ADDA.W        (A1),A2
    ADDA.W        (A1)+,A2
    ADDA.W        -(A1),A2
    ADDA.L        D1,A2
    ADDA.L        (A1),A2
    ADDA.L        (A1)+,A2
    ADDA.L        -(A1),A2
    
    ASR.B     D1,D2
    ASR.W     D1,D2
    ASR.W     (A1)
    ASR.W     (A1)+
    ASR.W     -(A1)
    ASR.L     D1,D2
    
    ASL.B     D1,D2
    ASL.W     D1,D2
    ASL.W     (A1)
    ASL.W     (A1)+
    ASL.W     -(A1)
    ASL.L     D1,D2
    
    LSR.B     D1,D2
    LSR.W     D1,D2
    LSR.W     (A1)
    LSR.W     (A1)+
    LSR.W     -(A1)
    LSR.L     D1,D2 
    
    LSL.B     D1,D2
    LSL.W     D1,D2
    LSL.W     (A1)
    LSL.W     (A1)+
    LSL.W     -(A1)
    LSL.L     D1,D2
    
    ROR.B     D1,D2
    ROR.W     D1,D2
    ROR.W     (A1)
    ROR.W     (A1)+
    ROR.W     -(A1)
    ROR.L     D1,D2 
    
    ROL.B     D1,D2
    ROL.W     D1,D2
    ROL.W     (A1)
    ROL.W     (A1)+
    ROL.W     -(A1)
    ROL.L     D1,D2
    
    
    
    END START

*--------------------------------------------------------        

     




























































*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
