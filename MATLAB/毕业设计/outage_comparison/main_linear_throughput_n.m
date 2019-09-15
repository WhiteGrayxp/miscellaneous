% 比较两种NOMA方案以及OMA的平均吞吐量（控制变量为n）
% 16QAM, 3/4 code rate
clear;
clc;
clf;
a = 3;
thres_1 = 7/0.396;
n_1 = 3;
thres_2 = 4.62;
n_2 = 1.5;
x_axis = zeros(8,1);

out_1_linear = zeros(8,1);
out_2_linear = zeros(8,1);
out_1_linear_2 = zeros(8,1);
out_2_linear_2 = zeros(8,1);
out_3 = zeros(8,1);
out_3_2 = zeros(8,1);
for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10); 
    i = 0;
    for d1 = 10:10:40
        for d2 = d1+10:10:50
             i = i+1;
             % 基于线性组合求解最优功率分配
            [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres_1);
            out_1_linear(loop) = out_1_linear(loop) + 4*n_1 - n_1*sum(outage_1);    
            [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres_1);
            out_2_linear(loop) = out_2_linear(loop) + 4*n_1 - n_1*(sum(outage_2) + 1 - exp(-1*d1^a*thres_1*sigma) + 1 - exp(-1*d2^a*thres_1*sigma)); 
            % 基于minmax求解最优功率分配
            [outage_3,p3] = find_noma1_linear(sigma, d1,d2,a,thres_2);
            out_1_linear_2(loop) = out_1_linear_2(loop) + 4*n_2 - n_2*sum(outage_3);    
            [outage_4,p4] = find_noma2_linear(sigma,d1,d2,a,thres_2);
            out_2_linear_2(loop) = out_2_linear_2(loop) + 4*n_2 - n_2*(sum(outage_4) + 1 - exp(-1*d1^a*thres_2*sigma) + 1 - exp(-1*d2^a*thres_2*sigma));
            % OMA
            out_3(loop) = out_3(loop) + 4*n_1 - n_1*2*(1 - exp(-1*d1^a*thres_1*sigma) + 1 - exp(-1*d2^a*thres_1*sigma));
            out_3_2(loop) = out_3_2(loop) + 4*n_2 - n_2*2*(1 - exp(-1*d1^a*thres_2*sigma) + 1 - exp(-1*d2^a*thres_2*sigma));
        end
    end
end
out_1_linear = out_1_linear./(2*i);
out_2_linear = out_2_linear./(2*i);
out_1_linear_2 = out_1_linear_2./(2*i);
out_2_linear_2 = out_2_linear_2./(2*i);
out_3 = out_3./(3*i);
out_3_2 = out_3_2./(3*i);
figure(1);
plot(x_axis,out_1_linear,'k-s','LineWidth',1,'MarkerSize',10),hold on;grid on;
plot(x_axis,out_2_linear,'k-d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3,'k--+','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_1_linear_2,'r-s','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_2_linear_2,'r-d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3_2,'r--+','LineWidth',1,'MarkerSize',10);
legend('NOMA1, n=3.0','NOMA2, n=3.0','OMA, n=3.0','NOMA1, n=1.5','NOMA2, n=1.5','OMA, n=1.5');
xlabel('Transmitter SNR (dB)');
ylabel('Throughput b/s/Hz');