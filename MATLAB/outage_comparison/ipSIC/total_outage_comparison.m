clc;
clf;
clear;

a = 3;
x_axis = zeros(8, 1);

co_noma_exact = zeros(8,1);
co_noma_asym = zeros(8,1);
co_noma_simu  =zeros(8,1);

no_noma_exact = zeros(8,1);
no_noma_asym = zeros(8,1);
no_noma_simu = zeros(8,1);

co_noma_exact_search = zeros(8,1);
co_noma_asym_search = zeros(8,1);
co_noma_simu_search = zeros(8,1);

no_noma_exact_search = zeros(8,1);
no_noma_asym_search = zeros(8,1);
no_noma_simu_search = zeros(8,1);

oma_exact = zeros(8,1);
oma_asym = zeros(8,1);
oma_simu = zeros(8,1);

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
             
             [temp,~] = find_noma1_linear_outage(sigma,a,d1,d2,thres,b);
             co_noma_exact(loop) = sum(temp);
             [temp,~] = find_noma2_linear_outage(sigma,a,d1,d2,thres,b);
             no_noma_exact(loop) = sum(temp);
             [temp,~] = exhaustive_noma1(sigma, d1,d2,a,thres);
             co_noma_exact_search(loop) = temp;
             [temp,~] = exhaustive_noma2(sigma, d1,d2,a,thres);
             no_noma_exact_search(loop) = temp;
             
             oma_exact(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
             
        end
    end
end
co_noma_exact = co_noma_exact/i;
co_noma_exact_search = co_noma_exact_search/i;
co_noma_simu = co_noma_exact;
co_noma_simu_search = co_noma_exact_search;

no_noma_exact = no_noma_exact/i;
no_noma_exact_search = no_noma_exact_search/i;
no_noma_simu = no_noma_exact;
no_noma_simu_search = no_noma_exact_search;

oma_exact = oma_exact/i;
oma_simu = oma_exact;
             
f = figure(1);
semilogy(x_axis,co_noma_exact,'r-','LineWidth',1,'MarkerSize',10),hold on;grid on;
semilogy(x_axis,co_noma_simu,'rs','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,co_noma_exact_search,'g-.','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,co_noma_simu_search,'gx','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,no_noma_exact,'k-','LineWidth',1,'MarkerSize',10),hold on;grid on;
semilogy(x_axis,no_noma_simu,'k+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,no_noma_exact_search,'b-.','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,no_noma_simu_search,'b>','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,oma_exact,'c-','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,oma_simu,'co','LineWidth',1,'MarkerSize',10);

legend('Co-NOMA-exact','Co-NOMA-simu','Co-NOMA-exact-search','Co-NOMA-simu-search','No-NOMA-exact','No-NOMA-simu','No-NOMA-exact-search','No-NOMA-simu-search','OMA-exact','OMA-simu');
xlabel('Transmitter SNR (dB)','FontSize',14,'Fontname','Times New Roman');
ylabel('Outage probability','FontSize',14,'Fontname','Times New Roman');

set(gca,'FontSize',14,'Fontname', 'Times New Roman');
             
             
             
             
             
             
             