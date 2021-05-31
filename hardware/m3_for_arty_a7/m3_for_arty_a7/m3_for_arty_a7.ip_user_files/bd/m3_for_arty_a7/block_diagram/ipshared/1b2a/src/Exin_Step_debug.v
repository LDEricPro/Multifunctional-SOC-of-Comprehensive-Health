`timescale 1ns / 1ps

module            Exin_step_debug(
input         	   clk, 	  //输入时钟 50MHz
input         	   rst,
input [15:0]  	   Ax_IN,
input [15:0]  	   Ay_IN,
input [15:0]  	   Az_IN,
input [15:0] 	   delay_high,//高电平持续时�? us
input [31:0] 	   delay_low,//施密特触发器静默时间 us
input [31:0]  	   Threshold,

output reg [31:0]  StepNum,
output reg [31:0]  MixValue,
output reg [31:0]  cnt,
output reg [1:0]   state

    );	
	

always @ (posedge clk  or negedge rst)
begin
    if(~rst)
		begin
			StepNum<=16'b0;
			MixValue<=16'b0;
			state<=2'b0;
		end
    else 
		begin
			case(state)
				0:
				begin
					MixValue <= Ax_IN+Ay_IN+Az_IN;
					if(MixValue>Threshold*32768)
					begin
						state <= 1;
						cnt<=32'b0;
					end
				end
				1:
				begin
					cnt<=cnt+1;
					if(cnt==delay_high*50)
						state<=2;
				end
				2:
				begin
					MixValue <= Ax_IN+Ay_IN+Az_IN;
					if(MixValue<Threshold*16384)
					begin
						state<=3;
						cnt<=32'b0;
					end
				end
				3:
				begin
					cnt<=cnt+1;
					if(cnt==delay_low*50)
					begin
						StepNum<=StepNum+1;
						state<=0;
					end
				end
			endcase
		end
end

endmodule
