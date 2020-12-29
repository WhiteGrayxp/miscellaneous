clear;
clc;
clf;
d1 = 15;
d2 = 30;
a = 3;
thres = 5;

x_axis = zeros(8,1);
out_noma_minmax = zeros(8,1);
out_noma_minmax_asym = zeros(8,1);
out_oma_minmax = zeros(8,1);
p3 = zeros(8,1);
p4 = zeros(8,1);

out_noma_algebra = zeros(8,1);

for loop = 1:8
    SIR = loop*5+50;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    [outage,position] = find_noma_min_max(sigma,d1,d2,a,thres);
    out_noma_minmax(loop) = outage;
    out_oma_minmax(loop) = 1 - exp(-2*d2^a*sigma*thres/3);
    
    
    [outage2,position2] = find_noma_min_max_asym(sigma,d1,d2,a,thres);
    out_noma_minmax_asym(loop) = outage2;
    
    [x,y] = solveFunction(sigma,d1,d2,a,thres);
    out_noma_algebra(loop) = max([thres*d1^a*sigma/(1-x-thres*x),thres*d2^a*sigma/(1-y-thres*y),thres^2*d2^(2*a)*sigma^2/(2*x*y)]);
    
    p3(loop) = position(1);
    p4(loop) = position(2);
    fprintf('p3:%.3f\n',position(1));
    fprintf('p4:%.3f\n',position(2));
    fprintf('代数解p3：%.3f\n',x);
    fprintf('代数解p4：%.3f\n',y);
end
% semilogy(x_axis,out_noma_minmax,'b-*','LineWidth',2,'MarkerSize',10);hold on;
semilogy(x_axis,out_oma_minmax,'r-*','LineWidth',2,'MarkerSize',10);hold on;
semilogy(x_axis,out_noma_minmax_asym,'c-','LineWidth',2,'MarkerSize',10);
semilogy(x_axis,out_noma_algebra,'bo','LineWidth',2,'MarkerSize',10);
legend('OMA','NOMA\_asym','NOMA\_algebra');
ylabel('Outage probability(%)');
xlabel('Transmitter SNR(dB)');
