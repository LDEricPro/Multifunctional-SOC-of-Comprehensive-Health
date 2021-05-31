/*函数说明:
1.sin: sin函数计算值,
2.cos: cos函数计算值
3.sinh:双曲正弦函数计算值
4.cosh：双曲余弦函数计算值
5.tanh: 双曲正切 
6.expout:e指数函数计算值   expout=sinh+cosh
7.sigmod:sigmod函数输出值  sigmod=1/(exp(-x)+1)
8.ELU:   ELU函数输出
        
        ELU = x (x>0)
            = (exp(x)-1)  (x<0)
9.softsign: softsign函数输出
        softsign=x/(1+|x|)
10.SySigmoid:Symmetrical Sigmoid函数输出
    Symmetrical Sigmoid=(1-exp(-x))/(1+exp(x))=-1+2*sigmod
*/

//非线性曲线协处理器
module noliner2(
    input          clk ,//时钟                  
    input          finish_rstch, 
    input          finish_rstco,                
    input signed [31:0]  phas,//角度  输入值为计算值的2^16次方                
    input          rst , //复位                 
    output signed [31:0]  sinh , //sinh函数输出          
    output signed [31:0]  cosh , //cosh函数输出     
    //output signed [31:0]  tanh , //tanh函数输出   
    //output signed [31:0]  ELU , //ELU函数输出      
    output signed [31:0]  expout,//指数输出       
    output signed [31:0]  cos,//余弦输出    
    output signed [31:0]  sin,//正弦输出          
   // output signed [31:0]  sigmod,//sigmod函数输出  
   // output signed [31:0]  softsign,//softsign函数输出
   // output signed [31:0]  SySigmoid,//Symmetrical Sigmoid函数输出
    output      finishcos,//三角函数计算结束
    output      finishcoh,//双曲函数计算结束，跳变沿有效
    output      interrupt                     
    );
    //wire [31:0] phas_abs;//求绝对值
    //wire [31:0] sin_c1;
    //wire [31:0] sin_c2;
   // wire [31:0] tanh1;
   // reg signed [31:0]  phasc;
    //parameter ELUa = 1;
    
    //sigmod函数实现
    //assign sigmod = 32'hffff_ffff/(65536+cosh - sinh);
    //tanh实现
   // assign tanh1   = sinh > 0? ((32'hffff*sinh)/cosh)
   //                :(32'h0000-(32'hffff*(32'h0000-sinh)/cosh));
   // assign tanh   = (cosh== 0 || phas==0) ? 32'd0:tanh1;
    //ELU函数实现
    //assign ELU    =   phas>=0 ? (phas):(ELUa*(expout - 16'hffff));
    
    //softsign函数实现
    //assign phas_abs = phas>0 ? phas:(32'h0-phas);
    //assign softsign = phas>0 ? (16'hffff*phas_abs)/(16'hffff+phas_abs)
     //                           :(32'h0-(16'hffff*phas_abs)/(16'hffff+phas_abs));
   // Symmetrical Sigmoid函数实现
    //assign SySigmoid =phas==0? 32'd0: -16'hffff+sigmod*2;
    //sinc函数实现
   // assign sin_c1      = (32'd65536*sin);
   // assign sinc      = (sin_c1)/phas;//(phas==32'b0)?32'hffffffff:(sin_cc);
    
    assign interrupt =    finishcoh & finishcos;//产生中断信号
  exp  exp(
    .clk       (clk),//时钟
    .finish_rst(finish_rstch),
    .phas      (phas),//角度
    .rst       (rst), //复位
    .sinh      (sinh) , //sinh函数输出
    .cosh      (cosh), //cosh函数输出
    .expout    (expout),//指数输出
    .finish    (finishcoh)
    );
    
    cordic cordic(                     
  .clk (clk),//时钟           
  .finish_rst(finish_rstco),         
  .phas(phas),//角度           
  .rst (rst ), //复位          
  .sin (sin ), //sin函数输出     
  .cos (cos ), //cos函数输出     
  .finish(finishcos)     
  );         
    
endmodule


