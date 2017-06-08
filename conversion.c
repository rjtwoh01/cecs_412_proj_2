#include <avr/io.h>
#include <avr/eeprom.h>
#include <asf.h>

uint8_t fahrenheit[20] = {32,34,36,37,39,41,43, 45,46,48,50,52,54,55,57,59,61,63,64,66};
uint8_t celsiusConverted[20] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
uint8_t fahrenheitFinal[20];



int main(void) {
	
	
	//loop through sram fahrenheit and write to eeprom
	for (int i = 0; i < 20; i++) {
		eeprom_write_byte((uint8_t *)i, fahrenheit[i]); //writing to internal EEPROM as an I/O Device via NVM
	}

	//incremented by 20 in eeprom memory
	for(int i = 20; i < 40; i++)
	{
		eeprom_write_byte((uint8_t* )i, fahrenheit[i]); //writing to internal EEPROM as an I/O Device via NVM Controller + 20
		//look at eeprom EEPROM Memory Window, address 0x0000
	}
	
	//eeprom_read_block ((void*) &fahrenheitFinal, (const void*) 0, 20); //read 20 bytes from EEPROM starting from the first address and store in SRAM
	//loop through eeprom and write to fahrenheit new
	for (int i = 0; i < 20; i++) {
		fahrenheitFinal[i] = eeprom_read_byte((uint8_t* )i); //copies over from eeprom into fahrenheitFinal
	}

	//loop through fahrenheit array and conver to celsius array
	for (int i = 0; i < 20; i++) {
		celsiusConverted[i] = (fahrenheitFinal[i] - 32) / 1.8; //convert fahrenheit to celsius
	}

	while(1); //keep program running
}