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
 * File:     gpio.c
 * Release Information : Cortex-M3 DesignStart-r0p1-00rel0
 * ----------------------------------------------------------------
 *
 */

/*
 * --------Included Headers--------
 */

#include "gpio.h"
#include "xparameters.h"        // Project memory and device map
#include "xgpio.h"              // Xilinx GPIO routines
#include "peripherallink.h"     // IRQ definitions

#include "uart.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_Timer_v1_0\src\Exin_Timer.h"

/************************** Variable Definitions **************************/
/*
 * The following are declared static to this module so they are zeroed and so they are
 * easily accessible from a debugger
 *
 * Also they are initialised in main, but accessed by the IRQ routines
 */
 
static XGpio Gpio_Led_DIPSw;   /* The driver instance for GPIO Device 0 */
static XGpio Gpio_RGBLed_PB;   /* The driver instance for GPIO Device 1 */
static XGpio Gpio_DAPLink;     /* The driver instance for the DAPLink GPIO */

static XGpio EXIN_Gpio;				 /* The driver instance for the EXIN GPIO*/

unsigned char IO_PRINTER_FLAG = 0;

/*****************************************************************************/

// Initialise the GPIO and zero the outputs
int InitialiseGPIO( void )
{
    // Define local variables
    int status;

    /*
     * Initialize the GPIO driver so that it's ready to use,
     * specify the device ID that is generated in xparameters.h
    */
    status = XGpio_Initialize(&Gpio_Led_DIPSw, XPAR_AXI_GPIO_0_DEVICE_ID);
    if (status != XST_SUCCESS)  {
        return XST_FAILURE;
    }

    status = XGpio_Initialize(&Gpio_RGBLed_PB, XPAR_AXI_GPIO_1_DEVICE_ID);
    if (status != XST_SUCCESS)  {
        return XST_FAILURE;
    }

    status = XGpio_Initialize(&Gpio_DAPLink, XPAR_DAPLINK_IF_0_AXI_GPIO_0_DEVICE_ID);
    if (status != XST_SUCCESS)  {
        return XST_FAILURE;
    }

		status = XGpio_Initialize(&EXIN_Gpio, XPAR_AXI_GPIO_2_DEVICE_ID);
		if (status != XST_SUCCESS)	{
				return XST_FAILURE;
		}

    // GPIO0
    // Port0 drives led_4bits.  Set bottom 4 UART ports to be outputs.
    XGpio_SetDataDirection(&Gpio_Led_DIPSw, ARTY_A7_LED_CHANNEL, 0xFFFFFFF0);
//    ARTY_A7_GPIO0->TRI0 = 0xfffffff0;

    // Port 1 inputs the dip switches. Set to be inputs
    XGpio_SetDataDirection(&Gpio_Led_DIPSw, ARTY_A7_DIP_CHANNEL, 0xFFFFFFFF);
//    ARTY_A7_GPIO0->TRI1 = 0xffffffff;

    // GPIO1
    // Port0 drives led_rgb.  Set 12 UART ports to be outputs.
    XGpio_SetDataDirection(&Gpio_RGBLed_PB, ARTY_A7_RGB_CHANNEL, 0xfffff000);
//    ARTY_A7_GPIO1->TRI0 = 0xfffff000;
    // Port 1 inputs the push button switches. Set to be inputs
    XGpio_SetDataDirection(&Gpio_RGBLed_PB, ARTY_A7_PB_CHANNEL, 0xffffffff);
//    ARTY_A7_GPIO1->TRI1 = 0xffffffff;
    
    // DAPLink GPIO
    // Single channel
    XGpio_SetDataDirection(&Gpio_DAPLink, ARTY_A7_DAPLINK_GPIO_CHANNEL, 0x00000000);

		//EXIN_GPIO
		//Set all the ports to be outputs except those unused
		XGpio_SetDataDirection(&EXIN_Gpio, EXIN_GPIO_CHANNEL, 0xFFFFFFF8);



    // Default value of LEDs
    XGpio_DiscreteWrite(&Gpio_RGBLed_PB, ARTY_A7_RGB_CHANNEL, 0x0);
//    ARTY_A7_GPIO1->DATA0 = 0x0;
    
    // Write 0xA to LEDs
    XGpio_DiscreteWrite(&Gpio_Led_DIPSw, ARTY_A7_LED_CHANNEL, 0x0);
//    ARTY_A7_GPIO0->DATA0 = 0x0;

		// Write the default value of EIXN_GPIOs
		XGpio_DiscreteWrite(&EXIN_Gpio, EXIN_GPIO_CHANNEL, 0x0);

    return XST_SUCCESS;
    
}

