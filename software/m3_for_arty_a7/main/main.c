/*
 * Copyright:
 * ----------------------------------------------------------------
 * This confidential and proprietary software may be used only as
 * authorised by a licensing agreement from ARM Limited
 *   (C) COPYRIGHT 2014, 2016 ARM Limited
 *       ALL RIGHTS RESERVED
 * The entire notice above must be reproduced on all authorised
 * copies and copies may only be made to the extent permitted
 * by a licensing agreement from ARM Limited.
 * ----------------------------------------------------------------
 * File:     main.c
 * Release Information : Cortex-M3 DesignStart-r0p1-00rel0
 * ----------------------------------------------------------------
 *
 */

/*
 * --------Included Headers--------
 */

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

// Xilinx specific headers
#include "xparameters.h"
#include "xgpio.h"

#include "m3_for_arty.h"        // Project specific header
#include "gpio.h"
#include "uart.h"
#include "spi.h"
#include "atomic.h"

#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_beep_v1_0\src\Exin_beep.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\breath_led_v1_0\src\breath_led.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_MPU6050_GYXX_v1_0\src\Exin_MPU6050_GYXX.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_Timer_v1_0\src\Exin_Timer.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_dht11_v1_0\src\Exin_dht11.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_StepCounter_debug_v1_0\src\Exin_StepCounter_debug.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_noliner2_v1_0\src\Exin_noliner2.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_ADC0832_v1_0\src\Exin_ADC0832.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_MAXMIN2_v1_0\src\Exin_MAXMIN2.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_HeartFre2_v1_0\src\Exin_HeartFre2.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_HMITX_v1_0\src\Exin_HMITX.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_IO_printer_v1_0\src\Exin_IO_printer.h"

#include "V:\software\m3_for_arty_a7\EXIN_HMI\EXIN_HMI.h"

short UART_BT_DATA[20] = {0};

														
// Atomic test function
uint32_t atomic_test(uint32_t *mem, uint32_t val);

/*******************************************************************/

