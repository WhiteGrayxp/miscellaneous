function [outage,position] = NOMA1_outage(sigma,d1,d2,a,thres)
% 优化两个阶段的功率分配，所以返回P3和P33
position = zeros(1,2);
pa = 0:0.001:1/(1+thres);
pb = pa;

[p3,p33] = meshgrid(pa,pb);
p1 = 1 - p3;
p2 = 1 - p33;

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

outage = M;
position = [pa(I_col),pa(I_row)];