// Set GPIO interrupts
void EnableGPIOInterrupts( void )
{
    // Push buttons and DIP switches are on Channel 2
    XGpio_InterruptEnable(&Gpio_RGBLed_PB, XGPIO_IR_CH2_MASK);
    XGpio_InterruptEnable(&Gpio_Led_DIPSw, XGPIO_IR_CH2_MASK);

    // Having enabled the M1 to handle the interrupts, now enable the GPIO to send the interrupts
    XGpio_InterruptGlobalEnable(&Gpio_RGBLed_PB);
    XGpio_InterruptGlobalEnable(&Gpio_Led_DIPSw);
}


// Define the GPIO interrupt handlers
void GPIO0_Handler ( void )
{
    volatile uint32_t gpio_dip_switches;
		char txt[256];

    // Read dip switches, change LEDs to match
    gpio_dip_switches = XGpio_DiscreteRead(&Gpio_Led_DIPSw, ARTY_A7_DIP_CHANNEL);   // Capture DIP status
    XGpio_DiscreteWrite(&Gpio_Led_DIPSw, ARTY_A7_LED_CHANNEL, gpio_dip_switches);   // Set LEDs
		
		IO_PRINTER_FLAG = gpio_dip_switches;
//		XGpio_DiscreteWrite(&EXIN_Gpio, EXIN_GPIO_CHANNEL, gpio_dip_switches);
		sprintf(txt, "%x",gpio_dip_switches);
		UART_DEBUG_String( txt );

    // Clear interrupt from GPIO
    XGpio_InterruptClear(&Gpio_Led_DIPSw, XGPIO_IR_MASK);
    // Clear interrupt in NVIC
    NVIC_ClearPendingIRQ(GPIO0_IRQn);
}

void GPIO1_Handler ( void )
{

    int mask, led_val, incr;
    volatile uint32_t gpio_push_buttons;
    volatile uint32_t gpio_leds_rgb;

    // For LEDs, cycle around colour each time respective push button is pressed
    // Only change if a pushbutton is pressed.
    // This prevents a double change as the button is released.
    if( XGpio_DiscreteRead(&Gpio_RGBLed_PB, ARTY_A7_PB_CHANNEL) != 0 )
    {
        // LEDs are on a 3 spacing.  So multiply button press by 2^3 to increment the correct LED
        gpio_push_buttons = XGpio_DiscreteRead(&Gpio_RGBLed_PB, ARTY_A7_PB_CHANNEL);
        gpio_leds_rgb     = XGpio_DiscreteRead(&Gpio_RGBLed_PB, ARTY_A7_RGB_CHANNEL);
        if ( gpio_push_buttons & 0x1 ) {
                mask = 0x7;
                incr = 0x1;
        } else if ( gpio_push_buttons & 0x2 ) {
                mask = (0x7 << 3);
                incr = (0x1 << 3);
        } else if ( gpio_push_buttons & 0x4 ) {
                mask = (0x7 << 6);
                incr = (0x1 << 6);
        } else if ( gpio_push_buttons & 0x8 ) {
                mask = (0x7 << 9);
                incr = (0x1 << 9);
        }

        led_val = gpio_leds_rgb & mask;
        led_val = (led_val+incr) & mask;
        gpio_leds_rgb = (gpio_leds_rgb & ~mask) | led_val;
        
        XGpio_DiscreteWrite(&Gpio_RGBLed_PB, ARTY_A7_RGB_CHANNEL, gpio_leds_rgb);
    }

    // Clear interrupt from GPIO
    XGpio_InterruptClear(&Gpio_RGBLed_PB, XGPIO_IR_MASK);
    // Clear interrupt in NVIC
    NVIC_ClearPendingIRQ(GPIO1_IRQn);
}

/* Note : No interrupt handler for DAPLink GPIO, it does not have the IRQ line connected
          No requirement as it is only a toggle between QSPI XIP and QSPI normal controllers
          Instead, standard routine provided
*/

void SetDAPLinkQSPIMode( u32 mode )
{
    // Set the qspi_sel line
    XGpio_DiscreteWrite(&Gpio_DAPLink, ARTY_A7_DAPLINK_GPIO_CHANNEL, mode);
    
}

