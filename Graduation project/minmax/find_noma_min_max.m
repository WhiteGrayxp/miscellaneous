function [outage,position] = find_noma_min_max(sigma,d1,d2,a,thres)

% 返回在minmax定义下的中断概率及最佳功率分配

% f(1) = outage_11
% f(2) = outage_22
% f(3) = outage_13
% f(4) = outage_23


fun = @(x)[1 - exp(sigma*thres*d1^a/(thres*x(1)+x(1)-1));...
    1 - exp(sigma*thres*d2^a/(thres*x(2)+x(2)-1));...
    1 - 1/(x(1)-x(2))*(x(1)*exp(-sigma*thres*d1^a/x(1)) - x(2)*exp(-sigma*thres*d1^a/x(2)));...
    1 - 1/(x(1)-x(2))*(x(1)*exp(-sigma*thres*d2^a/x(1)) - x(2)*exp(-sigma*thres*d2^a/x(2)))];

% fun = @(x)[thres*d1^a*sigma/(1-x(1)-thres*x(1));...
%     thres*d2^a*sigma/(1-x(2)-thres*x(2));...
%     thres^2*d1^(2*a)*sigma^2/(2*x(1)*x(2));...
%     thres^2*d2^(2*a)*sigma^2/(2*x(1)*x(2))];
            

x0 = [0.1;0.1];
lb = [0+sigma;0+sigma];
ub = [1/(1+thres)-sigma;1/(1+thres)-sigma];
[x,fval] = fminimax(fun,x0,[],[],[],[],lb,ub);

outage = fval;
position = x;


