function [outage,position] = find_noma3_min_max_asym(sigma,d1,d2,a,thres)

% 返回在minmax定义下的第三组NOMA方案中断概率及最佳功率分配

% d1 = 15;
% d2 = 30;
% a = 3;
% thres = 5;
% sigma = 1/10^5;

position = zeros(1,4);
% 第一个时隙
fun1 = @(x)[-1*sigma*thres*d1^a/(thres*x+x-1);...
    sigma*thres*d2^a/x];
      

x0 = 0.1;
lb = 0 + sigma;
ub = 1/(1+thres)-sigma;
[x,fval1] = fminimax(fun1,x0,[],[],[],[],lb,ub);

position(1) = 1 - x;
position(3) = x;

% 第二个时隙
fun2 = @(x)[-1*sigma*thres*d2^a/(thres*x+x-1);...
    sigma*thres*d2^a/x];
      

x0 = 0.1;
lb = 0 + sigma;
ub = 1/(1+thres)-sigma;
[x,fval2] = fminimax(fun2,x0,[],[],[],[],lb,ub);

position(2) = 1 - x;
position(4) = x;

outage = 0.5*(max(fval1) + max(fval2));

