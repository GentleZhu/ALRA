function [ exfeature ] = swapdsift( img_train,train_order,bin,mask_bin )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
n=sum(train_order~=3);
idx=find(train_order~=3);
d=size(bin,1);
exfeature=zeros(2*n,d);
bin=bin';
mask_bin=mask_bin';
for i=1:length(idx)
    exfeature(2*i-1,:)=bin(img_train(idx(i),1),:)-mask_bin(img_train(idx(i),1),:)+mask_bin(img_train(idx(i),2),:);
    exfeature(2*i,:)=bin(img_train(idx(i),2),:)-mask_bin(img_train(idx(i),2),:)+mask_bin(img_train(idx(i),1),:);
end
exfeature=normr(exfeature);

