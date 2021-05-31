

/***************************** Include Files *******************************/
#include "Exin_ADC0832.h"
#include "xil_io.h"

/************************** Function Definitions ***************************/

void EXIN_ADC_Init()
{
	EXIN_ADC0832_mWriteReg(XPAR_EXIN_ADC0832_0_S0_AXI_BASEADDR , EXIN_ADC0832_S0_AXI_SLV_REG0_OFFSET, 0x01);
	EXIN_ADC0832_mWriteReg(XPAR_EXIN_ADC0832_0_S0_AXI_BASEADDR , EXIN_ADC0832_S0_AXI_SLV_REG0_OFFSET, 0x00);
}

int EXIN_ADC_RCV()
{
	int heartb;
	heartb = EXIN_ADC0832_mReadReg(XPAR_EXIN_ADC0832_0_S0_AXI_BASEADDR,EXIN_ADC0832_S0_AXI_SLV_REG1_OFFSET)-100;
	return heartb;
}