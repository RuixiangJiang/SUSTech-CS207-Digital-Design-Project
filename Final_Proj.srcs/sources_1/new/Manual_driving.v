`timescale 1ns / 1ps

module Manual_driving(
    input manual_driving,
    input semi_auto_driving,
    input auto_driving,
    input turn_left_signal,
    input turn_right_signal,
    input move_forward_signal,
    input move_backward_signal,
    input clutch_signal,
    input throttle_signal,
    input brake_signal,
    input clk,
    input Rst_n,
    input poweron_signal,
    output reg[7:0] out,
    output reg[2:0] state,
    output wire[7:0] seg,
    output wire[7:0] seg1,
    output wire[7:0] an
    );  
  

//    parameter S0 = 3'd0;
    parameter STOP1 = 3'd0;
    parameter STOP2 = 3'd6;
    parameter S1 = 3'd1;
    parameter S2 = 3'd2;
    parameter S3 = 3'd3;
    parameter S4 = 3'd4;
    parameter S5 = 3'd5;

    reg[2:0] current_state;
    reg[2:0] next_state;
//    reg flag;
//    reg[7:0] out;

    wire backchange_signal;
    Edge_detect backchange(clk,Rst_n,move_backward_signal,backchange_signal);

    always @ (posedge clk or negedge Rst_n) begin
        if(!Rst_n) 
        begin
          current_state <= S1;
        end
        else 
          current_state <= next_state;
    end
    
    
    wire[7:0] tmp;
    assign tmp= {manual_driving,semi_auto_driving,auto_driving,poweron_signal,throttle_signal,brake_signal,clutch_signal,backchange_signal};
    always @*
    begin
    case(current_state)
//    S0:
//        begin
//        casex({tmp})
//        8'bxxx0xxxx: next_state = S1;
//        default: next_state = S0;
//        endcase
//        flag=0;
//        end
    S1:
        begin
        casex({tmp})
        8'bxxx1xxxx: next_state = S2;
        default: next_state = S1; 
        endcase 
        end
    S2: 
        begin
        casex({tmp})
        8'bxxx0xxxx: next_state = S1;
        8'b1001xxxx: next_state = S3;
        default: next_state = S2;
        endcase
        end
    S3:
        begin
        casex({tmp})
        8'bxxx0xxxx: next_state = S1;
        8'b1001101x: next_state = S4;
        8'b10011x0x: next_state = STOP1;
        default: next_state = S3;
        endcase
        end
    S4:
        begin
        casex({tmp})
        8'bxxx0xxxx: next_state = S1;
        8'b1001x1xx: next_state = S3;
        8'b1001100x: next_state = S5;
        default: next_state = S4;
        endcase
        end
    S5:
        begin
        casex({tmp})
        8'bxxx0xxxx: next_state = S1;
        8'b1001xx01: next_state = STOP1;
        8'b1001000x: next_state = S4;
        8'b1001001x: next_state = S4;
        8'b1001011x: next_state = S4;
        8'b10011x1x: next_state = S5;
        8'b10010x1x: next_state = S4;
        default: next_state = S5;
    STOP1:
        begin
        casex({tmp})
        8'bxxx0xxxx: next_state = STOP2;
        8'bxxx1xxxx: next_state = STOP1;
        endcase
        end
    STOP2:
        begin
        casex({tmp})
        8'bxxx1xxxx: next_state = S1;
        default: next_state = STOP2;
        endcase
        end
        endcase
        end
    default: next_state = S1;
    endcase
    end
  
    
    
    CountDesign(
    clk,
    Rst_n,
    1'b1,
    1'b1,
    seg,
    seg1,
    an
    );
    
//    always@(*)
//    begin
//    case(poweron_signal)
//    1'b1: begin seg = tmpseg;seg1 = tmpseg1;an = tmpan;end
//    endcase
//    end

    always @(*)
    begin
    case(current_state)
//        S0: begin out =  8'b10000000;  end
//        S1:  out = {4'b1000, 1'b1, turn_left_signal, move_backward_signal, move_forward_signal}; 
//        S2:  out = 8'b10000000; 
//        S3:  out ={4'b1000, turn_right_signal, 1'b1, move_backward_signal,move_forward_signal};
//        S4:  out = {4'b1000, turn_right_signal, turn_left_signal, move_backward_signal, 1'b1}; 
//        S5:  out = {4'b1000, turn_right_signal, turn_left_signal, move_backward_signal, move_forward_signal};
        STOP1:begin out = 8'b10000000;state = STOP1;end
        STOP2:begin out = 8'b10000000;state = STOP2;end
        S1:begin out = 8'b10000000;state = S1;end
        S2:begin out = 8'b10000000;state = S2;end
        S3:begin out = 8'b10000000;state = S3;end
        S4:begin out = 8'b10000000;state = S4;end
        S5:begin out = {4'b1000, turn_right_signal, turn_left_signal, move_backward_signal, move_forward_signal&!brake_signal&!move_backward_signal};state = S5;end
    endcase
    end
    endmodule