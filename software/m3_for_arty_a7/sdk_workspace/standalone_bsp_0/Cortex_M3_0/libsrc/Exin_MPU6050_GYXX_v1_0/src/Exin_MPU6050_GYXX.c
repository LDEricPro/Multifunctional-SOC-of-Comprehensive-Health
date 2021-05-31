

/***************************** Include Files *******************************/
#include "Exin_MPU6050_GYXX.h"

#include "Exin_noliner2.h"
#include "V:\software\m3_for_arty_a7\EXIN_HMI\EXIN_HMI.h"
#include "xil_io.h"

/************************** Function Definitions ***************************/

float ROLL = 0;
float PITCH = 0;
float YAW = 0;
float Wx = 0;
float Wy = 0;
float Wz = 0;
float Ax = 0;
float Ay = 0;
float Az = 0;
unsigned char MPU_FLAG = 0;
	
void EXIN_MPU_Init()
{
	EXIN_MPU6050_GYXX_mWriteReg(XPAR_EXIN_MPU6050_GYXX_0_S00_AXI_BASEADDR, EXIN_MPU6050_GYXX_S00_AXI_SLV_REG0_OFFSET, 0x01);
}

void EXIN_MPU_Deal()
{
	float NOLINER = 0;
	
	ROLL = EXIN_MPU6050_GYXX_mReadReg(XPAR_EXIN_MPU6050_GYXX_0_S00_AXI_BASEADDR, EXIN_MPU6050_GYXX_S00_AXI_SLV_REG2_OFFSET);
	PITCH = EXIN_MPU6050_GYXX_mReadReg(XPAR_EXIN_MPU6050_GYXX_0_S00_AXI_BASEADDR, EXIN_MPU6050_GYXX_S00_AXI_SLV_REG3_OFFSET);
	YAW = EXIN_MPU6050_GYXX_mReadReg(XPAR_EXIN_MPU6050_GYXX_0_S00_AXI_BASEADDR, EXIN_MPU6050_GYXX_S00_AXI_SLV_REG4_OFFSET);
	
	Wx = EXIN_MPU6050_GYXX_mReadReg(XPAR_EXIN_MPU6050_GYXX_0_S00_AXI_BASEADDR, EXIN_MPU6050_GYXX_S00_AXI_SLV_REG5_OFFSET);
	Wy = EXIN_MPU6050_GYXX_mReadReg(XPAR_EXIN_MPU6050_GYXX_0_S00_AXI_BASEADDR, EXIN_MPU6050_GYXX_S00_AXI_SLV_REG6_OFFSET);
	Wz = EXIN_MPU6050_GYXX_mReadReg(XPAR_EXIN_MPU6050_GYXX_0_S00_AXI_BASEADDR, EXIN_MPU6050_GYXX_S00_AXI_SLV_REG7_OFFSET);
	
	Ax = EXIN_MPU6050_GYXX_mReadReg(XPAR_EXIN_MPU6050_GYXX_0_S00_AXI_BASEADDR, EXIN_MPU6050_GYXX_S00_AXI_SLV_REG8_OFFSET);
	Ay = EXIN_MPU6050_GYXX_mReadReg(XPAR_EXIN_MPU6050_GYXX_0_S00_AXI_BASEADDR, EXIN_MPU6050_GYXX_S00_AXI_SLV_REG9_OFFSET);
	Az = EXIN_MPU6050_GYXX_mReadReg(XPAR_EXIN_MPU6050_GYXX_0_S00_AXI_BASEADDR, EXIN_MPU6050_GYXX_S00_AXI_SLV_REG10_OFFSET);
	
	ROLL = ROLL / 32768 * 180 - screen.ROLL_adj;
	PITCH = PITCH /32768 * 180 - screen.Pitch_adj;
	YAW = YAW / 32768 * 180 - screen.YAW_adj;
	
	Wx = Wx / 32768 * 2000;
	Wy = Wy / 32768 * 2000;
	Wz = Wz / 32768 * 2000;
	
	if( PITCH >= 180 )
	{
		EXIN_NOLINER2_mWriteReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG0_OFFSET, (int)((360 - PITCH) * 65536));
		NOLINER = ((float)EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG11_OFFSET) / 65536);
	}
	
	if( PITCH < 180 )
	{
		EXIN_NOLINER2_mWriteReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG0_OFFSET, (int)(PITCH * 65536));
		NOLINER = ((float)EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG11_OFFSET) / 65536);
	}
	
	Ax = (Ax / (float)(32768)) * 16 * 9.8 - NOLINER * 9.8;
	
	if( ROLL >= 180 )
	{
		EXIN_NOLINER2_mWriteReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG0_OFFSET, (int)((360 - ROLL) * 65536));
		NOLINER = ((float)EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG11_OFFSET) / 65536);
	}
	
	if( ROLL < 180 )
	{
		EXIN_NOLINER2_mWriteReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG0_OFFSET, (int)(ROLL * 65536));
		NOLINER = ((float)EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG11_OFFSET) / 65536);
	}
	
	Ay = (Ay / (float)(32768)) * 16 * 9.8 - NOLINER * 9.8;
	Az = (Az / (float)(32768)) * 16 * 9.8;
	
	MPU_FLAG = 1;
}
