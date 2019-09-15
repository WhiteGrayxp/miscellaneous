function [r11,r22] = find_noma_rate_12(B,sigma,d1,d2,a,thres)
% x1ºÍx2µþ¼Ó

fun = @(x)[1 - exp(-1*d1^a*thres*sigma/x(1)),...
    1- exp(d2^a*thres*sigma/(thres*x(1)-x(2)))];

x0 = [0.1,0.9];
Aeq = [1,1];
beq = 1;
lb = [0,1/(1+thres)];
ub = [1/(1+thres),1];
[x,~] = fminimax(fun,x0,[],[],Aeq,beq,lb,ub);

r11 = B*log2(1+x(1)/(d1^a*sigma));
r22 = B*log2(1+x(2)/(x(1)+d2^a*sigma));