%clear;
%load '~/Desktop/DavisSummer/training_data/smile.mat'
%load '~/Desktop/DavisSummer/training_data/teeth.mat'
%load '~/Desktop/DavisSummer/training_data/mouthopen.mat'
%load '~/Desktop/DavisSummer/training_data/eyesopen.mat'
%load '~/Desktop/DavisSummer/training_data/vforehead.mat'
%load '~/Desktop/DavisSummer/training_data/baldhead.mat'
%load '~/Desktop/DavisSummer/training_data/hot.mat'
load '~/Desktop/DavisSummer/training_data/hotmale.mat'
%load  'dsiftfeature/dsiftfeature.mat'
%load  'dsiftfeature/swapdsiftfeature.mat'
%feat=[convnetfeature(1:1000,:);graymaskconvnetfeature(1:1000,:)];
%feat=[convnetfeature(1:1000,:);exconvnetfeature];
%feat=[gistrgb(1:1000,:);exgistrgb];
%feat=[gistrgb(1:1000,:);regularmaskgistrgb(1:1000,:)];
feat=[siftfeature];
n_train=[50 100 150 200 250 300 350 400 450 500];
s=[1];% 0.2 0.5 1 2 4 8 16 32 64 128 256 1000];
%u=[0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2]
%Sp=[];
%Sp=sparse(Sp);
%Sm=[Sm;Sp];
% Rp=sparse(Rp);
%Om=[Om;Rp];
% Sm=sparse(Sm);
% Om=sparse(Om);
%nrepeat=1;
acc=zeros(50,2);
% for i=1:length(n_train)
exfeature=[];
test_index=201:1000;
for j=1:50
    clear img_t;
    clear t_order;
    clear Om;
    clear Sm;
    clear Rp;
    train_index=randperm(200,100);
    %train_index=index(1:40);
	img_t=pairs(train_index,1:2);
    t_order=pairs(train_index,3);
    img_test=pairs(test_index,1:2);
    test_order=pairs(test_index,3);
    exfeature=swapdsift(img_t,t_order,bin,mask_bin);
    [Om,Sm]=constructTraining(img_t,[feat;exfeature],t_order);
    
    %[Rp]=addConstraints(Sm,img_t,t_order,2,img_train,train_order);
    [Rp]=addConstraints(Sm,img_t,t_order,2);
    %break;
    %[Sp]=addConstraints(Sm,img_t,t_order,1);
%for i=1:length(s)
%Om=[Sm;Sp];
%       c_s(1:size(Sm,1))=s(1);
%       C_S=c_s';
%       c_o(1:size(Om,1))=s(1);
%       C_O=c_o';
%wb=ranksvm_with_sim(feat,Om,Sm,C_O,C_S);
%    
%for i=1:length(u)
     %wa=ALTR_train_v4(feat,Om,[Sm;Sp],Rp,s(1),s(1),1,0.5);
     wa=ALTR_train_v4([feat;exfeature],Om,Sm,Rp,s(1),s(1),1,1);
     wb=ALTR_train_v4([feat;exfeature],Om,Sm,Rp,s(1),s(1),1,0.5);
     %wc=ALTR_train_v2(feat,Om,[Sm;Sp],s(1),s(1));
     wd=ALTR_train_v2([feat;exfeature],Om,Sm,s(1),s(1));
    %wb=ALTR_train_v3(feat,Om,Sm,s(i),s(i));
 	predictions=feat*wa;
    acc(j,1)= test(predictions,img_test,test_order);
    predictions=feat*wb;
    acc(j,2)= test(predictions,img_test,test_order);
    %predictions=convnetfeature*wc;
    %acc(3)= test(predictions,img_test,test_order);
    predictions=feat*wd;
    acc(j,3)= test(predictions,img_test,test_order);
    
    fprintf('Best AC =%f %f %f\n',acc(j,1),acc(j,2),acc(j,3));
end
	%fprintf('Best AC =%f %f %f %f\n',acc(1),acc(2),acc(3),acc(4));
%     predictions=gistrgb*wb;
%     [AC]= test(predictions,img_test,test_order);
%     fprintf('C=%f,cvx_2 Ac=%f\n',s(i),AC);
%     predictions=gistrgb*wc;
%     [AC]= test(predictions,img_test,test_order);
%     fprintf('C=%f,cvx_2 Ac=%f\n',s(1),AC);
    %end
     %break;
%end
%save('acc.mat','acc');
