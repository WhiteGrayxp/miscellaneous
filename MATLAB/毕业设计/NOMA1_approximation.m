all clear;
clc;
clf;
thres = 5;     
pa = 0:0.001:1/(1+thres);
pb = pa;
[p3,p33] = meshgrid(pa,pb);
p1 = 1 - p3;
p2 = 1 - p33;
d1 = 10;
d2 = 20;
a = 3;
sigma = 1/10^8;    %当信噪比大约小于40db时非凸，不考虑路径损耗

p_total = 2 - exp(sigma*thres*d1^a./(thres*p3-p1)) - exp(sigma*thres*d2^a./(thres*p33-p2));
figure(1);
surf(p3,p33,p_total);
shading interp;
xlabel('P3');
ylabel('P33');
zlabel('total outage probability');