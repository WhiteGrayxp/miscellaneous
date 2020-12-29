clc;
clf;
all clear;

d1 = 15;
d2 = 30;
a = 3;

B = 1.4*10^6/72;
p1 = 0.8;
p2 = 0.9;
p3 = 0.2;
p4 = 0.1;

rate_11 = zeros(10,1);
rate_22 = zeros(10,1);
rate_13 = zeros(10,1);
rate_23 = zeros(10,1);

rate_11_bound = zeros(10,1);
rate_22_bound = zeros(10,1);
rate_13_bound = zeros(10,1);
rate_23_bound = zeros(10,1);
x_axis = zeros(10,1);

for loop = 1:10
    SNR = loop*5+30;
    sigma = 10^(-1*SNR/10);
    x_axis(loop) = SNR;
    
     %产生信道
    h11 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    h21 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    h12 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    h22 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    
    h11 = abs(h11).^2;
    h21 = abs(h21).^2;
    h12 = abs(h12).^2;
    h22 = abs(h22).^2;
        
    % 产生高斯白噪声
    noise1 = sqrt(sigma/2)*(randn(100000,1)+1j*randn(100000,1));
    noise2 = sqrt(sigma/2)*(randn(100000,1)+1j*randn(100000,1));
    noise3 = sqrt(sigma/2)*(randn(100000,1)+1j*randn(100000,1));
    noise4 = sqrt(sigma/2)*(randn(100000,1)+1j*randn(100000,1));
    
    
    rate_11_bound(loop) = log2(1+p1/(p3+d1^a*sigma));
    rate_22_bound(loop) = log2(1+p2/(p4+d2^a*sigma));
    rate_13_bound(loop) = log2(1+(p3+p4)/(d1^a*sigma));
    rate_23_bound(loop) = log2(1+(p3+p4)/(d2^a*sigma));
    
    r11 = log2(1+(p1*h11)./(p3*h11+d1^a*sigma));
    r22 = log2(1+(p2*h22)./(p4*h22+d2^a*sigma));
    
    r13 = log2(1+(p3*h11+p4*h12)/(d1^a*sigma));
    r23 = log2(1+(p3*h21+p4*h22)/(d2^a*sigma));
    
    rate_11(loop) = mean(r11);
    rate_22(loop) = mean(r22);
    rate_13(loop) = mean(r13);
    rate_23(loop) = mean(r23);
end
figure(1);
plot(x_axis,rate_11_bound,'b-*');grid on;hold on;
plot(x_axis,rate_11,'r-o');
legend('UE1-X1 Bound Theory','UE1-X1 Simulation');
xlabel('Transmitter SNR(dB)');
ylabel('Data Rate(bps/Hz)');

figure(2);
plot(x_axis,rate_22_bound,'b-*');grid on;hold on;
plot(x_axis,rate_22,'r-o');
legend('UE2-X2 Bound Theory','UE2-X2 Bound Simulation');
xlabel('Transmitter SNR(dB)');
ylabel('Data Rate(bps/Hz)');

figure(3);
plot(x_axis,rate_13_bound,'b-*');grid on;hold on;
plot(x_axis,rate_13,'r-o');
legend('UE1-X3 Bound Theory','UE1-X3 Bound Simulation');
xlabel('Transmitter SNR(dB)');
ylabel('Data Rate(bps/Hz)');

figure(4);
plot(x_axis,rate_23_bound,'b-*');grid on;hold on;
plot(x_axis,rate_23,'r-o');
legend('UE2-X3 Bound Theory','UE2-X3 Bound Simulation');
xlabel('Transmitter SNR(dB)');
ylabel('Data Rate(bps/Hz)');
    
    