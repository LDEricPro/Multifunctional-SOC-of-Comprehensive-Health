

/***************************** Include Files *******************************/
#include "Exin_HMITX.h"
#include "xil_io.h"

#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_Timer_v1_0\src\Exin_Timer.h"

/************************** Function Definitions ***************************/

void UART_BT_Init()
{
	EXIN_HMITX_mWriteReg(XPAR_EXIN_HMITX_0_S0_AXI_BASEADDR, EXIN_HMITX_S0_AXI_SLV_REG1_OFFSET, 0x00);
	EXIN_HMITX_mWriteReg(XPAR_EXIN_HMITX_0_S0_AXI_BASEADDR, EXIN_HMITX_S0_AXI_SLV_REG1_OFFSET, 0x01);
}

void UART_BT_PutChar(unsigned char CharByte)
{
	while( EXIN_HMITX_mReadReg(XPAR_EXIN_HMITX_0_S0_AXI_BASEADDR,  EXIN_HMITX_S0_AXI_SLV_REG2_OFFSET) == 0 );
	
	EXIN_HMITX_mWriteReg(XPAR_EXIN_HMITX_0_S0_AXI_BASEADDR, EXIN_HMITX_S0_AXI_SLV_REG0_OFFSET, CharByte);
	EXIN_HMITX_mWriteReg(XPAR_EXIN_HMITX_0_S0_AXI_BASEADDR, EXIN_HMITX_S0_AXI_SLV_REG1_OFFSET, 0x03);
	EXIN_HMITX_mWriteReg(XPAR_EXIN_HMITX_0_S0_AXI_BASEADDR, EXIN_HMITX_S0_AXI_SLV_REG1_OFFSET, 0x01);


}

void UART_BT_String(char *String)
{
	while (*String != (char8)0) 
	{
    UART_BT_PutChar(*String);
		String++;
		EXIN_TIMER_Delayus(100);
  }
}

