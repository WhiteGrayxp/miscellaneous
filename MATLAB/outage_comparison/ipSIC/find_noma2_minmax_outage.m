function [outage] = find_noma2_minmax_outage(sigma,a,d1,d2,thres,b)
% x = p1
fun = @(x)[d1^a*thres*sigma/(x-thres*(1-x)*b^2),...
           d2^a*thres*sigma/(1-thres*x-x)];

x0 = 0.1;
Aeq = [];
beq = [];
lb = thres*b^2/(1+thres*b^2);
ub = 1/(1+thres)-sigma;
[x,~] = fminimax(fun,x0,[],[],Aeq,beq,lb,ub);

outage = zeros(4,1);
outage(1) = 1 - exp(d1^a*thres*sigma/(thres*(1-x)*b^2-x));
outage(2) = 1- exp(d2^a*thres*sigma/(thres*x+x-1));
outage(3) = 1 - exp(-1*d1^a*thres*sigma);
outage(4) = 1 - exp(-1*d2^a*thres*sigma);