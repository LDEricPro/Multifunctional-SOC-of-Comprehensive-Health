/*������������������������������������
    clk���ʱ��
    worregѡ����ĸ
    1:C
    2:O
    3:R
    4:T
    5:E
    6:X
    7:M
    8:3
    9:-
    ÿ�η������֮��finishflag����
    ��ѯ�˱�־λ��wordregд�������֣�������rst�󣬿�ʼ��ӡ�ڶ����ַ�
*/

module     Exin_IO_printer(
    input                clk,//ʱ��
    input                rst,//��λ��
    input                EN ,//��ӡʹ��
    input   [15:0]    wordreg,//��ǰ��ӡ�ַ��Ĵ���      
    output   reg  finishflag,//���ִ�ӡ�����ź�
    output reg [7:0]      IO//��ĸ��ӡIO��
    );
    
    reg [7:0] state;
    parameter n = 2;//2��Ƶ
    reg [31:0] cnt;//��Ƶ������ 
    reg printclk;//��ӡʱ���ɷ�Ƶ���õ�
    
    always@(posedge printclk or posedge rst)//��ĸ��ӡC
    begin
        if(rst)//��λ
        begin
            IO<=8'd0;//��ӡIO�ڸ�λ
            state<=8'd0;//״̬����λ
            finishflag<=1'b0;//�����źŸ�λ
        end
        else  begin
            if(EN)//����ӡʹ��λ
            begin 
                if(~finishflag)//����Ƿ����һ�ִ�ӡ
                begin
                    if(wordreg == 16'd1)//��ӡ��ĸC
                    begin
                        case(state)
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//��ӡһ���ո�
                        8'd1:begin  IO<=8'b01111110;state<=state+8'd1;end
                        8'd2:begin  IO<=8'b1000_0001;state<=state+8'd1;end
                        8'd3:begin  IO<=8'b1000_0001;state<=state+8'd1;end
                        8'd4:begin  IO<=8'b1000_0001;state<=state+8'd1;end
                        8'd5:begin  IO<=8'b0100_0010;state<=state+8'd1;end
                        8'd6:begin  IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b1;end
                        default:begin IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b0;end
                        endcase
                    end
                    else if(wordreg == 16'd2)//O
                    begin
                        case(state)
                         8'd0:begin  IO<=8'd0; state<=state+8'd1; end//��ӡһ���ո�
                        8'd1:begin  IO<=8'b01111110;state<=state+8'd1;end
                        8'd2:begin  IO<=8'b1000_0001;state<=state+8'd1;end
                        8'd3:begin  IO<=8'b1000_0001;state<=state+8'd1;end
                        8'd4:begin  IO<=8'b1000_0001;state<=state+8'd1;end
                        8'd5:begin  IO<=8'b01111110;state<=state+8'd1;end
                        8'd6:begin  IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b1;end
                        default:begin IO<=8'b00000000;state<=8'd0;finishflag<=1'b0;end
                        endcase
                    end
                    else if(wordreg == 16'd3)//R
                    begin
                        case(state)
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//��ӡһ���ո�
                        8'd1:begin  IO<=8'b01111111;state<=state+8'd1;end
                        8'd2:begin  IO<=8'b1001_0000;state<=state+8'd1;end
                        8'd3:begin  IO<=8'b1001_1000;state<=state+8'd1;end
                        8'd4:begin  IO<=8'b1001_0100;state<=state+8'd1;end
                        8'd5:begin  IO<=8'b01100011;state<=state+8'd1;end
                        8'd6:begin  IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b1;end
                        default:begin IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b0;end
                        endcase
                    end
                    else if(wordreg == 16'd4)//T
                    begin
                        case(state)
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//��ӡһ���ո�
                        8'd1:begin  IO<=8'b1000_0000;state<=state+8'd1;end
                        8'd2:begin  IO<=8'b1000_0000;state<=state+8'd1;end
                        8'd3:begin  IO<=8'b1111_1111;state<=state+8'd1;end
                        8'd4:begin  IO<=8'b1000_0000;state<=state+8'd1;end
                        8'd5:begin  IO<=8'b1000_0000;state<=state+8'd1;end
                        8'd6:begin  IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b1;end
                        default:begin IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b0;end
                        endcase
                    end
                    else if(wordreg == 16'd5)//E
                    begin
                        case(state)
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//��ӡһ���ո�
                        8'd1:begin  IO<=8'b1111_1111;state<=state+8'd1;end
                        8'd2:begin  IO<=8'b1000_1001;state<=state+8'd1;end
                        8'd3:begin  IO<=8'b1000_1001;state<=state+8'd1;end
                        8'd4:begin  IO<=8'b1000_1001;state<=state+8'd1;end
                        8'd5:begin  IO<=8'b1000_1001;state<=state+8'd1;end
                        8'd6:begin  IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b1;end
                        default:begin IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b0;end
                        endcase
                    end
                    else if(wordreg == 16'd6)//X
                    begin
                        case(state)
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//��ӡһ���ո�
                        8'd1:begin  IO<=8'b1000_0001;state<=state+8'd1;end
                        8'd2:begin  IO<=8'b0110_0110;state<=state+8'd1;end
                        8'd3:begin  IO<=8'b0001_1000;state<=state+8'd1;end
                        8'd4:begin  IO<=8'b0110_0110;state<=state+8'd1;end
                        8'd5:begin  IO<=8'b1000_0001;state<=state+8'd1;end
                        8'd6:begin  IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b1;end
                        default:begin IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b0;end
                        endcase
                    end
                    else if(wordreg == 16'd7)//M
                    begin
                        case(state)
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//��ӡһ���ո�                 
                        8'd1:begin  IO<=8'b1111_1111;state<=state+8'd1;end                   
                        8'd2:begin  IO<=8'b1000_0000;state<=state+8'd1;end                   
                        8'd3:begin  IO<=8'b0100_0000;state<=state+8'd1;end                   
                        8'd4:begin  IO<=8'b0010_0000;state<=state+8'd1;end                   
                        8'd5:begin  IO<=8'b0100_0000;state<=state+8'd1;end                   
                        8'd6:begin  IO<=8'b1000_0000;state<=state+8'd1;end                   
                        8'd7:begin  IO<=8'b1111_1111;state<=state+8'd1;end
                        8'd8:begin  IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b1;end     
                        default:begin IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b0;end
                        endcase
                    end
                    else if(wordreg == 16'd8)//3
                    begin
                        case(state)
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//��ӡһ���ո�                        
                        8'd1:begin  IO<=8'b1001_0001;state<=state+8'd1;end                          
                        8'd2:begin  IO<=8'b1001_0001;state<=state+8'd1;end                          
                        8'd3:begin  IO<=8'b1001_0001;state<=state+8'd1;end                          
                        8'd4:begin  IO<=8'b1001_0001;state<=state+8'd1;end                          
                        8'd5:begin  IO<=8'b0111_1110;state<=state+8'd1;end
                        8'd6:begin  IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b1;end
                        default:begin IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b0;end
                        endcase
                    end
                    else if(wordreg == 16'd9)//-----
                    begin
                        case(state)
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//��ӡһ���ո�                        
                        8'd1:begin  IO<=8'b0001_0000;state<=state+8'd1;end                          
                        8'd2:begin  IO<=8'b0001_0000;state<=state+8'd1;end                          
                        8'd3:begin  IO<=8'b0001_0000;state<=state+8'd1;end                          
                        8'd4:begin  IO<=8'b0001_0000;state<=state+8'd1;end                          
                        8'd5:begin  IO<=8'b0001_0000;state<=state+8'd1;end
                        8'd6:begin  IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b1;end
                        default:begin IO<=8'b0000_0000;state<=8'd0;finishflag<=1'b0;end
                        endcase
                    end
                    else
                    begin
                        IO<=8'd0;//��ӡIO�ڸ�λ
                        state<=8'd0;//״̬����λ
                    end
                end
                else
                begin
                     IO<=8'd0;//��ӡIO�ڸ�λ
                     state<=8'd0;//״̬����λ
                end
            end
            else
            begin
                IO<=IO;//��ӡIO�ڸ�λ
                state<=state;//״̬����λ
                finishflag<=finishflag;//�����źŸ�λ
            end  
        end
    end
    
    always @(posedge clk or posedge rst)//��Ƶ��ģ��
    begin
        if(rst)
        begin
            cnt<=16'b0;
        end
        else
        begin
            if(cnt==n)
                cnt<=16'd0;
            else
                cnt<=cnt+16'b1;
        end
    end
    
    always @(posedge clk or posedge rst)
    begin
        if(rst)
            printclk<=1'b0;
        else
        begin
            if(cnt<=n/2-1)
                printclk<=1'b0;
            else
                 printclk<=1'b1;
        end
    end
    
endmodule
