/*����˵��:
1.sin: sin��������ֵ,
2.cos: cos��������ֵ
3.sinh:˫�����Һ�������ֵ
4.cosh��˫�����Һ�������ֵ
5.tanh: ˫������ 
6.expout:eָ����������ֵ   expout=sinh+cosh
7.sigmod:sigmod�������ֵ  sigmod=1/(exp(-x)+1)
8.ELU:   ELU�������
        
        ELU = x (x>0)
            = (exp(x)-1)  (x<0)
9.softsign: softsign�������
        softsign=x/(1+|x|)
10.SySigmoid:Symmetrical Sigmoid�������
    Symmetrical Sigmoid=(1-exp(-x))/(1+exp(x))=-1+2*sigmod
*/

//����������Э������
module noliner2(
    input          clk ,//ʱ��                  
    input          finish_rstch, 
    input          finish_rstco,                
    input signed [31:0]  phas,//�Ƕ�  ����ֵΪ����ֵ��2^16�η�                
    input          rst , //��λ                 
    output signed [31:0]  sinh , //sinh�������          
    output signed [31:0]  cosh , //cosh�������     
    //output signed [31:0]  tanh , //tanh�������   
    //output signed [31:0]  ELU , //ELU�������      
    output signed [31:0]  expout,//ָ�����       
    output signed [31:0]  cos,//�������    
    output signed [31:0]  sin,//�������          
   // output signed [31:0]  sigmod,//sigmod�������  
   // output signed [31:0]  softsign,//softsign�������
   // output signed [31:0]  SySigmoid,//Symmetrical Sigmoid�������
    output      finishcos,//���Ǻ����������
    output      finishcoh,//˫�����������������������Ч
    output      interrupt                     
    );
    //wire [31:0] phas_abs;//�����ֵ
    //wire [31:0] sin_c1;
    //wire [31:0] sin_c2;
   // wire [31:0] tanh1;
   // reg signed [31:0]  phasc;
    //parameter ELUa = 1;
    
    //sigmod����ʵ��
    //assign sigmod = 32'hffff_ffff/(65536+cosh - sinh);
    //tanhʵ��
   // assign tanh1   = sinh > 0? ((32'hffff*sinh)/cosh)
   //                :(32'h0000-(32'hffff*(32'h0000-sinh)/cosh));
   // assign tanh   = (cosh== 0 || phas==0) ? 32'd0:tanh1;
    //ELU����ʵ��
    //assign ELU    =   phas>=0 ? (phas):(ELUa*(expout - 16'hffff));
    
    //softsign����ʵ��
    //assign phas_abs = phas>0 ? phas:(32'h0-phas);
    //assign softsign = phas>0 ? (16'hffff*phas_abs)/(16'hffff+phas_abs)
     //                           :(32'h0-(16'hffff*phas_abs)/(16'hffff+phas_abs));
   // Symmetrical Sigmoid����ʵ��
    //assign SySigmoid =phas==0? 32'd0: -16'hffff+sigmod*2;
    //sinc����ʵ��
   // assign sin_c1      = (32'd65536*sin);
   // assign sinc      = (sin_c1)/phas;//(phas==32'b0)?32'hffffffff:(sin_cc);
    
    assign interrupt =    finishcoh & finishcos;//�����ж��ź�
  exp  exp(
    .clk       (clk),//ʱ��
    .finish_rst(finish_rstch),
    .phas      (phas),//�Ƕ�
    .rst       (rst), //��λ
    .sinh      (sinh) , //sinh�������
    .cosh      (cosh), //cosh�������
    .expout    (expout),//ָ�����
    .finish    (finishcoh)
    );
    
    cordic cordic(                     
  .clk (clk),//ʱ��           
  .finish_rst(finish_rstco),         
  .phas(phas),//�Ƕ�           
  .rst (rst ), //��λ          
  .sin (sin ), //sin�������     
  .cos (cos ), //cos�������     
  .finish(finishcos)     
  );         
    
endmodule


module exp(
input          clk ,//ʱ��
input          finish_rst,
input  [31:0]  phas,//�Ƕ�
input          rst , //��λ
output [31:0]  sinh , //sinh�������
output [31:0]  cosh , //cosh�������
output [31:0]  expout,//ָ�����
output reg     finish
    );
reg [31:0] pre_sinh;
always@(posedge clk or posedge  finish_rst or posedge rst)
begin
    if(finish_rst || rst)
        finish<=0;
    else
    begin
        if(pre_sinh!=sinh)
            finish<=1;
        else
            finish <= finish;
    end
    pre_sinh<=sinh;
