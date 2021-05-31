/*
 * Copyright:
 * ----------------------------------------------------------------
 * This confidential and proprietary software may be used only as
 * authorised by a licensing agreement from ARM Limited
 *   (C) COPYRIGHT 2014, 2018 ARM Limited
 *       ALL RIGHTS RESERVED
 * The entire notice above must be reproduced on all authorised
 * copies and copies may only be made to the extent permitted
 * by a licensing agreement from ARM Limited.
 * ----------------------------------------------------------------
 * File:     uart.c
 * Release Information : Cortex-M3 DesignStart-r0p1-00rel0
 * ----------------------------------------------------------------
 *
 */

/*
 * --------Included Headers--------
 */
/*
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
*/

#include "m3_for_arty.h"        // Project specific header
#include "uart.h"
#include <string.h>
// #include "gpio.h"

// #include "uart_stdout.h"

// #include "platform.h"
#include "xparameters.h"
#include "xuartlite.h"

#include "V:\software\m3_for_arty_a7\EXIN_HMI\EXIN_HMI.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_Timer_v1_0\src\Exin_Timer.h"

// Instance of the UART, local to this module
static XUartLite UART0_instance;
static XUartLite UART1_instance;

/*
 * The following counters are used to determine when the entire buffer has
 * been sent and received.
 */
static volatile int TotalReceivedCount;
static volatile int TotalSentCount;

static volatile int TotalReceivedCount1;
static volatile int TotalSentCount1;


u8 UARTSendBuffer[UART_BUFFER_SIZE];
u8 UARTSendBuffer_1[UART_BUFFER_SIZE];
u8 UARTReceiveBuffer[UART_BUFFER_SIZE];
u8 UARTReceiveBuffer_1[UART_BUFFER_SIZE];
u8 UARTReceiveBuffer_2[UART_BUFFER_SIZE];

u8 UART_SENDEND[3] = {0xff, 0xff, 0xff};

u8 UART_HMI_RCV_BUFFER[UART_HMI_BUFFER_RCVNUM];
u8 UART_HMI_RCV_BUFFER_ALL[20];

u8 UART_HMI_FLAG = 0;
unsigned char UART_HMI_RCV[20] = {0};


