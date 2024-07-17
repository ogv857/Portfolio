/*
 * main.c
 *
 * Created: 3/29/2024 8:35:25 AM
 *  Author: bengcov
 */ 

/*
 * Lab5_EX1_C.c
 *
 * Created: 3/22/2024 8:34:38 AM
 * Author : bengcov
 */ 

#define F_CPU 8000000UL
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

ISR (ADC_vect)
{

	PORTD = ADCH;
	ADCSRA |=(1<<ADSC);

}

int main(void)
{

		//Set neccessary PORT direction
		//DDRC is input
		DDRD = 0xFF;

		
		//Set channel to take input for ADC0, set ALDAR, AVcc with external cap at AREF
		ADMUX |= (1<<REFS0) | (1<<ADLAR);			
		//0x0110 0000
		
		//Set prescaler to 128, enable ADC interrupt, enable adc, start conversion
		ADCSRA |= (1<<ADEN) | (1<<ADSC) |(1<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);		
		//1100 1111
		 
		sei();
		while(1){

		}

}