end


//���÷Ŵ� 2^16�η���
parameter     o0   =  32'd35999;   //0.549306�Ƚ�         0
parameter     o1   =  32'd16738;   //0.255413�Ƚ� 1
parameter     o2   =  32'd8235;   //0.125657�Ƚ�  2
parameter     o3   =  32'd4101;   //0.062582�Ƚ�     3
parameter     o4   =  32'd2048;   //0.031260�Ƚ�     4
parameter     o5   =  32'd1024;   //0.015626�Ƚ�     5
parameter     o6   =  32'd512;   //0.007813�Ƚ�     6
parameter     o7   =  32'd256;   //0.003906250�Ƚ�      7
parameter     o8   =  32'd128;   //0.001953125�Ƚ�       8
parameter     o9  =  32'd64;   //0.0009765625�Ƚ�      10 
parameter     o10  =  32'd32;   //0.00048828125�Ƚ�  11
parameter     o11  =  32'd16;   //0.000244140625�Ƚ�      12
parameter     o12  =  32'd8;   //0.0001220703125�Ƚ�      13
parameter     o13  =  32'd4;   //0.00006103515625�Ƚ�      14
parameter     multip= 32'd79134 ; //��ֵ1.20749706

reg  signed [31:0]  x0,y0,z0,cnt0;
wire signed [31:0]  x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16;//x0Ϊ������ֵ x1-x16�ֱ�Ϊ16�ε�������Ӧ��ֵ
wire signed [31:0]  y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16;//y0Ϊ������ֵ y1-y16�ֱ�Ϊ16�ε�������Ӧ��ֵ
wire signed [31:0]  z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15,z16;//z0Ϊ�Ƕȳ�ֵ z1-z16�ֱ�Ϊ16�ε�������Ӧ�ĽǶ�ʣ��ֵ

always@ ( posedge clk or posedge rst ) begin//��һ��clk���г�ʼ��
    if(rst)
        begin
            x0<=32'd0;
            y0<=32'd0;
            z0<=32'd0;
            cnt0<=4'b0;
        end
    else
        begin
            //����ѳ�ʼֵ����x0 y0 z0
            x0<=multip;
            y0<=32'd0;
            cnt0<=4'b0;
            z0<=phas ;//ͬ���� phasҲҪ�Ŵ�2^16�η���
        end
end

//��ˮ�����
//��һ����ˮ��  0
cordic_line line0(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd1),  
            .o   (o0),//�Ƕ�
            .xin (x0),//x����
            .yin (y0),//y����
            .zin (z0),//z����
            .xout(x1) ,//������Ӧ����ֵ���
            .yout(y1) ,
            .zout(z1) 
    );
    
//�ڶ�����ˮ��  1
cordic_line line1(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd2)   ,
            .o   (o1),//�Ƕ�
            .xin (x1),//x����
            .yin (y1),//y����
            .zin (z1),//z����
            .xout(x2) ,//������Ӧ����ֵ���
            .yout(y2) ,
            .zout(z2) 
    );
//��������ˮ��  2
cordic_line line2(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd3)   ,
            .o   (o2),//�Ƕ�
            .xin (x2),//x����
            .yin (y2),//y����
            .zin (z2),//z����
            .xout(x3) ,//������Ӧ����ֵ���
            .yout(y3) ,
            .zout(z3) 
    );
    
//���ļ���ˮ��  3
cordic_line line3(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd4)   ,
            .o   (o3),//�Ƕ�
            .xin (x3),//x����
            .yin (y3),//y����
            .zin (z3),//z����
            .xout(x4) ,//������Ӧ����ֵ���
            .yout(y4) ,
            .zout(z4)
    );
    
//���弶��ˮ��  4
cordic_line line4(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd5)   ,
            .o   (o4),//�Ƕ�
            .xin (x4),//x����
            .yin (y4),//y����
            .zin (z4),//z����
            .xout(x5) ,//������Ӧ����ֵ���
            .yout(y5) ,
            .zout(z5)
    );

//��������ˮ��  5
cordic_line line5(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd6)   ,
            .o   (o5),//�Ƕ�
            .xin (x5),//x����
            .yin (y5),//y����
            .zin (z5),//z����
            .xout(x6) ,//������Ӧ����ֵ���
            .yout(y6) ,
            .zout(z6) 
    );

