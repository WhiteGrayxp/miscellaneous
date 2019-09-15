% 第一种NOMA方案的理论中断概率与仿真概率对比
clc;
clf;
all clear;
d1 = 15;
d2 = 30;
a = 3;        %路径损耗指数

thres = 5;      %信噪比门限
p3 = 0.15;
p33 = 0.1;
p1 = 1-p3;
p2 = 1-p33;

%产生信号
x1 = ones(1,10000);
x2 = ones(1,10000);
x3 = ones(1,10000);

%产生信道
h11 = sqrt(0.5)*(randn(1,10000)+1j*randn(1,10000));
h21 = sqrt(0.5)*(randn(1,10000)+1j*randn(1,10000));
h12 = sqrt(0.5)*(randn(1,10000)+1j*randn(1,10000));
h22 = sqrt(0.5)*(randn(1,10000)+1j*randn(1,10000));


out_total = zeros(1,30);
out_analysis = zeros(1,30);

out_total1 = zeros(1,30);
out_total2 = zeros(1,30);
out_total3 = zeros(1,30);
out_analysis1 = zeros(1,30);
out_analysis2 = zeros(1,30);
out_analysis3 = zeros(1,30);

for loop=1:30
    sigma = 10^(-loop/10)/20^a;      %噪声方差
    %仿真值
    y1 = sqrt(p1)*d1^(-0.5*a)*(h11.*x1);
    y1 = abs(y1);
    y2 = sqrt(p3)*d1^(-0.5*a)*(h11.*x3);
    y2 = abs(y2);
    out1 = sum(y1.^2<thres*(y2.^2+sigma))/10000;
    
     y3 = sqrt(p2)*d2^(-0.5*a)*(h22.*x2);
     y3 = abs(y3);
     y4 = sqrt(p33)*d2^(-0.5*a)*(h22.*x3);
     y4 = abs(y4);
    out2 = sum(y3.^2<thres*(y4.^2+sigma))/10000;
    
    y51 = sqrt(p3)*d1^(-0.5*a)*(h11.*x3);
    y52 = sqrt(p33)*d1^(-0.5*a)*(h12.*x3);
    y61 = sqrt(p3)*d2^(-0.5*a)*(h21.*x3);
    y62 = sqrt(p33)*d2^(-0.5*a)*(h22.*x3);
    y5 = (abs(y51)).^2+(abs(y52)).^2;
    y6 = (abs(y61)).^2+(abs(y62)).^2;
    out3 = sum(y5<thres*(sigma))/10000+sum(y6<thres*(sigma))/10000;
    
    out_total(loop) = out1+out2+out3;
    
    %理论值
    p_total1 = 1 - exp(sigma*thres*d1^a/(thres*p3-p1));
    p_total2 = 1 - exp(sigma*thres*d2^a/(thres*p33-p2));
    p_total3 = 2 - 1/(p3-p33)*(p3*(exp(-sigma*thres*d1^a/p3) + exp(-sigma*thres*d2^a/p3)) - p33*(exp(-sigma*thres*d1^a/p33) + exp(-sigma*thres*d2^a/p33)));
    out_analysis(loop) = p_total1 + p_total2 +p_total3;
    
    out_total1(loop) = out1;
    out_total2(loop) = out2;
    out_total3(loop) = out3;
    out_analysis1(loop) = p_total1;
    out_analysis2(loop) = p_total2;
    out_analysis3(loop) = p_total3;
end

figure(1);
semilogy(out_total,'*'),hold on;
semilogy(out_analysis,'r');
legend('Simulation','Analysis');
ylabel('Outage probability');
xlabel('SNR');

figure(2);
subplot(3,1,1);
semilogy(out_total1,'*'),hold on;
semilogy(out_analysis1,'r');
subplot(3,1,2);
semilogy(out_total2,'*'),hold on;
semilogy(out_analysis2,'r');
subplot(3,1,3);
semilogy(out_total3,'*'),hold on;
semilogy(out_analysis3,'r');
