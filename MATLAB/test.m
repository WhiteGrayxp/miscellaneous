all clear;
p = 0:0.001:2/3;
threshold = 0.5;
d = 10;
a = 0.2;
pout = 1 - exp(-0.5*threshold*d^a./p);
pout2 = 1 - exp(0.5*threshold*d^a./(threshold*p+p-1));
pout3 = 2 - exp(-0.5*threshold*d^a./p) - exp(-0.5*threshold*d^a./(1-p));

figure(1);
subplot(3,1,1);plot(p,pout);
subplot(3,1,2);plot(p,pout2);
subplot(3,1,3);plot(p,pout+pout2);

figure(2);
plot(p,pout+pout2,'r',p,pout3,'b');
