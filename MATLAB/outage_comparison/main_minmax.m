% 比较两种NOMA方案的中断概率（控制变量为距离）
clear;
clc;
clf;
d1 = 10;
d2 = 20;
a = 3;
thres = 5;

x_axis = zeros(8,1);

out_1_11 = zeros(8,1);
out_1_22 = zeros(8,1);
out_1_13 = zeros(8,1);
out_1_23 = zeros(8,1);

out_2_11 = zeros(8,1);
out_2_22 = zeros(8,1);
out_2_13 = zeros(8,1);
out_2_23 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+30;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_min_max(sigma, d1,d2,a,thres);
    out_1_11(loop) = outage_1(1);
    out_1_22(loop) = outage_1(2);
    out_1_13(loop) = outage_1(3);
    out_1_23(loop) = outage_1(4);
    
    [outage_2,p2] = find_noma2_min_max(sigma,d1,d2,a,thres);
    out_2_11(loop) = outage_2(1);
    out_2_22(loop) = outage_2(2);
    out_2_13(loop) = 1 - exp(-1*d1^a*thres*sigma);
    out_2_23(loop) = 1 - exp(-1*d2^a*thres*sigma);
end
figure(11);
semilogy(x_axis,out_1_11,'r-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2_11,'r--d','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_22,'g-x','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_22,'g--o','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_13,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_13,'b--<','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_23,'k-+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_23,'k--p','LineWidth',1,'MarkerSize',10);

legend('NOMA1-OUT11','NOMA2-OUT11','NOMA1-OUT22','NOMA2-OUT22','NOMA1-OUT13','NOMA2-OUT13','NOMA1-OUT23','NOMA2-OUT23');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' minmax']);


d1 = 10;
d2 = 30;
a = 3;
thres = 5;

x_axis = zeros(8,1);

out_1_11 = zeros(8,1);
out_1_22 = zeros(8,1);
out_1_13 = zeros(8,1);
out_1_23 = zeros(8,1);

out_2_11 = zeros(8,1);
out_2_22 = zeros(8,1);
out_2_13 = zeros(8,1);
out_2_23 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+30;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_min_max(sigma, d1,d2,a,thres);
    out_1_11(loop) = outage_1(1);
    out_1_22(loop) = outage_1(2);
    out_1_13(loop) = outage_1(3);
    out_1_23(loop) = outage_1(4);
    
    [outage_2,p2] = find_noma2_min_max(sigma,d1,d2,a,thres);
    out_2_11(loop) = outage_2(1);
    out_2_22(loop) = outage_2(2);
    out_2_13(loop) = 1 - exp(-1*d1^a*thres*sigma);
    out_2_23(loop) = 1 - exp(-1*d2^a*thres*sigma);
end
figure(12);
semilogy(x_axis,out_1_11,'r-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2_11,'r--d','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_22,'g-x','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_22,'g--o','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_13,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_13,'b--<','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_23,'k-+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_23,'k--p','LineWidth',1,'MarkerSize',10);

legend('NOMA1-OUT11','NOMA2-OUT11','NOMA1-OUT22','NOMA2-OUT22','NOMA1-OUT13','NOMA2-OUT13','NOMA1-OUT23','NOMA2-OUT23');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' minmax']);

d1 = 10;
d2 = 40;
a = 3;
thres = 5;

x_axis = zeros(8,1);

out_1_11 = zeros(8,1);
out_1_22 = zeros(8,1);
out_1_13 = zeros(8,1);
out_1_23 = zeros(8,1);

out_2_11 = zeros(8,1);
out_2_22 = zeros(8,1);
out_2_13 = zeros(8,1);
out_2_23 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+30;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_min_max(sigma, d1,d2,a,thres);
    out_1_11(loop) = outage_1(1);
    out_1_22(loop) = outage_1(2);
    out_1_13(loop) = outage_1(3);
    out_1_23(loop) = outage_1(4);
    
    [outage_2,p2] = find_noma2_min_max(sigma,d1,d2,a,thres);
    out_2_11(loop) = outage_2(1);
    out_2_22(loop) = outage_2(2);
    out_2_13(loop) = 1 - exp(-1*d1^a*thres*sigma);
    out_2_23(loop) = 1 - exp(-1*d2^a*thres*sigma);