int InitialiseUART( void )
{
    int Status;

    /*
    * Initialize the UartLite driver so that it's ready to use.
    */
    Status = XUartLite_Initialize(&UART0_instance, XPAR_AXI_UARTLITE_0_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /*
    * Setup the handlers for the UartLite that will be called from the
    * interrupt context when data has been sent and received, specify a
    * pointer to the UartLite driver instance as the callback reference so
    * that the handlers are able to access the instance data.
    */
    XUartLite_SetSendHandler(&UART0_instance, SendHandler, &UART0_instance);
    XUartLite_SetRecvHandler(&UART0_instance, RecvHandler, &UART0_instance);

    /*
    * Start receiving data before sending it since there is a loopback.
    */
    XUartLite_Recv(&UART0_instance, UARTReceiveBuffer, UART_BUFFER_SIZE);

    return XST_SUCCESS;
}

int InitialiseUART_1( void )
{
    int Status;

    /*
    * Initialize the UartLite driver so that it's ready to use.
    */
    Status = XUartLite_Initialize(&UART1_instance, XPAR_AXI_UARTLITE_1_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /*
    * Setup the handlers for the UartLite that will be called from the
    * interrupt context when data has been sent and received, specify a
    * pointer to the UartLite driver instance as the callback reference so
    * that the handlers are able to access the instance data.
    */
    XUartLite_SetSendHandler(&UART1_instance, SendHandler_1, &UART1_instance);
    XUartLite_SetRecvHandler(&UART1_instance, RecvHandler_1, &UART1_instance);

    /*
    * Start receiving data before sending it since there is a loopback.
    */

    		
		XUartLite_Recv(&UART1_instance, UARTReceiveBuffer_1, UART_BUFFER_SIZE);

    return XST_SUCCESS;
}


void SendHandler(void *CallBackRef, unsigned int EventData)
{
    TotalSentCount = EventData;
}

void RecvHandler(void *CallBackRef, unsigned int EventData)
{
    TotalReceivedCount = EventData;
		XUartLite_Send(&UART0_instance, UARTReceiveBuffer, UART_BUFFER_SIZE);
		XUartLite_Recv(&UART0_instance, UARTReceiveBuffer, UART_BUFFER_SIZE);
}

void SendHandler_1(void *CallBackRef, unsigned int EventData)
{
    TotalSentCount1 = EventData;
}

void RecvHandler_1(void *CallBackRef, unsigned int EventData)
{
		static u8 Counter;
		static u8 Counter_num;
		static u8 Counter2;
		static u8 Counter_flag;
    TotalReceivedCount1 = EventData;
	
		UART_HMI_RCV_BUFFER[Counter ++] = UARTReceiveBuffer_1[0];
		

		if( Counter == UART_HMI_BUFFER_RCVNUM )
		{
				Counter = 0;
								
				if( Counter_flag )
				{
					UART_HMI_RCV[Counter2 ++] = UART_HMI_RCV_BUFFER[0];
					
					if( UART_HMI_RCV_BUFFER[0] == 0xff )
					{
						Counter_num ++;
					
						if( Counter_num == 3 )
						{
							Counter_num = 0;
							Counter2 = 0;
							Counter_flag = 0;
							rec_flag = 1;
//							UART_HMI_FLAG = 1;
						}
					}
				}
				
				else if( UART_HMI_RCV_BUFFER[0] == 0x65 || UART_HMI_RCV_BUFFER[0] == 0x70 || UART_HMI_RCV_BUFFER[0] == 0x5a || UART_HMI_RCV_BUFFER[0] == 0x5b )
				{
					UART_HMI_RCV[Counter2 ++] = UART_HMI_RCV_BUFFER[0];
					Counter_flag = 1;
				}
								
		}
		
		XUartLite_Recv(&UART1_instance, UARTReceiveBuffer_1, UART_BUFFER_SIZE);
		
		
}



int CheckUARTRxBytes( void )
{
    static int  BytesRx;
    int         Diff;
    
    Diff = TotalReceivedCount - BytesRx;
    
    if ( Diff )
        BytesRx = TotalReceivedCount;
    
    return Diff;
}


void EnableUARTInterrupts( void )
{
    XUartLite_EnableInterrupt(&UART0_instance);
}


void EnableUARTInterrupts_1( void )
{
		NVIC_EnableIRQ(UART1_IRQn);
    XUartLite_EnableInterrupt(&UART1_instance);
		NVIC_SetPriority(UART1_IRQn, 0);
	
//		XUartLite_Send(&UART1_instance, (unsigned char *)"START\n", 5);		
}



void UART_HMI_Send(char *SendString, unsigned char len)
{
	unsigned char counter = 0;
	
	for(counter = 0; counter < len; counter ++)
	{
		XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, *SendString);
		SendString ++;
	}
//	XUartLite_Send(&UART1_instance, (unsigned char *)SendString, len);
//#if DEBUG_MOD
//	XUartLite_Send(&UART0_instance, (unsigned char *)SendString, len);
//#endif
}

void UART_HMI_PutChar(char CharByte)
{
	XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, CharByte);
//#if DEBUG_MOD
//	XUartLite_Send(&UART0_instance, (unsigned char *)BUFFER_CHAR, 1);
//#endif	
}

void UART_HMI_instru_send(char * ins)
{
  while (*ins != (char8)0) 
	{
    XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, *ins);
		ins++;
  }
	
	XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, 0xFF);
	XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, 0xFF);
	XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, 0xFF);
	
//	XUartLite_Send(&UART1_instance, ins, len);
//	while( *ins != (char8)0 )
//	{
//		XUartLite_SendByte(&UART1_instance, *ins);
//		XUartLite_SendByte(&UART0_instance, *ins);
//		ins ++;
//	}
//	EXIN_TIMER_Delayus(400);
//	
//	XUartLite_SendByte(&UART1_instance, 0xff);
//	XUartLite_SendByte(&UART1_instance, 0xff);
//	XUartLite_SendByte(&UART1_instance, 0xff);
//	XUartLite_SendByte(&UART0_instance, 0xff);
//	XUartLite_SendByte(&UART0_instance, 0xff);
//	XUartLite_SendByte(&UART0_instance, 0xff);
//	XUartLite_Send(&UART1_instance, UART_SENDEND, 3);

