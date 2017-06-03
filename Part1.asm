/*
 * Part1.asm
 *
 *  Created: 6/3/2017 4:17:50 PM
 *   Author: Ryan
 */ 
 ;******************************
;* Declare Variables
;******************************
.dseg
quotient: .byte 1 ;uninitialized quotient variable stored in SRAM aka data segment
remainder: .byte 1 ;uninitialized remainder variable stored in SRAM
.set count = 0 ;initialized count variable stored in SRAM
;******************************
.cseg ; Declare and Initialize Constants (modify them for different results)
.equ dividend = 13 ;8-bit dividend constant (positive integer) stored in FLASH memory aka code segment
.equ divisor = 3 ;8-bit divisor constant (positive integer) stored in FLASH memory
;******************************
;* Vector Table (partial)
;******************************
reset: jmp main ;RESET Vector at address 0x0 in FLASH memory (handled by MAIN)
ofail: jmp oscf ;Oscillator Failure Vector at address 0x2 in FLASH memory ()
;******************************
;* MAIN entry point to program*
;******************************
.org 0x200 ;originate MAIN at address 0x200 in FLASH memory (step through the code)
main:
call init ;initialize variables subroutine, set break point here, check the STACK,SP,PC
endmain: jmp endmain
 
init:
lds r0,count ;get initial count, set break point here and check the STACK,SP,PC
sts quotient,r0 ;use the same r0 value to clear the quotients
sts remainder,r0 ;and the remainder storage locations
call getnums ;Check the STACK,SP,PC here.
ret ;return from subroutine, check the STACK,SP,PC here.
 
getnums:
ldi r30,dividend ;Check the STACK,SP,PC here.
ldi r31,divisor
call test ;Check the STACK,SP,PC here.
ret ;Check the STACK,SP,PC here.
 
test:
cpi r30,0 ; is dividend == 0 ?
brne test2
 
test1:
jmp test1 ; halt program, output = 0 quotient and 0 remainder
 
test2:
cpi r31,0 ; is divisor == 0 ?
brne test4
ldi r30,0xEE ; set output to all EE's = Error division by 0
sts quotient,r30
sts remainder,r30
 
test3:
jmp test3 ; halt program, look at output
 
test4:
cp r30,r31 ; is dividend == divisor ?
brne test6
ldi r30,1 ;then set output accordingly
sts quotient,r30
 
test5:
jmp test5 ; halt program, look at output
 
test6:
brpl test8 ; is dividend < divisor ?
ser r30
sts quotient,r30
sts remainder,r30 ; set output to all FF's = not solving Fractions in this program
 
test7:
jmp test7 ; halt program look at output
 
test8:
call divide ;Check the STACK,SP,PC here.
ret ; otherwise, return to do positive integer division
 
divide:
lds r0,count ;load directly from SRAM the variable "count" to R0
 
divide1:
inc r0 ;incrementing R0 by 1
sub r30,r31 ;subtracting r31 from r30 (how many times can divisor go into the dividend)
brpl divide1 ;break if dividend is smaller than the divisor, loop until divisor is smaller
dec r0 ;after loop breaks, decrement r0 by one to show the proper quotient
add r30,r31 ;adding the negative number in register 30 to the positive number in register 31 gives you the remainder
sts quotient,r0 ;store to the SRAM the quotient in register 0
sts remainder,r30 ;store the remainder in register 30 to SRAM
;note 13/3=4 remainder 1 as shown in SRAM location 0x2000
 
divide2:
ret ;returns from the subroutine, The return address is loaded from the Stack
 
oscf: jmp oscf ; oscillator failure interrupt handler goes here.
