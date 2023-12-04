`timescale 1ns / 1ps

module power_off(
input clk_i,
input rst_n_i,
input key_i,
output poweroff
);

(*mark_debug = "true"*) reg poweroff;
(*mark_debug = "true"*) wire key_cap;
always @(posedge clk_i)
begin
	if(!rst_n_i)
		begin
			poweroff <= 1'b0;
		end
	else 
		if(key_cap)
			begin
				poweroff <= ~poweroff;
			end
end
key#(
	.CLK_FREQ(100000000))key0
	(
	.clk_i(clk_i),
	.key_i(key_i),
	.key_cap(key_cap)
	);
endmodule
