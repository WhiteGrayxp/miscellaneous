clear;
clf;
thres = 5;
lb = [0;0];
ub = [1/6;1/6];
options = optimoptions('ga','ConstraintTolerance',1e-6,'PlotFcn', @gaplotbestf);
[X,FVAL,EXITFLAG,OUTPUT] = ga(@myfit,2,[],[],[],[],lb,ub,[],[],options);
