`timescale 1ns / 1ps
/*
���������������

EGO1���͸�������8bit���ݣ�ǰ4bitһ�ζ�Ӧ���ֲ�����ǰ�������ˡ���ת����ת�����bitΪ��֤λ�����뱣��1����������������������
EGO1���յ���8bit���ݣ�ǰ4bit��Ӧǰ���Һ��ĸ����������źţ�ʵʱ���£���4bit��ʱû�á������к��ź���Ϊûɶ�ã�������ʱû����

*/
module uart_top(
    input clk,//ʱ������
    input rst,
    input[7:0] data_in, //��������
    output[7:0] data_rec,//����
    input rxd,  //���ݽ��� 
    output txd //���ݷ���
    ); 

wire clk_ms,clk_20ms,clk_16x,clk_x;
wire data_ready;//�����Ƿ�׼����
wire data_error;
wire send_ready;

reg send = 0;
always @(posedge clk_ms) 
    send = ~send;
    
//���÷�Ƶģ��
//clk ����ʱ��50Mhz
//clk_ms ���ʱ��1Khz
//clk_20ms ���ʱ��50Hz
//clk_x ���ʱ��9600Hz
//clk_16x ���ʱ��9600hz*16
divclk my_divclk(
    .clk(clk),
    .clk_ms(clk_ms),
    .btnclk(clk_20ms),
    .clk_16x(clk_16x),
    .clk_x(clk_x)
);

uart_tx tx(//���ô��ڷ���ģ��
    .clk_x(clk_x),
    .rst(rst),
    .data_in({1'b1,data_in[6:0]}),
    .send(send),
    .trans_done(send_ready),
    .txd(txd)
    );
uart_rx rx(
    .clk_16x(clk_16x),
    .rst(rst),
    .rxd(rxd),
    .data_rec(data_rec),
    .data_ready(data_ready),
    .data_error(data_error)
);
endmodule

//
//��Ƶģ��
/*
clk:����ʱ��100MHZ
clk_ms:���ʱ�� 1KHz
clk_20ms:���ʱ��50HZ
clk_x ���ʱ��9600HZ
clk_16x ���ʱ��9600hz*16
*/

module divclk(clk,clk_ms,btnclk,clk_16x,clk_x);
input clk;
output clk_ms,btnclk,clk_16x,clk_x;
reg[31:0] cnt1=0;
reg[31:0] cnt2=0;
reg[31:0] cnt3=0;
reg[31:0] cntclk_cnt=0;
reg clk_ms=0;
reg btnclk=0;
reg clk_16x=0;
reg clk_x=0;
always@(posedge clk)//ϵͳʱ�ӷ�Ƶ 100M/1000 = 100000   1000HZ
begin
    if(cnt1==26'd50000)
    begin
        clk_ms=~clk_ms;
        cnt1=0;
    end
    else
        cnt1=cnt1+1'b1;
end
always@(posedge clk)//20MS: 100M/50 = 2000 000   50HZ
begin
    if(cntclk_cnt==500000)
    begin
        btnclk=~btnclk;
        cntclk_cnt=0;
    end
    else
        cntclk_cnt=cntclk_cnt+1'b1;
end
always@(posedge clk)//100M/153600 = 651       9.6K*16=153.6k
begin
    if(cnt2=='d326)
    begin
        clk_16x<=~clk_16x;
        cnt2<='d0;
    end
    else
        cnt2=cnt2+1'b1;
end
always@(posedge clk)//100M/9600 = 10416.67       9600HZ
begin
    if(cnt3=='d5208)
    begin
        clk_x<=~clk_x;
        cnt3<= 0;
    end
    else
        cnt3=cnt3+1'b1;
end
endmodule

