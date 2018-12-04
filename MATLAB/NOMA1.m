all clear;
clc;
clf;
thres = 5;
pa = 0:0.001:1/(1+thres);
pb = pa;
[p3,p33] = meshgrid(pa,pb);
p1 = 1 - p3;
p2 = 1 - p33;
d1 = 15;
d2 = 25;
a = 3;
sigma = 0.01/10^a;

p_total1 = 4 - exp(sigma*thres*d1^a./(thres*p3-p1)) - exp(sigma*thres*d2^a./(thres*p33-p2));

% p3!=p33
p_total2 = 1./(p3-p33).*(p3.*(exp(-sigma*thres*d1^a./p3) + exp(-sigma*thres*d2^a./p3)) - p33.*(exp(-sigma*thres*d1^a./p33) + exp(-sigma*thres*d2^a./p33)));

% p3=p33
p_total22 = exp(-sigma*thres*d1^a./pa).*(sigma*thres*d1^a./pa+1) + exp(-sigma*thres*d2^a./pa).*(sigma*thres*d2^a./pa+1);

for i=1:size(p3)
    p_total2(i,i) = p_total22(i);
end

p_total = p_total1 - p_total2;


% 查找最小值
[M,I] = min(p_total(:));
[I_row, I_col] = ind2sub(size(p_total),I);

fprintf('最小值为：%0.3f\n',M);
fprintf('位于p3:%0.3f, p33:%0.3f',pa(I_col),pa(I_row));

p_oma = 4-exp(-sigma*thres*d1^a/(1-pa(I_row)))-exp(-sigma*thres*d1^a/pa(I_row))-exp(-sigma*thres*d2^a/(1-pa(I_col)))-exp(-sigma*thres*d2^a/pa(I_col));
p_oma_2 = 4-2*exp(-sigma*thres*d1^a)-2*exp(-sigma*thres*d2^a);
figure(1)
surf(p3,p33,p_total1);
shading interp;

figure(2)
surf(p3,p33,p_total2);
shading interp;

figure(3)
surf(p3,p33,p_total);
shading interp;
xlabel('P3');
ylabel('P33');
zlabel('total outage probability');