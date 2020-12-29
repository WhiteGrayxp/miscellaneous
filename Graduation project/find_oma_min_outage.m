% 求OMA方案的最佳功率分配方案
function [outage,position] = find_oma_min_outage(sigma,d1,d2,a,thres)
% sigma = 1/10^6;
% d1 = 15;
% d2 = 30;
% a = 3;
% thres = 5;
fun = @(x)4-exp(-d1^a*thres*sigma/x(1))-exp(-d2^a*thres*sigma/x(2))-exp(-d1^a*thres*sigma/x(3))-exp(-d2^a*thres*sigma/x(3));
x0 = 2/3*[1,1,1];
Aeq = [1,1,1];
beq = 2;
% p = [1,1,1]
% y = 4-exp(-d1^a*thres*sigma/p(1))-exp(-d2^a*thres*sigma/p(2))-exp(-d1^a*thres*sigma/p(3))-exp(-d2^a*thres*sigma/p(3));
[x,fval] = fmincon(fun,x0,[],[],Aeq,beq);
outage = fval;
position = x;