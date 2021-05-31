#include "EXIN_HMI.h"
#include "xparameters.h"
#include "xil_io.h"
#include "uart.h"
#include "gpio.h"

#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_beep_v1_0\src\Exin_beep.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\breath_led_v1_0\src\breath_led.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_MPU6050_GYXX_v1_0\src\Exin_MPU6050_GYXX.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_Timer_v1_0\src\Exin_Timer.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_dht11_v1_0\src\Exin_dht11.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_StepCounter_debug_v1_0\src\Exin_StepCounter_debug.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_noliner2_v1_0\src\Exin_noliner2.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_ADC0832_v1_0\src\Exin_ADC0832.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_MAXMIN2_v1_0\src\Exin_MAXMIN2.h"
#include "V:\software\m3_for_arty_a7\sdk_workspace\standalone_bsp_0\Cortex_M3_0\libsrc\Exin_HeartFre2_v1_0\src\Exin_HeartFre2.h"


#include <string.h>


SHOW_ENUM screen;//保存页面设置

float HMI_num = 30;                     //存放获取来自计算器界面的输入数值

int i = 0;
int numget = 0;
unsigned char ID_PAGE = 0;             //存放当前页
unsigned char pre_ID_PAGE = 0;		//存放前一次页面ID
int ID_BUTTON = 0;                     //存放按键ID
int ID_BUTTON_NUM = 0;                 //存放按键键值
unsigned char rec_flag = 0;
unsigned char indexI = 0;

int heartb;
int heartfre;

//水平仪参数配置
float disx = 0;
//水平移滚动球
unsigned char PAGE4_init = 0;
float ball_x = 237;
float ball_y = 160;//小球xy坐标
float  pre_ballx = 0;
float   pre_bally = 0;
int ball_step = 1;//小球步长
int ball_cnt = 0;//小球坐标更新时间

float pre_Ay = 0;
int now_page = 0;

int sleep_time = 0;
unsigned char show_dim = 0;

float LED_num = 0;
int   LED_ID = 0;

unsigned char BLE_FLAG = 0;

void screen_init(SHOW_ENUM * screen)
{
	screen-> voice = 1;
	screen-> light = 100;
	screen-> ROLL_adj = 0;
	screen-> YAW_adj = 0;
	screen-> Pitch_adj = 0;
	screen-> lignt_state = 0;
	screen-> BLE_SW = 0;
	screen-> PAGE9_init = 0;
	screen-> PAGE13_init = 0;
	screen-> PAGE14_init = 0;
	screen-> PAGE7_init = 0;
}

void screen_PAGE_clr()
{
	screen.PAGE1_init = 0;
	screen.PAGE4_init = 0;
	screen.PAGE9_init = 0;
	screen.PAGE13_init = 0;
	screen.PAGE7_init = 0;

}


int POW_10(int din,int n)
{
	int temp=din;

	while(n--)
	{
		temp*=10;
	}
	return temp;
}

float DIV_10(int din,int n)
{
	float temp=din;

	while(n--)
	{
		temp/=10;
	}
	return temp;
}

