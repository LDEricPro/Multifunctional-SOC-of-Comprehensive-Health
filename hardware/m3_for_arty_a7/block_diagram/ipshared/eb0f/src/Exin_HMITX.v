`timescale 1ns / 1ps

module Exin_HMITX(
input             clk    ,			
input             rst_n  ,		
input [7:0]       din    ,
input             din_vld,	 //��ʼ�����źţ������Ҫһֱ���Ϳ���ɾ�����źţ������Ǵ�ģ���м������Ĵ��룬����ɾ����
output            rdy    ,  //���ƽ��յ�����źţ���ʾ�����һ���ֽڵĴ��䣬ͬdin_vld�ź�һ������Ҫ����ɾ��
output            dout   
    );
    uart_tx HMI0(                             
         .clk    (clk    ),	
         .rst_n  (rst_n  ),	
         .din    (din    ), 
         .din_vld(din_vld),	
         .rdy    (rdy    ), 
         .dout   (dout   )  
      );                               
      
endmodule
	
module uart_tx(
                 input             clk    ,			
                 input             rst_n  ,		
                 input [7:0]       din    ,
                 input             din_vld,	 //��ʼ�����źţ������Ҫһֱ���Ϳ���ɾ�����źţ������Ǵ�ģ���м������Ĵ��룬����ɾ����
                 output reg        rdy    ,  //���ƽ��յ�����źţ���ʾ�����һ���ֽڵĴ��䣬ͬdin_vld�ź�һ������Ҫ����ɾ��
                 output reg        dout   
             );

parameter         BPS    = 434;

reg   [7:0]       tx_data_tmp;	

reg               flag_add   ;
reg   [14:0]      cnt0       ;
wire              add_cnt0   ;
wire              end_cnt0   ;

reg   [ 3:0]      cnt1       ;
wire              add_cnt1   ;
wire              end_cnt1   ;

wire  [ 9:0]      data       ;

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        flag_add <= 0;
    end
    else if(flag_add==0 && din_vld)begin
        flag_add <= 1;
    end
    else if(end_cnt1)begin
        flag_add <= 0;
    end
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt0 <= 0;
    end
    else if(add_cnt0)begin
        if(end_cnt0)
            cnt0 <= 0;
        else
            cnt0 <= cnt0 + 1;
    end
end

assign add_cnt0 = flag_add;
assign end_cnt0 = add_cnt0 && cnt0==BPS-1 ;

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt1 <= 0;
    end
    else if(add_cnt1)begin
        if(end_cnt1)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + 1;
    end
end

assign add_cnt1 = end_cnt0;
assign end_cnt1 = add_cnt1 && cnt1==10-1 ;


always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		tx_data_tmp <=8'd0;
	end
	else if(flag_add==1'b0 && din_vld) begin	
		tx_data_tmp <= din;	
	end
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		dout <= 1'b1;
	end
	else if(add_cnt0 && cnt0==1-1)begin
        dout<= data[cnt1];
    end 
end

assign  data = {1'b1,tx_data_tmp,1'b0}; //����ʱ�Ǵӵ͵��� data = {ֹͣλ������[7],����[6] ~ ����[0],��ʼλ};

always  @(*)begin
    if(din_vld || flag_add)
        rdy = 1'b0;
    else
        rdy = 1'b1;
end

endmodule

