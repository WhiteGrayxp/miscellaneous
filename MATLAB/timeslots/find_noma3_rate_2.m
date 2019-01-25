function [r11,r13,r23] = find_noma3_rate_2(B,sigma,d1,d2,a,thres)
% x1ºÍx3µþ¼Ó
fun = @(x)3 - exp(-1*d1^a*thres*sigma/x(2)) - exp(d1^a*thres*sigma/(thres*x(2)-x(1))) - exp(-1*d2^a*thres*sigma/x(2));

x0 = [0.5,0.5];
Aeq = [1,1];
beq = 1;
[x,~] = fmincon(fun,x0,[],[],Aeq,beq);

r11 = B*log2(1+x(1)/(x(2)+d2^a*sigma));
r13 = B*log2(1+x(2)/(d1^a*sigma));
r23 = B*log2(1+x(2)/(d2^a*sigma));