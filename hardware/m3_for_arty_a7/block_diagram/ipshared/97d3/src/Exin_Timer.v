module Exin_timer(
    input             clk,//����100Mhz
    input             rstcnt,//��λtimer�ڲ�������
    input             rstsys,//��λϵͳʱ��
    input             ENcnt,//����ʹ��
    input             ENsys,//ϵͳʱ��ʹ��
    input           INTEN ,//�ж�ʹ�� 
    input           INTRST, //�ж��źŸ�λ
    input [31:0]   CMP_REG,
    output reg [4:0] hour,//Сʱ��ʱ���
    output reg [5:0] min ,//�ּ�ʱ���
    output reg [5:0] sec ,//���ʱ���
    output reg [9:0] ms  ,//�������
    output reg [9:0] us  ,//us���
    output reg        ussignal,   
    output reg        mssignal, 
    output reg        secsignal, 
    output reg        minsignal, 
    output reg        hoursignal, 
    output            interrupt//�ж��ź����(��ʱ����ź�)
    );
    
    parameter n = 100;//����1Mhz ��1us
    
    reg [31:0] Timer_cnt  ;    //us������
    reg [6:0]  sysreg;
    reg        count_cmp_flag; //�ﵽ�Ƚ�����ֵ��־λ
    
    //�ж�ϵͳ
    assign interrupt = INTEN & count_cmp_flag;
    always @ (posedge clk or posedge rstcnt)
    begin
        if(rstcnt)
             Timer_cnt <= 0;
        else
            if(ENcnt)
                Timer_cnt <= Timer_cnt + 31'd1;//ʹ�ܼ���
            else
                 Timer_cnt <= Timer_cnt;    //ʧ�ܼ���
    end
    
    always @ (posedge clk or posedge  INTRST)
    begin
        if(INTRST)
            count_cmp_flag<=1'b0;
        else
        begin
            if(Timer_cnt == CMP_REG)//�Ƚ������
                count_cmp_flag<=1'b1;
            else
                count_cmp_flag<=count_cmp_flag;
        end
    end
    
    //ϵͳʱ��
    always @ (posedge clk or posedge rstsys)
    begin
        if(rstsys)
        begin
             hour<=5'd0;
             min<= 6'd0;
             sec<= 6'd0;
             ms <= 10'd0;
             us <= 10'd0;
             sysreg<=8'd0;
             ussignal<=0;
             mssignal<=0;
             secsignal<=0;
             minsignal<=0;
             hoursignal<=0;
        end
        else
        begin
                if(ENsys)
                begin
                if(sysreg == n-1)
                begin
                    sysreg <= 8'd0;
                    if(us == 10'd999)//us��λ
                    begin
                        ussignal<=1;
                        us<=10'd0;
                        if(ms == 10'd999)//ms��λ
                        begin
                            mssignal<=1;
                            ms<=10'd0;
                            if(sec == 10'd59)
                            begin
                                secsignal<=1;
                                sec <= 10'd0;
                                if(min == 6'd59)
                                begin
                                    min<=6'd0;
                                     minsignal<=1;
                                    if(hour == 24'd23)
                                      begin  hour<=5'd0;hoursignal<=1; end
                                    else
                                      begin  hour<=hour+5'd1;hoursignal<=1; end
                                end
                                else
                                  begin  min<=min+6'd1; minsignal<=0;end
                            end
                            else
                               begin sec<=sec+6'd1;secsignal<=0; end
                        end
                        else
                           begin ms<=ms+10'd1;mssignal<=0;  end
                    end
                    else
                      begin  us<=us+10'd1;ussignal<=0; end
                    end
                   else
                    sysreg<=sysreg+7'd1;
                end
                else
                    begin
                       hour<= hour;  
                       min<=  min;    
                       sec<=  sec;    
                       ms <=  ms ;    
                       us <=  us ;    
                       sysreg<=sysreg;
                    end
           end
    end
endmodule
