clc;
clf;
clear;
% 中断概率的总对比分析

p1 = 0.1;
p2 = 0.9;
thres = 4.59;
d1 = 20;
d2 = 40;
a = 3;
b = 0.1;        % 残留误差系数
% 不考虑SIC误差
outage_theo11 = zeros(8,1);  %理论中断概率
outage_theo22 = zeros(8,1);

outage_simu11 = zeros(8,1);  %仿真中断概率
outage_simu22 = zeros(8,1);


outage_asym11 = zeros(8,1);  %渐进中断概率
outage_asym22 = zeros(8,1);

% 考虑SIC误差
% ipSIC按照复杂情况考虑
outage_simu11_ip = zeros(8,1);
outage_theo11_ip = zeros(8,1);
outage_asym11_ip = zeros(8,1);
x_axis = zeros(8,1);

for i = 1:10
    for loop = 1:8
        SNR = loop*5+40;
        sigma = 10^(-SNR/10);
        x_axis(loop) = SNR;

        % 理论中断概率
        outage_theo11(loop) = outage_theo11(loop)+ 1 - exp(sigma*thres*d1^a/(-p1));
        outage_theo22(loop) = outage_theo22(loop)+ 1 - exp(sigma*thres*d2^a/(thres*p1-p2));
        
        % 渐进中断概率
        outage_asym11(loop) = outage_asym11(loop)+ sigma*thres*d1^a/p1;
        outage_asym22(loop) = outage_asym22(loop)+ sigma*thres*d2^a/(p2-thres*p1);
        
        % 仿真中断概率
        %产生信号
        x1 = ones(1,1000000);
        x2 = ones(1,1000000);

        %产生信道
        h11 = sqrt(0.5)*(randn(1,1000000)+1j*randn(1,1000000));
        h21 = sqrt(0.5)*(randn(1,1000000)+1j*randn(1,1000000));

        y11 = sqrt(p1)*d1^(-0.5*a)*(h11.*x1);
        y11 = abs(y11).^2;
        y21 = sqrt(p1)*d2^(-0.5*a)*(h21.*x1);
        y21 = abs(y21).^2;
        y2 = sqrt(p2)*d2^(-0.5*a)*(h21.*x2);
        y2 = abs(y2).^2;
        outage_simu11(loop) = outage_simu11(loop)+ sum(y11<thres*sigma)/1000000;
        outage_simu22(loop) = outage_simu22(loop)+ sum(y2<thres*(y21+sigma))/1000000;

       
        % imperfect SIC
        ytemp = b*sqrt(p2)*d1^(-0.5*a)*(h11.*x2);
        ytemp = abs(ytemp).^2;
        
        outage_theo11_ip(loop) = outage_theo11_ip(loop) + 1 - exp(sigma*thres*d1^a/(thres*b^2-p1*(1+thres*b^2)));
        outage_simu11_ip_temp = sum(y11<thres*(ytemp+sigma))/1000000;
        outage_simu11_ip(loop) = outage_simu11_ip(loop) + outage_simu11_ip_temp;
        outage_asym11_ip(loop) = outage_asym11_ip(loop) - sigma*thres*d1^a/(thres*b^2-p1*(1+thres*b^2));
    end
end

figure(1);
semilogy(x_axis,outage_theo11/10,'r-','LineWidth',1,'MarkerSize',10),hold on;grid on;
semilogy(x_axis,outage_simu11/10,'rd','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_asym11/10,'b--o','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_theo11_ip/10,'k-','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_simu11_ip/10,'k+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_asym11_ip/10,'b--s','LineWidth',1,'MarkerSize',10);
legend('Analysis, pSIC','Simulation, pSIC','Asymptotic, pSIC','Analysis, ipSIC','Simulation, ipSIC','Asymptotic, ipSIC','Fontname','Times New Roman');
xlabel('Transmitter SNR (dB)','Fontname','Times New Roman');
ylabel('Outage Probability','Fontname','Times New Roman');
set(gca,'FontSize',14,'Fontname', 'Times New Roman');


figure(2);
semilogy(x_axis,outage_theo22/10,'r-','LineWidth',1,'MarkerSize',10),hold on;grid on;
semilogy(x_axis,outage_simu22/10,'ro','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,outage_asym22/10,'b--d','LineWidth',1,'MarkerSize',10);
legend('Analysis','Simulation','Asymptotic','Fontname','Times New Roman');
xlabel('Transmitter SNR (dB)','Fontname','Times New Roman');
ylabel('Outage Probability','Fontname','Times New Roman');
set(gca,'FontSize',14,'Fontname', 'Times New Roman');


