
module Exin_dht11(
    input  clk,
    input  nRST,//1Mhz
    inout  Data,
    output [7:0]tmpH,
    output [7:0]tmpL,
    output [7:0]wetH,
    output [7:0]wetL
);
wire [39:0]data1;

assign wetL=data1[31:24];
assign wetH=data1[39:32];
assign tmpL=data1[15:8];
assign tmpH=data1[23:16];

DHT11(.clk(clk),.nRST(nRST),.Data(Data),.data1(data1));
endmodule



module DHT11(clk,nRST,Data,data1);
    input clk,nRST;//1Mhz
    inout Data;
    output data1;
    reg [31:0]counter;
    reg [4:0]state;
    reg[5:0] rec=0;
    reg read_begin;
    reg [39:0]data,data1;
    reg read_done;
    reg data_reg;
    reg flag;
    parameter state0=0;
    parameter state1=1;
    parameter state2=2;
    parameter state3=3;
    parameter state4=4;
    parameter state5=5;
    parameter state6=6;
    parameter state7=7;
    parameter state8=8;
    parameter state9=9;
    parameter state10=10;
    parameter state11=11;
    parameter state12=12;
    assign Data=(flag)?data_reg:1'bz;


always @(posedge clk or posedge nRST )//shang sheng yan qu dong 
begin
if(nRST)
begin
  state<=0 ;
  data<=0;
end
else
begin   
case (state)
  state0:begin
         if(counter==500000)//0.5s
           begin
             counter<=0;
             state<=state1;
           end
           else
           begin
              data<=0;
              flag<=1;
              data_reg<=1;
              read_done<=0;             
              counter<=counter+1;//
           end
           end
  state1:
      begin
         if(counter==19000)   //19ms
           begin
           flag<=0;
           state<=state2;
           counter<=0;
           
           end
           else
           begin
           data_reg<=0;
           counter<=counter+1'b1;
           end 
      end 
  state2:
      begin
        counter<=counter+1'b1;
         if(counter==20)      //20us~30us
           begin
              state<=state3;
              counter<=0;             
           end
       end
  state3:
       begin
         if(Data==1)
            begin
               state<=state3;
        
                
             end
         else
           begin
                state<=state4;
                 
           end
         end
 state4:
       begin
          if(Data==0)
             begin

               state<=state4;
             end
          else
              begin
             
                state<=state5;
              end
       end
  state5:
         begin
            if(Data==1)
              begin
                state<=state5;
                
              end
            else
              begin
              
                state<=state6;
              end
          end
  state6: 
           begin
              if(Data==0)
               begin
                 state<=state6;
               end
              else
                begin
                
                 read_begin<=1;
                 state<=state7;
              
              
                end
            end
      state7:
           begin
              if(Data==1)
                begin
                state<=state8;               
                end
           end
      state8:
       begin
         if(counter==50)     //50us

            begin
             counter<=0;
              state<=state9; 
            end           
          else 
             begin     
             counter<=counter+1;
             state<=state8;
           end
       end
   //////////////////    
    state9:
        begin
                 if(Data==1)                
                       begin
                        data[0]<=1;
                       
                       end
                           
                   else 
                       begin
                        data[0]<=0;   
                        end
                  state<=state12;
                  rec<=rec+1;
           end
 // ////////////////////////////////////////////       
                         
         
   state12:
        begin 
        if(rec >= 40)
        begin
        state<=state0;
        rec <= 0;
        data1<=data;
        end
        else
        begin
        data<= data<<1;
        if(Data==1)
        state<=state10;
        else
        state<=state11;
        end
        
        end
                              
  state10:
                begin
                   if(Data==1)
                      begin
                      state<=state10;              
                      end
                   else
                      begin
                      state<=state11;
                      end
                 end
                              
         state11:
               begin
                  if(Data==0)
                    begin
                      state<=state11;                
                    end
                  else
                    begin
                      state<=state8;
                    end
               end   
          default: begin state<=state0;end            
  endcase           
end
end
endmodule 