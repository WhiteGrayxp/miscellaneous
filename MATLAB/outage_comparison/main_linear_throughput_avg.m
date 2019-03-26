% 比较两种NOMA方案以及OMA的平均吞吐量（控制变量为距离）
% 16QAM, 3/4 code rate
clear;
clc;
clf;
a = 3;
thres = 7;
n = 3;
x_axis = zeros(8,1);

out_1_linear = zeros(8,1);
out_2_linear = zeros(8,1);
out_1_minmax = zeros(8,1);
out_2_minmax = zeros(8,1);
out_3 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10); 
    i = 0;
    for d1 = 10:10:40
        for d2 = d1+10:10:50
             i = i+1;
             % 基于线性组合求解最优功率分配
            [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
            out_1_linear(loop) = out_1_linear(loop) + 4*n - n*sum(outage_1);    
            [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
            out_2_linear(loop) = out_2_linear(loop) + 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma)); 
            % 基于minmax求解最优功率分配
            [outage_3,p3] = find_noma1_min_max(sigma, d1,d2,a,thres);
            out_1_minmax(loop) = out_1_minmax(loop) + 4*n - n*sum(outage_3);    
            [outage_4,p4] = find_noma2_min_max(sigma,d1,d2,a,thres);
            out_2_minmax(loop) = out_2_minmax(loop) + 4*n - n*(sum(outage_4) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
            % OMA
            out_3(loop) = out_1_linear(loop) + 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
        end
    end
end
out_1_linear = out_1_linear./(2*i);
out_2_linear = out_2_linear./(2*i);
out_1_minmax = out_1_minmax./(2*i);
out_2_minmax = out_2_minmax./(2*i);
out_3 = out_3./(3*i);
figure(1);
plot(x_axis,out_1_linear,'k-s','LineWidth',1,'MarkerSize',10),hold on;grid on;
plot(x_axis,out_2_linear,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_1_minmax,'r-s','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_2_minmax,'r--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3,'b-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1-linear','NOMA2-linear','NOMA1-minmax','NOMA2-minmax','OMA');
xlabel('Transmitter SNR (dB)');
ylabel('Throughput b/s/Hz');