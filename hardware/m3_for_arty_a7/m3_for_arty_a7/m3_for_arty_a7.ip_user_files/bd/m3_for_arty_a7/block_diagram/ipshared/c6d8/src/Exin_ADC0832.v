module               Exin_ADC0832(
    output   reg     clk_0832,//��ƽ���ʱ��
    input                 clk,//ϵͳclk����״̬����
    input                 rst,//0832��λ
    input                  D0832,//0832�������
    output   reg           DI,//0832��������
    output   reg           cs,//0832Ƭѡ
    output   reg       finish,//һ�ֲɼ���������ź�
    output   reg [7:0] OUT0832//0832�ɼ�ֵ���
    );
    
    reg [4:0]state;
    reg [7:0]data;
    always @ (posedge clk or posedge rst)
    begin
        if(rst)
            begin
                 OUT0832<=8'd0;
                 data<=8'd0;
                 state<=5'd0;
                 cs<=1'b1;
            end
         else
         begin
            case(state)
            5'd0:begin cs<=1'b0;DI<=1'b1;clk_0832<=1'b1;state<=state+5'd1;data<=8'd0;finish<=1'b0; end//ѡ��0832оƬ DI���� 0832clk������
            5'd1:begin clk_0832<=1'b0;state<=state+5'd1;end//��һ��clk DI��λ
            5'd2:begin DI<=1'b1;clk_0832<=1'b1;state<=state+5'd1;  end 
            5'd3:begin clk_0832<=1'b0;state<=state+5'd1;  end //�ڶ���clkд��DI ˫ͨ��������
            5'd4:begin DI<=1'b1;clk_0832<=1'b1;state<=state+5'd1;  end 
            5'd5:begin clk_0832<=1'b0;state<=state+5'd1;  end //������clkд��DI ѡ��CH2
            
            5'd6:begin state<=state+5'd1; end//�ղ���
            
            5'd7:begin state<=state+5'd1;clk_0832<=1'b1; end//����clk
            5'd8:begin state<=state+5'd1;clk_0832<=1'b0; end//����clk
            
            5'd9:begin state<=state+5'd1;clk_0832<=1'b1; end//����clk
            5'd10:begin state<=state+5'd1;clk_0832<=1'b0; end//����clk
            
            5'd11:begin data<=data<<1|D0832; clk_0832<=1'b1;state<=state+5'd1; end//�ɼ�data��һλ ����clk
            
            5'd12:begin state<=state+5'd1;clk_0832<=1'b0; end//����clk
            5'd13:begin data<=data<<1|D0832; clk_0832<=1'b1;state<=state+5'd1; end//�ɼ�data�ڶ�λ ����clk
            
            5'd14:begin state<=state+5'd1;clk_0832<=1'b0; end//����clk
            5'd15:begin data<=data<<1|D0832; clk_0832<=1'b1;state<=state+5'd1; end//�ɼ�data����λ ����clk
            
            5'd16:begin state<=state+5'd1;clk_0832<=1'b0; end//����clk          
            5'd17:begin data<=data<<1|D0832; clk_0832<=1'b1;state<=state+5'd1; end//�ɼ�data����λ ����clk
            
            5'd18:begin state<=state+5'd1;clk_0832<=1'b0; end//����clk          
            5'd19:begin data<=data<<1|D0832; clk_0832<=1'b1;state<=state+5'd1; end//�ɼ�data����λ ����clk
            
            5'd20:begin state<=state+5'd1;clk_0832<=1'b0; end//����clk          
            5'd21:begin data<=data<<1|D0832; clk_0832<=1'b1;state<=state+5'd1; end//�ɼ�data����λ ����clk
            
            5'd22:begin state<=state+5'd1;clk_0832<=1'b0; end//����clk          
            5'd23:begin data<=data<<1|D0832; clk_0832<=1'b1;state<=state+5'd1; end//�ɼ�data����λ ����clk
            
            5'd24:begin state<=state+5'd1;clk_0832<=1'b0; end//����clk          
            5'd25:begin data<=data<<1|D0832; clk_0832<=1'b1;state<=state+5'd1; end//�ɼ�data�ڰ�λ ����clk
            
            5'd26:begin  finish<=1'b1;state<=5'd0; OUT0832<= data;cs<=1'b1; end//����һ������
            default:begin  finish<=1'b1;state<=5'd0; OUT0832<= 5'd0;data<=5'd0;  cs<=1'b1; end
            endcase
         end
    end
endmodule