end
figure(13);
semilogy(x_axis,out_1_11,'r-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2_11,'r--d','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_22,'g-x','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_22,'g--o','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_13,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_13,'b--<','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_23,'k-+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_23,'k--p','LineWidth',1,'MarkerSize',10);

legend('NOMA1-OUT11','NOMA2-OUT11','NOMA1-OUT22','NOMA2-OUT22','NOMA1-OUT13','NOMA2-OUT13','NOMA1-OUT23','NOMA2-OUT23');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' minmax']);

d1 = 10;
d2 = 45;
a = 3;
thres = 5;

x_axis = zeros(8,1);

out_1_11 = zeros(8,1);
out_1_22 = zeros(8,1);
out_1_13 = zeros(8,1);
out_1_23 = zeros(8,1);

out_2_11 = zeros(8,1);
out_2_22 = zeros(8,1);
out_2_13 = zeros(8,1);
out_2_23 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+30;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_min_max(sigma, d1,d2,a,thres);
    out_1_11(loop) = outage_1(1);
    out_1_22(loop) = outage_1(2);
    out_1_13(loop) = outage_1(3);
    out_1_23(loop) = outage_1(4);
    
    [outage_2,p2] = find_noma2_min_max(sigma,d1,d2,a,thres);
    out_2_11(loop) = outage_2(1);
    out_2_22(loop) = outage_2(2);
    out_2_13(loop) = 1 - exp(-1*d1^a*thres*sigma);
    out_2_23(loop) = 1 - exp(-1*d2^a*thres*sigma);
end
figure(14);
semilogy(x_axis,out_1_11,'r-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2_11,'r--d','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_22,'g-x','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_22,'g--o','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_13,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_13,'b--<','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_23,'k-+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_23,'k--p','LineWidth',1,'MarkerSize',10);

legend('NOMA1-OUT11','NOMA2-OUT11','NOMA1-OUT22','NOMA2-OUT22','NOMA1-OUT13','NOMA2-OUT13','NOMA1-OUT23','NOMA2-OUT23');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' minmax']);

d1 = 20;
d2 = 30;
a = 3;
thres = 5;

x_axis = zeros(8,1);

out_1_11 = zeros(8,1);
out_1_22 = zeros(8,1);
out_1_13 = zeros(8,1);
out_1_23 = zeros(8,1);

out_2_11 = zeros(8,1);
out_2_22 = zeros(8,1);
out_2_13 = zeros(8,1);
out_2_23 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+30;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_min_max(sigma, d1,d2,a,thres);
    out_1_11(loop) = outage_1(1);
    out_1_22(loop) = outage_1(2);
    out_1_13(loop) = outage_1(3);
    out_1_23(loop) = outage_1(4);
    
    [outage_2,p2] = find_noma2_min_max(sigma,d1,d2,a,thres);
    out_2_11(loop) = outage_2(1);
    out_2_22(loop) = outage_2(2);
    out_2_13(loop) = 1 - exp(-1*d1^a*thres*sigma);
    out_2_23(loop) = 1 - exp(-1*d2^a*thres*sigma);
end
figure(15);
semilogy(x_axis,out_1_11,'r-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2_11,'r--d','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_22,'g-x','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_22,'g--o','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_13,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_13,'b--<','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_23,'k-+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_23,'k--p','LineWidth',1,'MarkerSize',10);

legend('NOMA1-OUT11','NOMA2-OUT11','NOMA1-OUT22','NOMA2-OUT22','NOMA1-OUT13','NOMA2-OUT13','NOMA1-OUT23','NOMA2-OUT23');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' minmax']);

d1 = 20;
d2 = 40;
a = 3;
thres = 5;

x_axis = zeros(8,1);

