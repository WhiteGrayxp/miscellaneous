function [p2,p3] = find_noma3_power(B,sigma,d1,d2,a,thres)
% x2ºÍx3µþ¼Ó
fun = @(x)[1 - exp(-1*d1^a*thres*sigma/x(2)),...
    1 - exp(d2^a*thres*sigma/(thres*x(2)-x(1))),...
    1 - exp(-1*d2^a*thres*sigma/x(2))];

x0 = [0.9,0.1];
Aeq = [1,1];
beq = 1;
lb = [1/(1+thres),0];
ub = [1,1/(1+thres)];
[x,~] = fminimax(fun,x0,[],[],Aeq,beq,lb,ub);

p2 = x(1);
p3 = x(2);