`timescale 1ns / 1ps

module power_on(
input clk_i,
input rst_n_i,
input key_i,
output poweron
);
(*mark_debug = "true"*) reg poweron;
(*mark_debug = "true"*) wire key_cap;
always @(posedge clk_i)
begin
	if(!rst_n_i)
		begin
			poweron <= 1'b0;
		end
	else 
		if(key_cap)
			begin
				poweron <= ~poweron;
			end
end
key1000#(
	.CLK_FREQ(100000000))key0
	(
	.clk_i(clk_i),
	.key_i(key_i),
	.key_cap(key_cap)
	);
endmodule
