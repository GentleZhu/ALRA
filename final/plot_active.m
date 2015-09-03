h=plot(acc(1:40,:));
l = cell(1,2);
l{1}='Active+augment';l{2}='Random+augment';
legend(h,l);