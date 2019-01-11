clear;
clc;
clf;
d1 = 15;
d2 = 30;
a = 3;
thres = 5;

x_axis = zeros(8,1);
out_noma_minmax = zeros(8,1);
out_oma_minmax = zeros(8,1);
for loop = 1:8
    SIR = loop*5+50;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    [outage,~] = find_noma_min_max(sigma,d1,d2,a,thres);
    out_noma_minmax(loop) = outage;
    out_oma_minmax(loop) = 1 - exp(-2*d2^a*sigma*thres/3);
end
semilogy(x_axis,out_noma_minmax,'b-*','LineWidth',2,'MarkerSize',10);hold on;
semilogy(x_axis,out_oma_minmax,'r-*','LineWidth',2,'MarkerSize',10);
legend('NOMA','OMA');
ylabel('Outage probability(%)');
xlabel('Transmitter SNR(dB)');
