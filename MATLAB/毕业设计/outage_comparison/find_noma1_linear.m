function [outage,position] = find_noma1_linear(sigma,d1,d2,a,thres)

fun = @(x)thres*d1^a*sigma/(1-x(1)-thres*x(1)) + thres*d2^a*sigma/(1-x(2)-thres*x(2))...
    + thres^2*d1^(2*a)*sigma^2/(2*x(1)*x(2)) + thres^2*d2^(2*a)*sigma^2/(2*x(1)*x(2));
x0 = [0.01,0.01];
lb = [0,0];
ub = [1/(1+thres),1/(1+thres)];

[x,~] = fmincon(fun,x0,[],[],[],[],lb,ub);
outage =zeros(4,1);
outage(1) = 1 - exp(sigma*thres*d1^a/(thres*x(1)+x(1)-1));
outage(2) = 1 - exp(sigma*thres*d2^a/(thres*x(2)+x(2)-1));
outage(3) = 1 - 1/(x(1)-x(2))*(x(1)*exp(-sigma*thres*d1^a/x(1)) - x(2)*exp(-sigma*thres*d1^a/x(2)));
outage(4) = 1 - 1/(x(1)-x(2))*(x(1)*exp(-sigma*thres*d2^a/x(1)) - x(2)*exp(-sigma*thres*d2^a/x(2)));
position = x;