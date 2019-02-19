function r = per(x,y,number)

[m,n] = size(x);
temp = x~=y;
count = 0;
for i = 0:m/number-1
    if sum(temp(i*number+1:(i+1)*number,1)) > 0
        count = count + 1;
    end
end
r = count/(m/number);