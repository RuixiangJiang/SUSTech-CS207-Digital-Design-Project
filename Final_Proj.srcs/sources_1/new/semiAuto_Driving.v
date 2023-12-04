`timescale 1ns / 1ps

module SemiAuto_Driving(
    input manual_driving,
    input semi_auto_driving,
    input auto_driving,
    input poweron,
    input go_straight_signal,
    input go_back_signal,
    input turn_left_signal,
    input turn_right_signal,
    input front_detector,
    input back_detector,
    input left_detector,
    input right_detector,
    input rst,
    input clk,
    output reg[7:0] out
    );
    wire[7:0] tmp;
    wire[2:0] command;
    
    assign tmp = {manual_driving,semi_auto_driving,auto_driving,poweron,front_detector,back_detector,left_detector,right_detector};
    assign command = {go_straight_signal,turn_left_signal,turn_right_signal};
    parameter S1 = 3'd1;
    parameter S2 = 3'd2;
    parameter S3 = 3'd3;
    parameter S4 = 3'd4;
    parameter S5 = 3'd5;
    parameter S6 = 3'd6;
    
    reg[2:0] current_state;
    reg[2:0] next_state;
    
    reg[29:0] count;
    parameter max_count = 30'd90000000;
    reg[24:0] straightcount;
    parameter max_straightcount = 25'd30000000;
    reg[24:0] backcount;
    parameter max_backcount = 25'd30000000;
    
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
    
    always @*
        begin
        case(current_state)
        S1:
            begin
            casex(tmp)
            8'b0101xxxx: next_state = S2;
            default: next_state = S1;
            endcase
            end
        S2: 
            begin
            if (straightcount < max_straightcount) next_state = S2;
            else casex(tmp)
                8'b0101xx10:next_state = S3;
                8'b0101xx01:next_state = S3;
                8'b0101xx00:next_state = S3;
                default:next_state = S2;
            endcase
            end
        S3:
            begin
            casex(tmp)
            8'b0101xxxx:
                begin
                if(go_back_signal)
                next_state = S5;
                else
                casex(command)
                3'b100: next_state = S2;
//                4'b0100: next_state = S5;
                3'b010: next_state = S4;
                3'b001: next_state = S4;
                default: next_state = S3;
                endcase
                end
            default: next_state = S3;
            endcase
            end
         S4:
            begin
            case (count)
            0:begin turnleft=turn_left_signal; turnright=turn_right_signal; next_state=S4; end
            max_count: next_state=S2;
            default: next_state=S4;
            endcase
            end
         S5:
           if (backcount < max_backcount) next_state = S5;
           else 
           casex(tmp)
                         8'b0101xx10:next_state = S3;
                         8'b0101xx01:next_state = S3;
                         8'b0101xx00:next_state = S3;
                         default:next_state = S5;
                     endcase
//        S6:
//        casex(tmp)
//                                8'b0101xx10:next_state = S3;
//                                8'b0101xx01:next_state = S3;
//                                8'b0101xx00:next_state = S3;
//                                default:next_state = S6;
//                            endcase
               default: next_state = S1;
        endcase
        end
        
        
   always @(posedge clk or negedge rst)
   begin
   if(rst==0) count<=0;
   else
    if(current_state == S4)
        begin
            if(count==max_count)
            count <= 0;
            else count <= count+1'b1;
        end
     else count<=0;
    end
    
   always @(posedge clk or negedge rst) 
   begin
     if (!rst) straightcount <= 0;
     else if (current_state == S2) straightcount <= (straightcount == max_straightcount) ? 0 : straightcount + 1'b1;
     else straightcount <= 0;
    end
   always @(posedge clk or negedge rst) 
    begin
      if (!rst) backcount <= 0;
      else if (current_state == S5) backcount <= (backcount == max_backcount) ? 0 : backcount + 1'b1;
      else backcount <= 0;
     end
    always @(*)
            begin
            case(current_state)
             S1:out = 8'b10000000;
             S2:out = 8'b10000001;
             S3:out = 8'b10000000;
             S4: begin
                  if(count==max_count) out = 8'b10000001;
                  else out = {4'b1000,turnright&~turnleft,turnleft&~turnright,2'b00};
                  end
            S5: out = 8'b10000010;
//            S6: out = 8'b10000001;
            endcase
            end
 endmodule
