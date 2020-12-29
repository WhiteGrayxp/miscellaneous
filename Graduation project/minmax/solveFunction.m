function [p3,p33] = solveFunction(sigma,d1,d2,a,thres)
% r = thres; s = sigma
r = thres;
s = sigma;

fun = @(x)[2*x(1)*x(2)+(1+r)*r*d2^a*s*x(2)-r*d2^a*s,...
    d1^a*(1-x(2)-r*x(2))-d2^a*(1-x(1)-r*x(1))];

x0 = [0.1,0.1];
x = fsolve(fun,x0);
p3 = x(1);
p33 = x(2);