clear;
clc;
clf;
a = 3;

x_axis = zeros(8,1);

out_1_pSIC_1 = zeros(8,1);
out_2_pSIC_1 = zeros(8,1);
% b=0.1
out_1_ipSIC_1 = zeros(8,1);
out_2_ipSIC_1 = zeros(8,1);
out_3 = zeros(8,1);
% b=0.2
out_1_ipSIC_2 = zeros(8,1);
out_2_ipSIC_2 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10); 
    i = 0;
    for d1 = 10:10:40
        for d2 = d1+10:10:50
             i = i+1;
             % n=1.5 b=0.1
             n = 1.5;
             thres = (2^n-1)/0.396;
             b = 0.1;
             
             [temp1,~] = find_noma1_linear_outage(sigma,a,d1,d2,thres,b);
             out_1_ipSIC_1(loop) = out_1_ipSIC_1(loop) + 4*n - n*sum(temp1);
             [temp3,~] = find_noma1_linear_outage(sigma,a,d1,d2,thres,0);
             out_1_pSIC_1(loop) = out_1_pSIC_1(loop) + 4*n - n*sum(temp3);
             out_3(loop) = out_3(loop) + 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
            % n=1.5 b=0.2
             n = 1.5;
             thres = (2^n-1)/0.396;
             b = 0.2;
             [temp5,~] = find_noma1_linear_outage(sigma,a,d1,d2,thres,b);
             out_1_ipSIC_2(loop) = out_1_ipSIC_2(loop) + 4*n - n*sum(temp5);
             
        end
    end
end
out_1_pSIC_1 = out_1_pSIC_1/i/2;
out_1_ipSIC_1 = out_1_ipSIC_1/i/2;
out_3 = out_3/i/3;

out_1_ipSIC_2 = out_1_ipSIC_2/i/2;


figure();
plot(x_axis,out_1_pSIC_1,'r-s','LineWidth',1,'MarkerSize',10),hold on;grid on;
plot(x_axis,out_1_ipSIC_1,'k-.p','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_1_ipSIC_2,'c-.+','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3,'b-o','LineWidth',1,'MarkerSize',10);

legend('NOMA, pSIC','NOMA, ipSIC, \beta=0.1','NOMA, ipSIC, \beta=0.2','OMA','FontSize',14,'Fontname','Times New Roman');
xlabel('Transmitter SNR (dB)','Fontname','Times New Roman','Fontsize',14);
ylabel('Average throughput (BPCU)','Fontname','Times New Roman','Fontsize',14);
 set(gca,'FontSize',14 ,'Fontname', 'Times New Roman');