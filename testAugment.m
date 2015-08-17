 clear;
clc;
load 'smile.mat'
load 'teeth.mat'
%load 'mouthopen.mat'
%load 'regularmaskgistrgb.mat'
load 'exteethconvnet'
load 'poolconvnet'
%load 'poolmaskconvnet'
%load 'poolmask2convnet'
idx=find(train_order~=3);
img_augment=zeros(length(idx),2);
augment_order=zeros(length(idx),1);
%feat=[gistrgb(1:1000,:);regularmaskgistrgb(1:1000,:)];
feat=[convnetfeature(1:1000,:);graymaskconvnetfeature(1:1000,:)];
%feat=[]
% for i=1:length(idx)
%     if train_order(idx(i))==1
%         img_augment(i,:)=[img_train(idx(i),1),img_train(idx(i),2)+1000];
%         augment_order(i)=1;
%     else
%         img_augment(i,:)=[img_train(idx(i),1)+1000,img_train(idx(i),2)];
%         augment_order(i)=2;
%     end
%     
% end
[Om,Sm]=constructTraining(img_train,feat,train_order);
[Rp]=addConstraints(Sm,img_train,train_order,2);
[Sp]=addConstraints(Sm,img_train,train_order,1);
wa=ALTR_train_v2(feat,Om,Sm,1,1);
predictions=convnetfeature*wa;
acc(1)= test(predictions,img_test,test_order);
predictions=feat*wa;
acc(2)=test(predictions,img_augment,augment_order);

wb=ALTR_train_v2(feat,Om,[Sm;Sp],1,1);
predictions=convnetfeature*wb;
acc(3)= test(predictions,img_test,test_order);
predictions=feat*wb;
acc(4)=test(predictions,img_augment,augment_order);

wc=ALTR_train_v4(feat,Om,Sm,Rp,1,1,1,0.5);
predictions=convnetfeature*wc;
acc(5)= test(predictions,img_test,test_order);
predictions=feat*wc;
acc(6)=test(predictions,img_augment,augment_order);

fprintf('Original Test err %f, Augment err %f\n',acc(1),acc(2));
fprintf('Add Equivalent Test err %f, Augment err %f\n',acc(3),acc(4));
fprintf('Add Partial Test err %f, Augment err %f\n',acc(5),acc(6));