void instru_deal()
{
	char txt[30] = {0};
	int i = 0;
	int inti = 0;
	int floati = 0;
	
	if( rec_flag )
	{
		numget = 0;
		rec_flag = 0;
		
//		UART_DEBUG_PutChar(0xFA);
//		UART_DEBUG_PutChar(UART_HMI_RCV[0]);
//		UART_DEBUG_PutChar(UART_HMI_RCV[1]);
//		UART_DEBUG_PutChar(UART_HMI_RCV[2]);
//		UART_DEBUG_PutChar(UART_HMI_RCV[3]);
//		UART_DEBUG_PutChar(UART_HMI_RCV[4]);
//		UART_DEBUG_PutChar(UART_HMI_RCV[5]);
//		UART_DEBUG_PutChar(UART_HMI_RCV[6]);
//		UART_DEBUG_PutChar(UART_HMI_RCV[7]);
//		UART_DEBUG_PutChar(0xFA);
		switch( UART_HMI_RCV[0] )
		{
			case 0x5a:
			{
				ID_PAGE = UART_HMI_RCV[1];
				{					
					unsigned char STRLEN = 0;
					sprintf( txt, "PAGE:%d\n", ID_PAGE );
					STRLEN = strlen( txt );
					UART_HMI_Send(txt, STRLEN);
				}
				
				break;
			}
			
			case 0x5b:
			{
				LED_ID = UART_HMI_RCV[1];
				LED_num = UART_HMI_RCV[4];
				{
					char txt[30] = {0};
					unsigned char STRLEN = 0;
					sprintf( txt, "LED_ID:%d LED_num:%d\n",LED_ID,(int)(LED_num) );
					STRLEN = strlen( txt );
					UART_HMI_Send(txt, STRLEN);
				}
				break;
			}
			
			case 0x65:
			{
				ID_PAGE = UART_HMI_RCV[1];
				ID_BUTTON = UART_HMI_RCV[2];
				{
					char txt[30] = {0};
					unsigned char STRLEN = 0;
					sprintf( txt, "PAGE:%d  BUTTON:%d\n", ID_PAGE, ID_BUTTON );
					STRLEN = strlen( txt );
					UART_HMI_Send(txt, STRLEN);
				}
				break;
			}
			
			case 0x70:
			{
				int tempi = 0;
				
				float tempnumget = 0;
				char UART_HMI_CAL_RCV[20];
				unsigned char STATE_HMI = 0;
				unsigned char counter = 0;
				
				HMI_num = 0;
				i = 0;
				
				while( UART_HMI_RCV[i] != 0xff )
				{
					switch( STATE_HMI )
					{
						case 0:
						{
							if( UART_HMI_RCV[i] == 0x70 )
							{
								STATE_HMI = 1;
								break;
							}
							STATE_HMI = 0;
							break;
						}
						
						case 1:
						{
							if( UART_HMI_RCV[i] == 0x20 )
							{
								STATE_HMI = 2;
								break;
							}
							STATE_HMI = 0;
							break;
						}
						
						case 2:
						{					
							UART_HMI_CAL_RCV[counter] = UART_HMI_RCV[i];
							
							if( UART_HMI_CAL_RCV[counter] == 0x2e )
							{
								inti = counter;
							}
							
							counter ++;

							break;
						}
					}
					
					i ++;
				}		
								
				if( inti == 0 )
				{
//					counter --;
					while( tempi < counter )
					{
						numget += POW_10( UART_HMI_CAL_RCV[tempi] - 0x30, counter - 1 - tempi);
						tempi ++;
					}
				
					HMI_num += numget;
					break;
				}
				
				counter --;
				
				floati = counter - inti;
				
				HMI_num = 0;
				tempi = 0;
				
				while( tempi < inti )
				{
					numget += POW_10( UART_HMI_CAL_RCV[tempi] - 0x30, inti - 1 - tempi);
					tempi ++;
				}
				
				HMI_num += numget;
				
				tempi = 1;
				
				
				while( tempi <= floati )
				{
					tempnumget += DIV_10( UART_HMI_CAL_RCV[tempi + inti] - 0x30, tempi);
					tempi ++;
				}
				HMI_num += tempnumget;

//				sprintf(txt, "%d FF %d FF %f", inti, numget, tempnumget);
//				UART_DEBUG_String( txt );
//				UART_DEBUG_PutChar(' ');
//				UART_DEBUG_PutChar('F');
//				UART_DEBUG_PutChar(' ');
//				UART_DEBUG_PutChar(UART_HMI_CAL_RCV[0]);
//				UART_DEBUG_PutChar(UART_HMI_CAL_RCV[1]);
//				UART_DEBUG_PutChar(UART_HMI_CAL_RCV[2]);
//				UART_DEBUG_PutChar(UART_HMI_CAL_RCV[3]);
//				UART_DEBUG_PutChar(UART_HMI_CAL_RCV[4]);
//				UART_DEBUG_PutChar(UART_HMI_CAL_RCV[5]);
//				UART_DEBUG_PutChar(UART_HMI_CAL_RCV[6]);
//				UART_DEBUG_PutChar(UART_HMI_CAL_RCV[7]);
//				UART_DEBUG_PutChar(0xFA);
		

//				{				
//					char txt[30] = {0};
//					UART_DEBUG_PutChar('A');
//					sprintf( txt, "%f",HMI_num);
//					UART_DEBUG_String( txt );
//				}

				
				break;
			}
		}
	}
}
				
