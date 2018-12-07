function f = myfit(x)

d1 = 15;
d2 = 25;
a = 3;
sigma = 0.0001/10^a;
thres = 5;


f = 4 - exp(sigma*thres*d1^a./(thres*x(1)+x(1)-1)) - ...
exp(sigma*thres*d2^a./(thres*x(2)+x(2)-1)) - 1./(x(1)-x(2)).*(x(1).*(exp(-sigma*thres*d1^a./x(1)) + ...
exp(-sigma*thres*d2^a./x(1))) - x(2).*(exp(-sigma*thres*d1^a./x(2)) + exp(-sigma*thres*d2^a./x(2))));