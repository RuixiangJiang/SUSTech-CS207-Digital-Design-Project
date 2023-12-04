`timescale 1ns / 1ps
module turnRightAngle(
    input l,
    input r,
    input clk,
    output reg[2:0] turnRightAngle
    );
    reg[29:0] cnt = 0;
    parameter maxcnt = 30'd100000000;
    always @(posedge clk) begin
        if (cnt == maxcnt) begin
            turnRightAngle = 3'b100;
            cnt = maxcnt;
        end
        else begin
            turnRightAngle = {1'b0, l & ~r, r & ~l};
            cnt = cnt + 1'b1;
        end
    end
endmodule