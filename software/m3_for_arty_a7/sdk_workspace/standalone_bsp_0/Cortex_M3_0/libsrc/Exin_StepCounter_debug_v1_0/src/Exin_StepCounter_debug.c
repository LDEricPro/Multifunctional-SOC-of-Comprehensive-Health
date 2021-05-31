

/***************************** Include Files *******************************/
#include "Exin_StepCounter_debug.h"
#include "xil_io.h"

#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_MPU6050_GYXX_v1_0\src\Exin_MPU6050_GYXX.h"

/************************** Function Definitions ***************************/

int n_step = 100;
int step_counter = 0;
double STEPCOUNTER_MIXVALUE = 0;

int PULL_UP = 0;
int JMP_UP = 0;
unsigned int state = 0;//״̬����
unsigned int state1 = 0;//״̬����
unsigned int move_step = 0;//�˶�ģʽ��һ�׶�
int move_time0 = 0;//�˶�ʱ���¼��ǰ�˶���ʼʱ��
int move_time1 = 0;//�˶�ʱ���¼��ǰ�˶�����ʱ��
int step_time = 30;//�˶��ִ�ת��ʱ��
int step_state = 0;//��¼��ǰ�˶��׶�
int step_up = 5;//ÿ���˶�������/��ʼ�˶���
int move_sum = 0;//�˶�����

void EXIN_STEPCOUNTER_Get()
{
	Az = Az - 9.8;
	EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG4_OFFSET, 600);
	EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG5_OFFSET, 500000);
	EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG6_OFFSET, 3);
	
	EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG0_OFFSET, 1);
	EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG1_OFFSET, Ax * 32768);
	EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG2_OFFSET, Ay * 32768);
	EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG3_OFFSET, Az * 32768);
	
	step_counter = EXIN_STEPCOUNTER_DEBUG_mReadReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG7_OFFSET);
	STEPCOUNTER_MIXVALUE = EXIN_STEPCOUNTER_DEBUG_mReadReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG8_OFFSET) / 32768.0;
}
