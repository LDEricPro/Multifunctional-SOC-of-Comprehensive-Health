module         MPU_6050(
    input                    clk,//50_000_000
    input                  rst_n,
    input                    rxd,
    output              dout_vld,
    output       [7:0]      dout,
    output reg  [15:0]  ROLL_OUT,
    output reg [15:0]  Pitch_OUT,
    output reg [15:0]    Yaw_OUT,
    
   // output reg [15:0]  wx_OUT,
   // output reg [15:0]  wy_OUT,
   // output reg [15:0]  wz_OUT, 
    
    output reg [15:0]  Ax_OUT,
    output reg [15:0]  Ay_OUT,
    output reg [15:0]  Az_OUT 
    );   
    parameter n=434;//����50Mhz ������ 50_000_000/434 = 115200
    
    reg [3:0]  state0;//״̬��0 �������
    reg [3:0]  state1;//״̬��1 ���ս��ٶ�
   // reg [3:0]  state2;//״̬��2 ���ռ��ٶ�
    reg [15:0] ROLL,Pitch,Yaw;
    //reg [15:0] wx,wy,wz;
    reg [15:0] Ax,Az,Ay;
       
    uart_rx#(.BPS(n)) rx1(  //���ڽ���ģ���ģ�����ݽ��н���                          
 . clk       (clk) ,		  
 . rst_n     (rst_n) ,	   
 . din       (rxd) ,    
 . dout      (dout) ,		  
 . dout_vld  (dout_vld)      
    );
    
    always @ (posedge dout_vld or negedge rst_n)//�ǶȽ���
    begin
        if(~rst_n)
        begin
            ROLL<=16'b0;
            Pitch<=16'b0;
            Yaw<=16'b0;
            ROLL_OUT<=16'b0;
            Pitch_OUT<=16'b0;
            Yaw_OUT<=16'b0;
            state0<=4'b0;
        end
        else
        begin
                case(state0)
                4'b0000:begin 
                            if(dout==8'h55)  
                                state0<=state0+4'b1;//��ת����
                            else
                                state0<=state0;
                         end
                4'b0001:begin
                            if(dout==8'h53)  //�������
                                state0<=state0+4'b1;//��ת����
                            else
                                state0<=4'b0;
                        end         
                4'b0010:begin state0<=state0+4'b1; ROLL[7:0]<=dout;end      
                4'b0011:begin state0<=state0+4'b1; ROLL[15:8]<=dout;end    
                
                4'b0100:begin state0<=state0+4'b1; Pitch[7:0]<=dout;end
                4'b0101:begin state0<=state0+4'b1; Pitch[15:8]<=dout;end
                
                4'b0110:begin state0<=state0+4'b1; Yaw[7:0]<=dout; end
                4'b0111:begin state0<=state0+4'b1; Yaw[15:8]<=dout; end
                
                4'b1000:begin state0<=4'b0; ROLL_OUT<= ROLL;Pitch_OUT<=Pitch;Yaw_OUT<=Yaw; end
                
                default:begin state0<=4'b0; Yaw[15:0]<=16'd0; ROLL[15:0]<=16'd0; Pitch[15:0]<=16'd0; 
                            Yaw_OUT[15:0]<=16'd0; ROLL_OUT[15:0]<=16'd0; Pitch_OUT[15:0]<=16'd0;
                end             
                endcase
        end
    end
    
    
    always @ (posedge dout_vld or negedge rst_n)//���ٶȽ���
    begin
        if(~rst_n)
        begin
            Ax<=16'b0;
            Ay<=16'b0;
            Az<=16'b0;
            Ax_OUT<=16'b0;
            Ay_OUT<=16'b0;
            Az_OUT<=16'b0;
            state1<=4'b0;
        end
        else
        begin
            case(state1)
            4'b0000:begin
                        if(dout==8'h55)
                            state1<=state1+4'b1;
                        else
                            state1<=state1;
                    end
            4'b0001:begin
                        if(dout==8'h51)
                            state1<=state1+4'b1;
                        else
                            state1<=4'b0;
                    end 
            4'b0010:begin  state1<=state1+4'b1;Ax[7:0]<=dout; end
            4'b0011:begin  state1<=state1+4'b1;Ax[15:8]<=dout; end
            
            4'b0100:begin  state1<=state1+4'b1;Ay[7:0]<=dout; end
            4'b0101:begin  state1<=state1+4'b1;Ay[15:8]<=dout; end
            
            4'b0110:begin  state1<=state1+4'b1;Az[7:0]<=dout; end
            4'b0111:begin  state1<=state1+4'b1;Az[15:8]<=dout; end
            4'b1000:begin  state1<=4'b0;Ax_OUT<=Ax;Ay_OUT<=Ay;Az_OUT<=Az; end
            default:begin
                            state1<=4'b0;Ax_OUT<=16'b0;Ay_OUT<=16'b0;Az_OUT<=16'b0;
                              Ax<=16'b01; Az<=16'b0; Ay<=16'b0;
                    end
            endcase
        end
    end
 /*   
    always @ (posedge dout_vld or negedge rst_n)//�Ǽ��ٶȽ���
    begin
        if(~rst_n)
        begin
            state2<=16'b0;
            wx<=16'b0;
            wy<=16'b0;
            wz<=16'b0;
            wx_OUT<=16'b0;
            wz_OUT<=16'b0;
            wy_OUT<=16'b0;
        end
        else
        case(state2)
        4'b0000:begin
                    if(dout==8'h55)
                        state2<=state2+4'b1;
                    else
                         state2<= state2;
                end
         4'b0001:begin
                    if(dout<=8'h52)
                        state2<=state2+4'b1;
                    else
                        state2<=4'b0;
                  end
         4'b0010: begin state2<=state2+4'b1;wx[7:0]<=dout; end
         4'b0011: begin state2<=state2+4'b1;wx[15:8]<=dout; end
         
         4'b0100: begin state2<=state2+4'b1;wy[7:0]<=dout; end
         4'b0101: begin state2<=state2+4'b1;wy[15:8]<=dout; end
         
         4'b0110: begin state2<=state2+4'b1;wz[7:0]<=dout; end
         4'b0111: begin state2<=state2+4'b1;wz[15:8]<=dout; end
         
         4'b1000: begin state2<=4'b0;wx_OUT<=wx;wy_OUT<=wy;wz_OUT<=wz; end
         default: begin wx_OUT<=16'b0;wy_OUT<=16'b0;wz_OUT<=16'b0;
                        wx<=16'b0;wz<=16'b0;wy<=16'b0;
                        state2<=16'b0;
                end
        endcase
        
    end*/
endmodule


module uart_rx(

               input               clk          ,		
               input               rst_n        ,	
               input               din          ,
               output  reg[7:0]    dout         ,		
               output  reg         dout_vld     
               );

parameter    	   BPS	  =	5208;	//9600������
reg   [14:0]        cnt0         ;
wire                add_cnt0     ;
wire                end_cnt0     ;

reg   [ 3:0]        cnt1         ;
wire                add_cnt1     ;
wire                end_cnt1     ;

reg                 rx0          ;	
reg                 rx1          ;	
reg                 rx2          ;	
wire                rx_en        ;

reg                 flag_add     ;

//�����ݵĿ�ʱ�Ӵ�����ֹ��������̬
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		rx0 <= 1'b1;
        rx1 <= 1'b1;
        rx2 <= 1'b1;
	end
	else begin
		rx0 <= din;
        rx1 <= rx0;
        rx2 <= rx1;
	end
end

assign rx_en = rx2 & ~rx1;	
//��⵽�½��أ�������λ��1��Ϊ0�����ݴ��俪ʼ

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
assign end_cnt1 = add_cnt1 && cnt1==9-1 ; //�����ǽ��ճ��򣬴˴�Ҳ����У��λ������ֻ��Ҫ�������ݾͿ��ԣ�����ĵ�10λ��Ȼλֹͣλ�����Բ�����ʡ��Դ

always @ (posedge clk or negedge rst_n)begin
	if(!rst_n) begin
		flag_add <= 1'b0;
	end
	else if(rx_en) begin		
		flag_add <= 1'b1;	
	end
    else if(end_cnt1) begin		
		flag_add <= 1'b0;	
	end
end

always @ (posedge clk or negedge rst_n)begin
	if(!rst_n) begin
		dout <= 8'd0;
	end
	else if(add_cnt0 && cnt0==BPS/2-1 && cnt1!=0) begin		//���м�ʱ�̲�������ʱ�����ݱȽ��ȶ����ӵ�λ����λ���β���
	    dout[cnt1-1]<= rx2 ;
	end
end


//�����������ź�
always @ (posedge clk or negedge rst_n)begin
	if(!rst_n) begin
		dout_vld <= 1'b0;
	end
    else if(end_cnt1) begin		
		dout_vld <= 1'b1;	
	end
	else begin	
        dout_vld <= 1'b0;			
	end
end

endmodule

