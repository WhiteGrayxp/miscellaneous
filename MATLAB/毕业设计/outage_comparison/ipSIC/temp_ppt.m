clear;
clc;
clf;
a = 3;

x_axis = zeros(8,1);


noma_fixed_1 = zeros(8,1);
noma_fixed_asym_1 = zeros(8,1);
noma_dynamic_1 = zeros(8,1);
noma_dynamic_asym_1 = zeros(8,1);

noma_fixed_2 = zeros(8,1);
noma_fixed_asym_2 = zeros(8,1);
noma_dynamic_2 = zeros(8,1);
noma_dynamic_asym_2 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10); 
    i = 0;
    for d1 = 10:10:40
        for d2 = d1+10:10:50
             i = i+1;
             n = 0.75;
             thres = (2^n-1)/0.396;
             b = 0.1;
            
             [noma1_linear,noma1_linear_asym] = find_noma1_linear_outage(sigma,a,d1,d2,thres,b);
             [noma2_linear,noma2_linear_asym] = find_noma2_linear_outage(sigma,a,d1,d2,thres,b);
             
            noma_dynamic_1(loop) = noma_dynamic_1(loop) + sum(noma1_linear);
            noma_dynamic_2(loop) = noma_dynamic_2(loop) + sum(noma2_linear);
            noma_dynamic_asym_1(loop) = noma_dynamic_asym_1(loop) + sum(noma1_linear_asym);
            noma_dynamic_asym_2(loop) = noma_dynamic_asym_2(loop) + sum(noma2_linear_asym);
            
             p3 = 1/3;
             p33 = 1/3+0.0001;
             c = p3 - thres*(1-p3)*b^2;
             d = p33 - thres*(1-p33)*b^2;
             out_temp = 4 - exp(sigma*thres*d1^a/(thres*p3+p3-1)) - exp(sigma*thres*d2^a/(thres*p33+p33-1))...
                        - 1/(c-d)*(c*exp(-sigma*thres*d1^a/c) - d*exp(-sigma*thres*d1^a/d)) - 1/(c-d)*(c*exp(-sigma*thres*d2^a/c) - d*exp(-sigma*thres*d2^a/d));
             out_temp_asym = thres*d1^a*sigma/(1-p3-thres*p3) + thres*d2^a*sigma/(1-p33-thres*p33)...
                        + thres^2*d1^(2*a)*sigma^2/(2*(p3-thres*b^2*(1-p3))*(p33-thres*b^2*(1-p33))) + thres^2*d2^(2*a)*sigma^2/(2*(p3-thres*b^2*(1-p3))*(p33-thres*b^2*(1-p33)));
             
             noma_fixed_1(loop) = noma_fixed_1(loop) + out_temp;
             noma_fixed_asym_1(loop) = noma_fixed_asym_1(loop) + out_temp_asym;
             
             p1 = 1/3;
             out_temp_2 = 4 - exp(d1^a*thres*sigma/(thres*b^2-p1*(1-thres*b^2))) - exp(d2^a*thres*sigma/(thres*p1+p1-1)) - exp(-1*d1^a*thres*sigma) - exp(-1*d2^a*thres*sigma);
             out_temp_asym_2 = -1*d1^a*thres*sigma/(thres*b^2-p1*(1-thres*b^2)) - d2^a*thres*sigma/(thres*p1+p1-1) + d1^a*thres*sigma + d2^a*thres*sigma;
             noma_fixed_2(loop) = noma_fixed_2(loop) + out_temp_2;
             noma_fixed_asym_2(loop) = noma_fixed_asym_2(loop) + out_temp_asym_2;
             
        end
    end
end
noma_dynamic_1 = noma_dynamic_1/i;
noma_dynamic_asym_1 = noma_dynamic_asym_1/i;
noma_dynamic_simu_1 = noma_dynamic_1;
noma_fixed_1 = noma_fixed_1/i;
noma_fixed_asym_1 = noma_fixed_asym_1/i;
noma_fixed_simu_1 = noma_fixed_1;

noma_dynamic_2 = noma_dynamic_2/i;
noma_dynamic_asym_2 = noma_dynamic_asym_2/i;
noma_dynamic_simu_2 = noma_dynamic_2;
noma_fixed_2 = noma_fixed_2/i;
noma_fixed_asym_2 = noma_fixed_asym_2/i;
noma_fixed_simu_2 = noma_fixed_2;

f1 = figure(1);
semilogy(x_axis,noma_dynamic_1/i,'r-','LineWidth',1,'MarkerSize',10),hold on,grid on;
semilogy(x_axis,noma_dynamic_simu_1/i,'r*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_dynamic_asym_1/i,'b--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_fixed_1/i,'k-','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_fixed_simu_1/i,'ko','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_fixed_asym_1/i,'b-.','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,noma_dynamic_2/i,'m-','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_dynamic_simu_2/i,'m+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_dynamic_asym_2/i,'g--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_fixed_2/i,'c-','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_fixed_simu_2/i,'c>','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_fixed_asym_2/i,'g-.','LineWidth',1,'MarkerSize',10);
xlabel('Transmitter SNR (dB)','Fontname','Times New Roman','Fontsize',14);
ylabel('Total outage probability','Fontname','Times New Roman','Fontsize',14);
legend('NOMA1, dynamic, exact','NOMA1, dynamic, simulation','NOMA1, dynamic, asymptotic','NOMA1, fixed, exact','NOMA1, fixed, simulation','NOMA1, fixed, asymptotic','NOMA2, dynamic, exact','NOMA2, dynamic, simulation','NOMA2, dynamic, asymptotic','NOMA2, fixed, exact','NOMA2, fixed, simulation','NOMA2, fixed, asymptotic','FontSize',14,'Fontname','Times New Roman');
 set(gca,'FontSize',14 ,'Fontname', 'Times New Roman');
