/**
* \file
*
* \brief Empty user application template
*
*/

/**
* \mainpage User Application template doxygen documentation
*
* \par Empty user application template
*
* Bare minimum empty user application template
*
* \par Content
*
* -# Include the ASF header files (through asf.h)
* -# "Insert system clock initialization code here" comment
* -# Minimal main function that starts with a call to board_init()
* -# "Insert application code here" comment
*
*/

/*
* Include header files for all drivers that have been imported from
* Atmel Software Framework (ASF).
*/
/*
* Support and FAQ: visit <a href="http://www.atmel.com/design-support/">Atmel Support</a>
*/

#include <avr/io.h>
#include <avr/eeprom.h>
#include <asf.h>

int main(void) {
	uint8_t fahrenheit[20] = {32,34,36,37,39,41,43, 45,46,48,50,52,54,55,57,59,61,63,64,66};
	uint8_t celsiusConverted[20];
	uint8_t fahrenheitFinal[20];
	
	for (int i = 0; i < 20; i++) {
		eeprom_write_byte((uint8_t *)i, fahrenheit[i]); //writing to internal EEPROM as an I/O Device via NVM
	}
	
	//eeprom_read_block ((void*) &fahrenheitFinal, (const void*) 0, 20); //read 20 bytes from EEPROM starting from the first address and store in SRAM
	for (int i = 0; i < 20; i++) {
		fahrenheitFinal[i] = eeprom_read_byte((uint8_t* )i);
	}
	
	for (int i = 0; i < 20; i++) {
		celsiusConverted[i] = (fahrenheitFinal[i] - 32) / 1.8; //convert fahrenheit to celsius
	}
}