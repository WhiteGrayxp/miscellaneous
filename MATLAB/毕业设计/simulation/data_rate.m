% 仿真QPSK在实际场景下的传输速率（Perfect SIC and Practical SIC)
clc;
clf;
all clear;

d1 = 15;
d2 = 30;
a = 3;

B = 1.4*10^6/72;
bits_per_packet = 100;
symbols_per_packet = 5;
time_packet = 0.0005;


p1 = 0.8;
p2 = 0.9;
p3 = 0.2;
p4 = 0.1;

rate_11 = zeros(10,1);
rate_22 = zeros(10,1);
rate_13 = zeros(10,1);
rate_23 = zeros(10,1);
rate_13_practical = zeros(10,1);
rate_23_practical = zeros(10,1);
x_axis = zeros(10,1);

rate_11_bound_perfect = zeros(10,1);
rate_22_bound_perfect = zeros(10,1);
rate_13_bound_perfect = zeros(10,1);
rate_23_bound_perfect = zeros(10,1);

rate_13_bound_practical = zeros(10,1);
rate_23_bound_practical = zeros(10,1);

for loop = 1:10
    SNR = loop*5+30;
    sigma = 10^(-1*SNR/10);
    x_axis(loop) = SNR;
    
    qpskModulator = comm.QPSKModulator;
    qpskDemodulator = comm.QPSKDemodulator;

    
    %产生信道
    h11 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    h21 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    h12 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    h22 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    
    % 产生高斯白噪声
    noise1 = sqrt(sigma/2)*(randn(100000,1)+1j*randn(100000,1));
    noise2 = sqrt(sigma/2)*(randn(100000,1)+1j*randn(100000,1));
    noise3 = sqrt(sigma/2)*(randn(100000,1)+1j*randn(100000,1));
    noise4 = sqrt(sigma/2)*(randn(100000,1)+1j*randn(100000,1));
    
    % 发送各100000符号的两个数据帧（叠加后200000个符号）
    txData1 = randi([0,1],100000,1);
    txData2 = randi([0,1],100000,1);
    txData3 = randi([0,1],100000,1);
    txData4 = txData3;
    
    % 调制数据
    modSig1 = qpskModulator(txData1);
    modSig2 = qpskModulator(txData2);
    modSig3 = qpskModulator(txData3);
    modSig4 = qpskModulator(txData4);
    
    % 接收数据
    rxSig11 = d1^(-0.5*a)*h11.*(sqrt(p1)*modSig1+sqrt(p3)*modSig3)+noise1;
    rxSig21 = d2^(-0.5*a)*h21.*(sqrt(p1)*modSig1+sqrt(p3)*modSig3)+noise2;
    rxSig12 = d1^(-0.5*a)*h12.*(sqrt(p2)*modSig2+sqrt(p4)*modSig4)+noise3;
    rxSig22 = d2^(-0.5*a)*h22.*(sqrt(p2)*modSig2+sqrt(p4)*modSig4)+noise4;
    
    % 解码数据
    rxData11 = qpskDemodulator((h11.^(-1)).*rxSig11);
    rxData21 = qpskDemodulator((h21.^(-1)).*rxSig21);
    rxData12 = qpskDemodulator((h12.^(-1)).*rxSig12);
    rxData22 = qpskDemodulator((h22.^(-1)).*rxSig22);
    
    per_11 = per(rxData11,txData1,20);
    per_22 = per(rxData22,txData2,20);
    
    rate_11(loop) = 2*symbols_per_packet*(1-per_11)/(time_packet*B);
    rate_22(loop) = 2*symbols_per_packet*(1-per_22)/(time_packet*B);
    
    rxData_11 = qpskModulator(rxData11);
    rxData_21 = qpskModulator(rxData21);
    rxData_12 = qpskModulator(rxData12);
    rxData_22 = qpskModulator(rxData22);
    
    % Perfect SIC
    remainData11 = d1^(-0.5*a)*h11.*(sqrt(p3)*modSig3)+noise1;
    remainData21 = d2^(-0.5*a)*h21.*(sqrt(p3)*modSig3)+noise2;
    remainData12 = d1^(-0.5*a)*h12.*(sqrt(p4)*modSig4)+noise3;
    remainData22 = d2^(-0.5*a)*h22.*(sqrt(p4)*modSig4)+noise4;
    
    % MRC Combining
    data_13 = conj(h11).*remainData11 + conj(h12).*remainData12;
    data_23 = conj(h21).*remainData21 + conj(h22).*remainData22;
    
    rxData_13 = qpskDemodulator(data_13);
    rxData_23 = qpskDemodulator(data_23);
    
    per_13 = per(rxData_13,txData3,20);
    per_23 = per(rxData_23,txData3,20);
    
    rate_13(loop) = 2*symbols_per_packet*(1-per_13)/(time_packet*B);
    rate_23(loop) = 2*symbols_per_packet*(1-per_23)/(time_packet*B);
    
    %Practical SIC
    remainData11 = d1^(-0.5*a)*h11.*(sqrt(p1)*modSig1+sqrt(p3)*modSig3)-d1^(-0.5*a)*sqrt(p1)*h11.*rxData_11+noise1;
    remainData21 = d2^(-0.5*a)*h21.*(sqrt(p1)*modSig1+sqrt(p3)*modSig3)-d2^(-0.5*a)*sqrt(p1)*h21.*rxData_21+noise2;
    remainData12 = d1^(-0.5*a)*h12.*(sqrt(p2)*modSig2+sqrt(p4)*modSig4)-d1^(-0.5*a)*sqrt(p2)*h12.*rxData_12+noise3;
    remainData22 = d2^(-0.5*a)*h22.*(sqrt(p2)*modSig2+sqrt(p4)*modSig4)-d2^(-0.5*a)*sqrt(p2)*h22.*rxData_22+noise4;
    
    % MRC Combining
    data_13 = conj(h11).*remainData11 + conj(h12).*remainData12;
    data_23 = conj(h21).*remainData21 + conj(h22).*remainData22;
    
    rxData_13 = qpskDemodulator(data_13);
    rxData_23 = qpskDemodulator(data_23);
    
    per_13 = per(rxData_13,txData3,20);
    per_23 = per(rxData_23,txData3,20);
    
    rate_13_practical(loop) = 2*symbols_per_packet*(1-per_13)/(time_packet*B);
    rate_23_practical(loop) = 2*symbols_per_packet*(1-per_23)/(time_packet*B);
    
    % 残余干扰项
    interference11 = remainData11 - d1^(-0.5*a)*sqrt(p3)*h11.*modSig3 - noise1;
    interference21 = remainData21 - d2^(-0.5*a)*sqrt(p3)*h21.*modSig3 - noise2;
    interference12 = remainData12 - d1^(-0.5*a)*sqrt(p4)*h12.*modSig4 - noise3;
    interference22 = remainData22 - d2^(-0.5*a)*sqrt(p4)*h22.*modSig4 - noise4;
    
    i_11 = abs(interference11).^2+sigma;
    i_21 = abs(interference21).^2+sigma;
    i_12 = abs(interference12).^2+sigma;
    i_22 = abs(interference22).^2+sigma;
    
    r13 = log2(1+d1^(-1*a)*p3*abs(h11).^2./i_11 + d1^(-1*a)*p4*abs(h12).^2./i_12);
    r23 = log2(1+d2^(-1*a)*p3*abs(h21).^2./i_21 + d2^(-1*a)*p4*abs(h22).^2./i_22);
    rate_13_bound_practical(loop) = mean(r13);
    rate_23_bound_practical(loop) = mean(r23);
    
    rate_11_bound_perfect(loop) = log2(1+p1/(p3+d1^a*sigma));
    rate_22_bound_perfect(loop) = log2(1+p2/(p4+d2^a*sigma));
    rate_13_bound_perfect(loop) = log2(1+(p3+p4)/(d1^a*sigma));
    rate_23_bound_perfect(loop) = log2(1+(p3+p4)/(d2^a*sigma));