out_1_11 = zeros(8,1);
out_1_22 = zeros(8,1);
out_1_13 = zeros(8,1);
out_1_23 = zeros(8,1);

out_2_11 = zeros(8,1);
out_2_22 = zeros(8,1);
out_2_13 = zeros(8,1);
out_2_23 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+30;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_min_max(sigma, d1,d2,a,thres);
    out_1_11(loop) = outage_1(1);
    out_1_22(loop) = outage_1(2);
    out_1_13(loop) = outage_1(3);
    out_1_23(loop) = outage_1(4);
    
    [outage_2,p2] = find_noma2_min_max(sigma,d1,d2,a,thres);
    out_2_11(loop) = outage_2(1);
    out_2_22(loop) = outage_2(2);
    out_2_13(loop) = 1 - exp(-1*d1^a*thres*sigma);
    out_2_23(loop) = 1 - exp(-1*d2^a*thres*sigma);
end
figure(16);
semilogy(x_axis,out_1_11,'r-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2_11,'r--d','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_22,'g-x','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_22,'g--o','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_13,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_13,'b--<','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_23,'k-+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_23,'k--p','LineWidth',1,'MarkerSize',10);

legend('NOMA1-OUT11','NOMA2-OUT11','NOMA1-OUT22','NOMA2-OUT22','NOMA1-OUT13','NOMA2-OUT13','NOMA1-OUT23','NOMA2-OUT23');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' minmax']);

d1 = 20;
d2 = 45;
a = 3;
thres = 5;

x_axis = zeros(8,1);

out_1_11 = zeros(8,1);
out_1_22 = zeros(8,1);
out_1_13 = zeros(8,1);
out_1_23 = zeros(8,1);

out_2_11 = zeros(8,1);
out_2_22 = zeros(8,1);
out_2_13 = zeros(8,1);
out_2_23 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+30;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_min_max(sigma, d1,d2,a,thres);
    out_1_11(loop) = outage_1(1);
    out_1_22(loop) = outage_1(2);
    out_1_13(loop) = outage_1(3);
    out_1_23(loop) = outage_1(4);
    
    [outage_2,p2] = find_noma2_min_max(sigma,d1,d2,a,thres);
    out_2_11(loop) = outage_2(1);
    out_2_22(loop) = outage_2(2);
    out_2_13(loop) = 1 - exp(-1*d1^a*thres*sigma);
    out_2_23(loop) = 1 - exp(-1*d2^a*thres*sigma);
end
figure(17);
semilogy(x_axis,out_1_11,'r-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2_11,'r--d','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_22,'g-x','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_22,'g--o','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_13,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_13,'b--<','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_23,'k-+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_23,'k--p','LineWidth',1,'MarkerSize',10);

legend('NOMA1-OUT11','NOMA2-OUT11','NOMA1-OUT22','NOMA2-OUT22','NOMA1-OUT13','NOMA2-OUT13','NOMA1-OUT23','NOMA2-OUT23');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' minmax']);

d1 = 30;
d2 = 40;
a = 3;
thres = 5;

x_axis = zeros(8,1);

out_1_11 = zeros(8,1);
out_1_22 = zeros(8,1);
out_1_13 = zeros(8,1);
out_1_23 = zeros(8,1);

out_2_11 = zeros(8,1);
out_2_22 = zeros(8,1);
out_2_13 = zeros(8,1);
out_2_23 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+30;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_min_max(sigma, d1,d2,a,thres);
    out_1_11(loop) = outage_1(1);
    out_1_22(loop) = outage_1(2);
    out_1_13(loop) = outage_1(3);
    out_1_23(loop) = outage_1(4);
    
    [outage_2,p2] = find_noma2_min_max(sigma,d1,d2,a,thres);
    out_2_11(loop) = outage_2(1);
    out_2_22(loop) = outage_2(2);
    out_2_13(loop) = 1 - exp(-1*d1^a*thres*sigma);
    out_2_23(loop) = 1 - exp(-1*d2^a*thres*sigma);
