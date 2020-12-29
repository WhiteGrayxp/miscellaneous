function [outage,asym] = find_noma2_linear_outage(sigma,a,d1,d2,thres,b)
% n :bits per second per Hz
% b :residual interference coefficients


% x = p1
fun = @(x)(-1*d1^a*thres*sigma/(thres*(1-x)*b^2-x)) + (-1*d2^a*thres*sigma/(thres*x+x-1));
x0 = 0.1;
Aeq = [];
beq = [];
lb = thres*b^2/(1+thres*b^2);
ub = 1/(1+thres)-sigma;
[x,~] = fmincon(fun,x0,[],[],Aeq,beq,lb,ub);
outage = zeros(4,1);
outage(1) = 1 - exp(d1^a*thres*sigma/(thres*(1-x)*b^2-x));
outage(2) = 1- exp(d2^a*thres*sigma/(thres*x+x-1));
outage(3) = 1 - exp(-1*d1^a*thres*sigma);
outage(4) = 1 - exp(-1*d2^a*thres*sigma);

asym = zeros(4,1);
asym(1) = (-1*d1^a*thres*sigma/(thres*(1-x)*b^2-x));
asym(2) = (-1*d2^a*thres*sigma/(thres*x+x-1));
asym(3) = d1^a*thres*sigma;
asym(4) = d2^a*thres*sigma;