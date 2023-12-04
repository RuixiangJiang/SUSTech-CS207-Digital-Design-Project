`timescale 1ns / 1ps

module SimulatedDevice(
    input sys_clk, //bind to P17 pin (100MHz system clock)
    input rx, //bind to N5 pin
    output tx, //bind to T4 pin
    input manual_driving,
    input semi_auto_driving,
    input auto_driving,
    input turn_left_signal,
    input turn_right_signal,
    input go_straight_signal,
    input move_forward_signal,
    input move_backward_signal,
    input place_barrier_signal,
    input destroy_barrier_signal,
    input Poweron_signal,
    input clutch_signal,
    input throttle_signal,
    input brake_signal,
    input Poweroff_signal,
    input rst,
    
    output front_detector,
    output left_detector,
    output right_detector,
    output back_detector,
    output Led_power,
    output ledL,
    output ledR,
    output[7:0] seg,
    output[7:0] seg1,
    output[7:0] an,
    output beep
    );
   wire[7:0] out1;
   wire[7:0] out2;
   wire[7:0] out3;
   
   wire clk_div;
   
   song us(
   sys_clk,
   beep
   );
  
   
   
   wire PowerState;
   wire ledL_on;
   wire ledR_on;
   wire [2:0] state;
       
        ledPower up(
        sys_clk,
        rst,
        Poweron_signal,
        Poweroff_signal,
        PowerState
        );
       assign Led_power = PowerState;
  
        
    Manual_driving u1(
    manual_driving,
    semi_auto_driving,
    auto_driving,
    turn_left_signal,
    turn_right_signal,
    move_forward_signal,
    move_backward_signal,
    clutch_signal,
    throttle_signal,
    brake_signal,
    sys_clk,
    rst,
    PowerState,
    out1,
    state,
    seg,
    seg1,
    an
    );
        
    ledDesign uled(
    sys_clk,
    rst,
    out1[3],
    out1[2],
    state,
    ledL_on,
    ledR_on
    );
    assign ledL = ledL_on;
    assign ledR = ledR_on;
    
//    wire [7:0] in = {2'b10, destroy_barrier_signal, place_barrier_signal,turn_right_signal, turn_left_signal, move_backward_signal, move_forward_signal};
    
    wire [7:0] rec;
    
    assign front_detector = rec[0];
    assign left_detector = rec[1];
    assign right_detector = rec[2];
    assign back_detector = rec[3];
    
    
    SemiAuto_Driving u2(
    manual_driving,
    semi_auto_driving,
    auto_driving,
    PowerState,
    go_straight_signal,
    move_backward_signal,
    turn_left_signal,
    turn_right_signal,
    front_detector,
    back_detector,
    left_detector,
    right_detector,
    rst,
    sys_clk,
    out2
    );
   
    Auto_Driving u3(
    manual_driving,
    semi_auto_driving,
    auto_driving,
    PowerState,
    place_barrier_signal,
    destroy_barrier_signal,
    front_detector,
    back_detector,
    left_detector,
    right_detector,
    rst,
    sys_clk,
    out3
    );
    
    reg [7:0] in;
    
    always@*
    begin
    case({manual_driving,semi_auto_driving,auto_driving})
    3'b100:  in = out1;
    3'b010:  in = out2;
    3'b001:  in = out3;
    default: in = 8'b10000000;
    endcase
    end
    uart_top md(.clk(sys_clk), .rst(0), .data_in(in), .data_rec(rec), .rxd(rx), .txd(tx));
endmodule