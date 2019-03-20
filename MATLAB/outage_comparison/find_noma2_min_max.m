function [outage, position] = find_noma2_min_max(sigma,d1,d2,a,thres)
% x1ºÍx2µþ¼Ó
% f(1) = outage_11
% f(2) = outage_22

fun = @(x)[1 - exp(-1*d1^a*thres*sigma/x(1)),...
    1- exp(d2^a*thres*sigma/(thres*x(1)-x(2)))];

x0 = [0.05,0.95];
Aeq = [1,1];
beq = 1;
lb = [0,1/(1+thres)];
ub = [1/(1+thres),1];
[x,fval] = fminimax(fun,x0,[],[],Aeq,beq,lb,ub);

outage = fval;
position = x;

