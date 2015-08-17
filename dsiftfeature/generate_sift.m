load 'original2_bin.mat'
load 'mask2_bin.mat'
%load 'maskhistogram.mat'
%h=maskhistogram;
%siftfeature=bsxfun(@rdivide,h,sum(h));
%bin=bin-mask_bin;
% train=bin(:,1:1000);
% test=bin(:,1001:2000);
% [P,~]=size(bin);
% siftfeature=zeros(size(bin));
% epsilon=0.001;
% for i=1:P
%     siftfeature(i,:)=bin(i,:)-mean(train(i,:));
%     if std(train(i,:))>0
%         siftfeature(i,:)=siftfeature(i,:)/std(train(i,:));
%     end
% end
bin=bin-5*mask_bin;
[P,~]=size(bin);
siftfeature=zeros(size(bin));
for i=1:P
    siftfeature(i,:)=bin(i,:)/sum(bin(i,:));
end

%siftfeature=normr(bin);

% MIN=min(bin,[],2);
% MAX=max(bin,[],2);
% siftfeature=bsxfun(@minus,bin,MIN);
% siftfeature=bsxfun(@rdivide,siftfeature,MAX-MIN);
masksiftfeature=siftfeature';
save('maskdsiftfeature.mat','masksiftfeature');