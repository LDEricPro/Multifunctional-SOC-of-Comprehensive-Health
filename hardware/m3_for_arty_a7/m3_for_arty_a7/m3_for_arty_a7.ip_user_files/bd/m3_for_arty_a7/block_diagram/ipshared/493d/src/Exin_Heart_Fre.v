module                Exin_Heart_Fre(
    input [7:0]       SCH_thread0,//������ֵ
    input [7:0]              data,//�ɼ�ֵ����
    input                     rst,
    input                      EN,
    input                     clk,//����ͬ��ʱ�� 1Mhz
    output reg          interrupt,
    output reg [31:0]    Heart_Fre,  //����
    output reg [3:0]        rseult      //���ʲ������ж�
    );
    
    parameter wia=2;
    parameter wib=3;
    wire [7:0] SCH_thread1;
    wire [7:0] din;
    
    assign SCH_thread1=(SCH_thread0<<1)/3;
    assign din = data-100;
    
    reg [1:0] state;
    
    reg [31:0] cnt;//��ʱ�������Ĵ���
    
    always @ (posedge clk or posedge rst)
    begin
        if(rst)
        begin
            state<=2'd0;
             Heart_Fre<=32'd0;
             cnt<=32'd0;
             interrupt<=1'b0;
        end
        else
        begin
            if(EN)
            begin
                case(state)
                    2'd0:begin 
                                if(din>=SCH_thread0)
                                begin
                                     state<=state+2'd1;cnt<=32'd0; interrupt<=1'b0;//���ڿ�ʼ��ʱ
                                end
                         end
                     2'd1:begin 
                                cnt<=cnt+32'd1;//��ʱ����
                                interrupt<=1'b0;
                                if(din<=SCH_thread1)
                                     state<=state+2'd1;//���ڿ�ʼ��ʱ
                         end
                      2'd2:begin
                                if(din>=SCH_thread0)
                                begin
                                     state<=state+2'd1;//���ڿ�ʼ��ʱ
                                     Heart_Fre<=cnt;
                                      interrupt<=1'b1;
                                end
                                else
                                     cnt<=cnt+32'd1;//��ʱ����
                            end
                      2'd3:begin
                                 interrupt<=1'b0;
                                if(din<=SCH_thread1)
                                    state<=2'd0;
                                else
                                    state<=state;
                            end
                       default:begin  state<=2'd0;Heart_Fre<=32'd0;cnt<=32'd0; interrupt<=1'b0;end
                endcase    
            end
            else
            begin
                Heart_Fre<=Heart_Fre;
                state<=state;
                cnt<=cnt;
            end
        end
    end
    
    
    
    
    //���������ж�
    always@(negedge interrupt or posedge rst)
    begin
        if(rst)
        begin
            rseult<=4'd0;
        end
        else
        begin
            if(Heart_Fre>32'd500000)//�Ķ����� 120/s
            begin
                rseult<=4'd1;
            end
            else if(Heart_Fre>32'd1500_0000 && Heart_Fre<32'd4000_000)//����Ķ����� 60/s~40/s
            begin
                 rseult<=4'd2;
            end
            else if(Heart_Fre<32'd1500_0000)//���Ҵ�������  <40/s
            begin
                rseult<=4'd4;
            end
            else
                rseult<=4'd0;
        end
    end
endmodule
