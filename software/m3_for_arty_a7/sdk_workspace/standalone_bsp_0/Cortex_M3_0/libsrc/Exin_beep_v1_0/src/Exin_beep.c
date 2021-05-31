

/***************************** Include Files *******************************/
#include "Exin_beep.h"
#include "xil_io.h"

#include "V:\software\m3_for_arty_a7\EXIN_HMI\EXIN_HMI.h"
#include "Exin_Timer.h"

/************************** Function Definitions ***************************/

void EXIN_BEEP_Init()
{
	EXIN_BEEP_mWriteReg(XPAR_EXIN_BEEP_0_S0_AXI_BASEADDR, EXIN_BEEP_S0_AXI_SLV_REG1_OFFSET, 0x10);
}
	
void EXIN_BEEP(int us)
{
	if( screen.voice )
	{
		EXIN_BEEP_mWriteReg(XPAR_EXIN_BEEP_0_S0_AXI_BASEADDR, EXIN_BEEP_S0_AXI_SLV_REG0_OFFSET, us);
		EXIN_BEEP_mWriteReg(XPAR_EXIN_BEEP_0_S0_AXI_BASEADDR, EXIN_BEEP_S0_AXI_SLV_REG1_OFFSET, 0x01);
		EXIN_TIMER_Delayus(us);
		EXIN_BEEP_mWriteReg(XPAR_EXIN_BEEP_0_S0_AXI_BASEADDR, EXIN_BEEP_S0_AXI_SLV_REG1_OFFSET, 0x00);
	}
}
	
	
	