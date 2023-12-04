
module led_flash
(
output reg DS_DP,//��
input wire clk,//ʱ��
input wire rst//��λ    ������ KEY4
);

parameter SEC_TIME = 32'd48_000_000;//48M
reg	[31:0]cnt;//����

always @ (posedge clk or negedge rst)begin
    if(rst==0)//��ʼ���Ǹߵ�ƽ,�����ǵ͵�ƽ
        cnt<=0;
    else if(cnt<32'd48_000_000)
        cnt<=cnt+1;
    else//��һ��ELSE��ֹlatch
        cnt<=0;
end

//ͨ����λ�Ĵ�������IO�ڵĸߵ͵�ƽ���Ӷ��ı�LED����ʾ״̬
always @ (posedge clk or negedge rst)begin
    if(rst==0)//��ʼ���Ǹߵ�ƽ,�����ǵ͵�ƽ
        DS_DP<=0;
    else if(cnt<32'd24_000_000)//С��24 000 000-1ʱ���Ǹߵ�ƽ 
        DS_DP<=1;
    else//��һ��ELSE��ֹlatch//����24 000 000-1ʱ���ǵ͵�ƽ
        DS_DP<=0;
end


endmodule
