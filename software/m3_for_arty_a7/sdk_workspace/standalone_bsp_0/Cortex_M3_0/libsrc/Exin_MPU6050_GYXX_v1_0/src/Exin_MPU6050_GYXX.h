
#ifndef EXIN_MPU6050_GYXX_H
#define EXIN_MPU6050_GYXX_H


/****************** Include Files ********************/
#include "xil_types.h"
#include "xstatus.h"

#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG0_OFFSET 0
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG1_OFFSET 4
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG2_OFFSET 8
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG3_OFFSET 12
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG4_OFFSET 16
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG5_OFFSET 20
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG6_OFFSET 24
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG7_OFFSET 28
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG8_OFFSET 32
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG9_OFFSET 36
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG10_OFFSET 40
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG11_OFFSET 44
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG12_OFFSET 48
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG13_OFFSET 52
#define EXIN_MPU6050_GYXX_S00_AXI_SLV_REG14_OFFSET 56

extern float ROLL;
extern float PITCH;
extern float YAW;
extern float Wx;
extern float Wy;
extern float Wz;
extern float Ax;
extern float Ay;
extern float Az;
extern unsigned char MPU_FLAG;

/**************************** Type Definitions *****************************/
/**
 *
 * Write a value to a EXIN_MPU6050_GYXX register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the EXIN_MPU6050_GYXXdevice.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void EXIN_MPU6050_GYXX_mWriteReg(u32 BaseAddress, unsigned RegOffset, u32 Data)
 *
 */
#define EXIN_MPU6050_GYXX_mWriteReg(BaseAddress, RegOffset, Data) \
  	Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))

/**
 *
 * Read a value from a EXIN_MPU6050_GYXX register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the EXIN_MPU6050_GYXX device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	u32 EXIN_MPU6050_GYXX_mReadReg(u32 BaseAddress, unsigned RegOffset)
 *
 */
#define EXIN_MPU6050_GYXX_mReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))

/************************** Function Prototypes ****************************/
/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the EXIN_MPU6050_GYXX instance to be worked on.
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
XStatus EXIN_MPU6050_GYXX_Reg_SelfTest(void * baseaddr_p);

void EXIN_MPU_Init();
void EXIN_MPU_Deal();

#endif // EXIN_MPU6050_GYXX_H
