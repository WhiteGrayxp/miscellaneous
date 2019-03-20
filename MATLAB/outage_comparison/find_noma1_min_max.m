function [outage,position] = find_noma1_min_max(sigma,d1,d2,a,thres)

outage = zeros(4,1);
% 返回在minmax定义下的中断概率及最佳功率分配

% f(1) = outage_11
% f(2) = outage_22
% f(3) = outage_13
% f(4) = outage_23


% fun = @(x)[1 - exp(sigma*thres*d1^a/(thres*x(1)+x(1)-1));...
%     1 - exp(sigma*thres*d2^a/(thres*x(2)+x(2)-1));...
%     1 - 1/(x(1)-x(2))*(x(1)*exp(-sigma*thres*d1^a/x(1)) - x(2)*exp(-sigma*thres*d1^a/x(2)));...
%     1 - 1/(x(1)-x(2))*(x(1)*exp(-sigma*thres*d2^a/x(1)) - x(2)*exp(-sigma*thres*d2^a/x(2)))];
% x0 = [0.01;0.01];
% lb = [0+sigma;0+sigma];
% ub = [1/(1+thres)-sigma;1/(1+thres)-sigma];
% [x,fval] = fminimax(fun,x0,[],[],[],[],lb,ub);
% 
% outage = fval;
% position = x;

% 用代数方法求解
r = thres;
s = sigma;

fun = @(x)[2*x(1)*x(2)+(1+r)*r*d2^a*s*x(2)-r*d2^a*s,...
    d1^a*(1-x(2)-r*x(2))-d2^a*(1-x(1)-r*x(1))];

x0 = [0.1,0.1];
x = fsolve(fun,x0);

outage(1) = 1 - exp(sigma*thres*d1^a/(thres*x(1)+x(1)-1));
outage(2) = 1 - exp(sigma*thres*d2^a/(thres*x(2)+x(2)-1));
outage(3) = 1 - 1/(x(1)-x(2))*(x(1)*exp(-sigma*thres*d1^a/x(1)) - x(2)*exp(-sigma*thres*d1^a/x(2)));
outage(4) = 1 - 1/(x(1)-x(2))*(x(1)*exp(-sigma*thres*d2^a/x(1)) - x(2)*exp(-sigma*thres*d2^a/x(2)));
            
position = x;



