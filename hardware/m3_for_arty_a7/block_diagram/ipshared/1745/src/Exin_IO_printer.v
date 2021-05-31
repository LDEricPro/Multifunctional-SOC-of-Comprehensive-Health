/*——————————————————
    clk外接时钟
    worreg选择字母
    1:C
    2:O
    3:R
    4:T
    5:E
    6:X
    7:M
    8:3
    9:-
    每次发送完成之后，finishflag拉高
    查询此标志位后，wordreg写入新数字，再启动rst后，开始打印第二个字符
*/

module     Exin_IO_printer(
    input                clk,//时钟
    input                rst,//复位端
    input                EN ,//打印使能
    input   [15:0]    wordreg,//当前打印字符寄存器      
    output   reg  finishflag,//单轮打印结束信号
    output reg [7:0]      IO//字母打印IO口
    );
    
    reg [7:0] state;
    parameter n = 2;//2分频
    reg [31:0] cnt;//分频计数器 
    reg printclk;//打印时钟由分频器得到
    
    always@(posedge printclk or posedge rst)//字母打印C
    begin
        if(rst)//复位
        begin
            IO<=8'd0;//打印IO口复位
            state<=8'd0;//状态机复位
            finishflag<=1'b0;//结束信号复位
        end
        else  begin
            if(EN)//检查打印使能位
            begin 
                if(~finishflag)//检查是否完成一轮打印
                begin
                    if(wordreg == 16'd1)//打印字母C
                    begin
                        case(state)
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//打印一个空格
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
                         8'd0:begin  IO<=8'd0; state<=state+8'd1; end//打印一个空格
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
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//打印一个空格
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
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//打印一个空格
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
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//打印一个空格
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
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//打印一个空格
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
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//打印一个空格                 
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
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//打印一个空格                        
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
                        8'd0:begin  IO<=8'd0; state<=state+8'd1; end//打印一个空格                        
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
                        IO<=8'd0;//打印IO口复位
                        state<=8'd0;//状态机复位
                    end
                end
                else
                begin
                     IO<=8'd0;//打印IO口复位
                     state<=8'd0;//状态机复位
                end
            end
            else
            begin
                IO<=IO;//打印IO口复位
                state<=state;//状态机复位
                finishflag<=finishflag;//结束信号复位
            end  
        end
    end
    
    always @(posedge clk or posedge rst)//分频器模块
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
