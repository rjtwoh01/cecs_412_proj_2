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
ldi XL,00
ldi XH, 32
ldi r18, 20
copy:
 
lpm r20, z
st x+,R20
inc zl
dec r18
cpi r18,0
brne copy
 
sort:
ldi r18,20
ldi r17,0
ldi xl,00
ldi xh,32
loop:
ld r20, x+
ld r21, x
dec r18 //status
cpi r18,0
breq finalCheck
 
cp r20,r21
 
brpl switch
brmi loop
 
switch:
mov r19,r20
mov r20,r21
mov r21,r19
clr r19
dec xl
st x+, r20
st x, r21
inc r17
rjmp loop
 
finalCheck:
cpi r17, 0
brne sort
 
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
