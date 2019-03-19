% 分别比较三种NOMA方案和OMA方案平均理论传输速率

clear;
clc;
clf;
d1 = 15;
d2 = 30;
a = 3;
thres = 5;

x_axis = zeros(8,1);
rate_noma1 = zeros(8,1);
rate_noma2 = zeros(8,1);
rate_noma3 = zeros(8,1);
rate_oma = zeros(8,1);

for loop = 1:8
    SIR = loop*5+50;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    rate_oma(loop) = 2/3*(log2(1+1/(d1^a*sigma)) + log2(1+1/(d2^a*sigma)));
    
    % 第一组NOMA方案
    [~, p] = find_noma1_min_max(sigma,d1,d2,a,thres);
    rate_temp = find_rate_noma1(p,sigma,d1,d2,a,thres);
    rate_noma1(loop) = rate_temp;
    
    % 第二组NOMA方案
    [~, p] = find_noma2_min_max(sigma,d1,d2,a,thres);
    rate_temp = find_rate_noma2(p,sigma,d1,d2,a,thres);
    rate_noma2(loop) = rate_temp;  
    
    % 第三种NOMA方案
    [~, p] = find_noma3_min_max(sigma,d1,d2,a,thres);
    rate_temp = find_rate_noma3(p,sigma,d1,d2,a,thres);
    rate_noma3(loop) = rate_temp; 
end

figure(1)
plot(x_axis,rate_noma1,'r-*','LineWidth',2,'MarkerSize',10);hold on;grid on;
plot(x_axis,rate_noma2,'b-x','LineWidth',2,'MarkerSize',10);
plot(x_axis,rate_noma3,'g-o','LineWidth',2,'MarkerSize',10);
plot(x_axis,rate_oma,'c-+','LineWidth',2,'MarkerSize',10);
legend('NOMA1','NOMA2','NOMA3','OMA');
xlabel('Transmitter SNR(dB)');
ylabel('Achievable Rate(bit/s/Hz)');

    
    