function [outage,position] = NOMA2_outage(sigma,d1,d2,a,thres)
% 只优化第一阶段的功率分配，所以只返回P1和P2
position = zeros(1,2)
p1 = 0:0.0001:1/(1+thres);
p_out = 2 - exp(-1*d1^a*thres*sigma./p1) - exp(d2^a*thres*sigma./(p1*thres+p1-1));
p_out2 = 2 - exp(-1*d1^a*thres*sigma) - exp(-1*d2^a*thres*sigma);
plot(p1,p_out);
% 查找最小值
[M,I] = min(p_out(:));
[I_row, I_col] = ind2sub(size(p_out),I);
outage = M + p_out2;
position(1) = p1(I_col);
position(2) = 1 - p1(I_col);