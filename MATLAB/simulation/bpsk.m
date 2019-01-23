% 仿真BPSK在实际场景下的中断概率
clc;
clf;
all clear;

d1 = 15;
d2 = 30;
a = 3;
thres = 5;

p1 = 0.85;
p2 = 0.9;
p3 = 0.15;
p4 = 0.1;


out_11 = zeros(30,1);
out_22 = zeros(30,1);
out_13 = zeros(30,1);
out_23 = zeros(30,1);
x_axis = zeros(30,1);

out_11_ana = zeros(30,1);
out_22_ana = zeros(30,1);
out_13_ana = zeros(30,1);
out_23_ana = zeros(30,1);

for loop = 1:40
    SNR = loop+30;
    sigma = 10^(-1*SNR/10);
    x_axis(loop) = SNR;
    
    bpskModulator = comm.BPSKModulator;
    bpskDemodulator = comm.BPSKDemodulator;

    
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
    modSig1 = bpskModulator(txData1);
    modSig2 = bpskModulator(txData2);
    modSig3 = bpskModulator(txData3);
    modSig4 = bpskModulator(txData4);
    
    % 接收数据
    rxSig11 = d1^(-0.5*a)*h11.*(sqrt(p1)*modSig1+sqrt(p3)*modSig3)+noise1;
    rxSig21 = d2^(-0.5*a)*h21.*(sqrt(p1)*modSig1+sqrt(p3)*modSig3)+noise2;
    rxSig12 = d1^(-0.5*a)*h12.*(sqrt(p2)*modSig2+sqrt(p4)*modSig4)+noise3;
    rxSig22 = d2^(-0.5*a)*h22.*(sqrt(p2)*modSig2+sqrt(p4)*modSig4)+noise4;
    
    outage11 = sum((d1^(-1*a)*p1*(abs(h11.*modSig1).^2))<(thres*(d1^(-1*a)*p3*(abs(h11.*modSig3).^2)+abs(noise1).^2)))/100000;
    outage22 = sum((d2^(-1*a)*p2*(abs(h22.*modSig2).^2))<(thres*(d2^(-1*a)*p4*(abs(h22.*modSig4).^2)+abs(noise4).^2)))/100000;
    
    % 产生评估信道
    h1 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    h2 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    h3 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    h4 = sqrt(0.5)*(randn(100000,1)+1j*randn(100000,1));
    
    % 解码数据
    rxData11 = bpskDemodulator(conj(h11).*rxSig11);
    rxData21 = bpskDemodulator(conj(h21).*rxSig21);
    rxData12 = bpskDemodulator(conj(h12).*rxSig12);
    rxData22 = bpskDemodulator(conj(h22).*rxSig22);
    
    rxData_11 = bpskModulator(rxData11);
    rxData_21 = bpskModulator(rxData21);
    rxData_12 = bpskModulator(rxData12);
    rxData_22 = bpskModulator(rxData22);
    
    %执行SIC

    remainData11 = d1^(-0.5*a)*h11.*(sqrt(p1)*modSig1+sqrt(p3)*modSig3)-d1^(-0.5*a)*sqrt(p1)*h11.*rxData_11+noise1;
    remainData21 = d2^(-0.5*a)*h21.*(sqrt(p1)*modSig1+sqrt(p3)*modSig3)-d2^(-0.5*a)*sqrt(p1)*h21.*rxData_21+noise2;
    remainData12 = d1^(-0.5*a)*h12.*(sqrt(p2)*modSig2+sqrt(p4)*modSig4)-d1^(-0.5*a)*sqrt(p2)*h12.*rxData_12+noise3;
    remainData22 = d2^(-0.5*a)*h22.*(sqrt(p2)*modSig2+sqrt(p4)*modSig4)-d2^(-0.5*a)*sqrt(p2)*h22.*rxData_22+noise4;

    
    % 残余干扰项
    interference11 = remainData11 - d1^(-0.5*a)*sqrt(p3)*h11.*modSig3;
    interference21 = remainData21 - d2^(-0.5*a)*sqrt(p3)*h21.*modSig3;
    interference12 = remainData12 - d1^(-0.5*a)*sqrt(p4)*h12.*modSig4;
    interference22 = remainData22 - d2^(-0.5*a)*sqrt(p4)*h22.*modSig4;
    

    outage13 = sum(((d1^(-1*a)*p3*abs(h11.*modSig3).^2./abs(interference11).^2 + d1^(-1*a)*p4*abs(h12.*modSig4).^2./abs(interference12).^2) < thres))/100000;
    outage23 = sum(((d2^(-1*a)*p3*abs(h21.*modSig3).^2./abs(interference21).^2 + d2^(-1*a)*p4*abs(h22.*modSig4).^2./abs(interference22).^2) < thres))/100000;

    
    out_11(loop) = outage11;
    out_22(loop) = outage22;
    out_13(loop) = outage13;
    out_23(loop) = outage23;
    
    out_11_ana(loop) = 1-exp(thres*d1^a*sigma/(p3*thres-p1));
    out_22_ana(loop) = 1-exp(thres*d2^a*sigma/(p4*thres-p2));
    out_13_ana(loop) = 1-(p3*exp(-1*thres*d1^a*sigma/p3)-p4*exp(-1*thres*d1^a*sigma/p4))/(p3-p4);
    out_23_ana(loop) = 1-(p3*exp(-1*thres*d2^a*sigma/p3)-p4*exp(-1*thres*d2^a*sigma/p4))/(p3-p4);
end

figure(1);
subplot(411);semilogy(x_axis,out_11,'b-*');grid on;hold on;
semilogy(x_axis,out_11_ana,'r');
legend('Simulation','Analysis');

subplot(412);semilogy(x_axis,out_22,'b-*');grid on;hold on;
semilogy(x_axis,out_22_ana,'r');
legend('Simulation','Analysis');

subplot(413);semilogy(x_axis,out_13,'b-*');grid on;hold on;
semilogy(x_axis,out_13_ana,'r');
legend('Simulation','Analysis');

subplot(414);semilogy(x_axis,out_23,'b-*');grid on;hold on;
semilogy(x_axis,out_23_ana,'r');
legend('Simulation','Analysis');
    
    
    