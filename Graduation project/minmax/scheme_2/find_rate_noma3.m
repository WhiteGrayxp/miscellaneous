function rate = find_rate_noma3(p,sigma,d1,d2,a,thres)

p1 = p(1);
p2 = p(2);
p3 = p(3);
p4 = p(4);

rate_noma_1 = 0.5*(log2(1+p1/(p3+d1^a*sigma)) + log2(1+p3/(d1^a*sigma)) + log2(1+p4/(d1^a*sigma)));
rate_noma_2 = 0.5*(log2(1+p2/(p4+d2^a*sigma)) + log2(1+p3/(d2^a*sigma)) + log2(1+p4/(d2^a*sigma)));

rate = rate_noma_1 + rate_noma_2;

