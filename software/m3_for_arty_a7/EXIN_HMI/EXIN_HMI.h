#ifndef __EXIN_HMI__
#define __EXIN_HMI__


typedef struct
{
   unsigned char voice;//�������ر�־λ
   unsigned int  lignt_state;//��Ļ���ȳ̶�
   unsigned int  light;//��Ļ����
   unsigned int  ROLL_adj;//����ǵ��ڶ�
   unsigned int  YAW_adj;//ƫ���ǵ��ڶ�
   unsigned int  Pitch_adj  ;//�����ǵ��ڶ�
	 unsigned int  BLE_SW;

   unsigned int  PAGE4_init;
   unsigned int  PAGE9_init;//�ھ�ҳ��ʼ����־λ
   unsigned int  PAGE13_init;//��13ҳ��ʼ����־λ
	 unsigned int	 PAGE1_init;
	 unsigned int	 PAGE14_init; 
	 unsigned int	 PAGE7_init;	
} SHOW_ENUM;//��������ṹ��

extern SHOW_ENUM screen;//����ҳ������
extern int numget;
extern float HMI_num;                     //��Ż�ȡ���Լ����������������ֵ

extern int heartb;
extern int heartfre;

extern unsigned char ID_PAGE;             //��ŵ�ǰҳ
extern unsigned char pre_ID_PAGE;		//���ǰһ��ҳ��ID
extern int ID_BUTTON;                     //��Ű���ID
extern int ID_BUTTON_NUM;                 //��Ű�����ֵ
extern unsigned char rec_flag;
extern unsigned char indexI;

extern unsigned char BLE_FLAG;

void screen_init(SHOW_ENUM * screen);
void screen_PAGE_clr();
void instru_deal();

void EXIN_SleepCheck( void );
void EXIN_HMI_Handle( void );

#endif