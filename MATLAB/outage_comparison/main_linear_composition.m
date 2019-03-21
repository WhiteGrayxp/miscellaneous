% 比较两种NOMA方案以及OMA的中断概率之和（控制变量为距离）
clear;
clc;
clf;
d1 = 10;
d2 = 20;
a = 3;
thres = 7;
n = 3;
x_axis = zeros(8,1);

out_1 = zeros(8,1);
out_2 = zeros(8,1);
out_3 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
    out_1(loop) = sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = (sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(1);
semilogy(x_axis,out_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2,'k--d','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);
pause;
%%
d1 = 10;
d2 = 30;
x_axis = zeros(8,1);
out_1 = zeros(8,1);
out_2 = zeros(8,1);
for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
    out_1(loop) = sum(outage_1);
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = (sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    out_3(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(2);
semilogy(x_axis,out_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2,'k--d','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);
pause;
%%
d1 = 10;
d2 = 40;

x_axis = zeros(8,1);
out_1 = zeros(8,1);
out_2 = zeros(8,1);
for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
    out_1(loop) = sum(outage_1);
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = (sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    out_3(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(3);
semilogy(x_axis,out_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2,'k--d','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);
pause;
%%
d1 = 10;
d2 = 50;

x_axis = zeros(8,1);

out_1 = zeros(8,1);
out_2 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
    out_1(loop) = sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = (sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(4);
semilogy(x_axis,out_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2,'k--d','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);
pause;
%%
d1 = 20;
d2 = 30;

x_axis = zeros(8,1);

out_1 = zeros(8,1);
out_2 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
    out_1(loop) = sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = (sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(5);
semilogy(x_axis,out_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2,'k--d','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);
pause;
%%
d1 = 20;
d2 = 40;

x_axis = zeros(8,1);

out_1 = zeros(8,1);
out_2 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
    out_1(loop) = sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = (sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(6);
semilogy(x_axis,out_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2,'k--d','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);
pause;
%%
d1 = 20;
d2 = 50;

x_axis = zeros(8,1);

out_1 = zeros(8,1);
out_2 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
    out_1(loop) = sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = (sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(7);
semilogy(x_axis,out_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2,'k--d','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);
pause;
%%
d1 = 30;
d2 = 40;
x_axis = zeros(8,1);

out_1 = zeros(8,1);
out_2 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
    out_1(loop) = sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = (sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(8);
semilogy(x_axis,out_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2,'k--d','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);
pause;
%%
d1 = 30;
d2 = 50;

x_axis = zeros(8,1);

out_1 = zeros(8,1);
out_2 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
    out_1(loop) = sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = (sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(9);
semilogy(x_axis,out_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2,'k--d','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);
pause;
%%
d1 = 40;
d2 = 50;

x_axis = zeros(8,1);

out_1 = zeros(8,1);
out_2 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+40;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_linear(sigma, d1,d2,a,thres);
    out_1(loop) = sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = (sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(10);
semilogy(x_axis,out_1,'k-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2,'k--d','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);
pause;

    