clear;
%load 'smile.mat'
load 'teeth.mat'
%load 'gistrgb.mat'
%load 'blurgistrgb.mat'
%load './localsift/siftfeature.mat'
%load './localsift/masksiftfeature.mat'
%load 'convnetfeature.mat'
%load 'maskconvnetfeature.mat'
%load 'mouthopen.mat'
%feat=[convnetfeature(1:1000,:);maskconvnetfeature(1:1000,:)];
%feat=[convnetfeature(1:1000,:)];
feat=[gistrgb(1:1000,:);maskgistrgb(1:1000,:)];
s=[0.1 0.2 0.5 1 2 4 8 16 32 64 128 256 1000];
[Om,Sm]=constructTraining(img_train,feat,train_order);
for i=1:length(s)
    c_s(1:size(Sm,1))=s(i);
    C_S=c_s';
    c_o(1:size(Om,1))=s(i);
    C_O=c_o';
    w=ranksvm_with_sim(feat,Om,Sm,C_O,C_S);
    predictions=gistrgb*w;
    [AC]= test(predictions,img_test,test_order);
    fprintf('C=%f,Ac=%f\n',s(i),AC);
end