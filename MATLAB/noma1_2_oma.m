all clear;
clc;
clf;
d1 = 15;
d2 = 30;
a = 3;
thres = 5;
% 分别调用函数NOMA1_outage，NOMA2_outage和OMA_outage计算相应信噪比下最小中断概率
% 及功率分配
x_axis = zeros(1,30);
out_noma_1 = zeros(1,30);
out_noma_2 = zeros(1,30);
out_oma_1 = zeros(1,30);    %对应NOMA1功率分配
out_oma_2 = zeros(1,30);    %对应NOMA2功率分配
position1 = zeros(1,4);     %对应NOMA1功率分配
position2 = zeros(1,4);     %对应NOMA2功率分配
for loop = 51:80
    %横坐标
    x_axis(loop-50) = loop;
    sigma= 10^(-loop/10);  %发射机信噪比为51dB到80dB
    [outage1,position1(1,3:4)] = NOMA1_outage(sigma,d1,d2,a,thres);
    [outage2,position2(1,1:2)] = NOMA2_outage(sigma,d1,d2,a,thres);
    position1(1) = 1 - position1(3);
    position1(2) = 1 - position1(4);
    position2(3) = 1;
    position2(4) = 1;
    outage3 = OMA_outage(sigma,d1,d2,a,thres,position1);
    outage4 = OMA_outage(sigma,d1,d2,a,thres,position2);
    
    out_noma_1(loop-50) = outage1;
    out_noma_2(loop-50) = outage2;
    out_oma_1(loop-50) = outage3;
    out_oma_2(loop-50) = outage4;
end
semilogy(x_axis,out_noma_1,'b'),hold on;
semilogy(x_axis,out_noma_2,'r');
semilogy(x_axis,out_oma_1,'b-*');
semilogy(x_axis,out_oma_2,'r-*');
legend('NOMA1','NOMA2','OMA1','OMA2');
ylabel('Outage probability');
xlabel('SNR');
    