`timescale 1ns / 1ps

module manualTB();
    reg rst;
    reg clk;
    reg left;
    reg right;
    reg forward;
    reg backward;
    reg clutch;
    reg throttle;
    reg brake;
    reg powerOn;
    reg powerOff;
    wire [7:0] outTB;

    Manual_driving manual(
        .manual_driving(1),
        .semi_auto_driving(0),
        .auto_driving(0),
        .turn_left_signal(left),
        .turn_right_signal(right),
        .move_forward_signal(forward),
        .move_backward_signal(backward),

        .clutch_signal(clutch),
        .throttle_signal(throttle),
        .brake_signal(brake),
        .clk(clk),
        .Rst_n(rst),
        .poweron_signal(powerOn),
        .poweroff_signal(powerOff),
        .out(outTB)
    );

    initial begin
        clk<=1;
        rst<=1;
        powerOn<=0;
        powerOff<=1;
        left<=0;
        right<=0;
        forward<=0;
        backward<=0;
        clutch<=0;
        throttle<=0;
        brake<=0;
        #100 powerOn<=1;powerOff<=0;//S1->S2->S3
        #200 throttle<=1;brake<=0;clutch<=1;//S3->S4
        #300 throttle<=1;brake<=0;clutch<=0;//S4->S5
        #400 throttle<=0;//S5->S4
        #500 brake<=1;//S4->S3
        #600 throttle<=1;brake<=0;clutch<=1;//S3->S4
        #700 throttle<=1;brake<=0;clutch<=0;//S4->S5
        #800 backward<=1;clutch<=0;//S5->S0
        #900 powerOff<=1;powerOn<=0;//S0->S1
        #1000000000 $finish;
    end
    always #5 clk<=~clk;
    always #10 left<=~left;
    always #20 right<=~right;
    always #30 forward<=~forward;
    always #40 backward<=~backward;

endmodule