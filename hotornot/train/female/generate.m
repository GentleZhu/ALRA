load 'hotornot.mat'
m = 217;
n = 1000;
k = randperm(m/2*(m-1),n);
q = floor(sqrt(8*(k-1) + 1)/2 + 3/2);
p = k - (q-1).*(q-2)/2;

pairs=sortrows([p;q]',[2 1])
get_order;