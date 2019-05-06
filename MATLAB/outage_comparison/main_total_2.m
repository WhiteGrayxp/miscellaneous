clc;
clf;
clear;
% 中断概率的总对比分析
p3 = 0.1;
p33 = 0.15;
p1 = 1-p3;
p2 = 1-p33;
n = 1.5;
thres = (2^n-1)/0.396;
d1 = 20;
d2 = 40;
a = 3;
b = 0.1;        % 残留误差系数
% 不考虑SIC误差
outage_theo11 = zeros(8,1);  %理论中断概率
outage_theo13 = zeros(8,1);
outage_theo22 = zeros(8,1);
outage_theo23 = zeros(8,1);

outage_simu11 = zeros(8,1);  %仿真中断概率
outage_simu13 = zeros(8,1);
outage_simu22 = zeros(8,1);
outage_simu23 = zeros(8,1);


outage_asym11 = zeros(8,1);  %渐进中断概率
outage_asym13 = zeros(8,1);
outage_asym22 = zeros(8,1);
outage_asym23 = zeros(8,1);

% 考虑SIC误差
% ipSIC按照复杂情况考虑
outage_simu13_ip = zeros(8,1);
outage_simu23_ip = zeros(8,1);
outage_theo13_ip = zeros(8,1);
outage_theo23_ip = zeros(8,1);
outage_asym13_ip = zeros(8,1);
outage_asym23_ip = zeros(8,1);
x_axis = zeros(8,1);

for i = 1:10
    for loop = 1:8
        SNR = loop*5+40;
        sigma = 10^(-SNR/10);
        x_axis(loop) = SNR;

        % 理论中断概率
        outage_theo11(loop) = outage_theo11(loop)+ 1 - exp(sigma*thres*d1^a/(thres*p3-p1));
        outage_theo22(loop) = outage_theo22(loop)+ 1 - exp(sigma*thres*d2^a/(thres*p33-p2));
        outage_theo13(loop) = outage_theo13(loop)+ 1 - 1/(p3-p33)*(p3*exp(-sigma*thres*d1^a/p3) - p33*exp(-sigma*thres*d1^a/p33));
        outage_theo23(loop) = outage_theo23(loop)+ 1 - 1/(p3-p33)*(p3*exp(-sigma*thres*d2^a/p3) - p33*exp(-sigma*thres*d2^a/p33));
        % 渐进中断概率
        outage_asym11(loop) = outage_asym11(loop)+ thres*d1^a*sigma/(1-p3-thres*p3);
        outage_asym22(loop) = outage_asym22(loop)+ thres*d2^a*sigma/(1-p33-thres*p33);
        outage_asym13(loop) = outage_asym13(loop)+ 0.5*(thres*d1^a*sigma/p3)*(thres*d1^a*sigma/p33);
        outage_asym23(loop) = outage_asym23(loop)+ 0.5*(thres*d2^a*sigma/p3)*(thres*d2^a*sigma/p33);
        % 仿真中断概率
        %产生信号
        x1 = ones(1,1000000);
        x2 = ones(1,1000000);
        x3 = ones(1,1000000);

        %产生信道
        h11 = sqrt(0.5)*(randn(1,1000000)+1j*randn(1,1000000));
        h21 = sqrt(0.5)*(randn(1,1000000)+1j*randn(1,1000000));
        h12 = sqrt(0.5)*(randn(1,1000000)+1j*randn(1,1000000));
        h22 = sqrt(0.5)*(randn(1,1000000)+1j*randn(1,1000000));

        y1 = sqrt(p1)*d1^(-0.5*a)*(h11.*x1);
        y1 = abs(y1).^2;
        y2 = sqrt(p3)*d1^(-0.5*a)*(h11.*x3);
        y2 = abs(y2).^2;
        outage_simu11(loop) = outage_simu11(loop)+ sum(y1<thres*(y2+sigma))/1000000;

         y3 = sqrt(p2)*d2^(-0.5*a)*(h22.*x2);
         y3 = abs(y3).^2;
         y4 = sqrt(p33)*d2^(-0.5*a)*(h22.*x3);
         y4 = abs(y4).^2;
        outage_simu22(loop) = outage_simu22(loop)+ sum(y3<thres*(y4+sigma))/1000000;

        y51 = sqrt(p3)*d1^(-0.5*a)*(h11.*x3);
        y52 = sqrt(p33)*d1^(-0.5*a)*(h12.*x3);
        y61 = sqrt(p3)*d2^(-0.5*a)*(h21.*x3);
        y62 = sqrt(p33)*d2^(-0.5*a)*(h22.*x3);
        y5 = (abs(y51)).^2+(abs(y52)).^2;
        y6 = (abs(y61)).^2+(abs(y62)).^2;
        
        y7 = sqrt(p2)*d1^(-0.5*a)*(h12.*x2);
        y8 = sqrt(p1)*d2^(-0.5*a)*(h21.*x1);
        y7 = abs(y7).^2;
        y8 = abs(y8).^2;
        outage_simu13(loop) = outage_simu13(loop)+ sum(y5<thres*(sigma))/1000000;
        outage_simu23(loop) = outage_simu23(loop)+ sum(y6<thres*(sigma))/1000000;

        % imperfect SIC
        c = p3 - thres*b^2*p1;
        d = p33 - thres*b^2*p2;
        outage_theo13_ip(loop) = outage_theo13_ip(loop) + 1 - (c*exp(-1*thres*d1^a*sigma/c) - d*exp(-1*thres*d1^a*sigma/d))/(c-d);
        outage_theo23_ip(loop) = outage_theo23_ip(loop) + 1 - (c*exp(-1*thres*d2^a*sigma/c) - d*exp(-1*thres*d2^a*sigma/d))/(c-d);
        outage_simu13_ip_temp = sum(y5<thres*(sigma+b^2*(y1+y7)))/1000000;
        outage_simu23_ip_temp = sum(y6<thres*(sigma+b^2*(y3+y8)))/1000000;
        outage_simu13_ip(loop) = outage_simu13_ip(loop) + outage_simu13_ip_temp;
        outage_simu23_ip(loop) = outage_simu23_ip(loop) + outage_simu23_ip_temp;
        
        outage_asym13_ip(loop) = outage_asym13_ip(loop) + (thres*d1^a*sigma)^2/(2*c*d);
        outage_asym23_ip(loop) = outage_asym23_ip(loop) + (thres*d2^a*sigma)^2/(2*c*d);
    end
