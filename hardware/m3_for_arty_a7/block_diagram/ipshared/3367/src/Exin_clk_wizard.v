
module         Exin_clk_wizard#(parameter n = 100)(
    input      clk,
    input      rst,
    output reg q
    );
    
    reg [15:0] cnt;
    
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
           cnt<=16'd0;
        end
        else
        begin
            if(cnt==n-1)
                cnt<=16'd0;
            else
                cnt<=cnt+16'd1;
        end
    end
    
    always @ (posedge clk or posedge rst)
    begin
        if(rst)
             q<=1'b0;
        else
        begin
            if(cnt<n/2-1)
                q<=1'b0;
            else
                q<=1'b1;
        end
    end
endmodule
