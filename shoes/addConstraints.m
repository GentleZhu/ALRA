%function [ Rp ] = addConstraints(Rr,img_train,train_order,type,all_train,all_order)
function [ Rp ] = addConstraints(Rr,img_train,train_order,type)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if nargin<4
    type=1;
end
[~,d]=size(Rr);
n=sum(train_order~=3);
if type==1
    Rp=zeros(n,d);
else
    Rp=zeros(2*n,d);
end
idx= find(train_order~=3);
%R_train=all_train(all_order~=3,:);
%[~, rlist]=ismember(img_train(idx,:),R_train,'rows');
%d=2000;
if type==1
    for i=1:length(idx)
%         t=i;
%         if train_order(idx(i))==1
%             Rp(2*i-1,img_train(idx(i),1))=1;
%             Rp(2*i-1,162+2*t)=-1;
%             Rp(2*i,img_train(idx(i),2))=1;
%             Rp(2*i,163+2*t)=-1;
%         else
%             Rp(2*i-1,img_train(idx(i),1))=1;
%             Rp(2*i-1,162+2*t)=-1;
%             Rp(2*i,img_train(idx(i),2))=1;
%             Rp(2*i,163+2*t)=-1;
%         end
        if train_order(idx(i))==1
            Rp(i,162+2*i)=1;
            Rp(i,163+2*i)=-1;
         else
            Rp(i,162+2*i)=1;
            Rp(i,163+2*i)=-1;
         end
%         if train_order(idx(i))==1
%         Rp(i,img_train(idx(i),1)+d/2)=1;
%         Rp(i,img_train(idx(i),2)+d/2)=-1;
%         end
%         if train_order(idx(i))==2
%     	Rp(i,img_train(idx(i),1)+d/2)=-1;
%         Rp(i,img_train(idx(i),2)+d/2)=1;
%         end
    %	if i>1
    %		[p,~]=sort([img_train(idx(i-1),2),img_train(idx(i),1)]);
    %		Sp(i,p(1)+d/2)=1;
    %		Sp(i,p(2)+d/2)=-1;
    %	end
%         t=i;
%         if train_order(idx(i))==1
%             Rp(2*i-1,img_train(idx(i),1))=1;
%             Rp(2*i-1,1000+2*t)=-1;
%             Rp(2*i,img_train(idx(i),2))=-1;
%             Rp(2*i,999+2*t)=1;
%         else
%             Rp(2*i-1,img_train(idx(i),1))=-1;
%             Rp(2*i-1,1000+2*t)=1;
%             Rp(2*i,img_train(idx(i),2))=1;
%             Rp(2*i,999+2*t)=-1;
%         end
    end
else
     for i=1:length(idx)
%          %t=rlist(i);
%          if train_order(idx(i))==1
%             Rp(i,999+2*i)=1;
%             Rp(i,1000+2*i)=-1;
%          else
%             Rp(i,1000+2*i)=1;
%             Rp(i,999+2*i)=-1;
% %          end
         t=i;
        if train_order(idx(i))==1
            Rp(2*i-1,img_train(idx(i),1))=1;
            Rp(2*i-1,167+2*t)=-1; %this should be chaned as dataset varies
            Rp(2*i,img_train(idx(i),2))=-1;
            Rp(2*i,168+2*t)=1;
        else
            Rp(2*i-1,img_train(idx(i),1))=-1;
            Rp(2*i-1,167+2*t)=1;
            Rp(2*i,img_train(idx(i),2))=1;
            Rp(2*i,168+2*t)=-1;
          end
%         if train_order(idx(i))==1
%         Rp(i,img_train(idx(i),1))=1;
%         Rp(i,162+2*i)=-1;
%         else
%     %     if train_order(idx(i))==2
%          Rp(i,163+2*i)=-1;
%          Rp(i,img_train(idx(i),2))=1;
%         end
%     	if i>1
%     		[p,~]=sort([img_train(idx(i-1),2),img_train(idx(i),1)]);
%     		Sp(i,p(1)+d/2)=1;
%     		Sp(i,p(2)+d/2)=-1;
%     	end
    end
end
end

