clear;
clc;
clf;
a = 3;

x_axis = zeros(8,1);
% n=1.5
out_1_pSIC_1 = zeros(8,1);
out_2_pSIC_1 = zeros(8,1);
out_1_ipSIC_1 = zeros(8,1);
out_2_ipSIC_1 = zeros(8,1);
out_3_1 = zeros(8,1);
% n=3.0
out_1_pSIC_2 = zeros(8,1);
out_2_pSIC_2 = zeros(8,1);
out_1_ipSIC_2 = zeros(8,1);
out_2_ipSIC_2 = zeros(8,1);
out_3_2 = zeros(8,1);
for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10); 
    i = 0;
    for d1 = 10:10:40
        for d2 = d1+10:10:50
             i = i+1;
             % n=0.75 b=0.1
             n = 0.75;
             thres = (2^n-1)/0.396;
             b = 0.1;
             out_1_ipSIC_1(loop) = out_1_ipSIC_1(loop) + 4*n - n*sum(find_noma1_linear_outage(sigma,a,d1,d2,thres,b));
             out_2_ipSIC_1(loop) = out_2_ipSIC_1(loop) + 4*n - n*sum(find_noma2_linear_outage(sigma,a,d1,d2,thres,b));
             out_1_pSIC_1(loop) = out_1_pSIC_1(loop) + 4*n - n*sum(find_noma1_linear_outage(sigma,a,d1,d2,thres,0));
             out_2_pSIC_1(loop) = out_2_pSIC_1(loop) + 4*n - n*sum(find_noma2_linear_outage(sigma,a,d1,d2,thres,0));
             out_3_1(loop) = out_3_1(loop) + 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
            % n=1.5 b=0.1
             n = 1.5;
             thres = (2^n-1)/0.396;
             b = 0.1;
             out_1_ipSIC_2(loop) = out_1_ipSIC_2(loop) + 4*n - n*sum(find_noma1_linear_outage(sigma,a,d1,d2,thres,b));
             out_2_ipSIC_2(loop) = out_2_ipSIC_2(loop) + 4*n - n*sum(find_noma2_linear_outage(sigma,a,d1,d2,thres,b));
             out_1_pSIC_2(loop) = out_1_pSIC_2(loop) + 4*n - n*sum(find_noma1_linear_outage(sigma,a,d1,d2,thres,0));
             out_2_pSIC_2(loop) = out_2_pSIC_2(loop) + 4*n - n*sum(find_noma2_linear_outage(sigma,a,d1,d2,thres,0));
             out_3_2(loop) = out_3_2(loop) + 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
        end
    end
end
out_1_pSIC_1 = out_1_pSIC_1/i/2;
out_2_pSIC_1 = out_2_pSIC_1/i/2;
out_1_ipSIC_1 = out_1_ipSIC_1/i/2;
out_2_ipSIC_1 = out_2_ipSIC_1/i/2;
out_3_1 = out_3_1/i/3;

out_1_pSIC_2 = out_1_pSIC_2/i/2;
out_2_pSIC_2 = out_2_pSIC_2/i/2;
out_1_ipSIC_2 = out_1_ipSIC_2/i/2;
out_2_ipSIC_2 = out_2_ipSIC_2/i/2;
out_3_2 = out_3_2/i/3;

figure();
plot(x_axis,out_1_pSIC_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;grid on;
plot(x_axis,out_2_pSIC_1,'k-d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_1_ipSIC_1,'k-.p','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_2_ipSIC_1,'k-.*','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3_1,'k-o','LineWidth',1,'MarkerSize',10);

plot(x_axis,out_1_pSIC_2,'r-s','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_2_pSIC_2,'r-d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_1_ipSIC_2,'r-.p','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_2_ipSIC_2,'r-.*','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3_2,'r-o','LineWidth',1,'MarkerSize',10);
legend('NOMA1 pSIC n=0.75','NOMA2 pSIC n=0.75','NOMA1 ipSIC n=0.75','NOMA2 ipSIC n=0.75','OMA n=0.75','NOMA1 pSIC n=1.5','NOMA2 pSIC n=1.5','NOMA1 ipSIC n=1.5','NOMA2 ipSIC n=1.5','OMA n=1.5');
xlabel('Transmitter SNR (dB)');
ylabel('Throughput b/s/Hz');