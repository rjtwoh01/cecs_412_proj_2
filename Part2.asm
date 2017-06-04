;
; Project2.asm
;
; Created: 6/3/2017 4:17:15 PM
; Author : Ryan
;


.dseg
.org 0x2000
output: .byte 1 ;reserves 1 byte for the variable output
.cseg
.org 0x0
jmp main ;partial vector table at address 0x0
.org 0x200 ;MAIN entry point at address 0x200 (step through the code)
 
main:
ldi ZL,low(2*table) ;address of table to pointer z
ldi ZH,high(2*table) ;multiplied by 2 for bytewise access
 
ldi r18, 20
sort:
lpm r20,z+
lpm    r21,z
cp r20, r21
dec r18
brmi sort
brpl switch
 
switch:
mov r19, r20 ;temp
mov r20, r21
mov r21, r19
clr r19
dec r30
mov r20,r0
mov r21,r1
sT Z+,r20
st Z,r21
jmp sort
 
 
 //Moving over from app memory to SRAM using Insertion Sort as we go
 //Loop through the list
 //At start of list, first value is the lowest value
 //This stays lowest value until you find one that's lower
 //The new number is now your lowest value
 //Keep going till end of list
 //Insert your lowest value into SRAM and remove it from app memory
 //Repeat until all data is into SRAM (already sorted)
 
 
ldi r16,celsius ;student comment goes here
add ZL,r16 ;student comment goes here
ldi r16,0 ;student comment goes here
adc ZH,r16 ;student comment goes here
lpm ;lpm = lpm r0,Z in reality, what does this mean?
sts output,r0 ;store look-up result to SRAM
ret ;consider MAIN as a subroutine to return from - but back to where??
 
; Fahrenheit look-up table
table: .db 3, 2, 7, 37, 5, 41, 43, 45, 46, 48, 50, 52, 54, 55, 57, 59, 61, 63, 64, 66
.equ celsius = 5 ;modify Celsius from 0 to 19 degrees for different results
 
.exit