int main (void)
{

    // Define local variables
    int     status;
    int     DAPLinkFittedn;
    int     i;
    int     readbackError;
    char    debugStr[256];
	
		int 		heartb2;
		short 	temp;
		char		txt[256];
		int TIME;
    
    // Illegal location
    volatile u32 emptyLoc;
    volatile u32 QSPIbase;
        
    // DTCM test location
    uint32_t dtcmTest;
    
    // BRAM base
    // Specify as volatile to ensure processor reads values back from BRAM
    // and not local storage
    volatile u32 *pBRAMmemory = (u32 *)XPAR_BRAM_0_BASEADDR;

    // CPU ID register
    volatile u32 *pCPUId = (u32 *)0xE000ED00;
    volatile u32 CPUId;
    volatile u32 alias_test;
    int          CPU_part;
    int          CPU_rev;
    int          CPU_var;
    char         CPU_name[20];
        
    // Enable the following if you wish to test illegal accesses
    // and debug lock-up conditions
/*    
    u32 *pLegalAddr   = (u32 *)0x40120000;
    u32 *pIllegalAddr = (u32 *)0x40200000;
*/


    // Test data for SPI
    u8 spi_tx_data[8] = {0x01,0x23,0x45,0x67,0x89,0xab,0xcd,0xef};
    u8 spi_rx_data[8] = {0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
    
    // Test data for BRAM
    u32 bram_data[8] = {0x01234567, 0x89abcdef, 0xdeadbeef, 0xfeebdaed, 0xa5f03ca5, 0x87654321, 0xfedc0ba9, 0x01020408};

    // Initialise the UART
    InitialiseUART();
		

    // Clear all interrupts
    NVIC_ClearAllPendingIRQ();
    
    // Initialise the GPIO
    status = InitialiseGPIO();
    if (status != XST_SUCCESS)  {
        print("Error - Xilinx GPIO failed to initialise\n");
    }

    // Enable GPIO Interrupts
    NVIC_EnableIRQ(GPIO0_IRQn);
    NVIC_EnableIRQ(GPIO1_IRQn);
    EnableGPIOInterrupts();

    // Enable UART Interrupts
    NVIC_EnableIRQ(UART0_IRQn);
    EnableUARTInterrupts();


    // Read the DAPLinkFitted input, (assigned to IRQ[31]).
    // Note the IRQ is never enabled, so polling the pending register will indicate the status
    NVIC_DisableIRQ(DAPLinkFittedn_IRQn);
    DAPLinkFittedn = NVIC_GetPendingIRQ( DAPLinkFittedn_IRQn );


    // Initialise the SPI
    status = InitialiseSPI(DAPLinkFittedn);
    if (status != XST_SUCCESS)  {
        print("Error - Xilinx SPI controllers failed to initialise\n");
    }

    DisableSPIInterrupts();


    // Set DAPLink QSPI to the normal read-write controller
    // Do NOT do this for code running from the DAPLink QSPI.  This will switch from the XIP QSPI
    // controller to the standard controller, so the processor will not be able to access it's code image
    // This should only be done if the XIP QSPI is used to copy code to internal TCM, then boot-load from that TCM
//    SetDAPLinkQSPIMode( QSPI_QSPIMODE );

    // Read the CPU ID register to auto-detect the CPU and revision
    // Note however that code is compiled for a specific processor, so even though
    // the processor can be auto-detected, if the compiled code has extended commands not
    // supported by the processor, then runtime issues can occur
    CPUId    = *pCPUId;
    CPU_var  = ((CPUId & 0x00F00000) >> 20);
    CPU_part = ((CPUId & 0x0000FFF0) >> 4);
    CPU_rev  = CPUId & (0x0000000F);
    
    switch (CPU_part)
    {
      case 0xC21 : strcpy(  CPU_name, "Cortex-M1" ); break;
      case 0xC23 : strcpy(  CPU_name, "Cortex-M3" ); break;
      default    : sprintf( CPU_name, "Unknown %x", CPU_part );
    }
    
    sprintf (debugStr, "Arm %s Revision %i Variant %i\r\n\n", CPU_name, CPU_rev, CPU_var );
    
#ifndef SIM_BUILD    
    // Use Xilinx version print command
    print ("************************************\r\n");
    print ( debugStr );
    print ("Example design for Digilent A7 board\r\n");
    if ( DAPLinkFittedn )
      print ("\nV2C-DAPLink board not detected\r\n");
    else
      print ("\nV2C-DAPLink board detected\r\n");
    print ("Use DIP switches and push buttons to\r\ncontrol LEDS\r\n");
    print (" Version 4.98\r\n");
    print ("************************************\r\n");
#else
    print ( debugStr );
#endif    

        // *****************************
        // Test the code memory aliasing
        // *****************************
        // Uses the reserved vector table location 0x0000001c and its alias
        // This is only writeable in TCM, a write to QSPI will hang
        // Any access to an unmapped region will hang

        // DAPLINK fitted: (Low QSPI, High BRAM)
        // DAPLINK absent: (Low BRAM, High BRAM)
        status = 0;

        if(*(uint32_t*)0x0000001c != 0x55){
          status += 1;
           }
        if(*(uint32_t*)0x1000001c != 0x55){
          status += 2;
          }

        // Write to ITCM upper alias
        *(uint32_t*)0x1000001c = 12;

        if(DAPLinkFittedn){
        //Lower alias should have changed
          if(*(uint32_t*)0x0000001c != 12){
            status += 4;
            }
            // Write to ITCM lower alias
          *(uint32_t*)0x0000001c = 11;
          if(*(uint32_t*)0x0000001c != 11){
            status += 4;
            }
          if(*(uint32_t*)0x1000001c != 11){
            status += 8;
            }
          } else {
          if(*(uint32_t*)0x0000001c != 0x55){
            status += 4;
            }
          if(*(uint32_t*)0x1000001c != 12){
            status += 8;
            }
          }


          if (status == 3){
            print("Upper and lower regions written since BRAM initialised\r\n");
                                                status = 0;
            }
                                        if (status == 2){
            print("Upper alias writen since BRAM initialised\r\n");
                                                status = 0;
                                        }                   
          if (status == 4 && (*(uint32_t*)0x0000001c == 12)){
            print("ITCM also aliased high\r\n");
                                          status = 0;
            }
                                        if(status != 0){
          print("Unexpected alias behaviour");
          // 1: QSPI content unexpected
          // 2: ITCM content unexpected (maybe written by download)
          // 4: Lower alias overwritten or wrong
          // 8: ITCM Upper alias not changed
          sprintf(debugStr, " %d\r\n", status);
          print(debugStr);
         } else {
           print ("Aliasing OK\r\n");
           }
    // *****************************************************
    // Test the BRAM
    // *****************************************************
    
    // Write to BRAM
    for( i=0; i< (sizeof(bram_data)/sizeof(u32)); i++)
        *pBRAMmemory++ = bram_data[i];
    readbackError = 0;
    // Reset the pointer
    pBRAMmemory = (u32 *)XPAR_BRAM_0_BASEADDR;

    // Readback
    for( i=0; i< (sizeof(bram_data)/sizeof(u32)); i++)
    {
      if ( *pBRAMmemory++ != bram_data[i] )
        readbackError++;
      }

    if ( readbackError )
        print( "ERROR - Bram readback corrupted.\r\n" );
    else
        print( "Bram readback correct\r\n" );


    // *****************************************************
    // Test the SPI
    // *****************************************************
    
    // Initialise the base QSPI to the correct mode
    status = InitQSPIBaseFlash();
    status = WriteQSPIBaseFlash( spi_tx_data, sizeof(spi_tx_data)/sizeof(u8), 0x0 );
    status = ReadQSPIBaseFlash ( spi_rx_data, sizeof(spi_rx_data)/sizeof(u8), 0x0 );


    // Manually type out, print does work when called back to back from a loop
/*
    sprintf( debugStr, "%x %x %x %x %x %x %x %x\r\n", spi_rx_data[0], spi_rx_data[1], spi_rx_data[2], spi_rx_data[3], 
                                                   spi_rx_data[4], spi_rx_data[5], spi_rx_data[6], spi_rx_data[7] );
    print( debugStr );
*/    
    // Compare buffers
    readbackError = 0;
    for( i=0; i<(sizeof(spi_rx_data)/sizeof(u8)); i++ )
    {
        if( spi_rx_data[i] != spi_tx_data[i] )
            readbackError++;
    }

    if ( readbackError )
        print( "ERROR - Base SPI readback corrupted.\r\n" );
    else
        print( "Base SPI readback correct\r\n" );
   

    // ******************************************************
    // Test exceptions.  Write to legal and illegal addresses
    // ******************************************************
/*    
    // Do an access to an legal location
    emptyLoc = *pLegalAddr;

    // Do an access to an illegal location
    emptyLoc = *pIllegalAddr;

*/
   // ******************************************************
   // Test exclusive transactions
   // ******************************************************
   
   // Data TCM supports exclusive access
   status = atomic_access(&dtcmTest,0x12341230);
   if (status == 1) {
   print( "STREX DTCM failed unexpectedly\r\n");
   }
   // Instruction TCM supports exclusive access (ARTY connected)
   status = atomic_access((uint32_t*)0x10001000,0x12341231);
   if (status == 1) {
   print( "STREX ITCM high alias failed unexpectedly\r\n");
   }
   // Instruction QSPI region, no exclusive monitor
   // Unused vector table entry after Usage fault handler
   status = atomic_access((uint32_t*)0x0000001c,0x12341232);
   if (status == 1 && DAPLinkFittedn) {
   print( "STREX ITCM low alias failed unexpectedly\r\n");
   }
   if (status == 0 && !DAPLinkFittedn) {
   print( "STREX QSPI success (unexpected)\r\n");
   }               
   // BRAM region is external, no exclusive monitor
   status = atomic_access((uint32_t*)XPAR_BRAM_0_BASEADDR,0x12341233);
   if (status == 0 && !DAPLinkFittedn) {
   print( "STREX BRAM success (unexpected)\r\n");
   }
   print( "Atomic transaction test completed\r\n" );
   

   // print( "Startup complete, entering main interrupt loop\r\n" );
/***********************************************************************************************************/
	 InitialiseUART_1();
	 EnableUARTInterrupts_1();	 
	 
	 UART_BT_Init();
	 
	 EXIN_ADC_Init();
	 EXIN_MPU_Init();
	 EXIN_MAXMIN_Init();
	 EXIN_HEART_Init();
	 EXIN_BEEP_Init();
	 screen_init(&screen);

	 EXIN_TIMER_Init();
	 EXIN_IO_PRINTER_Init();
	 
	 EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO0, EXIN_GPIO_CAM_IO0_OFF);
	 EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO1, EXIN_GPIO_CAM_IO0_OFF);
	 EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO2, EXIN_GPIO_CAM_IO0_ON);
	 
