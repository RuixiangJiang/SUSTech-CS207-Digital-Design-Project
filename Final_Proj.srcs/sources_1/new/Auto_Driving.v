`timescale 1ns / 1ps

module Auto_Driving(
    input manual_driving,
    input semi_auto_driving,
    input auto_driving,
    input poweron,
    input place_barrier_signal,
    input destroy_barrier_signal,
    input front_detector,
    input back_detector,
    input left_detector,
    input right_detector,
    input rst,
    input clk,
    output reg[7:0] out,
    output[7:0] seg,
    output[7:0] seg1,
    output[7:0] an
    );
    wire[7:0] tmp;
    parameter S0 = 3'd0;
    parameter S1 = 3'd1;
    parameter S2 = 3'd2;
    parameter S3 = 3'd3;
    parameter S4 = 3'd4;
    parameter S5 = 3'd5;
    parameter S6 = 3'd6;
    parameter S7 = 3'd7;
    
    reg trig11,trig12,trig13,trig21,trig22,trig23,trig31,trig32,trig33,trig41,trig42,trig43;
    wire pos1,neg1,pos2,neg2,pos3,neg3,pos4,neg4;
    
    
    always @(posedge clk, negedge rst)
    if(!rst)
    {trig11,trig12,trig13} <= 3'b000;
    else begin
    trig11 <= front_detector;
    trig12 <= trig11;
    trig13 <= trig12;
    end
    assign pos1 = (~trig13) & trig12;
    assign neg1 = trig13 & (~trig12);
    always @(posedge clk, negedge rst)
    if(!rst)
    {trig21,trig22,trig23} <= 3'b000;
    else begin
    trig21 <= left_detector;
    trig22 <= trig21;
    trig23 <= trig22;
    end
    assign pos2 = (~trig23) & trig22;
    assign neg2 = trig23 & (~trig22);
    
    always @(posedge clk, negedge rst)
    if(!rst)
    {trig31,trig32,trig33} <= 3'b000;
    else begin
    trig31 <= right_detector;
    trig32 <= trig31;
    trig33 <= trig32;
    end
    assign pos3 = (~trig33) & trig32;
    assign neg3 = trig33 & (~trig32);
    
    always @(posedge clk, negedge rst)
    if(!rst)
    {trig41,trig42,trig43} <= 3'b000;
    else begin
    trig41 <= back_detector;
    trig42 <= trig41;
    trig43 <= trig42;
    end
    assign pos4 = (~trig43) & trig42;
    assign neg4 = trig43 & (~trig42);
  
        reg[2:0] current_state;
        reg[2:0] next_state;
        
        reg[29:0] cnt;
        parameter max_cnt = 30'd90000000;
        
        reg[29:0] count;
        parameter max_count = 30'd90000000;
        reg[29:0] count2;
        parameter max_count2 = 30'd180000000;
        
        reg[25:0] straightcount;
        parameter max_straightcount = 26'd30000000;
        
        reg turnleft;
        reg turnright;
        
        always @ (posedge clk or negedge rst) begin
            if(~rst) 
            begin
              current_state <= S1;
            end
            else 
              current_state <= next_state;
        end

    assign tmp = {manual_driving,semi_auto_driving,auto_driving,poweron,front_detector,back_detector,left_detector,right_detector};
   always @(neg1 or neg2 or neg3 or neg4) begin
            case (current_state)
                S0://放置障碍
                    begin
                        next_state = S2;
                    end
                S1://初始状态
                    begin
                        casex (tmp)
                            8'b0011xxxx: next_state = S2;
                            default: next_state = S1;
                        endcase
                    end
                S2://直行
                    begin
                    if (straightcount < max_straightcount) next_state = S2;
                    else
                    next_state = (front_detector == 1'b1 || left_detector + right_detector <= 2'b1) ? S3 : S2;
                    end
                S3://决定走哪条路
                   begin
                   if (cnt < max_cnt) next_state = S3;
                   else casex (tmp)
                        8'b0011xxx0: next_state = S4;
                        8'b0011xx01: next_state = S5;
                        8'b00110x11: next_state = S2;
                        8'b00111x11: next_state = S6;
                        default: next_state = S1;
                        endcase
                        end
                S4://右转
                   begin
                   next_state = (count == max_count) ? S2 : S4;
                   end
               S5://左转
                  begin
                  next_state = (count == max_count) ? S2 : S5;
                  end
              S6://180
                 begin
                 next_state = (count2 == max_count2) ? S2 : S6;
                 end
//             S7://转弯后前进一格放障碍
//                 begin
//                 next_state = (straightcount < max_straightcount) ? S2 : S0;
//                 end
              default: next_state = S1;
              endcase
              end
        

         

       always @(posedge clk or negedge rst)
       begin
       if(rst==0) count<=0;
       else
        if(current_state == S4||current_state == S5)
            begin
                if(count==max_count)
                count <= 0;
                else count <= count+1'b1;
            end
         else count<=0;
        end
      
       always @(posedge clk or negedge rst)
        begin
        if(rst==0) count2<=0;
        else
         if(current_state == S6)
             begin
                 if(count2==max_count2)
                 count2 <= 0;
                 else count2 <= count2+1'b1;
             end
          else count2<=0;
         end
         
       always @(posedge clk or negedge rst)
          begin
          if(rst==0) cnt<=0;
          else
           if(current_state == S3)
               begin
                   if(cnt==max_cnt)
                   cnt <= 0;
                   else cnt <= cnt+1'b1;
               end
            else cnt<=0;
           end
        
        
        
       always @(posedge clk or negedge rst) 
       begin
         if (!rst) straightcount <= 0;
         else if (current_state == S2) straightcount <= (straightcount == max_straightcount) ? 0 : straightcount + 1'b1;
         else straightcount <= 0;
        end
       
         always @(*) begin
              case(current_state)
                  S0: out = 8'b10010000;
                  S1: out = 8'b10000000;
                  S2: out = 8'b10000001;
                  S3: out = 8'b10000000;
                  S4: out = (count == max_count) ? 8'b10000000 : 8'b10001000;
                  S5: out = (count == max_count) ? 8'b10000000 : 8'b10000100;
                  S6: out = (count2 == max_count2) ? 8'b10000000 : 8'b10000100;
//                  S7: out = 8'b10000001;
                  default: out = 8'b10000000;
              endcase
          end
          
          
          
             reg[7:0] seg = 0;
             reg[7:0] seg1 = 0;
             reg[7:0] an = 8'b00000001;
             reg[3:0] res;
             always @(current_state)
                 case (current_state)
                     S0: res = 4'd0;
                     S1: res = 4'd1;
                     S2: res = 4'd2;
                     S3: res = 4'd3;
                     S4: res = 4'd4;
                     S5: res = 4'd5;
                     S6: res = 4'd6;
                     S7: res = 4'd7;
                 endcase
             always @(res)
                 case (res)
                     4'h0 : seg1 = 8'hfc;
                     4'h1 : seg1 = 8'h60;
                     4'h2 : seg1 = 8'hda;
                     4'h3 : seg1 = 8'hf2;
                     4'h4 : seg1 = 8'h66;
                     4'h5 : seg1 = 8'hb6;
                     4'h6 : seg1 = 8'hbe;
                     4'h7 : seg1 = 8'he0;
                     4'h8 : seg1 = 8'hfe;
                     4'h9 : seg1 = 8'hf6;
                     4'ha : seg1 = 8'hee;
                     4'hb : seg1 = 8'h3e;
                     4'hc : seg1 = 8'h9c;
                     4'hd : seg1 = 8'h7a;
                     4'he : seg1 = 8'h9e;
                     4'hf : seg1 = 8'h8e;
                 endcase
          
          
          
          
          
          
endmodule