module exp(
input          clk ,//时钟
input          finish_rst,
input  [31:0]  phas,//角度
input          rst , //复位
output [31:0]  sinh , //sinh函数输出
output [31:0]  cosh , //cosh函数输出
output [31:0]  expout,//指数输出
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


//采用放大 2^16次方倍
parameter     o0   =  32'd35999;   //0.549306度角         0
parameter     o1   =  32'd16738;   //0.255413度角 1
parameter     o2   =  32'd8235;   //0.125657度角  2
parameter     o3   =  32'd4101;   //0.062582度角     3
parameter     o4   =  32'd2048;   //0.031260度角     4
parameter     o5   =  32'd1024;   //0.015626度角     5
parameter     o6   =  32'd512;   //0.007813度角     6
parameter     o7   =  32'd256;   //0.003906250度角      7
parameter     o8   =  32'd128;   //0.001953125度角       8
parameter     o9  =  32'd64;   //0.0009765625度角      10 
parameter     o10  =  32'd32;   //0.00048828125度角  11
parameter     o11  =  32'd16;   //0.000244140625度角      12
parameter     o12  =  32'd8;   //0.0001220703125度角      13
parameter     o13  =  32'd4;   //0.00006103515625度角      14
parameter     multip= 32'd79134 ; //初值1.20749706

reg  signed [31:0]  x0,y0,z0,cnt0;
wire signed [31:0]  x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16;//x0为迭代初值 x1-x16分别为16次迭代所对应的值
wire signed [31:0]  y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16;//y0为迭代初值 y1-y16分别为16次迭代所对应的值
wire signed [31:0]  z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15,z16;//z0为角度初值 z1-z16分别为16次迭代所对应的角度剩余值

always@ ( posedge clk or posedge rst ) begin//第一个clk进行初始化
    if(rst)
        begin
            x0<=32'd0;
            y0<=32'd0;
            z0<=32'd0;
            cnt0<=4'b0;
        end
    else
        begin
            //这里把初始值赋给x0 y0 z0
            x0<=multip;
            y0<=32'd0;
            cnt0<=4'b0;
            z0<=phas ;//同样的 phas也要放大2^16次方倍
        end
end

//流水线设计
//第一级流水线  0
cordic_line line0(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd1),  
            .o   (o0),//角度
            .xin (x0),//x输入
            .yin (y0),//y输入
            .zin (z0),//z输入
            .xout(x1) ,//计算后对应的数值输出
            .yout(y1) ,
            .zout(z1) 
    );
    
//第二级流水线  1
cordic_line line1(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd2)   ,
            .o   (o1),//角度
            .xin (x1),//x输入
            .yin (y1),//y输入
            .zin (z1),//z输入
            .xout(x2) ,//计算后对应的数值输出
            .yout(y2) ,
            .zout(z2) 
    );
//第三级流水线  2
cordic_line line2(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd3)   ,
            .o   (o2),//角度
            .xin (x2),//x输入
            .yin (y2),//y输入
            .zin (z2),//z输入
            .xout(x3) ,//计算后对应的数值输出
            .yout(y3) ,
            .zout(z3) 
    );
    
//第四级流水线  3
cordic_line line3(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd4)   ,
            .o   (o3),//角度
            .xin (x3),//x输入
            .yin (y3),//y输入
            .zin (z3),//z输入
            .xout(x4) ,//计算后对应的数值输出
            .yout(y4) ,
            .zout(z4)
    );
    
//第五级流水线  4
cordic_line line4(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd5)   ,
            .o   (o4),//角度
            .xin (x4),//x输入
            .yin (y4),//y输入
            .zin (z4),//z输入
            .xout(x5) ,//计算后对应的数值输出
            .yout(y5) ,
            .zout(z5)
    );

//第六级流水线  5
cordic_line line5(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd6)   ,
            .o   (o5),//角度
            .xin (x5),//x输入
            .yin (y5),//y输入
            .zin (z5),//z输入
            .xout(x6) ,//计算后对应的数值输出
            .yout(y6) ,
            .zout(z6) 
    );

//第七级流水线  6
cordic_line line6(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd7)   ,
            .o   (o6),//角度
            .xin (x6),//x输入
            .yin (y6),//y输入
            .zin (z6),//z输入
            .xout(x7) ,//计算后对应的数值输出
            .yout(y7) ,
            .zout(z7)
    );

//第八级流水线  7
cordic_line line7(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd8)   ,
            .o   (o7),//角度
            .xin (x7),//x输入
            .yin (y7),//y输入
            .zin (z7),//z输入
            .xout(x8) ,//计算后对应的数值输出
            .yout(y8) ,
            .zout(z8) 
    );

//第九级流水线  8
cordic_line line8(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd9)   ,
            .o   (o8),//角度
            .xin (x8),//x输入
            .yin (y8),//y输入
            .zin (z8),//z输入
            .xout(x9) ,//计算后对应的数值输出
            .yout(y9) ,
            .zout(z9)
    );

//第十级流水线  9
cordic_line line9(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd10)   ,
            .o   (o9),//角度
            .xin (x9),//x输入
            .yin (y9),//y输入
            .zin (z9),//z输入
            .xout(x10) ,//计算后对应的数值输出
            .yout(y10) ,
            .zout(z10) 
    );