//	 EXIN_NOLINER_Test();
    // Main loop.  Handle LEDs and switches via interrupt
    while ( 1 )
    {
        /* Main loop. Wait for interrupts to occur */
        /*
        if ( CheckUARTRxBytes() != 0 )
            print ("x");
        */
			
			instru_deal();	
			EXIN_MPU_Deal();
			EXIN_HMI_Handle();
			

			if( BLE_FLAG )
			{
				UART_BT_PutChar(0xa5);
				temp = 0;
				heartb2 = EXIN_ADC_RCV();
				UART_BT_DATA[0] = (short)DHT_TMPH & 0xFF;
				UART_BT_DATA[1] = (short)DHT_WETH & 0xFF;
				UART_BT_DATA[2] = (short)step_counter & 0xFF;
				UART_BT_DATA[3] = (short)heartfre & 0xFF;
				UART_BT_DATA[4] = (short)heartfre >> 8;
				UART_BT_DATA[5] = (short)heartb2 & 0xFF;
        UART_BT_DATA[6] = (short)heartb2 >> 8;
				UART_BT_DATA[7] = (short)ROLL & 0xFF;
				UART_BT_DATA[8] = (short)ROLL >> 8;
				UART_BT_DATA[9] = (short)PITCH & 0xFF;
				UART_BT_DATA[10] = (short)PITCH >> 8;
				UART_BT_DATA[11] = (short)YAW & 0xFF;
				UART_BT_DATA[12] = (short)YAW >> 8;
				UART_BT_PutChar(UART_BT_DATA[0]);
				UART_BT_PutChar(UART_BT_DATA[1]);
				UART_BT_PutChar(UART_BT_DATA[2]);
				UART_BT_PutChar(UART_BT_DATA[3]);
				UART_BT_PutChar(UART_BT_DATA[4]);
				UART_BT_PutChar(UART_BT_DATA[5]);
				UART_BT_PutChar(UART_BT_DATA[6]);
				UART_BT_PutChar(UART_BT_DATA[7]);
				UART_BT_PutChar(UART_BT_DATA[8]);
				UART_BT_PutChar(UART_BT_DATA[9]);
				UART_BT_PutChar(UART_BT_DATA[10]);
				UART_BT_PutChar(UART_BT_DATA[11]);
				UART_BT_PutChar(UART_BT_DATA[12]);
//				UART_BT_PutChar(UART_BT_DATA[13]);
				for(i = 0; i < 13; i ++)
				{
					temp += UART_BT_DATA[i];
				}
				UART_BT_PutChar(temp & 0xFF);
				
				UART_BT_PutChar(0x5a);
				
			}
			
//			sprintf(txt, "%u", EXIN_HEART_Check());
//			print( txt );

//				UART_BT_PutChar(0x00);
//				UART_BT_PutChar(0x00);
//				UART_BT_PutChar(0x00);
//				UART_BT_PutChar(0x00);
//				UART_BT_PutChar(0x00);
//				UART_BT_PutChar(0x00);
//				UART_BT_PutChar(((DHT_TMPH & 0xFF)+(DHT_WETH & 0xFF)) & 0xFF);
				
				
			
			

			
    
    }
}

/* Interrupt handler for DAPLink Fitted */
// This routine should never be called as the signal is used as IO
// Routine created to prevent exceptions in the case the IRQ is enabled
void DAPLinkFittedn ( void )
{
    // Clear the IRQ and disable any future IRQs
    NVIC_ClearPendingIRQ(DAPLinkFittedn_IRQn);
    NVIC_DisableIRQ(DAPLinkFittedn_IRQn);
}
