clear;
%load 'smile.mat'
load 'teeth.mat'
%load 'gistrgb.mat'
%load 'blurgistrgb.mat'
load 'regularmaskgistrgb.mat'
%load './localsift/siftfeature.mat'
%load './localsift/masksiftfeature.mat'
<<<<<<< HEAD
load 'convnetfeature.mat'
load 'graymaskconvnetfeature.mat'
%load 'mouthopen.mat'
feat=[convnetfeature(1:1000,:);graymaskconvnetfeature(1:1000,:)];
%feat=[convnetfeature(1:1000,:)];
%feat=[gistrgb(1:1000,:);regularmaskgistrgb(1:1000,:)];
s=[0.1 0.2 0.5 1];% 2 4 8 16 32 64 128 256 1000];
%load 'convnetfeature.mat'
%load 'graymaskconvnetfeature.mat'
load 'caffeconvnet.mat'
load 'caffegrayconvnet.mat'
%load 'mouthopen.mat'
feat=[convnetfeature(1:1000,:);graymaskconvnetfeature(1:1000,:)];
%feat=[convnetfeature(1:1000,:)];
%feat=[gistrgb(1:1000,:);regularmaskgistrgb(1:1000,:)];
s=[1];% 0.2 0.5 1 2 4 8 16 32 64 128 256 1000];
[Om,Sm]=constructTraining(img_train,feat,train_order);
[Rp]=addConstraints(Sm,img_train,train_order,2);
%[Sp]=addConstraints(Sm,img_train,train_order,1);
%Sp=[];
%Sp=sparse(Sp);
%Sm=[Sm;Sp];
%Rp=sparse(Rp);
%Om=[Om;Rp];
Sm=sparse(Sm);
Om=sparse(Om);
for i=1:length(s)
%     c_s(1:(size(Sm,1)+size(Sp,1)))=s(i);
%     C_S=c_s';
%     c_o(1:size(Om,1))=s(i);
%     C_O=c_o';
%    wa=ranksvm_with_sim(feat,Om,[Sm;Sp],C_O,C_S);
     %wa=ALTR_train(feat,Om,Sm,Sp,s(i),s(i),s(i));
    wb=ALTR_train_v4(feat,Om,Sm,Rp,s(i),s(i),1,2);
    %wb=ALTR_train_v3(feat,Om,Sm,s(i),s(i));
    predictions=convnetfeature*wb;
     [AC]= test(predictions,img_test,test_order);
 	fprintf('C=%f, AC =%f\n',s(i),AC);
% 	predictions=gistrgb*wb;
%     [AC]= test(predictions,img_test,test_order);
%     fprintf('C=%f,cvx_2 Ac=%f\n',s(i),AC);
%     predictions=gistrgb*wc;
%     [AC]= test(predictions,img_test,test_order);
%     fprintf('C=%f,cvx_3 Ac=%f\n',s(i),AC);
end