//���߼���ˮ��  6
cordic_line line6(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd7)   ,
            .o   (o6),//�Ƕ�
            .xin (x6),//x����
            .yin (y6),//y����
            .zin (z6),//z����
            .xout(x7) ,//������Ӧ����ֵ���
            .yout(y7) ,
            .zout(z7)
    );

//�ڰ˼���ˮ��  7
cordic_line line7(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd8)   ,
            .o   (o7),//�Ƕ�
            .xin (x7),//x����
            .yin (y7),//y����
            .zin (z7),//z����
            .xout(x8) ,//������Ӧ����ֵ���
            .yout(y8) ,
            .zout(z8) 
    );

//�ھż���ˮ��  8
cordic_line line8(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd9)   ,
            .o   (o8),//�Ƕ�
            .xin (x8),//x����
            .yin (y8),//y����
            .zin (z8),//z����
            .xout(x9) ,//������Ӧ����ֵ���
            .yout(y9) ,
            .zout(z9)
    );

//��ʮ����ˮ��  9
cordic_line line9(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd10)   ,
            .o   (o9),//�Ƕ�
            .xin (x9),//x����
            .yin (y9),//y����
            .zin (z9),//z����
            .xout(x10) ,//������Ӧ����ֵ���
            .yout(y10) ,
            .zout(z10) 
    );

//��ʮһ����ˮ��  10
cordic_line line10(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd11)   ,
            .o   (o10),//�Ƕ�
            .xin (x10),//x����
            .yin (y10),//y����
            .zin (z10),//z����
            .xout(x11) ,//������Ӧ����ֵ���
            .yout(y11) ,
            .zout(z11) 
    );

//��ʮ������ˮ��  11
cordic_line line11(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd12)   ,
            .o   (o11),//�Ƕ�
            .xin (x11),//x����
            .yin (y11),//y����
            .zin (z11),//z����
            .xout(x12) ,//������Ӧ����ֵ���
            .yout(y12) ,
            .zout(z12) 
    );

//��ʮ������ˮ��  12
cordic_line line12(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd13)   ,
            .o   (o12),//�Ƕ�
            .xin (x12),//x����
            .yin (y12),//y����
            .zin (z12),//z����
            .xout(x13) ,//������Ӧ����ֵ���
            .yout(y13) ,
            .zout(z13) 
    );
//��ʮ�ļ���ˮ��  13
cordic_line line14(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd14)   ,
            .o   (o13),//�Ƕ�
            .xin (x13),//x����
            .yin (y13),//y����
            .zin (z13),//z����
            .xout(x14) ,//������Ӧ����ֵ���
            .yout(y14) ,
            .zout(z14) 
    );

 
assign sinh =phas==0? y14: -y14;
assign cosh = x14;
assign expout = sinh + cosh;
endmodule


module cordic_line(
input                      clk ,//ʱ��
input                      rst ,//��λ
input         [3:0 ]       n   ,//��λ����
input         [31:0]       o   ,//�Ƕ�
input  signed [31:0]       xin ,//x����
input  signed [31:0]       yin ,//y����
input  signed [31:0]       zin ,//z����
output reg signed [31:0]   xout ,//������Ӧ����ֵ���
output reg signed [31:0]   yout ,
output reg signed [31:0]   zout 
    );
    
    always @ (posedge clk or posedge rst)
    begin
        if(rst)
            begin
                xout<=32'd0;
                yout<=32'd0;
                zout<=32'd0;
            end
         else
            begin
                if(zin[31])
                begin
                    xout<=xin+(yin>>>n);
                    yout<=yin+(xin>>>n);
                    zout<=zin+o;
                end
                else
                begin
                    xout<=xin-(yin>>>n);
                    yout<=yin-(xin>>>n);
                    zout<=zin-o;
                end
            end
    end
endmodule


module cordic(
input          clk ,//ʱ��
input          finish_rst,
input  [31:0]  phas,//�Ƕ�
input          rst , //��λ
output [31:0]  sin , //sin�������
output [31:0]  cos , //cos�������
output reg     finish
    );
reg [31:0] pre_sin;
always@(posedge clk or posedge  finish_rst or posedge rst)
begin
    if(finish_rst || rst)
        finish<=0;
    else
    begin
        if(pre_sin!=sin)
            finish<=1;
        else
            finish<=finish;
    end
    pre_sin<=sin;
end


