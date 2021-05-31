
/***************************** Include Files *******************************/
#include "Exin_HMITX.h"
#include "xparameters.h"
#include "stdio.h"
#include "xil_io.h"

/************************** Constant Definitions ***************************/
#define READ_WRITE_MUL_FACTOR 0x10

/************************** Function Definitions ***************************/
/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the EXIN_HMITXinstance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus EXIN_HMITX_Reg_SelfTest(void * baseaddr_p)
{
	u32 baseaddr;
	int write_loop_index;
	int read_loop_index;
	int Index;

	baseaddr = (u32) baseaddr_p;

	print("******************************\n\r");
	print("* User Peripheral Self Test\n\r");
	print("******************************\n\n\r");

	/*
	 * Write to user logic slave module register(s) and read back
	 */
	print("User logic slave module test...\n\r");

	for (write_loop_index = 0 ; write_loop_index < 4; write_loop_index++)
	  EXIN_HMITX_mWriteReg (baseaddr, write_loop_index*4, (write_loop_index+1)*READ_WRITE_MUL_FACTOR);
	for (read_loop_index = 0 ; read_loop_index < 4; read_loop_index++)
	  if ( EXIN_HMITX_mReadReg (baseaddr, read_loop_index*4) != (read_loop_index+1)*READ_WRITE_MUL_FACTOR){
	    print ("Error reading register value at address \n");
	    return XST_FAILURE;
	  }

	print("   - slave register write/read passed\n\n\r");

	return XST_SUCCESS;
}
