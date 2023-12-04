module Edge_detect(clk,rst_n,data,data_edge);
        input       clk;
	    input       rst_n;
		input       data; 
		output      data_edge;  //数据�?
        wire pos_edge;
        wire neg_edge;    
     	reg[1:0] data_r;
	//设置两个寄存器，实现前后电平状�?�的寄存
	//相当于对dat_i 打两�?
	always @(posedge clk or negedge rst_n)begin
	    if(rst_n == 1'b0)begin
	        data_r <= 2'b00;
	    end
	    else begin
	        data_r <= {data_r[0], data};    //{前一状�?�，后一状�?�}  
	    end
	end
	//组合逻辑进行边沿�?�?
	assign  pos_edge = ~data_r[1] & data_r[0];
	assign  neg_edge = data_r[1] & ~data_r[0];
	assign  data_edge = pos_edge | neg_edge;
endmodule