//���÷Ŵ� 2^16�η���
parameter     o0   =  32'd2949120;   //45�Ƚ�         0
parameter     o1   =  32'd1740967;   //26.56505118�Ƚ� 1
parameter     o2   =  32'd919879;   //14.03624347�Ƚ�  2
parameter     o3   =  32'd466945;   //7.125016�Ƚ�     3
parameter     o4   =  32'd234378;   //3.576334�Ƚ�     4
parameter     o5   =  32'd117303;   //1.789910�Ƚ�     5
parameter     o6   =  32'd58666;   //0.8951737�Ƚ�     6
parameter     o7   =  32'd29344;   //0.447614�Ƚ�      7
parameter     o8   =  32'd14667;   //0.223810�Ƚ�       8
parameter     o9   =  32'd7333;   //0.1119056�Ƚ�      9
parameter     o10  =  32'd3666;   //0.0559528�Ƚ�      10 
parameter     o11  =  32'd1833;   //0.02797645262�Ƚ�  11
parameter     o12  =  32'd916;   //0.13988227�Ƚ�      12
parameter     o13  =  32'd458;   //0.00699411�Ƚ�      13
parameter     o14  =  32'd229;   //0.00349705�Ƚ�      14
parameter     o15  =  32'd114;   //0.00174852�Ƚ�      15

parameter     multip= 32'd39796 ; //��ֵ0.6072529351

reg  signed [31:0]  x0,y0,z0,cnt0;
wire signed [31:0]  x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16;//x0Ϊ������ֵ x1-x16�ֱ�Ϊ16�ε�������Ӧ��ֵ
wire signed [31:0]  y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16;//y0Ϊ������ֵ y1-y16�ֱ�Ϊ16�ε�������Ӧ��ֵ
wire signed [31:0]  z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15,z16;//z0Ϊ�Ƕȳ�ֵ z1-z16�ֱ�Ϊ16�ε�������Ӧ�ĽǶ�ʣ��ֵ

always@ ( posedge clk or posedge rst ) begin//��һ��clk���г�ʼ��
    if(rst)
        begin
            x0<=32'd0;
            y0<=32'd0;
            z0<=32'd0;
            cnt0<=4'b0;
        end
    else
        begin
            //����ѳ�ʼֵ����x0 y0 z0
            x0<=multip;
            y0<=32'd0;
            cnt0<=4'b0;
            z0<=phas ;//ͬ���� phasҲҪ�Ŵ�2^16�η���
        end
end

//��ˮ�����
//��һ����ˮ��  0
cordic_linec line0(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd0),  
            .o   (o0),//�Ƕ�
            .xin (x0),//x����
            .yin (y0),//y����
            .zin (z0),//z����
            .xout(x1) ,//������Ӧ����ֵ���
            .yout(y1) ,
            .zout(z1) 
    );
    
//�ڶ�����ˮ��  1
cordic_linec line1(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd1)   ,
            .o   (o1),//�Ƕ�
            .xin (x1),//x����
            .yin (y1),//y����
            .zin (z1),//z����
            .xout(x2) ,//������Ӧ����ֵ���
            .yout(y2) ,
            .zout(z2) 
    );
//��������ˮ��  2
cordic_linec line2(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd2)   ,
            .o   (o2),//�Ƕ�
            .xin (x2),//x����
            .yin (y2),//y����
            .zin (z2),//z����
            .xout(x3) ,//������Ӧ����ֵ���
            .yout(y3) ,
            .zout(z3) 
    );
    
//���ļ���ˮ��  3
cordic_linec line3(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd3)   ,
            .o   (o3),//�Ƕ�
            .xin (x3),//x����
            .yin (y3),//y����
            .zin (z3),//z����
            .xout(x4) ,//������Ӧ����ֵ���
            .yout(y4) ,
            .zout(z4)
    );
    
//���弶��ˮ��  4
cordic_linec line4(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd4)   ,
            .o   (o4),//�Ƕ�
            .xin (x4),//x����
            .yin (y4),//y����
            .zin (z4),//z����
            .xout(x5) ,//������Ӧ����ֵ���
            .yout(y5) ,
            .zout(z5)
    );

//��������ˮ��  5
cordic_linec line5(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd5)   ,
            .o   (o5),//�Ƕ�
            .xin (x5),//x����
            .yin (y5),//y����
            .zin (z5),//z����
            .xout(x6) ,//������Ӧ����ֵ���
            .yout(y6) ,
            .zout(z6) 
    );

