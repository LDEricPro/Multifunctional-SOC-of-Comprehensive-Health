#ifndef __EXIN_HMI__
#define __EXIN_HMI__


typedef struct
{
   unsigned char voice;//声音开关标志位
   unsigned int  lignt_state;//屏幕亮度程度
   unsigned int  light;//屏幕亮度
   unsigned int  ROLL_adj;//横滚角调节度
   unsigned int  YAW_adj;//偏航角调节度
   unsigned int  Pitch_adj  ;//俯仰角调节度
	 unsigned int  BLE_SW;

   unsigned int  PAGE4_init;
   unsigned int  PAGE9_init;//第九页初始化标志位
   unsigned int  PAGE13_init;//第13页初始化标志位
	 unsigned int	 PAGE1_init;
	 unsigned int	 PAGE14_init; 
	 unsigned int	 PAGE7_init;	
} SHOW_ENUM;//交互界面结构体

extern SHOW_ENUM screen;//保存页面设置
extern int numget;
extern float HMI_num;                     //存放获取来自计算器界面的输入数值

extern int heartb;
extern int heartfre;

extern unsigned char ID_PAGE;             //存放当前页
extern unsigned char pre_ID_PAGE;		//存放前一次页面ID
extern int ID_BUTTON;                     //存放按键ID
extern int ID_BUTTON_NUM;                 //存放按键键值
extern unsigned char rec_flag;
extern unsigned char indexI;

extern unsigned char BLE_FLAG;

void screen_init(SHOW_ENUM * screen);
void screen_PAGE_clr();
void instru_deal();

void EXIN_SleepCheck( void );
void EXIN_HMI_Handle( void );

#endif