module breath_led_AXI4_IP(
    input clk,
    input [23:0]reg_cn,
    output reg led
    );
    
    parameter period=50_000_000/1000;//得到1khz
    reg [23:0]cnt_count;
    
always @ (posedge clk )    
begin
    if (cnt_count==period)
        cnt_count<=24'd0;//达到计数值，计数器清零
    else    
        cnt_count<= cnt_count+1;
end

always @ (posedge clk )    
begin
    if(cnt_count<reg_cn)
        led<=1'b1;
    else
        led<=1'b0;
end
endmodule
