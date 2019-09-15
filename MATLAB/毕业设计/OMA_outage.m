% 求在相应功率分配下OMA的中断概率
function outage = OMA_outage(sigma,d1,d2,a,thres,power)
% power:功率分配，为一个四元组
p1 = power(1);
p2 = power(2);
p3 = power(3);
p33 = power(4);
outage = 4-exp(-sigma*thres*d1^a/p1)-exp(-sigma*thres*d2^a/p2)-exp(-sigma*thres*d1^a/p3)-exp(-sigma*thres*d2^a/p33);