//���߼���ˮ��  6
cordic_linec line6(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd6)   ,
            .o   (o6),//�Ƕ�
            .xin (x6),//x����
            .yin (y6),//y����
            .zin (z6),//z����
            .xout(x7) ,//������Ӧ����ֵ���
            .yout(y7) ,
            .zout(z7)
    );

//�ڰ˼���ˮ��  7
cordic_linec line7(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd7)   ,
            .o   (o7),//�Ƕ�
            .xin (x7),//x����
            .yin (y7),//y����
            .zin (z7),//z����
            .xout(x8) ,//������Ӧ����ֵ���
            .yout(y8) ,
            .zout(z8) 
    );

//�ھż���ˮ��  8
cordic_linec line8(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd8)   ,
            .o   (o8),//�Ƕ�
            .xin (x8),//x����
            .yin (y8),//y����
            .zin (z8),//z����
            .xout(x9) ,//������Ӧ����ֵ���
            .yout(y9) ,
            .zout(z9)
    );

//��ʮ����ˮ��  9
cordic_linec line9(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd9)   ,
            .o   (o9),//�Ƕ�
            .xin (x9),//x����
            .yin (y9),//y����
            .zin (z9),//z����
            .xout(x10) ,//������Ӧ����ֵ���
            .yout(y10) ,
            .zout(z10) 
    );

//��ʮһ����ˮ��  10
cordic_linec line10(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd10)   ,
            .o   (o10),//�Ƕ�
            .xin (x10),//x����
            .yin (y10),//y����
            .zin (z10),//z����
            .xout(x11) ,//������Ӧ����ֵ���
            .yout(y11) ,
            .zout(z11) 
    );

//��ʮ������ˮ��  11
cordic_linec line11(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd11)   ,
            .o   (o11),//�Ƕ�
            .xin (x11),//x����
            .yin (y11),//y����
            .zin (z11),//z����
            .xout(x12) ,//������Ӧ����ֵ���
            .yout(y12) ,
            .zout(z12) 
    );

//��ʮ������ˮ��  12
cordic_linec line12(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd12)   ,
            .o   (o12),//�Ƕ�
            .xin (x12),//x����
            .yin (y12),//y����
            .zin (z12),//z����
            .xout(x13) ,//������Ӧ����ֵ���
            .yout(y13) ,
            .zout(z13) 
    );

//��ʮ�ļ���ˮ��  13
cordic_linec line13(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd13)   ,
            .o   (o13),//�Ƕ�
            .xin (x13),//x����
            .yin (y13),//y����
            .zin (z13),//z����
            .xout(x14) ,//������Ӧ����ֵ���
            .yout(y14) ,
            .zout(z14) 
    );
    

//��ʮ�弶��ˮ��  14
cordic_linec line14(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd14)   ,
            .o   (o14),//�Ƕ�
            .xin (x14),//x����
            .yin (y14),//y����
            .zin (z14),//z����
            .xout(x15) ,//������Ӧ����ֵ���
            .yout(y15) ,
            .zout(z15) 
    );
   
cordic_linec line15(
            .clk (clk),//ʱ��
            .rst (rst),//��λ
            .n   (4'd15)   ,
            .o   (o15),//�Ƕ�
            .xin (x15),//x����
            .yin (y15),//y����
            .zin (z15),//z����
            .xout(x16) ,//������Ӧ����ֵ���
            .yout(y16) ,
            .zout(z16) 
    );    
assign sin = y16;
assign cos = x16;

endmodule


module cordic_linec(
input                      clk ,//ʱ��
input                      rst ,//��λ
input         [3:0 ]       n   ,//��λ����
input         [31:0]       o   ,//�Ƕ�
input  signed [31:0]       xin ,//x����
input  signed [31:0]       yin ,//y����
input  signed [31:0]       zin ,//z����
output reg signed [31:0]   xout ,//������Ӧ����ֵ���
output reg signed [31:0]   yout ,
output reg signed [31:0]   zout 
    );
    
    always @ (posedge clk or posedge rst)
    begin
        if(rst)
            begin
                xout<=32'd0;
                yout<=32'd0;
                zout<=32'd0;
            end
         else
            begin
                if(zin[31])
                begin
                    xout<=xin+(yin>>>n);
                    yout<=yin-(xin>>>n);
                    zout<=zin+o;
                end
                else
                begin
                    xout<=xin-(yin>>>n);
                    yout<=yin+(xin>>>n);
                    zout<=zin-o;
                end
            end
    end
endmodule
