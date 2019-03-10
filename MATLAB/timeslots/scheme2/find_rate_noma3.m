function [r11,r13,r22,r23] = find_rate_noma3(p,B,sigma,d1,d2,a,thres)

p1 = p(1);
p2 = p(2);
p3 = p(3);
p4 = p(4);

r11 = 0.5*B*log2(1+p1/(p3+d1^a*sigma));
r13 = 0.5*B*(log2(1+p3/(d1^a*sigma)) + log2(1+p4/(d1^a*sigma)));
r22 = 0.5*B*log2(1+p2/(p4+d2^a*sigma));
r23 = 0.5*B*(log2(1+p3/(d2^a*sigma)) + log2(1+p4/(d2^a*sigma)));