end
figure(18);
semilogy(x_axis,out_1_11,'r-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2_11,'r--d','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_22,'g-x','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_22,'g--o','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_13,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_13,'b--<','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_23,'k-+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_23,'k--p','LineWidth',1,'MarkerSize',10);

legend('NOMA1-OUT11','NOMA2-OUT11','NOMA1-OUT22','NOMA2-OUT22','NOMA1-OUT13','NOMA2-OUT13','NOMA1-OUT23','NOMA2-OUT23');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' minmax']);

d1 = 30;
d2 = 45;
a = 3;
thres = 5;

x_axis = zeros(8,1);

out_1_11 = zeros(8,1);
out_1_22 = zeros(8,1);
out_1_13 = zeros(8,1);
out_1_23 = zeros(8,1);

out_2_11 = zeros(8,1);
out_2_22 = zeros(8,1);
out_2_13 = zeros(8,1);
out_2_23 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+30;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_min_max(sigma, d1,d2,a,thres);
    out_1_11(loop) = outage_1(1);
    out_1_22(loop) = outage_1(2);
    out_1_13(loop) = outage_1(3);
    out_1_23(loop) = outage_1(4);
    
    [outage_2,p2] = find_noma2_min_max(sigma,d1,d2,a,thres);
    out_2_11(loop) = outage_2(1);
    out_2_22(loop) = outage_2(2);
    out_2_13(loop) = 1 - exp(-1*d1^a*thres*sigma);
    out_2_23(loop) = 1 - exp(-1*d2^a*thres*sigma);
end
figure(19);
semilogy(x_axis,out_1_11,'r-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2_11,'r--d','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_22,'g-x','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_22,'g--o','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_13,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_13,'b--<','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_23,'k-+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_23,'k--p','LineWidth',1,'MarkerSize',10);

legend('NOMA1-OUT11','NOMA2-OUT11','NOMA1-OUT22','NOMA2-OUT22','NOMA1-OUT13','NOMA2-OUT13','NOMA1-OUT23','NOMA2-OUT23');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' minmax']);

d1 = 40;
d2 = 45;
a = 3;
thres = 5;

x_axis = zeros(8,1);

out_1_11 = zeros(8,1);
out_1_22 = zeros(8,1);
out_1_13 = zeros(8,1);
out_1_23 = zeros(8,1);

out_2_11 = zeros(8,1);
out_2_22 = zeros(8,1);
out_2_13 = zeros(8,1);
out_2_23 = zeros(8,1);

for loop = 1:8
    SIR = loop*5+30;
    x_axis(loop) = SIR;
    sigma = 10^(-SIR/10);
    
    [outage_1,p1] = find_noma1_min_max(sigma, d1,d2,a,thres);
    out_1_11(loop) = outage_1(1);
    out_1_22(loop) = outage_1(2);
    out_1_13(loop) = outage_1(3);
    out_1_23(loop) = outage_1(4);
    
    [outage_2,p2] = find_noma2_min_max(sigma,d1,d2,a,thres);
    out_2_11(loop) = outage_2(1);
    out_2_22(loop) = outage_2(2);
    out_2_13(loop) = 1 - exp(-1*d1^a*thres*sigma);
    out_2_23(loop) = 1 - exp(-1*d2^a*thres*sigma);
end
figure(20);
semilogy(x_axis,out_1_11,'r-s','LineWidth',1,'MarkerSize',10),hold on;
semilogy(x_axis,out_2_11,'r--d','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_22,'g-x','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_22,'g--o','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_13,'b-*','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_13,'b--<','LineWidth',1,'MarkerSize',10);

semilogy(x_axis,out_1_23,'k-+','LineWidth',1,'MarkerSize',10);
semilogy(x_axis,out_2_23,'k--p','LineWidth',1,'MarkerSize',10);

legend('NOMA1-OUT11','NOMA2-OUT11','NOMA1-OUT22','NOMA2-OUT22','NOMA1-OUT13','NOMA2-OUT13','NOMA1-OUT23','NOMA2-OUT23');
title(['d1=',num2str(d1) , ' d2=',num2str(d2) , ' minmax']);
    