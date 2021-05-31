/***************************** Include Files *******************************/
#include "Exin_IO_printer.h"
#include "xil_io.h"

/************************** Function Definitions ***************************/

void EXIN_IO_PRINTER_Init()
{
	EXIN_IO_PRINTER_mWriteReg(XPAR_EXIN_IO_PRINTER_0_S0_AXI_BASEADDR, EXIN_IO_PRINTER_S0_AXI_SLV_REG1_OFFSET, 0x01);
	EXIN_IO_PRINTER_mWriteReg(XPAR_EXIN_IO_PRINTER_0_S0_AXI_BASEADDR, EXIN_IO_PRINTER_S0_AXI_SLV_REG2_OFFSET, 0x00);

}
	
void EXIN_IO_PRINTER_Print(int i)
{
		EXIN_IO_PRINTER_mWriteReg(XPAR_EXIN_IO_PRINTER_0_S0_AXI_BASEADDR, EXIN_IO_PRINTER_S0_AXI_SLV_REG2_OFFSET, i);
		EXIN_IO_PRINTER_mWriteReg(XPAR_EXIN_IO_PRINTER_0_S0_AXI_BASEADDR, EXIN_IO_PRINTER_S0_AXI_SLV_REG0_OFFSET, 0x01);
		EXIN_IO_PRINTER_mWriteReg(XPAR_EXIN_IO_PRINTER_0_S0_AXI_BASEADDR, EXIN_IO_PRINTER_S0_AXI_SLV_REG0_OFFSET, 0x00);
		
		while( EXIN_IO_PRINTER_mReadReg(XPAR_EXIN_IO_PRINTER_0_S0_AXI_BASEADDR, EXIN_IO_PRINTER_S0_AXI_SLV_REG3_OFFSET) == 0 );

}