void EXIN_SleepCheck( void )
{
	char txt[30] = {0};
	if( sleep_time >= 30000)
	{
		sprintf(txt, "dim=25");
		UART_HMI_instru_send(txt);
		
		if(sleep_time >= 31000)
		{
			sleep_time = 0;
			sprintf(txt, "sleep=1");
			UART_HMI_instru_send(txt);
		}
		
		else
		{
			sleep_time ++;
			EXIN_TIMER_Delayus(1000);
		}
	}
	
	else
	{
		sleep_time ++;
		EXIN_TIMER_Delayus(1000);
	}
}


void EXIN_HMI_Handle( void )
{
	char txt[30] = {0};
	pre_Ay = Ay;
	
	if( pre_ID_PAGE != ID_PAGE )
	{
		EXIN_BEEP(10000);
		
		sleep_time = 0;
		sprintf(txt, "dim = %d",screen.light);
		UART_HMI_instru_send(txt);
		
		if( ID_PAGE == 0 )
		{
			sprintf(txt, "t1.txt=\"2021\"");
			UART_HMI_instru_send(txt);

			sprintf(txt, "t2.txt=\"年\"");
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "t3.txt=\"5\"");
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "t4.txt=\"月\"");
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "t5.txt=\"20\"");
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "t6.txt=\"日\"");
			UART_HMI_instru_send(txt);
		}
		screen.PAGE1_init = 0;
		EXIN_GPIO_SetMode( MODE_EXIT );
		
		if( ID_PAGE != 10 && ID_PAGE != 11 && ID_PAGE != 12 )
		{
			move_step = 0;
		}
	}
	
	if( ID_PAGE == 0 )
	{
		int hour = EXIN_TIMER_Read(TIME_hour);
		int min = EXIN_TIMER_Read(TIME_min);
		int sec = EXIN_TIMER_Read(TIME_sec);
		

		screen_PAGE_clr();		
		
		sprintf(txt, "t0.txt=\"%d:%d:%d\"",hour,min,sec);
		UART_HMI_instru_send(txt);
		
		while( IO_PRINTER_FLAG )
		{
			
			sprintf(txt, "t0.txt=\"正在打印..\"");
			UART_HMI_instru_send(txt);		
		
			EXIN_IO_PRINTER_Print(1);
			EXIN_IO_PRINTER_Print(2);
			EXIN_IO_PRINTER_Print(3);
			EXIN_IO_PRINTER_Print(4);
			EXIN_IO_PRINTER_Print(5);
			EXIN_IO_PRINTER_Print(6);
			EXIN_IO_PRINTER_Print(7);
			EXIN_IO_PRINTER_Print(8);

			EXIN_TIMER_Delayus(500000);
			EXIN_TIMER_Delayus(500000);
		}

		EXIN_SleepCheck();
	}
	
	if( ID_PAGE == 1 )
	{
		if( screen.PAGE1_init == 0 )
		{
			screen.PAGE1_init = 1;
			sprintf(txt, "t0.txt=\" \"");
			UART_HMI_instru_send( txt );
		}

//		print( "PAGE1!\n" );
		if( ID_BUTTON == 14 )
		{
			ID_BUTTON = 0;
			UART_HMI_instru_send("get t0.txt");
			UART_HMI_instru_send("get t0.txt");
//			UART_DEBUG_String("get t0.txt");
			while( !rec_flag );
			instru_deal();


			EXIN_NOLINER_Calculate();
			HMI_num = 0;
		}
	}
	
	if( ID_PAGE == 2 )
	{
		int hour = EXIN_TIMER_Read(TIME_hour);
		int min = EXIN_TIMER_Read(TIME_min);
		int sec = EXIN_TIMER_Read(TIME_sec);
		int ms = EXIN_TIMER_Read(TIME_ms);
		
//		print( "PAGE2!\n" );
		sprintf(txt, "t0.txt=\"%d\"", hour);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t1.txt=\"%d\"", min);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t2.txt=\"%d\"", sec);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t3.txt=\"%d\"", ms % 100);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t4.txt=\"H\"");
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t5.txt=\"W\"");
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "z2.val=%d", 0 + sec * 6);
		UART_HMI_instru_send(txt);
	}
	
	if( ID_PAGE == 3 )
	{
//		print( "PAGE3!\n" );
		EXIN_MPU_Deal();
		sprintf(txt, "z0.val=%d", (int)PITCH);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "z1.val=%d", (int)ROLL);
		UART_HMI_instru_send(txt);
		
		if( PITCH > 180 )
		{
			PITCH = PITCH - 360;
		}
		
		if( ROLL > 180 )
		{
			ROLL = ROLL - 360;
		}
		
		sprintf(txt, "t3.txt=\"X:%.2f\"", PITCH);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t4.txt=\"Y:%.2f\"", ROLL);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t5.txt=\"Z:%.2f\"", YAW);
		UART_HMI_instru_send(txt);
	}
	
	if( ID_PAGE == 4 )
	{
		float PITCH_TEMP;
		float ROLL_TEMP;
		float ANGLE_TEMP;
		float QIN_TEMP;
		float ky = 0;
		float kx = 0;
		
//		print( "PAGE4!\n" );
		
		if( screen.PAGE4_init == 0 )
		{
			screen.PAGE4_init = 1;
			ball_x = 237;
			ball_y = 160;
		}
		
//		UART_HMI_instru_send(txt);
		EXIN_TIMER_Delayus(10000);
		EXIN_MPU_Deal();
		if( PITCH > 180 )
		{
			PITCH = PITCH - 360;
		}
		
		if( ROLL > 180 )
		{
			ROLL = ROLL - 360;
		}
		
		PITCH = -PITCH;
		ROLL = - ROLL;
		
		sprintf(txt, "t2.txt=\"%.2f\"", PITCH);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t3.txt=\"%.2f\"", ROLL);
		UART_HMI_instru_send(txt);
		
		PITCH_TEMP = PITCH > 0 ? PITCH / 180 : - PITCH / 180;
		ROLL_TEMP = ROLL > 0 ? ROLL / 180 : - ROLL / 180;
		ANGLE_TEMP = PITCH_TEMP + ROLL_TEMP;
		
		QIN_TEMP = EXIN_NOLINER_Cal(ANGLE_TEMP, EXP) - 1;
		sprintf(txt, "t0.txt=\"%.2f\"", QIN_TEMP);
		UART_HMI_instru_send(txt);
		
		ky = PITCH / 45;
		kx = ROLL / 45;
		
		if(ball_cnt >= 5)
		{
			ball_cnt = 0;
			
			if( ball_x < 110 )
			{
				ball_x = 110;
			}
			
			else if( ball_x > 365 )
			{
				ball_x = 365;
			}
			
			else
			{
				ball_y = ball_y + kx * ball_step;
			}
			
			if( ball_y < 30 )
			{
				ball_y = 30;
			}
			
			else if( ball_y > 290 )
			{
				ball_y = 290;
			}
			
			else
			{
				ball_x = ball_x + ky * ball_step * 1.45;
			}
			
			sprintf(txt, "cirs %d,%d,1,RED", (int)ball_x, (int)ball_y);
			UART_HMI_instru_send(txt);
		}
		
		else
		{
			ball_cnt ++;
		}
	}
	
	if( ID_PAGE == 5 )
	{
//		print( "PAGE5!\n" );
		BREATH_LED_Light((LED_num / 100) * 50000);
	}
	
	if( ID_PAGE == 6 )
	{
//		print( "PAGE6!\n" );
		sprintf(txt, "t0.txt=\"%d.%d\'C\"", DHT_TMPH, DHT_TMPL);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t1.txt=\"%d.%d\"", DHT_WETH, DHT_WETL);
		UART_HMI_instru_send(txt);
		
		EXIN_DHT_Init();
		EXIN_TIMER_Delayus(1500000);
		EXIN_TIMER_Delayus(1500000);
		EXIN_DHT_Read();
		
		sprintf(txt, "t0.txt=\"%d.%d\'C\"", DHT_TMPH, DHT_TMPL);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t1.txt=\"%d.%d\"", DHT_WETH, DHT_WETL);
		UART_HMI_DEBUGinstru_send(txt);
		
		sprintf(txt, "add 5,0,%d", DHT_TMPH);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "add 5,1,%d", DHT_WETH);
		UART_HMI_instru_send(txt);
	}
	
	if( ID_PAGE == 8 )
	{
//		print( "PAGE8!\n" );
		EXIN_MPU_Deal();
		EXIN_STEPCOUNTER_Get();
//		Az = Az - 9.8;
//		EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG4_OFFSET, 600);
//		EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG5_OFFSET, 500000);
//		EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG6_OFFSET, 3);
//		
//		EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG0_OFFSET, 1);
//		EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG1_OFFSET, Ax * 32768);
//		EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG2_OFFSET, Ay * 32768);
//		EXIN_STEPCOUNTER_DEBUG_mWriteReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG3_OFFSET, Az * 32768);
//		
//		step_counter = EXIN_STEPCOUNTER_DEBUG_mReadReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG7_OFFSET);
//		STEPCOUNTER_MIXVALUE = EXIN_STEPCOUNTER_DEBUG_mReadReg(XPAR_EXIN_STEPCOUNTER_DEB_0_S00_AXI_BASEADDR, EXIN_STEPCOUNTER_DEBUG_S00_AXI_SLV_REG8_OFFSET) / 32768.0;

		sprintf(txt, "t0.txt=\"%d\"", n_step);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t1.txt=\"%d\"", step_counter);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t2.txt=\"%.2f m/s\"", STEPCOUNTER_MIXVALUE);
		UART_HMI_instru_send(txt);
		
		if( step_counter >= n_step )
		{
			sprintf(txt, "pic 360,15,16");
			UART_HMI_instru_send(txt);
		}
		
		else
		{
			sprintf(txt, "pic 360,15,15");
			UART_HMI_instru_send(txt);
		}
	}
	
	if( ID_PAGE == 10 )
	{
//		print( "PAGE10!\n" );
		sprintf(txt, "t2.txt=\"%d\"", PULL_UP + JMP_UP);
		step_up = 5;
		step_time = 30;
		UART_HMI_instru_send(txt);
		move_time0 = EXIN_TIMER_GetTime(); 
	}
	
	if( ID_PAGE == 11 )
	{
		int now_time = step_time - (move_time1 - move_time0);
		
//		print( "PAGE11!\n" );
		move_time1 = EXIN_TIMER_GetTime();
		EXIN_MPU_Deal();
		sprintf(txt, "t4.txt=\"%d\"", now_time);
		UART_HMI_instru_send(txt);
		
		if( now_time == 0 )
		{
			if( PULL_UP >= step_up )
			{
				step_state ++;
				step_up += 3;
				step_time += 2;
				move_sum += PULL_UP;
				PULL_UP = 0;
			}
			
			else
			{
				step_up = step_up;
				step_time += 2;
			}
			
			sprintf(txt, "vis t6,1");
			EXIN_BEEP(1000000);
			UART_HMI_instru_send(txt);
			EXIN_TIMER_Delayus(30000000);
			EXIN_BEEP(1000000);
			move_time0 = EXIN_TIMER_GetTime();
		}
		
		else
		{
			sprintf(txt, "vis t6,0");
			UART_HMI_instru_send(txt);
			
			if( PITCH > 180 )
			{
				PITCH = PITCH - 360;
			}
			
			if( PITCH > 180 )
			{
				ROLL = ROLL - 360;
			}
			
			if( PITCH <= 0 && state == 1 )
			{
				state = 0;
			}
			
			if( PITCH >= 40 && state == 0 )
			{
				state = 1;
				PULL_UP ++;
				EXIN_BEEP(100000);
			}
			
			if( PULL_UP >= step_up )
			{
				sprintf(txt, "t5.pco=GREEN");
				UART_HMI_instru_send(txt);
			}
			
			else
			{
				sprintf(txt, "t5.pco=RED");
				UART_HMI_instru_send(txt);
			}
			
			sprintf(txt, "t5.txt=\"%d\"",PULL_UP);
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "t0.txt=\"%d\"", step_time);
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "t2.txt=\"%d\"", step_up);
			UART_HMI_instru_send(txt);
		}
	}
	
	if( ID_PAGE == 12 )
	{
		float nol_Az;
		int now_time;
		
//		print( "PAGE12!\n" );
		move_time1 = EXIN_TIMER_GetTime();
		EXIN_MPU_Deal();
		EXIN_NOLINER2_mWriteReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG0_OFFSET, (int)(((Az - 9.8) / 3) * 65536));
		nol_Az = ((float)EXIN_NOLINER2_mReadReg(XPAR_EXIN_NOLINER2_0_S0_AXI_BASEADDR, EXIN_NOLINER2_S0_AXI_SLV_REG9_OFFSET) / 65536);
		now_time = step_time - (move_time1 - move_time0);
		EXIN_MPU_Deal();
		sprintf(txt, "t4.txt=\"%d\"", now_time);
		UART_HMI_instru_send(txt);
		
		if( now_time == 0 )
		{
			if( JMP_UP >= step_up )
			{
				step_state ++;
				step_up += 3;
				step_time += 2;
				move_sum += JMP_UP;
				JMP_UP = 0;
			}
			
			else
			{
				step_up = step_up;
				step_time += 2;
			}
			
			sprintf(txt, "vis t6,1");
			EXIN_BEEP(1000000);
			UART_HMI_instru_send(txt);
			EXIN_TIMER_Delayus(30000000);
			EXIN_BEEP(1000000);
			
			move_time0 = EXIN_TIMER_GetTime();
		}
		
		else
		{
			sprintf(txt, "vis t6,0");
			UART_HMI_instru_send(txt);
			
			if( nol_Az > 2.5 && state1 == 0 )
			{
				JMP_UP ++;
				state1 = 1;
				EXIN_BEEP(100000);
			}
			
			if( nol_Az < 2.5 && state1 == 1 )
			{
				state1 = 0;
			}
			
			if( JMP_UP >= step_up )
			{
				sprintf(txt, "t5.pco=GREEN");
				UART_HMI_instru_send(txt);
			}
			
			sprintf(txt, "t5.txt=\"%d\"", JMP_UP);
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "t0.txt=\"%d\"", step_time);
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "t2.txt=\"%d\"", step_up);
			UART_HMI_instru_send(txt);
		}
	}
	
	if( ID_PAGE == 9 )
	{
		static unsigned char BLE_SW_FLAG = 0;
//		print( "PAGE9!\n" );
		if( screen.PAGE9_init == 0 )
		{
			screen.PAGE9_init = 1;
			sprintf(txt, "p1.pic=%d", screen.lignt_state + 22);
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "p3.pic=%d", 28 - screen.voice);
			UART_HMI_instru_send(txt);
		}
		
		if( BLE_SW_FLAG == 0 )
		{
			sprintf(txt, "b3.txt=\"OPEN\"");
			UART_HMI_instru_send(txt);
//			UART_HMI_DEBUGinstru_send(txt);
	}
		
		else if( BLE_SW_FLAG == 1 )
		{
			sprintf(txt, "b3.txt=\"CLOSE\"");
			UART_HMI_instru_send(txt);
//			UART_HMI_DEBUGinstru_send(txt);
	}

		if( ID_BUTTON == 5 )
		{
			ID_BUTTON = 0;
			
			if( screen.lignt_state == 4 )
			{
				screen.lignt_state = 0;
				sprintf(txt, "b0.txt=\"%d\%\"", screen.light);
				UART_HMI_instru_send(txt);
			}
			else
			{
				screen.lignt_state ++;
				sprintf(txt, "b0.txt=\"%d\%\"", screen.light);
				UART_HMI_instru_send(txt);
			}
			
			ID_BUTTON = 0;
			screen.light = 100 - 16 * screen.lignt_state;
			
			sprintf(txt, "p1.pic=%d", screen.lignt_state + 21);
			UART_HMI_instru_send(txt);
			

			
			sprintf(txt, "dim=%d", screen.light);
			UART_HMI_instru_send(txt);

			EXIN_TIMER_Delayus(50000);
			
		}
		
		if( ID_BUTTON == 9 )
		{
			ID_BUTTON = 0;
			
			if(screen.voice == 1)
			{
				screen.voice = 0;
				sprintf(txt, "b2.txt=\"CLOSED\"");
				UART_HMI_instru_send(txt);
			}
			
			else
			{
				screen.voice = 1;
				sprintf(txt, "b2.txt=\"OPEN\"");
				UART_HMI_instru_send(txt);
			}
			
			sprintf(txt, "p3.pic=%d", 28 - screen.voice);
			UART_HMI_instru_send(txt);
			
			

		}
		
		if( ID_BUTTON == 11 )
		{
			ID_BUTTON = 0;
			
//			if(screen.BLE_SW == 0)
//			{
//				screen.BLE_SW = 1;
//				sprintf(txt, "b3.txt=\"CLOSE\"");
//				UART_HMI_DEBUGinstru_send(txt);
//				
//				sprintf(txt, "p4.pic=29");
//				UART_HMI_instru_send(txt);
//			}
			
			if( BLE_SW_FLAG == 0 )
			{
				BLE_SW_FLAG = 1;

				
				BLE_FLAG = 0;
			}
			
			else
			{
				BLE_SW_FLAG = 0;
				
				BLE_FLAG = 1;
			}
		}	
		
	}
	
	if( ID_PAGE == 13 )
	{
//		print( "PAGE13!\n" );
		if( screen.PAGE13_init == 0 )
		{
			screen.PAGE13_init = 1;
			sprintf(txt, "vis t3,0");
			UART_HMI_instru_send(txt);
		}
		
		EXIN_MPU_Deal();
		
		sprintf(txt, "t1.txt=\"x:%.3f\"", PITCH);
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t2.txt=\"y:%.3f\"", ROLL);
		UART_HMI_instru_send(txt);
		
		
		if( ID_BUTTON == 6 )
		{
			sprintf(txt, "vis t3,0");
			UART_HMI_instru_send(txt);
			
			ID_BUTTON = 0;
			EXIN_TIMER_Delayus(5000000);
			
			screen.ROLL_adj = ROLL;
			screen.YAW_adj = YAW;
			screen.Pitch_adj = PITCH;
			
			sprintf(txt, "vis t3,1");
			UART_HMI_instru_send(txt);
		}
		
		
	}
	
	
	if( ID_PAGE == 7 )
	{
		int rate;
		int sum;
		int i;
		static unsigned char DISPLAY_FLAG = 0;
		
		if( screen.PAGE7_init == 0 )
		{
			screen.PAGE7_init ++;
			sprintf(txt, "t0.txt=\"MAXHR\"");
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "vis t11,0");
			UART_HMI_instru_send(txt);
			
			sprintf(txt, "vis t12,0");
			UART_HMI_instru_send(txt);
		}
			
