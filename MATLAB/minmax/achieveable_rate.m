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
rate_oma1 = zeros(8,1);
rate_oma2 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+50;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    rate_oma_1 = log2(1+d1^(-a)/sigma);
    rate_oma_2 = log2(1+d2^(-a)/sigma);
    [~,position] =  find_noma_min_max(sigma,d1,d2,a,thres);
    p1 = 1 - position(1);
    p2 = 1 - position(2);
    p3 = position(1);
    p4 = position(2);
    rate_noma_1 = log2(1+p1/(p3+d1^a*sigma)) + log2(1+(p3+p4)/(d1^a*sigma));
    rate_noma_2 = log2(1+p2/(p4+d2^a*sigma)) + log2(1+(p3+p4)/(d2^a*sigma));
    rate_oma1(loop) = rate_oma_1;
    rate_oma2(loop) = rate_oma_2;
    rate_noma1(loop) = rate_noma_1;
    rate_noma2(loop) = rate_noma_2;
end
figure(1)
plot(x_axis,rate_noma1,'b-*','LineWidth',2,'MarkerSize',10);hold on;grid on;
plot(x_axis,rate_noma2,'b-x','LineWidth',2,'MarkerSize',10);
plot(x_axis,rate_oma1,'r-*','LineWidth',2,'MarkerSize',10);
plot(x_axis,rate_oma2,'r-x','LineWidth',2,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA1','OMA2');
xlabel('Transmitter SNR(dB)');
ylabel('Achievable Rate(bit)');
figure(2)
plot(x_axis,(rate_noma1+rate_noma2)/2,'b-*','LineWidth',2,'MarkerSize',10);hold on;grid on;
plot(x_axis,(rate_oma1+rate_oma2)/2,'r-*','LineWidth',2,'MarkerSize',10);
legend('NOMA','OMA');
xlabel('Transmitter SNR(dB)');
ylabel('Average Achievable Rate(bit)');


