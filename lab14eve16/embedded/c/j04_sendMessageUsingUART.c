#include <LPC17xx.H>
#include <stdio.h>
#define PCLK 18000000U
void SystemInit(void)
{
} // end of function


/*
Initialize the serial interface
*/
void Uart_Init(unsigned long BR)
{
	unsigned int Fdiv;
	LPC_PINCON->PINSEL0=0x00000050; // Configuring Uart0
	LPC_UART0->LCR=0x00000083; // 8bit, no parity, 1 stop bit, enable DLAB
	/*
	*/
	Fdiv = (PCLK / 16) / BR;
	LPC_UART0->DLM = Fdiv / 256;
	LPC_UART0->DLL = Fdiv % 256;
	LPC_UART0->LCR = 0x00000003; // disable DLAB
}// end of Uart_Init


/*
UART character transmit Function
Transmits one character at a time
*/
void Uart_Tx(unsigned char c)
{
	LPC_UART0->THR=c; // Send the data through the THR
	while(!(LPC_UART0->LSR&0x20)); // Check the status of the LSR
}// end of Uart_Tx

/*
UART string transmit function
*/
void Uart_String(char* ptr)
{
	while(*ptr)
	{
		Uart_Tx(*ptr);
		ptr++;
	}
}

/*
The entry point for the program
*/
int main(void)
{
	SystemInit(); // Initialize the MCU System
	Uart_Init(9600); // Initialize the UART0
	Uart_String("namaskaara jaggi"); // send the communication messages to PC
	Uart_String(" ----------     "); // send the communication messages to PC
	Uart_String("namaskaara UTL"); // send the communication messages to PC
	Uart_String(" ----------     "); // send the communication messages to PC
	Uart_String(" ---END---     "); // send the communication messages to PC
}// end of main()