//		print( "PAGE7!\n" );
		heartb = EXIN_ADC_RCV();
		
		sprintf(txt, "s0.dis=300");
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "add 3,0,%d", (int)heartb);
		UART_HMI_instru_send(txt);

		rate = (int)(60 * 1000.0 / beattime);
		heartb = (int)( a * rate + (1 - a) * pre_heartfre);
		sum = 0;
		i = 1000;
		
		while( i -- )
		{
			beattime = EXIN_HEARTFRE2_mReadReg(XPAR_EXIN_HEARTFRE2_0_S0_AXI_BASEADDR, EXIN_HEARTFRE2_S0_AXI_SLV_REG2_OFFSET)/1000;
			rate = (int)(60 * 1000.0 / beattime);
			heartfre = (int)( a * rate + (1 - a) * pre_heartfre);
			sum += heartfre;	
			
//			EXIN_TIMER_Delayus(5);
		}
		
		heartfre = sum / 1000;
		
		sprintf(txt, "t4.txt=\"%d\"", EXIN_MAXMIN_Get(EXIN_MAXMIN_MAX));
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t5.txt=\"%d\"", EXIN_MAXMIN_Get(EXIN_MAXMIN_MIN));
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t6.txt=\"%d\"", EXIN_MAXMIN_Get(EXIN_MAXMIN_THREAD));
		UART_HMI_instru_send(txt);
		
		sprintf(txt, "t9.txt=\"%d\"", beattime);
		UART_HMI_instru_send(txt);
		
		if(EXIN_HEART_Check() == HEART_STATE_NORMAL && DISPLAY_FLAG)
		{
			sprintf(txt, "t13.txt=\"心率正常\"");
			UART_HMI_instru_send(txt);
		}
		
		else if(EXIN_HEART_Check() != HEART_STATE_NORMAL && DISPLAY_FLAG)
		{
			sprintf(txt, "t13.txt=\"窦性心律不齐！建议调整作息！\"");
			UART_HMI_instru_send(txt);
		}
		
		else if( !DISPLAY_FLAG )
		{
			sprintf(txt, "t13.txt=\" \"");
			UART_HMI_instru_send(txt);
		}			
		
		
		if( EXIN_MAXMIN_Get(EXIN_MAXMIN_MAX) == 255 || EXIN_MAXMIN_Get(EXIN_MAXMIN_MIN) == 0 )
		{
			DISPLAY_FLAG = 0;
			sprintf(txt, "t10.txt=\"检测到手指未正确放置\"");
			UART_HMI_instru_send(txt);
		}
		
		else
		{
			DISPLAY_FLAG = 1;
			sprintf(txt, "t10.txt=\"检测到手指放置\"");
			UART_HMI_instru_send(txt);

		}
				
		if( rate < 120 )
		{
			sprintf(txt, "t7.txt=\"%d\"", heartfre);
			UART_HMI_instru_send(txt);
		}
		
		pre_heartfre = heartfre;
	}
	
	if( ID_PAGE == 14 )
	{
		
		
//		if( screen.PAGE14_init == 0 )
//		{
//			screen.PAGE14_init = 1;
//			sprintf(txt, "t1.txt=\"Normal\"");
//			UART_HMI_instru_send(txt);
			
//		}
		
		if( ID_BUTTON == 3 )
		{
			static unsigned char MODE_FLAG;
			ID_BUTTON = 0;
			EXIN_GPIO_SetMode( MODE_NORMAL );

			if( MODE_FLAG == 2 )
			{
				MODE_FLAG = 0;
				sprintf(txt, "t1.txt=\"Anti-Color\"");
				UART_HMI_instru_send(txt);
				UART_HMI_instru_send(txt);

				EXIN_GPIO_SetMode( MODE_ANTICOLOR );
			}
			
			else if( MODE_FLAG == 1 )
			{
				MODE_FLAG = 2;			
				sprintf(txt, "t1.txt=\"Scan\"");
				UART_HMI_instru_send(txt);
				UART_HMI_instru_send(txt);

				EXIN_GPIO_SetMode( MODE_BLACK_WHITE );
			}
			
			else if( MODE_FLAG == 0 )
			{
				MODE_FLAG = 1;
				sprintf(txt, "t1.txt=\"Normal\"");
				UART_HMI_instru_send(txt);
				UART_HMI_instru_send(txt);

				EXIN_GPIO_SetMode( MODE_NORMAL );
			}
			
			else
			{
				MODE_FLAG = 0;
			}
		}
		
		if( ID_BUTTON == 5 )
		{
			EXIN_GPIO_SetMode( MODE_TAKE_PICTURE );
		}
	}
				
//*/	
	pre_ID_PAGE = ID_PAGE;
}


					
				
