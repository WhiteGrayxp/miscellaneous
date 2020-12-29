clear;
clc;
clf;
a = 3;

x_axis = zeros(8,1);

noma_11 = zeros(8,1);
noma_11_asym = zeros(8,1);

noma_22 = zeros(8,1);
noma_22_asym = zeros(8,1);

noma_13 = zeros(8,1);
noma_13_asym = zeros(8,1);

noma_23 = zeros(8,1);
noma_23_asym = zeros(8,1);

noma_fixed = zeros(8,1);
noma_fixed_asym = zeros(8,1);
noma_dynamic = zeros(8,1);
noma_dynamic_asym = zeros(8,1);
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
             [noma1_minmax,noma1_minmax_asym] = find_noma1_minmax_outage(sigma,a,d1,d2,thres,b);
             [noma2_minmax,noma2_minmax_asym] = find_noma2_minmax_outage(sigma,a,d1,d2,thres,b);
             
             noma_11(loop) = noma_11(loop) + noma1_linear(1);
             noma_11_asym(loop) = noma_11_asym(loop) + noma1_linear_asym(1);

             noma_22(loop) = noma_22(loop) + noma1_linear(2);
             noma_22_asym(loop) = noma_22_asym(loop) + noma1_linear_asym(2);
             
             noma_13(loop) = noma_13(loop) + noma1_linear(3);
             noma_13_asym(loop) = noma_13_asym(loop) + noma1_linear_asym(3);
             
             noma_23(loop) = noma_23(loop) + noma1_linear(4);
             noma_23_asym(loop) = noma_23_asym(loop) + noma1_linear_asym(4);
             
             p3 = 1/3;
             p33 = 1/3+0.0001;
             c = p3 - thres*(1-p3)*b^2;
             d = p33 - thres*(1-p33)*b^2;
             out_temp = 4 - exp(sigma*thres*d1^a/(thres*p3+p3-1)) - exp(sigma*thres*d2^a/(thres*p33+p33-1))...
                        - 1/(c-d)*(c*exp(-sigma*thres*d1^a/c) - d*exp(-sigma*thres*d1^a/d)) - 1/(c-d)*(c*exp(-sigma*thres*d2^a/c) - d*exp(-sigma*thres*d2^a/d));
             out_temp_asym = thres*d1^a*sigma/(1-p3-thres*p3) + thres*d2^a*sigma/(1-p33-thres*p33)...
                        + thres^2*d1^(2*a)*sigma^2/(2*(p3-thres*b^2*(1-p3))*(p33-thres*b^2*(1-p33))) + thres^2*d2^(2*a)*sigma^2/(2*(p3-thres*b^2*(1-p3))*(p33-thres*b^2*(1-p33)));
             
             noma_fixed(loop) = noma_fixed(loop) + out_temp;
             noma_fixed_asym(loop) = noma_fixed_asym(loop) + out_temp_asym;
             
        end
    end
end
noma_dynamic = noma_11 +noma_22 + noma_13 +noma_23;
noma_dynamic_asym = noma_11_asym + noma_22_asym + noma_13_asym + noma_23_asym;
noma_dynamic_simu = noma_dynamic;
noma_fixed_simu = noma_fixed;
f1 = figure(1);
semilogy(x_axis,noma_dynamic/i,'r-','LineWidth',1,'MarkerSize',10),hold on,grid on;
semilogy(x_axis,noma_dynamic_simu/i,'r*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_dynamic_asym/i,'b--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_fixed/i,'k-','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_fixed_simu/i,'ko','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma_fixed_asym/i,'b-.','LineWidth',1,'MarkerSize',10);

xlabel('Transmitter SNR (dB)','Fontname','Times New Roman','Fontsize',14);
ylabel('Total outage probability','Fontname','Times New Roman','Fontsize',14);
legend('Dynamic, exact','Dynamic, simulation','Dynamic, asymptotic','Fixed, exact','Fixed, simulation','Fixed, asymptotic','FontSize',14,'Fontname','Times New Roman');
 set(gca,'FontSize',14 ,'Fontname', 'Times New Roman');
