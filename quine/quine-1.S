 .code 32
 .align 4
 .global main
main:
 SUB  r3,  pc, #0x00000008
 MOV r11,  r3
 MOV r12,  lr
 ADD  r1, r11, #0x00000500
 MOV  r2, #0x00000028
 BL main +0x0000041c
 LDR  r4,[  r3]
 MOV  r5,  r4, LSR #0x0000001c
 AND  r7,  r4, #0x0ff00000
 CMP  r7, #0x01200000
 ANDEQ  r7,  r4, #0x000ff000
 CMPEQ  r7, #0x000ff000
 ANDEQ  r7,  r4, #0x00000ff0
 CMPEQ  r7, #0x00000f10
 BEQ main +0x00000224
 MOV  r6, #0x00000001
 MOV  r7,  r4, LSR #0x00000017
 AND  r7,  r7, #0x0000001c
 ADD  pc,  pc,  r7
 MOV  r0,  r0
 B main +0x00000070
 B main +0x00000074
 B main +0x000000ec
 B main +0x000000f0
 B main +0x0000013c
 B main +0x000001d8
 MOV  r0,  r0
 B main +0x00000240
 MOV  r6, #0x00000000
 MOV  r7,  r4, LSR #0x00000013
 AND  r7,  r7, #0x0000003c
 ADD  r1, r11, #0x00000570
 ADD  r1,  r1,  r7
 MOV  r2, #0x00000004
 BL main +0x0000041c
 BL main +0x00000368
 MOV  r0,  r7, LSR #0x00000004
 CMP  r0, #0x00000002
 BEQ main +0x000000a8
 MOV  r0,  r4, LSR #0x0000000c
 BL main +0x000003f0
 BL main +0x00000404
 MOV  r0,  r7, LSR #0x00000002
 ORR  r0,  r0, #0x00000002
 CMP  r0, #0x0000000f
 BEQ main +0x000000c4
 MOV  r0,  r4, LSR #0x00000010
 BL main +0x000003f0
 BL main +0x00000404
 CMP  r6, #0x00000001
 BNE main +0x00000260
 AND  r0,  r4, #0x000000ff
 MOV  r1,  r4, LSR #0x00000008
 AND  r1,  r1, #0x0000000f
 MOV  r1,  r1, LSL #0x00000001
 MOV  r0,  r0, ROR  r1
 MOV  r1, #0x00000000
 BL main +0x00000380
 B main +0x000002b8
 MOV  r6, #0x00000000
 ADD  r1, r11, #0x000005b0
 TST  r4, #0x00100000
 ADDEQ  r1,  r1, #0x00000004
 MOV  r2, #0x00000004
 BL main +0x0000041c
 TST  r4, #0x00400000
 MOVNE  r0, #0x00000006
 BLNE main +0x0000040c
 BL main +0x00000368
 MOV  r0,  r4, LSR #0x0000000c
 BL main +0x000003f0
 BL main +0x00000404
 MOV  r0, #0x00000007
 BL main +0x0000040c
 MOV  r0,  r4, LSR #0x00000010
 BL main +0x000003f0
 MOV  r0, #0x00000008
 BL main +0x0000040c
 B main +0x000002b8
 ADD  r1, r11, #0x000005c0
 TST  r4, #0x00100000
 ADDEQ  r1,  r1, #0x00000004
 MOV  r2, #0x00000004
 BL main +0x0000041c
 BL main +0x00000368
 ADD  r1, r11, #0x000005d0
 AND  r2,  r4, #0x01800000
 ADD  r1,  r1,  r2, LSR #0x00000016
 MOV  r2, #0x00000002
 BL main +0x0000041c
 MOV  r0,  r4, LSR #0x00000010
 BL main +0x000003f0
 TST  r4, #0x00200000
 MOVNE  r0, #0x00000004
 BLNE main +0x0000040c
 BL main +0x00000404
 MOV  r0, #0x00000002
 BL main +0x0000040c
 MOV  r5, #0x00000000
 MOV  r6,  r4
 MOV  r7, #0x00000000
 TST  r6, #0x00000001
 BEQ main +0x000001b0
 CMP  r7, #0x00000001
 BLEQ main +0x00000404
 MOV  r0,  r5
 BL main +0x000003f0
 MOV  r7, #0x00000001
 MOV  r6,  r6, LSR #0x00000001
 ADD  r5,  r5, #0x00000001
 CMP  r5, #0x00000010
 BNE main +0x00000194
 MOV  r0, #0x00000003
 BL main +0x0000040c
 TST  r4, #0x00400000
 MOVNE  r0, #0x00000005
 BLNE main +0x0000040c
 B main +0x000002b8
 ADD  r1, r11, #0x000005e0
 TST  r4, #0x01000000
 MOVEQ  r2, #0x00000002
 MOVNE  r2, #0x00000003
 BL main +0x0000041c
 BL main +0x00000368
 ADD  r1, r11, #0x000005f0
 MOV  r2, #0x00000005
 BL main +0x0000041c
 TST  r4, #0x00800000
 ORRNE  r0,  r4, #0xff000000
 BICEQ  r0,  r4, #0xff000000
 MOV  r0,  r0, LSL #0x00000002
 SUB  r1,  r3, r11
 ADD  r0,  r0,  r1
 ADD  r0,  r0, #0x00000008
 MOV  r1, #0x00000001
 BL main +0x00000380
 B main +0x000002b8
 ADD  r1, r11, #0x00000600
 MOV  r2, #0x00000003
 BL main +0x0000041c
 BL main +0x00000368
 MOV  r0,  r4
 BL main +0x000003f0
 B main +0x000002b8
 ADD  r1, r11, #0x00000610
 MOV  r2, #0x00000004
 BL main +0x0000041c
 BL main +0x00000368
 BIC  r0,  r4, #0xff000000
 MOV  r1, #0x00000000
 BL main +0x00000380
 B main +0x000002b8
 MOV  r0,  r4
 BL main +0x000003f0
 MOV  r0,  r4, LSR #0x00000004
 TST  r0, #0x000000f9
 BEQ main +0x000002b8
 BL main +0x00000404
 MOV  r0,  r4, LSR #0x00000003
 AND  r0,  r0, #0x0000000c
 ADD  r1, r11, #0x00000680
 ADD  r1,  r1,  r0
 MOV  r2, #0x00000004
 BL main +0x0000041c
 TST  r4, #0x00000010
 BNE main +0x000002ac
 MOV  r0,  r4, LSR #0x00000007
 AND  r0,  r0, #0x0000001f
 MOV  r1, #0x00000000
 BL main +0x00000380
 B main +0x000002b8
 MOV  r0,  r4, LSR #0x00000008
 BL main +0x000003f0
 B main +0x000002b8
 MOV  r0, #0x00000000
 BL main +0x0000040c
 ADD  r3,  r3, #0x00000004
 ADD  r4, r11, #0x00000500
 CMP  r3,  r4
 BNE main +0x00000018
 ADD  r1, r11, #0x00000530
 MOV  r2, #0x0000001b
 BL main +0x0000041c
 MOV  r0, #0x0000000a
 BL main +0x0000040c
 ADD  r3, r11, #0x00000500
 LDRB  r4,[  r3]
 CMP  r4, #0x00000020
 BLO main +0x0000031c
 CMP  r4, #0x0000007e
 BHI main +0x0000031c
 CMP  r4, #0x00000022
 BEQ main +0x0000031c
 CMP  r4, #0x0000005c
 BEQ main +0x0000031c
 MOV  r1,  r3
 MOV  r2, #0x00000001
 BL main +0x0000041c
 B main +0x00000344
 MOV  r0, #0x0000000b
 BL main +0x0000040c
 MOV  r0,  r4, LSR #0x00000006
 AND  r0,  r0, #0x00000007
 BL main +0x000003dc
 MOV  r0,  r4, LSR #0x00000003
 AND  r0,  r0, #0x00000007
 BL main +0x000003dc
 AND  r0,  r4, #0x00000007
 BL main +0x000003dc
 ADD  r3,  r3, #0x00000001
 ADD  r4, r11, #0x000006a0
 CMP  r3,  r4
 BNE main +0x000002e8
 MOV  r0, #0x0000000a
 BL main +0x0000040c
 MOV  r0, #0x00000000
 BL main +0x0000040c
 BX r12
 CMP  r5, #0x0000000e
 BXEQ  lr
 ADD  r1, r11, #0x00000550
 ADD  r1,  r1,  r5, LSL #0x00000001
 MOV  r2, #0x00000002
 B main +0x0000041c
 STMDB  sp!,{  r3,  lr}
 MOV  r3,  r0
 ADD  r1, r11,  r1, LSL #0x00000002
 ADD  r1,  r1, #0x00000630
 MOV  r2, #0x00000004
 BL main +0x0000041c
 MOV  r0,  r3, LSR #0x0000001c
 BL main +0x000003dc
 MOV  r0,  r3, LSR #0x00000018
 BL main +0x000003dc
 MOV  r0,  r3, LSR #0x00000014
 BL main +0x000003dc
 MOV  r0,  r3, LSR #0x00000010
 BL main +0x000003dc
 MOV  r0,  r3, LSR #0x0000000c
 BL main +0x000003dc
 MOV  r0,  r3, LSR #0x00000008
 BL main +0x000003dc
 MOV  r0,  r3, LSR #0x00000004
 BL main +0x000003dc
 MOV  r0,  r3
 BL main +0x000003dc
 LDMIA  sp!,{  r3,  pc}
 AND  r0,  r0, #0x0000000f
 ADD  r1, r11, #0x00000620
 ADD  r1,  r1,  r0
 MOV  r2, #0x00000001
 B main +0x0000041c
 AND  r0,  r0, #0x0000000f
 ADD  r1, r11, #0x00000640
 ADD  r1,  r1,  r0, LSL #0x00000002
 MOV  r2, #0x00000004
 B main +0x0000041c
 MOV  r0, #0x00000001
 B main +0x0000040c
 ADD  r1, r11, #0x00000690
 ADD  r1,  r1,  r0
 MOV  r2, #0x00000001
 B main +0x0000041c
 MOV  r0, #0x00000001
 STMDB  sp!,{  r3,  r4,  r5,  r6,  r7,  lr}
 MOV  r7, #0x00000004
 SWI #0x00000000
 LDMIA  sp!,{  r3,  r4,  r5,  r6,  r7,  pc}
 MOV  r0,  r0
 MOV  r0,  r0
 MOV  r0,  r0
 MOV  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 ANDEQ  r0,  r0,  r0
 .align 8
strings:
 .ascii " .code 32\012 .align 4\012 .global main\012main:\012\000\000\240\341\000\000\240\341 .align 8\012strings:\012 .ascii \000\000\000\240\341EQNEHSLOMIPLVSVCHILSGELTGTLEALNV AND EOR SUB RSB ADD ADC SBC RSC TST TEQ CMP CMN ORR MOV BIC MVN LDR STR\000\000\240\341\000\000\240\341 LDM STM\000\000\240\341\000\000\240\341DAIADBIB\000\000\240\341\000\000\240\341 BL\000\000\000\240\341\000\000\240\341\000\000\240\341 main\000\000\000\000\000\240\341\000\000\240\341 BX\000\000\000\240\341\000\000\240\341\000\000\240\341 SWI\000\000\240\341\000\000\240\341\000\000\240\3410123456789abcdef #0x +0x -0x\000\000\240\341  r0  r1  r2  r3  r4  r5  r6  r7  r8  r9 r10 r11 r12  sp  lr  pc LSL LSR ASR ROR\012,{}!^B[]-\042\134\000\000\240\341"
