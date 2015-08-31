%clear;
%load '~/Desktop/DavisSummer/training_data/smile.mat'
%load '~/Desktop/DavisSummer/training_data/teeth.mat'
load '~/Desktop/DavisSummer/training_data/mouthopen.mat'
%load '~/Desktop/DavisSummer/training_data/eyesopen.mat'
%load '~/Desktop/DavisSummer/training_data/vforehead.mat'
%load '~/Desktop/DavisSummer/training_data/baldhead.mat'
%load '~/Desktop/DavisSummer/training_data/hot.mat'
%load  'dsiftfeature/dsiftfeature.mat'
%load  'dsiftfeature/swapdsiftfeature.mat'
%feat=[convnetfeature(1:1000,:);graymaskconvnetfeature(1:1000,:)];
feat=[convnetfeature(1:1000,:);exconvnetfeature];
%feat=[gistrgb(1:1000,:);exgistrgb];
%feat=[gistrgb(1:1000,:);regularmaskgistrgb(1:1000,:)];
%feat=[siftfeature];
%n_train=[0.1 100 150 200 250 300 350 400 450 500];
aug_ratio=[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]
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
acc=zeros(10,2,10);
n_train=length(img_train)
for i=1:length(aug_ratio)
for j=1:10
    clear img_t;
    clear t_order;
    clear Om;
    clear Sm;
    clear Rp;
    index=randperm(n_train);
    train_index=index(1:int(aug_ratio(i)*n_train));
    %test_index=index(21:end);
	img_t=pairs(train_index,:);
    t_order=train_order(train_index);
    %img_test=pairs(test_index,1:2);
    %test_order=pairs(test_index,3);
    [Om,Sm]=constructTraining(img_t,feat,t_order);
    %[Rp]=addConstraints(Sm,img_t,t_order,2,img_train,train_order);
     [Rp]=addConstraints(Sm,img_t,t_order,2);
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
     wb=ALTR_train_v4(feat,Om,Sm,Rp,s(1),s(1),1,0.5);
     %wc=ALTR_train_v2(feat,Om,[Sm;Sp],s(1),s(1));
     wd=ALTR_train_v2(feat,Om,Sm,s(1),s(1));
    %wb=ALTR_train_v3(feat,Om,Sm,s(i),s(i));
 	%predictions=convnetfeature*wa;
    %acc(1)= test(predictions,img_test,test_order);
    predictions=siftfeature*wb;
    acc(i,1,j)= test(predictions,img_test,test_order);
    %predictions=convnetfeature*wc;
    %acc(3)= test(predictions,img_test,test_order);
    predictions=siftfeature*wd;
    acc(i,2,j)= test(predictions,img_test,test_order);
    
    fprintf('I %d J %d Best AC =%f %f\n',i,j,acc(i,1,j),acc(i,2,j));
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
