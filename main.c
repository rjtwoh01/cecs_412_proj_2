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

#include <asf.h>
#include <avr/io.h>
#include <avr/eeprom.h>


int main (void)
{
	uint8_t fahrenheit[20] = {32,34,36,37,39,41,43,45,46,48,50,52,54,55,57,59,61,63,64,66};
	for(int i = 0; i < 20; i++)
	{
		eeprom_write_byte((uint8_t* )i, fahrenheit[i]); //writing to internal EEPROM as an I/O Device via NVM Controller
		//look at eeprom EEPROM Memory Window, address 0x0000
	}
	
	/*for(int i = 0; i < 20; i++)
	{
	eeprom_write_byte((uint8_t* )i, 0);
	}
	*/
	uint8_t Celsius[20];
	for(int i = 0; i < 20; i++)
	{
		Celsius[i] = eeprom_read_byte((uint8_t* )i);
	}
	
	for(int i = 0; i < 20; i++)
	{
		volatile int celsius2= (Celsius[i] - 20) * 5/9;
		eeprom_write_byte((uint8_t* )i+8192, celsius2);
	}
}