end

figure(1);
semilogy(x_axis,outage_theo11/10,'r-','LineWidth',1,'MarkerSize',10),hold on;grid on;
semilogy(x_axis,outage_simu11/10,'ro','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_asym11/10,'b--d','LineWidth',1,'MarkerSize',10);
legend('Analysis','Simulation','Asymptotic','Fontname','Times New Roman');
xlabel('Transmitter SNR (dB)','Fontname','Times New Roman');
ylabel('Outage Probability','Fontname','Times New Roman');


figure(2);
semilogy(x_axis,outage_theo22/10,'r-','LineWidth',1,'MarkerSize',10),hold on;grid on;
semilogy(x_axis,outage_simu22/10,'ro','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_asym22/10,'b--d','LineWidth',1,'MarkerSize',10);
legend('Analysis','Simulation','Asymptotic','Fontname','Times New Roman');
xlabel('Transmitter SNR (dB)','Fontname','Times New Roman');
ylabel('Outage Probability','Fontname','Times New Roman');


figure(3);
semilogy(x_axis,outage_theo13/10,'r-','LineWidth',1,'MarkerSize',10),hold on;grid on;
semilogy(x_axis,outage_simu13/10,'rd','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_asym13/10,'b--o','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_theo13_ip/10,'k-','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_simu13_ip/10,'k+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_asym13_ip/10,'b--s','LineWidth',1,'MarkerSize',10);
legend('Analysis-pSIC','Simulation-pSIC','Asymptotic-pSIC','Analysis-ipSIC','Simulation-ipSIC','Asymptotic-ipSIC','Fontname','Times New Roman');
xlabel('Transmitter SNR (dB)','Fontname','Times New Roman');
ylabel('Outage Probability','Fontname','Times New Roman');

figure(4);
semilogy(x_axis,outage_theo23/10,'r-','LineWidth',1,'MarkerSize',10),hold on;grid on;
semilogy(x_axis,outage_simu23/10,'rd','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_asym23/10,'b--o','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_theo23_ip/10,'k-','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_simu23_ip/10,'k+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_asym23_ip/10,'b--s','LineWidth',1,'MarkerSize',10);
legend('Analysis-pSIC','Simulation-pSIC','Asymptotic-pSIC','Analysis-ipSIC','Simulation-ipSIC','Asymptotic-ipSIC','Fontname','Times New Roman');
xlabel('Transmitter SNR (dB)','Fontname','Times New Roman');
ylabel('Outage Probability','Fontname','Times New Roman');