void IncLeds( void )
{
    // Routine to allow other blocks to indicate activity
    volatile uint32_t gpio_dip_switches;

    // Read dip switches, change LEDs to match
    gpio_dip_switches = XGpio_DiscreteRead(&Gpio_Led_DIPSw, ARTY_A7_DIP_CHANNEL);   // Capture DIP status
    XGpio_DiscreteWrite(&Gpio_Led_DIPSw, ARTY_A7_LED_CHANNEL, (gpio_dip_switches+1));   // Set LEDs
    
}

u32 EXIN_GPIO_CAM_Set( EXIN_GPIO_CAM_IO EXIN_GPIO_CAM_SELECT, unsigned char mode )
{
		volatile uint32_t EXIN_GPIO_CAM_READ;
	
		EXIN_GPIO_CAM_READ = XGpio_DiscreteRead(&EXIN_Gpio, EXIN_GPIO_CHANNEL);
		
		switch( EXIN_GPIO_CAM_SELECT )
		{
				case EXIN_GPIO_CAM_IO0:
				{
						if( mode == EXIN_GPIO_CAM_IO0_ON )
						{
								XGpio_DiscreteWrite(&EXIN_Gpio, EXIN_GPIO_CHANNEL, EXIN_GPIO_CAM_READ | EXIN_GPIO_CAM_IO0_ON);
						}
						else if( mode == EXIN_GPIO_CAM_IO0_OFF )
						{
								XGpio_DiscreteWrite(&EXIN_Gpio, EXIN_GPIO_CHANNEL, EXIN_GPIO_CAM_READ & EXIN_GPIO_CAM_IO0_OFF);
						}
				
						break;
				}
			
				case EXIN_GPIO_CAM_IO1:
				{
						if( mode == EXIN_GPIO_CAM_IO1_ON )
						{
								XGpio_DiscreteWrite(&EXIN_Gpio, EXIN_GPIO_CHANNEL, EXIN_GPIO_CAM_READ | EXIN_GPIO_CAM_IO1_ON);
						}
						else if( mode == EXIN_GPIO_CAM_IO1_OFF )
						{
								XGpio_DiscreteWrite(&EXIN_Gpio, EXIN_GPIO_CHANNEL, EXIN_GPIO_CAM_READ & EXIN_GPIO_CAM_IO1_OFF);
						}
				
						break;
				}
			
				case EXIN_GPIO_CAM_IO2:
				{
						if( mode == EXIN_GPIO_CAM_IO2_ON )
						{
								XGpio_DiscreteWrite(&EXIN_Gpio, EXIN_GPIO_CHANNEL, EXIN_GPIO_CAM_READ | EXIN_GPIO_CAM_IO2_ON);
						}
						else if( mode == EXIN_GPIO_CAM_IO2_OFF )
						{
								XGpio_DiscreteWrite(&EXIN_Gpio, EXIN_GPIO_CHANNEL, EXIN_GPIO_CAM_READ & EXIN_GPIO_CAM_IO2_OFF);
						}
						
						break;
				}
		}
		
		return XGpio_DiscreteRead(&EXIN_Gpio, EXIN_GPIO_CHANNEL);
}

void EXIN_GPIO_SetMode( EXIN_MODE MODE )
{
	switch( MODE )
	{
		case MODE_NORMAL:
		{
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO0, EXIN_GPIO_CAM_IO0_OFF);
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO1, EXIN_GPIO_CAM_IO1_ON);
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO2, EXIN_GPIO_CAM_IO2_OFF);
			
			break;
		}
		
		case MODE_BLACK_WHITE:
		{
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO0, EXIN_GPIO_CAM_IO0_OFF);
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO1, EXIN_GPIO_CAM_IO1_OFF);
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO2, EXIN_GPIO_CAM_IO2_ON);
			
			break;
		}
		
		case MODE_TAKE_PICTURE:
		{
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO0, EXIN_GPIO_CAM_IO0_ON);
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO0, EXIN_GPIO_CAM_IO0_OFF);
		
			break;
		}
		
		case MODE_EXIT:
		{
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO0, EXIN_GPIO_CAM_IO0_OFF);
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO1, EXIN_GPIO_CAM_IO1_OFF);
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO2, EXIN_GPIO_CAM_IO2_OFF);
			
			break;
		}
		
		case MODE_ANTICOLOR:
		{
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO0, EXIN_GPIO_CAM_IO0_OFF);
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO1, EXIN_GPIO_CAM_IO1_ON);
			EXIN_GPIO_CAM_Set(EXIN_GPIO_CAM_IO2, EXIN_GPIO_CAM_IO2_ON);
			
			break;
		}
	}
}