//第十一级流水线  10
cordic_line line10(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd11)   ,
            .o   (o10),//角度
            .xin (x10),//x输入
            .yin (y10),//y输入
            .zin (z10),//z输入
            .xout(x11) ,//计算后对应的数值输出
            .yout(y11) ,
            .zout(z11) 
    );

//第十二级流水线  11
cordic_line line11(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd12)   ,
            .o   (o11),//角度
            .xin (x11),//x输入
            .yin (y11),//y输入
            .zin (z11),//z输入
            .xout(x12) ,//计算后对应的数值输出
            .yout(y12) ,
            .zout(z12) 
    );

//第十三级流水线  12
cordic_line line12(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd13)   ,
            .o   (o12),//角度
            .xin (x12),//x输入
            .yin (y12),//y输入
            .zin (z12),//z输入
            .xout(x13) ,//计算后对应的数值输出
            .yout(y13) ,
            .zout(z13) 
    );
//第十四级流水线  13
cordic_line line14(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd14)   ,
            .o   (o13),//角度
            .xin (x13),//x输入
            .yin (y13),//y输入
            .zin (z13),//z输入
            .xout(x14) ,//计算后对应的数值输出
            .yout(y14) ,
            .zout(z14) 
    );

 
assign sinh =phas==0? y14: -y14;
assign cosh = x14;
assign expout = sinh + cosh;
endmodule


module cordic_line(
input                      clk ,//时钟
input                      rst ,//复位
input         [3:0 ]       n   ,//移位次数
input         [31:0]       o   ,//角度
input  signed [31:0]       xin ,//x输入
input  signed [31:0]       yin ,//y输入
input  signed [31:0]       zin ,//z输入
output reg signed [31:0]   xout ,//计算后对应的数值输出
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
input          clk ,//时钟
input          finish_rst,
input  [31:0]  phas,//角度
input          rst , //复位
output [31:0]  sin , //sin函数输出
output [31:0]  cos , //cos函数输出
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


//采用放大 2^16次方倍
parameter     o0   =  32'd2949120;   //45度角         0
parameter     o1   =  32'd1740967;   //26.56505118度角 1
parameter     o2   =  32'd919879;   //14.03624347度角  2
parameter     o3   =  32'd466945;   //7.125016度角     3
parameter     o4   =  32'd234378;   //3.576334度角     4
parameter     o5   =  32'd117303;   //1.789910度角     5
parameter     o6   =  32'd58666;   //0.8951737度角     6
parameter     o7   =  32'd29344;   //0.447614度角      7
parameter     o8   =  32'd14667;   //0.223810度角       8
parameter     o9   =  32'd7333;   //0.1119056度角      9
parameter     o10  =  32'd3666;   //0.0559528度角      10 
parameter     o11  =  32'd1833;   //0.02797645262度角  11
parameter     o12  =  32'd916;   //0.13988227度角      12
parameter     o13  =  32'd458;   //0.00699411度角      13
parameter     o14  =  32'd229;   //0.00349705度角      14
parameter     o15  =  32'd114;   //0.00174852度角      15

parameter     multip= 32'd39796 ; //初值0.6072529351

reg  signed [31:0]  x0,y0,z0,cnt0;
wire signed [31:0]  x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16;//x0为迭代初值 x1-x16分别为16次迭代所对应的值
wire signed [31:0]  y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16;//y0为迭代初值 y1-y16分别为16次迭代所对应的值
wire signed [31:0]  z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15,z16;//z0为角度初值 z1-z16分别为16次迭代所对应的角度剩余值

always@ ( posedge clk or posedge rst ) begin//第一个clk进行初始化
    if(rst)
        begin
            x0<=32'd0;
            y0<=32'd0;
            z0<=32'd0;
            cnt0<=4'b0;
        end
    else
        begin
            //这里把初始值赋给x0 y0 z0
            x0<=multip;
            y0<=32'd0;
            cnt0<=4'b0;
            z0<=phas ;//同样的 phas也要放大2^16次方倍
        end
end

//流水线设计
//第一级流水线  0
cordic_linec line0(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd0),  
            .o   (o0),//角度
            .xin (x0),//x输入
            .yin (y0),//y输入
            .zin (z0),//z输入
            .xout(x1) ,//计算后对应的数值输出
            .yout(y1) ,
            .zout(z1) 
    );
    
//第二级流水线  1
cordic_linec line1(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd1)   ,
            .o   (o1),//角度
            .xin (x1),//x输入
            .yin (y1),//y输入
            .zin (z1),//z输入
            .xout(x2) ,//计算后对应的数值输出
            .yout(y2) ,
            .zout(z2) 
    );
//第三级流水线  2
cordic_linec line2(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd2)   ,
            .o   (o2),//角度
            .xin (x2),//x输入
            .yin (y2),//y输入
            .zin (z2),//z输入
            .xout(x3) ,//计算后对应的数值输出
            .yout(y3) ,
            .zout(z3) 
    );
    
