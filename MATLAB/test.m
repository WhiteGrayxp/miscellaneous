% 比较在渐进分析下三个中断概率的函数图形（第三个肯定小于第四个，所以省略）
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
sigma = 1/10^8;

p1 = thres*d1^a*sigma./(1-p3-thres*p3);
p2 = thres*d2^a*sigma./(1-p33-thres*p33);
p4 = thres^2*d2^(2*a)*sigma^2./(2*p3.*p33);

figure(1)
surf(p3,p33,p1);hold on;
xlabel('p3');
ylabel('p33');
shading interp;
surf(p3,p33,p2);hold on;
surf(p3,p33,p4);
shading interp;



figure(2)
surf(p3,p33,p2);hold on;
xlabel('p3');
ylabel('p33');
shading interp;

surf(p3,p33,p4);
shading interp;