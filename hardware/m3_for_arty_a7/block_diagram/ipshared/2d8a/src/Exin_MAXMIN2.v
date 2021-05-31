//Ѱ������˼�ֵ
module              Exin_MAXMIN2(
   input [7:0]      data,
   input            clk,
   input            rst,//��λ��
   output reg [7:0] max,
   output reg [7:0] min,
   output reg [7:0] Thread0 
    );
    wire [7:0] din;
    assign din = data - 8'd100;
    reg [23:0] cnt;//���Է�Ƶ
    reg [7:0] max0,min0;//��ʱ�洢��ֵ
    
    always @ (posedge clk or posedge rst)
    begin
        if(rst)
        begin
            max<=8'd0;
            min<=8'd255;
            max0<=8'd0;
            min0<=8'd255;
            cnt<=24'd0;
        end
        else
        begin
                if(cnt != 24'd3000_000)
                begin
                    cnt <= cnt+24'd1;
                    if(max0 < din)
                        max0 <= din;
                    else
                        max0 <= max0;
                    if(min0 > din)
                        min0 <= din;
                    else
                        min0 <= min0;
                end
                else//���������һ�β���ֵ
                begin
                    cnt  <= 24'd0;
                    max0 <= 8'd0;
                    min0 <= 8'd255;
                    max  <= max0;
                    min  <= min0;
                    Thread0<=(max0+min)/2;
                end
           end
    end
endmodule
