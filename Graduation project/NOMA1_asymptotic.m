% 第一种NOMA方案渐进性分析下中断概率三维图
all clear;
clc;
clf;
thres = 5;     
pa = 0:0.001:1/(1+thres);
pb = pa;
[p3,p33] = meshgrid(pa,pb);

d1 = 15;
d2 = 30;
a = 3;
sigma = 0.1;

outage_asym1= thres*d1^a*sigma./(1-p3-thres*p3);
outage_asym2 = thres*d2^a*sigma./(1-p33-thres*p33);
outage_asym3 = 0.5*(thres*d1^a*sigma./p3).*(thres*d1^a*sigma./p33);
outage_asym4 = 0.5*(thres*d2^a*sigma./p3).*(thres*d2^a*sigma./p33);
outage_asym = outage_asym1 + outage_asym2 + outage_asym3 + outage_asym4;

surf(p3,p33,outage_asym);
shading interp;
xlabel('P_3');
ylabel('P^’_3');
zlabel('Outage probability(%)');