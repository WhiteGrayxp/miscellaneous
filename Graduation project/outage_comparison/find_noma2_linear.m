function [outage,position] = find_noma2_linear(sigma,d1,d2,a,thres)

fun = @(x)1 - exp(-1*d1^a*thres*sigma/x) +  1- exp(d2^a*thres*sigma/(thres*x+x-1));
x0 = 0.1;
Aeq = [];
beq = [];
lb = 0+sigma;
ub = 1/(1+thres)-sigma;
[x,~] = fmincon(fun,x0,[],[],Aeq,beq,lb,ub);
outage = zeros(2,1);
outage(1) = 1 - exp(-1*d1^a*thres*sigma/x);
outage(2) = 1- exp(d2^a*thres*sigma/(thres*x+x-1));
position = x;
