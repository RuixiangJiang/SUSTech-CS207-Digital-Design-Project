`timescale 1ns / 1ps

module ledDesign(
	input wire clk,
	input wire rst_n,
	input wire left,
	input wire right,
	input wire[2:0] state,

	output reg  ledL,
	output reg ledR
	);
	
	
parameter SEC_TIME = 32'd48_000_000;//48M
reg	[31:0]cnt;//����

//always@*
//begin
//if(rst_n==0)
//ledR<=0;
//ledL<=0;
//end

always @ (posedge clk or negedge rst_n)begin
    if(rst_n==0)//��ʼ���Ǹߵ�ƽ,�����ǵ͵�ƽ
        cnt<=0;
    else if(cnt<32'd48_000_000)
        cnt<=cnt+1;
    else//��һ��ELSE��ֹlatch
        cnt<=0;
end


always@ *
begin
	casex ({left, right,state})
	    5'bxx100: begin  ledL<=1'b1; ledR <= 1'b1; end
		5'b00101: begin  ledL<=1'b0; ledR <= 1'b0; end
		5'b11101: begin  ledL<=1'b0; ledR <= 1'b0; end
		5'b01101: begin
		        if(cnt<32'd24_000_000)//С��24 000 000-1ʱ���Ǹߵ�ƽ 
                ledR<=1;
                else//��һ��ELSE��ֹlatch//����24 000 000-1ʱ���ǵ͵�ƽ
                ledR<=0;
		       end
		5'b10101: begin
		          if(cnt<32'd24_000_000)//С��24 000 000-1ʱ���Ǹߵ�ƽ 
                  ledL<=1;
                  else//��һ��ELSE��ֹlatch//����24 000 000-1ʱ���ǵ͵�ƽ
                  ledL<=0;
		       end
	    default: begin ledL<=1'b0;ledR<=1'b0;end
	endcase
	end
endmodule

/*
set_property PACKAGE_PIN K2 [get_ports {led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN F6 [get_ports {led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
*/