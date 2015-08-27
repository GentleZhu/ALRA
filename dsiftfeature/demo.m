%load '~/Desktop/DavisSummer/training_data/eyesopen.mat'
%load '../dataset/LFW10/annotations/trainpairs.mat'
%load '../dataset/LFW10/code/testpairs.mat'
load '~/Desktop/DavisSummer/training_data/smile.mat'
load 'original2_bin.mat'
load 'mask2_bin.mat'
n=sum(train_order~=3);
idx=find(train_order~=3);
bin=bin';
mask_bin=mask_bin';
masksiftfeature=zeros(2*n,1000);
%addpath '~/Desktop/DavisSummer/dataset/LFW10/mask'
for i=1:n
    %clear img_A;
    %clear img_B;
    fprintf('%d\n',i);
    id_1=img_train(idx(i),1);
    id_2=img_train(idx(i),2);
    masksiftfeature(2*i-1,:)=bin(id_1,:)-mask_bin(id_1,:)+mask_bin(id_2,:);
    masksiftfeature(2*i,:)=bin(id_2,:)-mask_bin(id_2,:)+mask_bin(id_1,:);
    %break;
end
