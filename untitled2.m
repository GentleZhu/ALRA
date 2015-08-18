load 'poolconvnet.mat'
load 'exconvnet.mat'
%load 'exteethconvnet.mat'
h=[convnetfeature;exconvnetfeature];
% train=h(:,1:1000);
% clear convnetfeature;
% for i=1:9216
%     cc(i,:)=h(i,:)/sum(h(i,:));
% %     cc(i,:)=h(i,:)-mean(h(i,:));
% %     if std(h(i,:))>0
% %         cc(i,:)=cc(i,:)/std(h(i,:));
% %     end
% end
% cc=cc';
cc=normr(h);
convnetfeature=cc(1:2000,:);
exconvnetfeature=cc(2001:2656,:);