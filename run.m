clear;
%load 'smile.mat'
load 'teeth.mat'
%load 'gistrgb.mat'
%load 'blurgistrgb.mat'
load 'regularmaskgistrgb.mat'
%load './localsift/siftfeature.mat'
%load './localsift/masksiftfeature.mat'
%load 'convnetfeature.mat'
%load 'graymaskconvnetfeature.mat'
%load 'mouthopen.mat'
%feat=[convnetfeature(1:1000,:);graymaskconvnetfeature(1:1000,:)];
%feat=[convnetfeature(1:1000,:)];
feat=[gistrgb(1:1000,:);regularmaskgistrgb(1:1000,:)];
s=[0.1];% 0.2 0.5 1 2 4 8 16 32 64 128 256 1000];
[Om,Sm]=constructTraining(img_train,feat,train_order);
Sm=addConstraints(Sm,img_train,train_order);
Sm=sparse(Sm);
Om=sparse(Om);
for i=1:length(s)
    c_s(1:size(Sm,1))=s(i);
    C_S=c_s';
    c_o(1:size(Om,1))=s(i);
    C_O=c_o';
    wa=ranksvm_with_sim(feat,Om,Sm,C_O,C_S);
	wb=ALTR_train(feat,Om,Sm,C_O,C_S);
    predictions=gistrgb*wa;
    [AC]= test(predictions,img_test,test_order);
	printf('C=%f, ranksvm AC =%f\n',s(i),AC);
	predictions=gistrgb*wb;
    fprintf('C=%f,cvx Ac=%f\n',s(i),AC);
end
