

/***************************** Include Files *******************************/
#include "Exin_noliner2.h"
#include "xil_io.h"

#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_MPU6050_GYXX_v1_0\src\Exin_MPU6050_GYXX.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_Timer_v1_0\src\Exin_Timer.h"
#include "V:\software\m3_for_arty_a7\EXIN_HMI\EXIN_HMI.h"
#include "uart.h"

/************************** Function Definitions ***************************/

void EXIN_NOLINER_Init()
{
	EXIN_NOLINER2_mWriteReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG2_OFFSET, 0x01);
	EXIN_NOLINER2_mWriteReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG2_OFFSET, 0x00);
}

float EXIN_NOLINER_Cal(float din, Noliner_enum type)
{
	char txt[256] = {0};
	
	float sin0 = 0;
	float cos0 = 0;
	float sinh0 = 0;
	float cosh0 = 0;
	float exp0 = 0;
	
	EXIN_NOLINER2_mWriteReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG0_OFFSET, (int)(din * 65536));
	
	sin0 	= (float)(EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG11_OFFSET)) / 65536.0;
	sinh0 = (float)(EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG5_OFFSET)) / 65536.0;
	
	cos0 	= (float)(EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG10_OFFSET)) / 65536.0;
	cosh0 = (float)(EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG6_OFFSET)) / 65536.0;

	
	exp0 = cosh0 + sinh0;
	
	switch( type )
	{
		case(SIN):
			return sin0;
		case(COS):
			return cos0;
		case(SINH):
			return sinh0;
		case(COSH):
			return cosh0;
		case(TANH):
			return sinh0/cosh0;
		case(EXP):
			return exp0;
		case(ELU):
			return EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG8_OFFSET);
		case(SIG):
			return 1 / (1 + 1 / exp0);
		case(SOF):
			return EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG13_OFFSET);
		case(SYS):
			return EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG14_OFFSET);
	}
	return 0;
}

void EXIN_NOLINER_Calculate()
{
	char txt[256] = {0};
	float nolinerdata;
	
	nolinerdata = EXIN_NOLINER_Cal(HMI_num, SIN);
	sprintf(txt, "t1.txt=\"%.6f\"",nolinerdata);
	UART_HMI_instru_send(txt);
//	UART_DEBUG_String(txt);//////////////////////////////
	
	nolinerdata = EXIN_NOLINER_Cal(HMI_num, COS);
	sprintf(txt,"t2.txt=\"%.6f\"",nolinerdata);
	UART_HMI_instru_send(txt);
//	UART_DEBUG_String(txt);//////////////////////////////
	
	nolinerdata = EXIN_NOLINER_Cal(HMI_num, SINH);
	sprintf(txt, "t3.txt=\"%.6f\"",nolinerdata);
	UART_HMI_instru_send(txt);
//	UART_DEBUG_String(txt);//////////////////////////////
	
	nolinerdata = EXIN_NOLINER_Cal(HMI_num, COSH);
	sprintf(txt, "t4.txt=\"%.6f\"",nolinerdata);
	UART_HMI_instru_send(txt);
//	UART_DEBUG_String(txt);//////////////////////////////
	
	nolinerdata = EXIN_NOLINER_Cal(HMI_num, EXP);
	sprintf(txt, "t5.txt=\"%.6f\"",nolinerdata);
	UART_HMI_instru_send(txt);
//	UART_DEBUG_String(txt);//////////////////////////////
	
	nolinerdata = EXIN_NOLINER_Cal(HMI_num, SIG);
	sprintf(txt, "t6.txt=\"%.6f\"",nolinerdata);
	UART_HMI_instru_send(txt);
//	UART_DEBUG_String(txt);//////////////////////////////

	sprintf(txt, "HMI = %f", HMI_num);
	UART_DEBUG_String( txt );
	
	sprintf(txt, "sin = %d", EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG11_OFFSET));
	UART_DEBUG_String( txt );
	
		sprintf(txt, "cos = %d", EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG10_OFFSET));
	UART_DEBUG_String( txt );
	
}

void EXIN_NOLINER_Test()
{
	char txt[256] = {0};
	
	EXIN_NOLINER2_mWriteReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG0_OFFSET, (int)(30 * 65536));
	sprintf(txt, "sin = %d", EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG11_OFFSET));
	UART_DEBUG_String( txt );

	sprintf(txt, "cos = %d", EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG10_OFFSET));
	UART_DEBUG_String( txt );
}
		