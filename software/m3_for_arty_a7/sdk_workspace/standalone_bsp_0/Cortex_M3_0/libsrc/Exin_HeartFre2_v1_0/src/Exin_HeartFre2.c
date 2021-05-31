

/***************************** Include Files *******************************/
#include "Exin_HeartFre2.h"
#include "xil_io.h"

/************************** Function Definitions ***************************/
int herat_num[num_length] = {0};
int mean_heart = 0;
int he_max = 0;
int he_min = 0;
unsigned int state_heb = 0;
int beattime = 0;
unsigned char succ_flag = 0;

float a = 0.6;//一介滞后系数
int pre_heartfre = 0;

void EXIN_HEART_Init()
{
	EXIN_HEARTFRE2_mWriteReg(XPAR_EXIN_HEARTFRE2_0_S0_AXI_BASEADDR, EXIN_HEARTFRE2_S0_AXI_SLV_REG1_OFFSET, 0x03);
	EXIN_HEARTFRE2_mWriteReg(XPAR_EXIN_HEARTFRE2_0_S0_AXI_BASEADDR, EXIN_HEARTFRE2_S0_AXI_SLV_REG1_OFFSET, 0x02);
}

int EXIN_HEART_Rcv()
{
	int beattime = 0;
	beattime = EXIN_HEARTFRE2_mReadReg(XPAR_EXIN_HEARTFRE2_0_S0_AXI_BASEADDR, EXIN_HEARTFRE2_S0_AXI_SLV_REG2_OFFSET)/1000;
	return (int)(60*1000.0/beattime);
}
	
void EXIN_heart_in(int din)
{
	int i = 0;
	for(i = num_length - 1; i > 0; i --)
	{
		herat_num[i]=herat_num[i-1];
	}
		
	herat_num[0]=din;
	he_max=0;
	he_min=255;
	
	for(i=0;i<num_length;i++)
	{
		if(he_max<herat_num[i])
		{
			he_max=herat_num[i];
		}
		
		if(he_min>herat_num[i])
		{
			he_min=herat_num[i];
		}
		
	}
	
	mean_heart=(he_max+he_min)/2;
	

}

int EXIN_HEART_Check()
{
	int state = EXIN_HEARTFRE2_mReadReg(XPAR_EXIN_HEARTFRE2_0_S0_AXI_BASEADDR, EXIN_HEARTFRE2_S0_AXI_SLV_REG3_OFFSET);
	
	if( state == 0x1 )
	{
		return HEART_STATE_NORMAL;
	}
	
	else
	{
		return HEART_STATE_ABNORMAL;
	}
}
		
		