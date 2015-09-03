%clear;
%load '../training_data/smile.mat'
%load '../training_data/teeth.mat'
load '../training_data/mouthopen.mat'
%load '../training_data/eyesopen.mat'
%feat=[convnetfeature(1:1000,:);graymaskconvnetfeature(1:1000,:)];
feat=[convnetfeature(1:1000,:);exconvnetfeature];
%feat=[gistrgb(1:1000,:);exgistrgb];
%feat=[gistrgb(1:1000,:);regularmaskgistrgb(1:1000,:)];
%feat=[siftfeature(1:1000,:);masksiftfeature(1:1000,:)];
n_train=[20 40 60 80 100 120 140 160 180 200];% 300 350 400 450 500];
%aug_ratio=[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
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
% for i=1:length(n_train)
%     for j=1:nrepeat
    clear img_t;
    clear t_order;
    clear Om;
    clear Sm;
    clear Rp;
%     index=randperm(length(img_train));
%     index=index(1:n_train(i));
	img_t=img_train;
    t_order=train_order;
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
n_O=size(Om,1);
n_R=size(Rp,1);
fprintf('Here\n');
for i=1:length(n_train)
	for j=1:10
	Ridx=randperm(n_R,n_train(i));
	
	R=Rp(Ridx,:);
     %wa=ALTR_train_v4(feat,Om,[Sm;Sp],Rp,s(1),s(1),1,0.5);
     wb=ALTR_train_v4(feat,Om,Sm,R,s(1),s(1),1,0.5);
     %wc=ALTR_train_v2(feat,Om,[Sm;Sp],s(1),s(1));
     wd=ALTR_train_v2(feat,Om,Sm,s(1),s(1));
%     %wb=ALTR_train_v3(feat,Om,Sm,s(i),s(i));
 	%predictions=convnetfeature*wa;
    %acc(1)= test(predictions,img_test,test_order);
    predictions=convnetfeature*wb;
    acc(i,1,j)= test(predictions,img_test,test_order);
    %predictions=convnetfeature*wc;
    %acc(3)= test(predictions,img_test,test_order);
    predictions=convnetfeature*wd;
    acc(i,2,j)= test(predictions,img_test,test_order);
	fprintf('%d %d\n',i,j);
    end
	ac1=mean(acc(i,1,:));
	ac2=mean(acc(i,2,:));
    fprintf('Sample ratio is %d, best AC =%f %f\n',n_train(i),ac1,ac2);
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
save('acc.mat','acc');