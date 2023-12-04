
module led_flash
(
output reg DS_DP,//灯
input wire clk,//时钟
input wire rst//复位    连接着 KEY4
);

parameter SEC_TIME = 32'd48_000_000;//48M
reg	[31:0]cnt;//计数

always @ (posedge clk or negedge rst)begin
    if(rst==0)//初始化是高电平,按下是低电平
        cnt<=0;
    else if(cnt<32'd48_000_000)
        cnt<=cnt+1;
    else//多一个ELSE防止latch
        cnt<=0;
end

//通过移位寄存器控制IO口的高低电平，从而改变LED的显示状态
always @ (posedge clk or negedge rst)begin
    if(rst==0)//初始化是高电平,按下是低电平
        DS_DP<=0;
    else if(cnt<32'd24_000_000)//小于24 000 000-1时候，是高电平 
        DS_DP<=1;
    else//多一个ELSE防止latch//大于24 000 000-1时候，是低电平
        DS_DP<=0;
end


endmodule
