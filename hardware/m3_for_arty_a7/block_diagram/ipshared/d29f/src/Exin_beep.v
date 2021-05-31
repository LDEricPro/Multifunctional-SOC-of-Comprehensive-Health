module           Exin_beep(
    output       beep_IO,
    output reg   busy,
    input [19:0] beep_time,//蜂鸣器使能时间
    input        start,//蜂鸣器触发使能
    input        EN,//蜂鸣器使能
    input        clk,//1Mhz时钟
    input        rst//复位
    );
    
    reg [19:0] cnt;//蜂鸣器计数
    assign beep_IO=~rst? EN:1;
    /*
    always @ (posedge clk  or posedge rst)
    begin
        if(rst)
        begin
            cnt<=20'd0;
        end
        else
        begin
            if(EN)
            begin
               if(cnt<beep_time)
               begin
                    cnt<=cnt+20'd1;
                    beep_IO<=1'b0;
               end
               else
               begin
                    cnt<=cnt;
                    beep_IO<=1'b1;
               end
            end
            else
            begin
                cnt<=cnt;
                beep_IO<= beep_IO;
            end
        end
    end*/
endmodule
