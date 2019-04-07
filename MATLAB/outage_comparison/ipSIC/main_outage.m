clear;
clc;
clf;
a = 3;

x_axis = zeros(8,1);

noma1_11_linear = zeros(8,1);
noma1_11_linear_asym = zeros(8,1);
noma1_11_minmax = zeros(8,1);
noma1_11_minmax_asym = zeros(8,1);

noma1_22_linear = zeros(8,1);
noma1_22_linear_asym = zeros(8,1);
noma1_22_minmax = zeros(8,1);
noma1_22_minmax_asym = zeros(8,1);

noma1_13_linear = zeros(8,1);
noma1_13_linear_asym = zeros(8,1);
noma1_13_minmax = zeros(8,1);
noma1_13_minmax_asym = zeros(8,1);

noma1_23_linear = zeros(8,1);
noma1_23_linear_asym = zeros(8,1);
noma1_23_minmax = zeros(8,1);
noma1_23_minmax_asym = zeros(8,1);

noma2_11_linear = zeros(8,1);
noma2_11_linear_asym = zeros(8,1);
noma2_11_minmax = zeros(8,1);
noma2_11_minmax_asym = zeros(8,1);

noma2_22_linear = zeros(8,1);
noma2_22_linear_asym = zeros(8,1);
noma2_22_minmax = zeros(8,1);
noma2_22_minmax_asym = zeros(8,1);

noma2_13 = zeros(8,1);
noma2_13_asym = zeros(8,1);

noma2_23 = zeros(8,1);
noma2_23_asym = zeros(8,1);
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
             
             noma1_11_linear(loop) = noma1_11_linear(loop) + noma1_linear(1);
             noma1_11_linear_asym(loop) = noma1_11_linear_asym(loop) + noma1_linear_asym(1);
             noma1_11_minmax(loop) = noma1_11_minmax(loop) + noma1_minmax(1);
             noma1_11_minmax_asym(loop) = noma1_11_minmax_asym(loop) + noma1_minmax_asym(1);

             noma1_22_linear(loop) = noma1_22_linear(loop) + noma1_linear(2);
             noma1_22_linear_asym(loop) = noma1_22_linear_asym(loop) + noma1_linear_asym(2);
             noma1_22_minmax(loop) = noma1_22_minmax(loop) + noma1_minmax(2);
             noma1_22_minmax_asym(loop) = noma1_22_minmax_asym(loop) + noma1_minmax_asym(2);
             
             noma1_13_linear(loop) = noma1_13_linear(loop) + noma1_linear(3);
             noma1_13_linear_asym(loop) = noma1_13_linear_asym(loop) + noma1_linear_asym(3);
             noma1_13_minmax(loop) = noma1_13_minmax(loop) + noma1_minmax(3);
             noma1_13_minmax_asym(loop) = noma1_13_minmax_asym(loop) + noma1_minmax_asym(3);
             
             noma1_23_linear(loop) = noma1_23_linear(loop) + noma1_linear(4);
             noma1_23_linear_asym(loop) = noma1_23_linear_asym(loop) + noma1_linear_asym(4);
             noma1_23_minmax(loop) = noma1_23_minmax(loop) + noma1_minmax(4);
             noma1_23_minmax_asym(loop) = noma1_23_minmax_asym(loop) + noma1_minmax_asym(4);
             
             noma2_11_linear(loop) = noma2_11_linear(loop) + noma2_linear(1);
             noma2_11_linear_asym(loop) = noma2_11_linear_asym(loop) + noma2_linear_asym(1);
             noma2_11_minmax(loop) = noma2_11_minmax(loop) + noma2_minmax(1);
             noma2_11_minmax_asym(loop) = noma2_11_minmax_asym(loop) + noma2_minmax_asym(1);

             noma2_22_linear(loop) = noma2_22_linear(loop) + noma2_linear(2);
             noma2_22_linear_asym(loop) = noma2_22_linear_asym(loop) + noma2_linear_asym(2);
             noma2_22_minmax(loop) = noma2_22_minmax(loop) + noma2_minmax(2);
             noma2_22_minmax_asym(loop) = noma2_22_minmax_asym(loop) + noma2_minmax_asym(2);
             
             noma2_13(loop) = noma2_13(loop) + noma2_linear(3);
             noma2_13_asym(loop) = noma2_13_asym(loop) + noma2_linear_asym(3);
             
             noma2_23(loop) = noma2_23(loop) + noma2_linear(4);
             noma2_23_asym(loop) = noma2_23_asym(loop) + noma2_linear_asym(4);
             
        end
    end
end

f1 = figure(1);
semilogy(x_axis,noma1_11_linear/i,'r-*','LineWidth',1,'MarkerSize',10),hold on,grid on;
semilogy(x_axis,noma1_11_linear_asym/i,'g--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma1_11_minmax/i,'r-o','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma1_11_minmax_asym/i,'m--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_11_linear/i,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_11_linear_asym/i,'k--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_11_minmax/i,'b-o','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_11_minmax_asym/i,'--','Color',[0.6,0.5,0.3],'LineWidth',1,'MarkerSize',10);
xlabel('Transmitter SNR (dB)');
ylabel('Outage Probability');
legend('NOMA1-linear','NOMA1-linear asymptotic','NOMA1-minmax','NOMA1-minmax asymptotic','NOMA2-linear','NOMA2-linear asymptotic','NOMA2-minmax','NOMA2-minmax asymptotic');


f2 = figure(2);
semilogy(x_axis,noma1_22_linear/i,'r-*','LineWidth',1,'MarkerSize',10),hold on,grid on;
semilogy(x_axis,noma1_22_linear_asym/i,'g--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma1_22_minmax/i,'r-o','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma1_22_minmax_asym/i,'m--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_22_linear/i,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_22_linear_asym/i,'k--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_22_minmax/i,'b-o','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_22_minmax_asym/i,'--','Color',[0.6,0.5,0.3],'LineWidth',1,'MarkerSize',10);
xlabel('Transmitter SNR (dB)');
ylabel('Outage Probability');
legend('NOMA1-linear','NOMA1-linear asymptotic','NOMA1-minmax','NOMA1-minmax asymptotic','NOMA2-linear','NOMA2-linear asymptotic','NOMA2-minmax','NOMA2-minmax asymptotic');


f3 = figure(3);
semilogy(x_axis,noma1_13_linear/i,'r-*','LineWidth',1,'MarkerSize',10),hold on,grid on;
semilogy(x_axis,noma1_13_linear_asym/i,'g--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma1_13_minmax/i,'r-o','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma1_13_minmax_asym/i,'m--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_13/i,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_13_asym/i,'k--','LineWidth',1,'MarkerSize',10);
xlabel('Transmitter SNR (dB)');
ylabel('Outage Probability');
legend('NOMA1-linear','NOMA1-linear asymptotic','NOMA1-minmax','NOMA1-minmax asymptotic','NOMA2','NOMA2 asymptotic');

f4 = figure(4);
semilogy(x_axis,noma1_23_linear/i,'r-*','LineWidth',1,'MarkerSize',10),hold on,grid on;
semilogy(x_axis,noma1_23_linear_asym/i,'g--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma1_23_minmax/i,'r-o','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma1_23_minmax_asym/i,'m--','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_23/i,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,noma2_23_asym/i,'k--','LineWidth',1,'MarkerSize',10);
xlabel('Transmitter SNR (dB)');
ylabel('Outage Probability');
legend('NOMA1-linear','NOMA1-linear asymptotic','NOMA1-minmax','NOMA1-minmax asymptotic','NOMA2','NOMA2 asymptotic');