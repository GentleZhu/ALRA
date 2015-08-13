function [ Sr,Sp ] = addConstraints(Sr,img_train,train_order )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[~,d]=size(Sr);
%d=2000;
n=sum(train_order~=3);
Sp=zeros(n,d);
idx=find(train_order~=3);
for i=1:length(idx)
%     if train_order(idx(i))==1
	Sp(i,img_train(idx(i),1)+d/2)=1;
    Sp(i,img_train(idx(i),2)+d/2)=-1;
%     end
%     if train_order(idx(i))==2
% 	Sp(i,img_train(idx(i),1)+d/2)=-1;
%     Sp(i,img_train(idx(i),2)+d/2)=1;
%     end
%	if i>1
%		[p,~]=sort([img_train(idx(i-1),2),img_train(idx(i),1)]);
%		Sp(i,p(1)+d/2)=1;
%		Sp(i,p(2)+d/2)=-1;
%	end
end
end

