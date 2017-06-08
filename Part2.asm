.dseg
.org 0x2000
output: .byte 1 ;reserves 1 byte for the variable output
.cseg
.org 0x0
jmp main ;partial vector table at address 0x0
.org 0x200 ;MAIN entry point at address 0x200 (step through the code)
 
 //Moving from app memory to sram
main:
ldi ZL,low(2*table) ;address of table to pointer z
ldi ZH,high(2*table) ;multiplied by 2 for bytewise access
ldi XL,00 ;sets X Low
ldi XH, 32 ;sets X High (SRAM)
ldi r18, 20 //Loads the number of elements into r18
copy:
 
lpm r20, z //loads from memory location z and stores into r20
st x+,R20 //stores r20 into x and increments
inc zl //increment z low (move up 1)
dec r18 //dec status
cpi r18,0 //compares status to 0
brne copy //if not equal, have to keep copying over
 
 //We're going to use a bubble sort algorithm here
 //We'll loop through the list, monitoring where in the list we're at
 //We'll keep track of how many value swaps have taken place
 //Each number will be compared to the next one, if the next one is greater than the first one we swap
 //Then we move on to the next number and compare it to its next number
 //We go through the list performing all swaps
 //Then we go back to the beginning and run another pass 
 //We go till there are no swaps in a run
 //Once there are no swaps, the list is sorted
sort:
ldi r18,20 //status counter
ldi r17,0 //swap counter
ldi xl,00 //2nd part of address
ldi xh,32 //beginning of SRAM 
loop:
ld r20, x+ //Load x into r20 and increment it
ld r21, x //Load new x into 21
dec r18 //dec status
cpi r18,0 //compare status to 0
breq finalCheck //if 0, we are at the end of the list and 
 
cp r20,r21 //Compare the two values
 
brpl switch //if the 2nd is bigger than the first, we have to swap
brmi loop //if not, move on to the next element
 
switch:
mov r19,r20 //create a temp register to hold 1st value
mov r20,r21 //2nd value into r20
mov r21,r19 //first value from temp to r21
clr r19 //clear r19 just cause
dec xl //dec x low down 1
st x+, r20 //store r20 into x and increment
st x, r21 // store r21 into new x
inc r17 //number of swaps goes up 1
rjmp loop //keep iterating
 
finalCheck:
cpi r17, 0 //compare swaps to 0
brne sort //if not 0, we have to iterate again
 
ldi r16,celsius ;student comment goes here
add ZL,r16 ;student comment goes here
ldi r16,0 ;student comment goes here
adc ZH,r16 ;student comment goes here
lpm ;lpm = lpm r0,Z in reality, what does this mean?
sts output,r0 ;store look-up result to SRAM
ret ;consider MAIN as a subroutine to return from - but back to where??
 
; Fahrenheit look-up table
table: .db 3, 2, 7, 37, 5, 21, 60, 25, 8, 13, 52, 53, 54, 26, 9, 59, 61, 63, 64, 66
.equ celsius = 5 ;modify Celsius from 0 to 19 degrees for different results
 
.exit
