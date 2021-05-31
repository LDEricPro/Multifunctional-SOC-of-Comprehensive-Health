
#ifndef EXIN_STEPCOUNTER_DEBUG_H
#define EXIN_STEPCOUNTER_DEBUG_H


/****************** Include Files ********************/
#include "xil_types.h"
#include "xstatus.h"

#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG0_OFFSET 0
#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG1_OFFSET 4
#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG2_OFFSET 8
#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG3_OFFSET 12
#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG4_OFFSET 16
#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG5_OFFSET 20
#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG6_OFFSET 24
#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG7_OFFSET 28
#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG8_OFFSET 32
#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG9_OFFSET 36
#define EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG10_OFFSET 40

extern int n_step;
extern int step_counter;
extern double STEPCOUNTER_MIXVALUE;

extern int PULL_UP;
extern int JMP_UP;
extern unsigned int state;//״̬����
extern unsigned int state1;//״̬����
extern unsigned int move_step;//�˶�ģʽ��һ�׶�
extern int move_time0;//�˶�ʱ���¼��ǰ�˶���ʼʱ��
extern int move_time1;//�˶�ʱ���¼��ǰ�˶�����ʱ��
extern int step_time;//�˶��ִ�ת��ʱ��
extern int step_state;//��¼��ǰ�˶��׶�
extern int step_up;//ÿ���˶�������/��ʼ�˶���
extern int move_sum;//�˶�����


/**************************** Type Definitions *****************************/
/**
 *
 * Write a value to a EXIN_STEPCOUNTER_DEBUG register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the EXIN_STEPCOUNTER_DEBUGdevice.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void EXIN_STEPCOUNTER_DEBUG_mWriteReg(u32 BaseAddress, unsigned RegOffset, u32 Data)
 *
 */
#define EXIN_STEPCOUNTER_DEBUG_mWriteReg(BaseAddress, RegOffset, Data) \
  	Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))

/**
 *
 * Read a value from a EXIN_STEPCOUNTER_DEBUG register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the EXIN_STEPCOUNTER_DEBUG device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	u32 EXIN_STEPCOUNTER_DEBUG_mReadReg(u32 BaseAddress, unsigned RegOffset)
 *
 */
#define EXIN_STEPCOUNTER_DEBUG_mReadReg(BaseAddress, RegOffset) \
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
 * @param   baseaddr_p is the base address of the EXIN_STEPCOUNTER_DEBUG instance to be worked on.
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
XStatus EXIN_STEPCOUNTER_DEBUG_Reg_SelfTest(void * baseaddr_p);

void EXIN_STEPCOUNTER_Get();

#endif // EXIN_STEPCOUNTER_DEBUG_H
