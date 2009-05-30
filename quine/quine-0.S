@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@  Copyright (C) 2009 Rob Clark <rob@ti.com>
@
@  This program is free software; you can redistribute it and/or
@  modify it under the terms of the DO WHAT THE FUCK YOU WANT TO
@  PUBLIC LICENSE (http://sam.zoy.org/wtfpl/COPYING)
@
@  This program is distributed in the hope that it will be useful,
@  but WITHOUT ANY WARRANTY; without even the implied warranty of
@  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE whatsoever.
@  It may even kill bambi.  Which would be sad.  But I disclaim
@  responsibility.  See http://sam.zoy.org/wtfpl/ for details.
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@  This program is a quine <http://en.wikipedia.org/wiki/Quine_(computing)>.
@  Or rather a program that generates a quine (but it might be easier to
@  figure out what is going on by reading this file which has the comments
@  and such).
@
@  Usage:
@    Step 1:  arm-none-linux-gnueabi-gcc quine-0.S -o quine-0
@    Step 2:  quine-0 > quine-1.S   (on ARM linux)
@    Step 3:  arm-none-linux-gnueabi-gcc quine-1.S -o quine-1
@    Step 4:  quine-1 > quine-2.S  (on ARM linux)
@    Step 5:  diff quine-1.S quine-2.S
@    Step 6:  ???
@    Step 7:  Profit!
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

 .code 32
 .align 4
 .global main
main:
 SUB r3, pc, #8
 MOV r11, r3
 MOV r12, lr
 ADD r1, r11, #preamble_code_str
 MOV r2, #40
 BL print_str

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ general notes on register usage:
@ r0-r2:  used for output operations
@ r3:     current instruction pointer (ie. what is being disassemble):
@ r4:     current instruction
@ r5-r10: available during decoding, saved accross various print operations
@    r5:  holds condition value at branch to instruction class handler.. can
@         be overwritten once this is printed
@    r6:  'I' bit, can be overwritten once no longer needed
@ r11:    used to load values relative to program start
@ r12:    saved lr to branch to at end of program (if we really need an extra
@         register, this could be pushed on stack)
code_loop:
 @@@@ debug
 @LDR r0, [r3]
 @BL print_int
 @@@@ end debug

 LDR r4, [r3]

 @@@@ disassemble intr in r4 here:
 @ put condition (for applicable instructions) in r5:
 MOV r5, r4, LSR #28
 @ check for the special case of BX:
 AND   r7, r4, #0x0ff00000
 CMP   r7,     #0x01200000
 ANDEQ r7, r4, #0x000ff000
 CMPEQ r7,     #0x000ff000
 ANDEQ r7, r4, #0x00000ff0
 CMPEQ r7,     #0x00000f10
 BEQ instr_bx
 @ store 'I' bit (for applicable instructions) in r6:
 MOV r6, #1
 @ put next three bits into r7.. which since we ignore a bunch of classes of
 @ instructions, is enough to decode the type of instruction.  Put the value
 @ in r7 multiply by 4 (LSL #2) so we can do a jump-table:
 MOV r7, r4, LSR #23
 AND r7, r7, #28
 @ jump-table:
 ADD pc, pc, r7
 NOP
 @ '000' - Data Processing, operand 2 is register
 B instr_dp0
 @ '001' - Data Processing, operand 2 is not register
 B instr_dp1
 @ '010' - Load/Store Byte/Word, operand 2 is register
 B instr_lsbw0
 @ '011' - Load/Store Byte/Word, operand 2 is not register
 B instr_lsbw1
 @ '100' - Load/Store Multiple
 B instr_lsm
 @ '101' - Branch
 B instr_b
 @ '110' - not used
 NOP   @ look, ma', no error handling!
 @ '111' - SWI
 B instr_swi

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Data Processing Instructions
@
instr_dp0:
 MOV r6, #0
instr_dp1:
 @ load opcode into r7, multiplied by 4:
 MOV r7, r4, LSR #19
 AND r7, r7, #60
 @ load index into instr_dp_str table in r1:
 ADD r1, r11, #instr_dp_str
 ADD r1, r1, r7
 MOV r2, #4
 BL print_str
 BL print_cond
 @ bit 20 - 'S' bit (set condition field)...
 @     XXX  do we need to care??

instr_dpN_Rd:
 @ note:  for TST ('1000'), TEQ ('1001'), CMP ('1010'), and CMN ('1011'),
 @        Rd is ignored:
 MOV r0, r7, LSR #4
 CMP r0, #2
 BEQ instr_dpN_operand1
 @ load Rd (destination register) into r0, and print:
 MOV r0, r4, LSR #12
 BL print_reg
 BL print_comma

instr_dpN_operand1:
 @ note:  MOV ('1101') and MVN ('1111'), operand1 is ignored:
 MOV r0, r7, LSR #2
 ORR r0, r0, #2
 CMP r0, #15
 BEQ instr_dpN_operand2
 @ load Rn (operand1) into r0, and print:
 MOV r0, r4, LSR #16
 BL print_reg
 BL print_comma

instr_dpN_operand2:
 @ bit 25 (r6) - 'I' bit (0 means operand2 is a shift+Rm, 1 means operand2 is
 @ an immed)
 CMP r6, #1
 BNE shift
 @ for an immed, bits 7:0 are imm, 11:8 are rotate
 AND r0, r4, #255
 MOV r1, r4, LSR #8
 AND r1, r1, #15
 MOV r1, r1, LSL #1
 MOV r0, r0, ROR r1
 MOV r1, #0
 BL print_int
 B code_loop_end


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Load/Store Byte/Word Instructions
@
instr_lsbw0:
 MOV r6, #0
instr_lsbw1:
 ADD r1, r11, #lsbw_str
 TST r4, #0x100000
 ADDEQ r1, r1, #4
 MOV r2, #4
 BL print_str
 @ print type ('B' bit):
 TST r4, #0x400000
 MOVNE r0, #6
 BLNE print_misc
 @ XXX print 'T' if 'W' bit is set (not used.. and unclear about this..
 @ DUI0204E and DDI0029E seem to disagree on the syntax here!)
 BL print_cond
 @ print Rd
 MOV r0, r4, LSR #12
 BL print_reg
 BL print_comma
 @ print '['
 MOV r0, #7
 BL print_misc
 @ print Rn
 MOV r0, r4, LSR #16
 BL print_reg
 @ XXXX print offset stuff..  (not used.. but if it was, the I=1 case is
 @ basically the same as data processing structions's I=0 case.. the shift
 @ stuff could be converted into a function that could be called here.
 @ The I=0 case is easy)
 @ print ']'
 MOV r0, #8
 BL print_misc
 @ XXX print '!' bit (not used)
 B code_loop_end


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Load/Store Multiple Instructions
@
instr_lsm:
 ADD r1, r11, #lsm_str
 TST r4, #0x100000
 ADDEQ r1, r1, #4
 MOV r2, #4
 BL print_str
 BL print_cond
 ADD r1, r11, #lsm_mode_str
 AND r2, r4, #0x1800000
 ADD r1, r2, LSR #22
 MOV r2, #2
 BL print_str
 MOV r0, r4, LSR #16
 BL print_reg
 @ if W bit is set, print '!'
 TST r4, #0x200000
 MOVNE r0, #4
 BLNE print_misc
 BL print_comma
 @ print '{':
 MOV r0, #2
 BL print_misc
 @ print register list:
 MOV r5, #0             @ current register #
 MOV r6, r4             @ register mask (we ignore high bits)
 MOV r7, #0             @ set to 1 if we need to print a comma
instr_lsm_reglist_loop:
 TST r6, #1
 BEQ instr_lsm_reglist_loop_end
 CMP r7, #1
 BLEQ print_comma
 MOV r0, r5
 BL print_reg
 MOV r7, #1
instr_lsm_reglist_loop_end:
 MOV r6, r6, LSR #1
 ADD r5, r5, #1
 CMP r5, #16
 BNE instr_lsm_reglist_loop
 @ print '}'
 MOV r0, #3
 BL print_misc
 @ if S bit is set, print '^'
 TST r4, #0x400000
 MOVNE r0, #5
 BLNE print_misc
 B code_loop_end

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Branch Instructions
@
instr_b:
 ADD r1, r11, #bl_str
 TST r4, #0x1000000
 MOVEQ r2, #2
 MOVNE r2, #3
 BL print_str
 BL print_cond
 ADD r1, r11, #main_str
 MOV r2, #5
 BL print_str
 @ deal with sign extension of the offset:
 TST r4, #0x800000
 ORRNE r0, r4, #0xff000000
 BICEQ r0, r4, #0xff000000
 MOV r0, r0, LSL #2
 @ convert offset into an offset relative to main, because we need to emit
 @ a label relative branch target:
 @   (1) figure out current instruction offset from main
 SUB r1, r3, r11
 ADD r0, r0, r1
 ADD r0, r0, #8    @ add two instructions to account for the pipeline
 MOV r1, #1
 BL print_int
 B code_loop_end

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Branch and exchange Instructions
@
instr_bx:
 ADD r1, r11, #bx_str
 MOV r2, #3
 BL print_str
 BL print_cond
 MOV r0, r4
 BL print_reg
 B code_loop_end

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Software Interrupt Instructions
@
instr_swi:
 ADD r1, r11, #swi_str
 MOV r2, #4
 BL print_str
 BL print_cond
 BIC r0, r4, #0xff000000
 MOV r1, #0
 BL print_int
 B code_loop_end



@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ common handling for shift+Rm 2nd operator:
shift:
 MOV r0, r4
 BL print_reg
 MOV r0, r4, LSR #4
 @ if it is shift by zero, then skip printing anything like "LSL #0":
 TST r0, #0xf9
 BEQ code_loop_end
 BL print_comma
 MOV r0, r4, LSR #3
 AND r0, r0, #12
 ADD r1, r11, #shift_str
 ADD r1, r1, r0
 MOV r2, #4
 BL print_str
 @ if bit 4 is '0', we have an unsigned int:
 TST r4, #16
 BNE shift_Rs
 MOV r0, r4, LSR #7
 AND r0, r0, #31
 MOV r1, #0
 BL print_int
 B code_loop_end
shift_Rs:
 @ if bit 4 is '1' we have a register:
 MOV r0, r4, LSR #8
 BL print_reg
 B code_loop_end


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
code_loop_end:
 MOV r0, #0    @ print eol
 BL print_misc
 ADD r3, r3, #4
 ADD r4, r11, #strings
 CMP r3, r4
 BNE code_loop
 ADD r1, r11, #preamble_ascii_str
 MOV r2, #27
 BL print_str

 @ print open-quote
 MOV r0, #10
 BL print_misc

 ADD r3, r11, #strings
strings_loop:
 LDRB r4, [r3]
 CMP r4, #0x20
 BLO strings_octal
 CMP r4, #0x7e
 BHI strings_octal
 CMP r4, #0x22
 BEQ strings_octal
 CMP r4, #0x5c
 BEQ strings_octal
 @ print string literal:
 MOV r1, r3
 MOV r2, #1
 BL print_str
 B strings_loop_end
strings_octal:
 @ print escape char
 MOV r0, #11
 BL print_misc
 @ print octal:
 MOV r0, r4, LSR #6
 AND r0, r0, #7
 BL print_nibble
 MOV r0, r4, LSR #3
 AND r0, r0, #7
 BL print_nibble
 AND r0, r4, #7
 BL print_nibble

strings_loop_end:
 ADD r3, r3, #1
 ADD r4, r11, #end
 CMP r3, r4
 BNE strings_loop

 @ print close-quote
 MOV r0, #10
 BL print_misc

 MOV r0, #0    @ print eol
 BL print_misc
 BX r12

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Various helper printer routines:
@

@ print the condition code, pased in r5 (destroys r0-r2):
print_cond:
 CMP r5, #0xe
 BXEQ lr
 ADD r1, r11, #cond_str
 ADD r1, r5, LSL #1
 MOV r2, #2
 B print_str

@ print an integer constant, passed in r0; if r1=0 then print the leading '#'
@ (destroys r0-r2):
print_int:
 PUSH {r3,lr}
 MOV r3, r0
 ADD r1, r11, r1, LSL #2
 ADD r1, r1, #hex_str_pre
 MOV r2, #4
 BL print_str
 MOV r0, r3, LSR #28
 BL print_nibble
 MOV r0, r3, LSR #24
 BL print_nibble
 MOV r0, r3, LSR #20
 BL print_nibble
 MOV r0, r3, LSR #16
 BL print_nibble
 MOV r0, r3, LSR #12
 BL print_nibble
 MOV r0, r3, LSR #8
 BL print_nibble
 MOV r0, r3, LSR #4
 BL print_nibble
 MOV r0, r3
 BL print_nibble
 POP {r3,pc}

@ print a hex digit, passed in r0 (destroys r0-r2):
print_nibble:
 AND r0, r0, #15
 ADD r1, r11, #hex_str
 ADD r1, r1, r0
 MOV r2, #1
 B print_str


@ print a register name, passed in r0 (destroys r0-r2):
@  (note: only the low four bits of r0 are considered.. so you don't need to
@  mask the high bits before calling this routine)
print_reg:
 AND r0, r0, #15
 ADD r1, r11, #reg_str
 ADD r1, r1, r0, LSL #2
 MOV r2, #4
 B print_str

@ print a comman (destroys r0-r2):
print_comma:
 MOV r0, #1
 B print_misc

print_misc:
 ADD r1, r11, #misc_str
 ADD r1, r1, r0
 MOV r2, #1
 B print_str

@ we don't need no stinkin libc!!
@
@ ssize_t write(
@     int fildes,        <--- r0   (hard coded)
@     const void *buf,   <--- r1   (passed in r1)
@     size_t nbyte       <--- r2   (passed in r2)
@   )
@
@ syscall uses r0-r6 to pass args, and r7 for the syscall number.. r0-r2 are
@ detroyed, everything else is preserved
@
@ write() is syscall #4, in EABI syscall # is passed in r7, and r0-r7 are
@ destroyed
print_str:
 MOV r0, #1
 PUSH {r3-r7,lr}
 MOV  r7, #4
 SWI  0
 POP  {r3-r7,pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 .align 8
strings:
preamble_code_str:
 .ascii " .code 32\012 .align 4\012 .global main\012main:\012"

 .align 4
preamble_ascii_str:
 .ascii " .align 8\012strings:\012 .ascii "

 .align 4
cond_str:
 .ascii "EQNEHSLOMIPLVSVCHILSGELTGTLEALNV"

 .align 4
instr_dp_str:
 .ascii " AND EOR SUB RSB ADD ADC SBC RSC TST TEQ CMP CMN ORR MOV BIC MVN"

 .align 4
lsbw_str:
 .ascii " LDR STR"

 .align 4
lsm_str:
 .ascii " LDM STM"

 .align 4
lsm_mode_str:
 .ascii "DAIADBIB"

 .align 4
bl_str:
 .ascii " BL"

 .align 4
main_str:
 .ascii " main"

 .align 4
bx_str:
 .ascii " BX"

 .align 4
swi_str:
 .ascii " SWI"

 .align 4
hex_str:
 .ascii "0123456789abcdef"

 .align 4
hex_str_pre:
 .ascii " #0x +0x -0x"

 .align 4
reg_str:
 .ascii "  r0  r1  r2  r3  r4  r5  r6  r7  r8  r9 r10 r11 r12  sp  lr  pc"

 .align 4
shift_str:
 .ascii " LSL LSR ASR ROR"

 .align 4
misc_str:
 .ascii "\012,{}!^B[]-\"\\"

 .align 4
end:
 .end
