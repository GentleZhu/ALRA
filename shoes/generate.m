load '~/Desktop/DavisSummer/training_data/shoes/shoes_attributes.mat'
% m = size(test_inds,1);
% n = 1000;
% k = randperm(m/2*(m-1),n);
% q = floor(sqrt(8*(k-1) + 1)/2 + 3/2);
% p = k - (q-1).*(q-2)/2;
% 
% pairs=sortrows([p;q]',[2 1]);
% real_inds=test_inds(pairs);
% O=orders(1,:);
% img_order=O(class_labels(real_inds));
% test_order=3*ones(1000,1);
% test_order(img_order(:,1)<img_order(:,2))=2;
% test_order(img_order(:,1)>img_order(:,2))=1;
%get_order;

m = size(train_inds,1);
n = 500;
k = randperm(m/2*(m-1),n);
q = floor(sqrt(8*(k-1) + 1)/2 + 3/2);
p = k - (q-1).*(q-2)/2;

pairs=sortrows([p;q]',[2 1]);
real_inds=train_inds(pairs);
O=orders(7,:);
img_order=O(class_labels(real_inds));
train_order=3*ones(2000,1);
train_order(img_order(:,1)<img_order(:,2))=2;
train_order(img_order(:,1)>img_order(:,2))=1;