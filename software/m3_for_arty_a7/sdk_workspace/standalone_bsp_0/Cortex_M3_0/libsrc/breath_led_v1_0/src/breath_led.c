

/***************************** Include Files *******************************/
#include "breath_led.h"
#include "xil_io.h"

/************************** Function Definitions ***************************/

void BREATH_LED_Light(int Brightness)
{
	BREATH_LED_mWriteReg(XPAR_BREATH_LED_0_S0_AXI_BASEADDR, BREATH_LED_S0_AXI_SLV_REG0_OFFSET, Brightness);
}