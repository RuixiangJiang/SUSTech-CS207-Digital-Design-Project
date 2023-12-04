`timescale 1ns / 1ps
module ledPower(
input clk,
input rst,
input on,
input off,
output led
    );
    
reg [29:0] cnt;
parameter cntmax = 30'd100000000;

always @(posedge clk or negedge rst) begin
    if (~rst) cnt <= 0;
    else if (off) cnt <= 0;
    else if (on) begin
        if (cnt == cntmax) cnt <= cntmax;
        else cnt <= cnt + 1'd1;
    end
end
assign led = (cnt == cntmax);
endmodule
