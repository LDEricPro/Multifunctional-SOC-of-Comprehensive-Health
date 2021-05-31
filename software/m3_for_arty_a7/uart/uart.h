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
 * File:     uart.h
 * Release Information : Cortex-M3 DesignStart-r0p1-00rel0
 * ----------------------------------------------------------------
 *
 */

// Define the UART interrupt handler here
// Already defined in startup_CMSDK_CM1.s
// void UART0_Handler ( void );

#define UART_BUFFER_SIZE        		1
#define UART_HMI_BUFFER_RCVNUM			1

#define DEBUG_MOD										1

extern unsigned char UART_HMI_RCV[20];
extern unsigned char UART_SENDEND[3];
extern unsigned char UART_HMI_FLAG;

int InitialiseUART( void );
int InitialiseUART_1( void );
int InitialiseUART_2( void );
void EnableUARTInterrupts( void );
void EnableUARTInterrupts_1( void );
void EnableUARTInterrupts_2( void );
int CheckUARTRxBytes( void );
void SendHandler(void *CallBackRef, unsigned int EventData);
void RecvHandler(void *CallBackRef, unsigned int EventData);
void SendHandler_1(void *CallBackRef, unsigned int EventData);
void RecvHandler_1(void *CallBackRef, unsigned int EventData);


void UART_HMI_Send(char *SendString, unsigned char len);
void UART_HMI_PutChar(char CharByte);
void UART_HMI_instru_send(char * ins);

void UART_HMI_DEBUGinstru_send(char * ins);
void UART_DEBUG_PutChar(char CharByte);
void UART_DEBUG_String(char *String);
void UART_DEBUG_Send(char *SendString, unsigned char len);