end

figure(1);
plot(x_axis,rate_11_bound_perfect,'b-*');grid on;hold on;
plot(x_axis,rate_11,'r-o');
legend('UE1-X1 Bound','UE1-X1 QPSK');
xlabel('Transmitter SNR(dB)');
ylabel('Data Rate(bps/Hz)');

figure(2);
plot(x_axis,rate_22_bound_perfect,'b-*');grid on;hold on;
plot(x_axis,rate_22,'r-o');
legend('UE2-X2 Bound','UE2-X2 QPSK');
xlabel('Transmitter SNR(dB)');
ylabel('Data Rate(bps/Hz)');

figure(3);
plot(x_axis,rate_13_bound_perfect,'b-*');grid on;hold on;
plot(x_axis,rate_13_bound_practical,'c-+');
plot(x_axis,rate_13,'r-o');
plot(x_axis,rate_13_practical,'g-d');
legend('UE1-X3 Bound Perfect SIC','UE1-X3 Bound Practical SIC','UE1-X3 QPSK Perfect SIC', 'UE1-X3 QPSK Practical SIC');
xlabel('Transmitter SNR(dB)');
ylabel('Data Rate(bps/Hz)');

figure(4);
plot(x_axis,rate_23_bound_perfect,'b-*');grid on;hold on;
plot(x_axis,rate_23_bound_practical,'c-+');
plot(x_axis,rate_23,'r-o');
plot(x_axis,rate_23_practical,'g-d');
legend('UE2-X3 Bound Perfect SIC','UE2-X3 Bound Practical SIC','UE2-X3 QPSK Perfect SIC', 'UE2-X3 QPSK Practical SIC');
xlabel('Transmitter SNR(dB)');
ylabel('Data Rate(bps/Hz)');
    
    
    