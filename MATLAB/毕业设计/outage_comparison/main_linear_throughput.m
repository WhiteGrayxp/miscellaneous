% 比较两种NOMA方案以及OMA的平均吞吐量（控制变量为距离）
% 16QAM, 3/4 code rate
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
    out_1(loop) = 4*n - n*sum(outage_1);    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));    
    out_3(loop) = 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(1);
plot(x_axis,out_1/2,'k-s','LineWidth',1,'MarkerSize',10),hold on;
plot(x_axis,out_2/2,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3/3,'r-+','LineWidth',1,'MarkerSize',10);
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
    out_1(loop) = 4*n - n*sum(outage_1);    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));    
    out_3(loop) = 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(2);
plot(x_axis,out_1/2,'k-s','LineWidth',1,'MarkerSize',10),hold on;
plot(x_axis,out_2/2,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3/3,'r-+','LineWidth',1,'MarkerSize',10);
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
    out_1(loop) = 4*n - n*sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(3);
plot(x_axis,out_1/2,'k-s','LineWidth',1,'MarkerSize',10),hold on;
plot(x_axis,out_2/2,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3/3,'r-+','LineWidth',1,'MarkerSize',10);
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
    out_1(loop) = 4*n - n*sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(4);
plot(x_axis,out_1/2,'k-s','LineWidth',1,'MarkerSize',10),hold on;
plot(x_axis,out_2/2,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3/3,'r-+','LineWidth',1,'MarkerSize',10);
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
    out_1(loop) = 4*n - n*sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(5);
plot(x_axis,out_1/2,'k-s','LineWidth',1,'MarkerSize',10),hold on;
plot(x_axis,out_2/2,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3/3,'r-+','LineWidth',1,'MarkerSize',10);
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
    out_1(loop) = 4*n - n*sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(6);
plot(x_axis,out_1/2,'k-s','LineWidth',1,'MarkerSize',10),hold on;
plot(x_axis,out_2/2,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3/3,'r-+','LineWidth',1,'MarkerSize',10);
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
    out_1(loop) = 4*n - n*sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(7);
plot(x_axis,out_1/2,'k-s','LineWidth',1,'MarkerSize',10),hold on;
plot(x_axis,out_2/2,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3/3,'r-+','LineWidth',1,'MarkerSize',10);
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
    out_1(loop) = 4*n - n*sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(8);
plot(x_axis,out_1/2,'k-s','LineWidth',1,'MarkerSize',10),hold on;
plot(x_axis,out_2/2,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3/3,'r-+','LineWidth',1,'MarkerSize',10);
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
    out_1(loop) = 4*n - n*sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(9);
plot(x_axis,out_1/2,'k-s','LineWidth',1,'MarkerSize',10),hold on;
plot(x_axis,out_2/2,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3/3,'r-+','LineWidth',1,'MarkerSize',10);
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
    out_1(loop) = 4*n - n*sum(outage_1);
    
    [outage_2,p2] = find_noma2_linear(sigma,d1,d2,a,thres);
    out_2(loop) = 4*n - n*(sum(outage_2) + 1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
    
    out_3(loop) = 4*n - n*2*(1 - exp(-1*d1^a*thres*sigma) + 1 - exp(-1*d2^a*thres*sigma));
end
figure(10);
plot(x_axis,out_1/2,'k-s','LineWidth',1,'MarkerSize',10),hold on;
plot(x_axis,out_2/2,'k--d','LineWidth',1,'MarkerSize',10);
plot(x_axis,out_3/3,'r-+','LineWidth',1,'MarkerSize',10);
legend('NOMA1','NOMA2','OMA');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' linear']);

    