% 第一种NOMA方案当信噪比趋于无穷时的渐进性分析
p3 = 0.1;
p33 = 0.15;
p1 = 1-p3;
p2 = 1-p33;
thres = 5;
d1 = 15;
d2 = 30;
a = 3;
outage_real1 = zeros(1,50);  %实际中断概率
outage_real2 = zeros(1,50);
outage_real3 = zeros(1,50);
outage_real4 = zeros(1,50);
outage_real = zeros(1,50);

outage_asym1 = zeros(1,50);  %渐进中断概率
outage_asym2 = zeros(1,50);
outage_asym3 = zeros(1,50);
outage_asym4 = zeros(1,50);
outage_asym = zeros(1,50);

x_axis = zeros(1,50);
for SNR = 41:90
    x_axis(SNR-40) = SNR;
    sigma = 10^(-SNR/10);
    
    outage_real1(SNR-40) = 1 - exp(sigma*thres*d1^a/(thres*p3-p1));
    outage_real2(SNR-40) = 1 - exp(sigma*thres*d2^a/(thres*p33-p2));
    outage_real3(SNR-40) = 1 - 1/(p3-p33)*(p3*exp(-sigma*thres*d1^a/p3) - p33*exp(-sigma*thres*d1^a/p33));
    outage_real4(SNR-40) = 1 - 1/(p3-p33)*(p3*exp(-sigma*thres*d2^a/p3) - p33*exp(-sigma*thres*d2^a/p33));
    outage_real(SNR-40) = outage_real1(SNR-40) + outage_real2(SNR-40) + outage_real3(SNR-40) + outage_real4(SNR-40);
    
    outage_asym1(SNR-40) = thres*d1^a*sigma/(1-p3-thres*p3);
    outage_asym2(SNR-40) = thres*d2^a*sigma/(1-p33-thres*p33);
    outage_asym3(SNR-40) = 0.5*(thres*d1^a*sigma/p3)*(thres*d1^a*sigma/p33);
    outage_asym4(SNR-40) = 0.5*(thres*d2^a*sigma/p3)*(thres*d2^a*sigma/p33);
    outage_asym(SNR-40) = outage_asym1(SNR-40) + outage_asym2(SNR-40) + outage_asym3(SNR-40) + outage_asym4(SNR-40);
end

figure(1);
subplot(411);
semilogy(x_axis,outage_real1,'r');hold on;
semilogy(x_axis,outage_asym1,'b--*');
legend('实际中断概率','渐进中断概率');
xlabel('SNR(dB)');
ylabel('Outage Probability (%)');
subplot(412);
semilogy(x_axis,outage_real2,'r');hold on;
semilogy(x_axis,outage_asym2,'b--*');
legend('实际中断概率','渐进中断概率');
xlabel('SNR(dB)');
ylabel('Outage Probability (%)');
subplot(413);
semilogy(x_axis,outage_real3,'r');hold on;
semilogy(x_axis,outage_asym3,'b--*');
legend('实际中断概率','渐进中断概率');
xlabel('SNR(dB)');
ylabel('Outage Probability (%)');
subplot(414);
semilogy(x_axis,outage_real4,'r');hold on;
semilogy(x_axis,outage_asym4,'b--*');
legend('实际中断概率','渐进中断概率');
xlabel('SNR(dB)');
ylabel('Outage Probability (%)');

figure(2);
semilogy(x_axis,outage_real,'r');hold on;
semilogy(x_axis,outage_asym,'b--*');
legend('实际中断概率','渐进中断概率');
xlabel('SNR(dB)');
ylabel('Outage Probability (%)');
    