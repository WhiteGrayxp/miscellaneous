function [outage,asym] = find_noma1_minmax_outage(sigma,a,d1,d2,thres,b)

% x(1) = p3
% x(2) = p33
fun = @(x)[thres*d1^a*sigma/(1-x(1)-thres*x(1));...
           thres*d2^a*sigma/(1-x(2)-thres*x(2));...
           thres^2*d1^(2*a)*sigma^2/(2*(x(1)-thres*b^2*(1-x(1)))*(x(2)-thres*b^2*(1-x(2))));...
           thres^2*d2^(2*a)*sigma^2/(2*(x(1)-thres*b^2*(1-x(1)))*(x(2)-thres*b^2*(1-x(2))))];
x0 = [0.1,0.1];
lb = [thres*b^2/(1+thres*b^2)+sigma,thres*b^2/(1+thres*b^2)+sigma];
ub = [1/(1+thres)-sigma,1/(1+thres)-sigma];

[x,~] = fminimax(fun,x0,[],[],[],[],lb,ub);

outage =zeros(4,1);
outage(1) = 1 - exp(sigma*thres*d1^a/(thres*x(1)+x(1)-1));
outage(2) = 1 - exp(sigma*thres*d2^a/(thres*x(2)+x(2)-1));
c = x(1) - thres*(1-x(1))*b^2;
d = x(2) - thres*(1-x(2))*b^2;
outage(3) = 1 - 1/(c-d)*(c*exp(-sigma*thres*d1^a/c) - d*exp(-sigma*thres*d1^a/d));
outage(4) = 1 - 1/(c-d)*(c*exp(-sigma*thres*d2^a/c) - d*exp(-sigma*thres*d2^a/d));

asym = zeros(4,1);
asym(1) = thres*d1^a*sigma/(1-x(1)-thres*x(1));
asym(2) = thres*d2^a*sigma/(1-x(2)-thres*x(2));
asym(3) = thres^2*d1^(2*a)*sigma^2/(2*(x(1)-thres*b^2*(1-x(1)))*(x(2)-thres*b^2*(1-x(2))));
asym(4) = thres^2*d2^(2*a)*sigma^2/(2*(x(1)-thres*b^2*(1-x(1)))*(x(2)-thres*b^2*(1-x(2))));
