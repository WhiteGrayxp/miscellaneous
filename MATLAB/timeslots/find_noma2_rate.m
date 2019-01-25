function [r11,r22] = find_noma2_rate(B,sigma,d1,d2,a,thres)
% x1ºÍx2µþ¼Ó

fun = @(x)2 - exp(-1*d1^a*thres*sigma/x(1)) - exp(d2^a*thres*sigma/(thres*x(1)-x(2)));

x0 = [0.5,0.5];
Aeq = [1,1];
beq = 1;
[x,~] = fmincon(fun,x0,[],[],Aeq,beq);

r11 = B*log2(1+x(1)/(d1^a*sigma));
r22 = B*log2(1+x(2)/(x(1)+d2^a*sigma));