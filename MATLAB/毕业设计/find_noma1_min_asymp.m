% 求NOMA1方案（渐进）的最佳功率分配方案
function [outage,position] = find_noma1_min_asymp(sigma,d1,d2,a,thres)

fun = @(x)thres*d1^a*sigma/(1-x(1)-thres*x(1)) + thres*d2^a*sigma/(1-x(2)-thres*x(2))...
    + thres^2*d1^(2*a)*sigma^2/(2*x(1)*x(2)) + thres^2*d2^(2*a)*sigma^2/(2*x(1)*x(2));
x0 = [0.01,0.01];
lb = [0,0];
ub = [1/(1+thres),1/(1+thres)];

[x,fval] = fmincon(fun,x0,[],[],[],[],lb,ub);
outage = fval;
position = x;