//第四级流水线  3
cordic_linec line3(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd3)   ,
            .o   (o3),//角度
            .xin (x3),//x输入
            .yin (y3),//y输入
            .zin (z3),//z输入
            .xout(x4) ,//计算后对应的数值输出
            .yout(y4) ,
            .zout(z4)
    );
    
//第五级流水线  4
cordic_linec line4(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd4)   ,
            .o   (o4),//角度
            .xin (x4),//x输入
            .yin (y4),//y输入
            .zin (z4),//z输入
            .xout(x5) ,//计算后对应的数值输出
            .yout(y5) ,
            .zout(z5)
    );

//第六级流水线  5
cordic_linec line5(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd5)   ,
            .o   (o5),//角度
            .xin (x5),//x输入
            .yin (y5),//y输入
            .zin (z5),//z输入
            .xout(x6) ,//计算后对应的数值输出
            .yout(y6) ,
            .zout(z6) 
    );

//第七级流水线  6
cordic_linec line6(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd6)   ,
            .o   (o6),//角度
            .xin (x6),//x输入
            .yin (y6),//y输入
            .zin (z6),//z输入
            .xout(x7) ,//计算后对应的数值输出
            .yout(y7) ,
            .zout(z7)
    );

//第八级流水线  7
cordic_linec line7(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd7)   ,
            .o   (o7),//角度
            .xin (x7),//x输入
            .yin (y7),//y输入
            .zin (z7),//z输入
            .xout(x8) ,//计算后对应的数值输出
            .yout(y8) ,
            .zout(z8) 
    );

//第九级流水线  8
cordic_linec line8(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd8)   ,
            .o   (o8),//角度
            .xin (x8),//x输入
            .yin (y8),//y输入
            .zin (z8),//z输入
            .xout(x9) ,//计算后对应的数值输出
            .yout(y9) ,
            .zout(z9)
    );

//第十级流水线  9
cordic_linec line9(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd9)   ,
            .o   (o9),//角度
            .xin (x9),//x输入
            .yin (y9),//y输入
            .zin (z9),//z输入
            .xout(x10) ,//计算后对应的数值输出
            .yout(y10) ,
            .zout(z10) 
    );

//第十一级流水线  10
cordic_linec line10(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd10)   ,
            .o   (o10),//角度
            .xin (x10),//x输入
            .yin (y10),//y输入
            .zin (z10),//z输入
            .xout(x11) ,//计算后对应的数值输出
            .yout(y11) ,
            .zout(z11) 
    );

//第十二级流水线  11
cordic_linec line11(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd11)   ,
            .o   (o11),//角度
            .xin (x11),//x输入
            .yin (y11),//y输入
            .zin (z11),//z输入
            .xout(x12) ,//计算后对应的数值输出
            .yout(y12) ,
            .zout(z12) 
    );

//第十三级流水线  12
cordic_linec line12(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd12)   ,
            .o   (o12),//角度
            .xin (x12),//x输入
            .yin (y12),//y输入
            .zin (z12),//z输入
            .xout(x13) ,//计算后对应的数值输出
            .yout(y13) ,
            .zout(z13) 
    );

//第十四级流水线  13
cordic_linec line13(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd13)   ,
            .o   (o13),//角度
            .xin (x13),//x输入
            .yin (y13),//y输入
            .zin (z13),//z输入
            .xout(x14) ,//计算后对应的数值输出
            .yout(y14) ,
            .zout(z14) 
    );
    

//第十五级流水线  14
cordic_linec line14(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd14)   ,
            .o   (o14),//角度
            .xin (x14),//x输入
            .yin (y14),//y输入
            .zin (z14),//z输入
            .xout(x15) ,//计算后对应的数值输出
            .yout(y15) ,
            .zout(z15) 
    );
   
cordic_linec line15(
            .clk (clk),//时钟
            .rst (rst),//复位
            .n   (4'd15)   ,
            .o   (o15),//角度
            .xin (x15),//x输入
            .yin (y15),//y输入
            .zin (z15),//z输入
            .xout(x16) ,//计算后对应的数值输出
            .yout(y16) ,
            .zout(z16) 
    );    
assign sin = y16;
assign cos = x16;

endmodule


module cordic_linec(
input                      clk ,//时钟
input                      rst ,//复位
input         [3:0 ]       n   ,//移位次数
input         [31:0]       o   ,//角度
input  signed [31:0]       xin ,//x输入
input  signed [31:0]       yin ,//y输入
input  signed [31:0]       zin ,//z输入
output reg signed [31:0]   xout ,//计算后对应的数值输出
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
