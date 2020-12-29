function [r11,r13,r22,r23] = find_rate(B,sigma,d1,d2,a,thres)

% 求在最优功率分配下，各部分传输速率
[p3,p33] = solveFunction(sigma,d1,d2,a,thres);
p1 = 1-p3;
p2 = 1-p33;

r11 = B*log2(1+p1/(p3+d1^a*sigma));
r22 = B*log2(1+p2/(p33+d2^a*sigma));
r13 = B*log2(1+(p3+p33)/(d1^a*sigma));
r23 = B*log2(1+(p3+p33)/(d2^a*sigma));