//	UART_HMI_Send(UART_SENDEND, 3);
//	UART_HMI_PutChar(0xff);
//	UART_HMI_PutChar(0xff);
//	UART_HMI_PutChar(0xff);
}

void UART_HMI_DEBUGinstru_send(char * ins)
{
  while (*ins != (char8)0) 
	{
    XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, *ins);
		XUartLite_SendByte (XPAR_UARTLITE_0_BASEADDR, *ins);
		ins++;
  }
	
	XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, 0xFF);
	XUartLite_SendByte (XPAR_UARTLITE_0_BASEADDR, 0xFF);
	XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, 0xFF);
	XUartLite_SendByte (XPAR_UARTLITE_0_BASEADDR, 0xFF);
	XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, 0xFF);
	XUartLite_SendByte (XPAR_UARTLITE_0_BASEADDR, 0xFF);
}

void UART_DEBUG_String(char *String)
{
  while (*String != (char8)0) 
	{
    XUartLite_SendByte (XPAR_UARTLITE_0_BASEADDR, *String);
		String++;
  }
}

void UART_DEBUG_PutChar(char CharByte)
{
	XUartLite_SendByte (XPAR_UARTLITE_0_BASEADDR, CharByte);
}

void UART_DEBUG_Send(char *SendString, unsigned char len)
{
	unsigned char counter = 0;
	
	for(counter = 0; counter < len; counter ++)
	{
		XUartLite_SendByte (XPAR_UARTLITE_1_BASEADDR, *SendString);
		SendString ++;
	}
}


// Define the UART interrupt handler here
void UART0_Handler ( void )
{
    XUartLite_InterruptHandler(&UART0_instance);
    NVIC_ClearPendingIRQ(UART0_IRQn);

    // Test to indicate when the IRQ is called
    // Used to detect received characters
    // IncLeds();

}

// UART_Receiver for HMI
void UART1_Handler ( void )
{
		static unsigned char endcount;             //接收到指令码的结束符个数 
    XUartLite_InterruptHandler(&UART1_instance);
		NVIC_ClearPendingIRQ(UART1_IRQn);
		

//		if( UART_HMI_FLAG )
//		{
//			UART_HMI_FLAG = 0;
////			UART_DEBUG_PutChar(UART_HMI_RCV_BUFFER[0]);
//			
//			if( UART_HMI_RCV_BUFFER[0] == 0xff )
//		  {
//			  endcount++;
//				
//			  if( endcount == 3 )
//			  {
//				  endcount = 0;
//				  indexI = 0;
//				  rec_flag = 1;
//			  }
//				
//		  }
//		  else
//			{
//			  endcount = 0;
//			}
//			
//			if((UART_HMI_RCV_BUFFER[0] == 0x65 || UART_HMI_RCV_BUFFER[0] == 0x70 || UART_HMI_RCV_BUFFER[0] == 0x5a || UART_HMI_RCV_BUFFER[0] == 0x5b) && indexI == 0)
//			{
//				UART_HMI_RCV[indexI ++] = UART_HMI_RCV_BUFFER[0];
//				UART_DEBUG_PutChar(0xFA);
//				UART_DEBUG_PutChar(UART_HMI_RCV[indexI - 1]);
//				UART_DEBUG_PutChar(indexI);
//				UART_DEBUG_PutChar(0xFA);
//			}
//			
//			if( !indexI )
//			{
//				UART_HMI_RCV[indexI ++] = UART_HMI_RCV_BUFFER[0];
//				UART_DEBUG_PutChar(0xFB);
//				UART_DEBUG_PutChar(UART_HMI_RCV[indexI - 1]);
//				UART_DEBUG_PutChar(indexI);
//				UART_DEBUG_PutChar(0xFB);
//			}

//		}
} 

// Define the UART2 interrupt handler here
