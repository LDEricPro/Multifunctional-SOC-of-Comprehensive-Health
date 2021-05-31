

/***************************** Include Files *******************************/
#include "Exin_MAXMIN2.h"
#include "xil_io.h"

/************************** Function Definitions ***************************/

void EXIN_MAXMIN_Init()
{
	EXIN_MAXMIN2_mWriteReg(XPAR_EXIN_MAXMIN2_0_S0_AXI_BASEADDR,EXIN_MAXMIN2_S0_AXI_SLV_REG0_OFFSET, 0x01);
	EXIN_MAXMIN2_mWriteReg(XPAR_EXIN_MAXMIN2_0_S0_AXI_BASEADDR,EXIN_MAXMIN2_S0_AXI_SLV_REG0_OFFSET, 0x00);
}

int EXIN_MAXMIN_Get(EXIN_MAXMIN type)
{
	switch(type)
	{
		case EXIN_MAXMIN_MAX:
		{
			return EXIN_MAXMIN2_mReadReg(XPAR_EXIN_MAXMIN2_0_S0_AXI_BASEADDR, EXIN_MAXMIN2_S0_AXI_SLV_REG1_OFFSET);
		}
		
		case EXIN_MAXMIN_MIN:
		{
			return EXIN_MAXMIN2_mReadReg(XPAR_EXIN_MAXMIN2_0_S0_AXI_BASEADDR, EXIN_MAXMIN2_S0_AXI_SLV_REG2_OFFSET);
		}
		
		case EXIN_MAXMIN_THREAD:
		{
			return EXIN_MAXMIN2_mReadReg(XPAR_EXIN_MAXMIN2_0_S0_AXI_BASEADDR, EXIN_MAXMIN2_S0_AXI_SLV_REG3_OFFSET);
		}
	}
	return 0;
}