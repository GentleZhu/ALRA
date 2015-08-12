function [ O,S ] = constructTraining( pairs,feat,relation)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%if nargin < 3,  threshold=0.02;  end;
[n_train,~]=size(pairs);
[N,~]=size(feat);
% X(X(:,1)>X(:,2),:)=[1,-1];
% X(X(:,1)<X(:,2),:)=[-1,1];
O=[];
S=[];
%N
for i=1:n_train
    temp=zeros(1,N);
    if relation(i)~=3
        temp(pairs(i,1)+N/2)=1;
        temp(pairs(i,2)+N/2)=-1;
        S=[S;temp];
    end
    temp=zeros(1,N);
    if relation(i)==1
        temp(pairs(i,1))=1;
        temp(pairs(i,2))=-1;
        O=[O;temp];
%         temp(pairs(i,1))=0;
%         temp(pairs(i,2))=0;
%         temp(pairs(i,1)+N/2)=1;
%         temp(pairs(i,2))=-1;
%         O=[O;temp];
    else if relation(i)==2
        temp(pairs(i,1))=-1;
        temp(pairs(i,2))=1;
        O=[O;temp];
%         temp(pairs(i,1))=0;
%         temp(pairs(i,2))=0;
%         temp(pairs(i,1)+N/2)=-1;
%         temp(pairs(i,2))=1;
%         O=[O;temp];
        else if relation(i)==3
            temp(pairs(i,1))=1;
            temp(pairs(i,2))=-1;
            S=[S;temp];
        end
    end
end
S=sparse(S);
O=sparse(O);
end
%O=zeros(
%o=feat(pairs);
%o=find(abs(o(:,1)-o(:,2))<threshold);

