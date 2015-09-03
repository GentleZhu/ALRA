function [ info_pair,idx ] = APAL_active( model,p,batch )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n=size(model.feat,1);
n_pair=size(model.img_train,1);
x=model.feat;
pair=model.img_train;
%rank_dist=zeros(n);
predictions=x*model.w;
%tic;
rank_dist=abs(bsxfun(@minus,predictions,predictions'));
%toc
%tic;
% for i=1:n
%     for j=setdiff(1:n,i)
%     rank_dist(i,j)=abs(predictions(i)-predictions(j));
%     end
% end
%find(test~=rank_dist)
%toc
%fprintf('rank_dist is ok!\n');
info_mat=zeros(n_pair,1);
used=[model.init;model.selected];
%count=0;
for i=1:n_pair
    if ismember(i,used)
        continue
    end
    %count=count+1;
    info_mat(i)=(info_entropy(rank_dist(pair(i,1),:))+ info_entropy(rank_dist(pair(i,2),:)))*(rank_dist(pair(i,1),pair(i,2)))^(-p);
end
%info_mat(model.selected)=0;
%fprintf('Used count %d\n',count);
[~,idx]=max(info_mat);
info_pair=pair(idx,:);

function info_en = info_entropy(a)
a = (a-min(a)) / (max(a)-min(a));
% info_en = 0;
% for i=1:length(a)
%     if (a(i)~=0)
%         info_en = info_en - a(i)*log2(a(i));
%     end
% end
a(a==0)=[];
%fprintf('info_en %f,%f',info_en,-a*log2(a)');
info_en=-a*log2(a)';

