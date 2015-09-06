%clear;
function train_varyu(train_data)
%load (strcat('../training_data/',train_data))
load train_data
load 'test.mat';
load '~/Desktop/DavisSummer/training_data/shoes/shoes_attributes'
%load '../training_data/smile.mat'
%load '../training_data/teeth.mat'
%load '../training_data/mouthopen.mat'
%load '../training_data/eyesopen.mat'
%feat=[convnetfeature(1:1000,:);graymaskconvnetfeature(1:1000,:)];
aug_ratio=[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
%feat=[convnetfeature(1:1000,:);graymaskconvnetfeature(1:1000,:)];
%feat=[convnetfeature(1:1000,:);exconvnetfeature];
%feat=[gistrgb(1:1000,:);exgistrgb];
%feat=[gistrgb(1:1000,:);regularmaskgistrgb(1:1000,:)];
%feat=[siftfeature];
%n_train=[50 100 150 200 250 300 350 400 450 500];
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
%acc=zeros(50,1);
% for i=1:length(n_train)
%for j=1:50
%     clear img_t;
%     clear t_order;
%     clear Om;
%     clear Sm;
%     clear Rp;
    %index=randperm(length(pairs));
    %train_index=index(1:20);
    %test_index=index(21:end);
acc=zeros(10,2,10);
clear img_t;
    clear t_order;
    clear Om;
    clear Sm;
    clear Rp;
	img_t=img_train;
    t_order=train_order;
    n_R=size(Rp,1);
fprintf('Here\n');
    [Om,Sm]=constructTraining(img_t,feat,t_order);
    %[Rp]=addConstraints(Sm,img_t,t_order,2,img_train,train_order);
    [Rp]=addConstraints(Sm,img_t,t_order,2);
for i=1:numel(aug_ratio)
	for j=1:10
	Ridx=randperm(n_R,floor(aug_ratio(i)*n_R));
	
	R=Rp(Ridx,:);
    
    %img_test=pairs(test_index,1:2);
    %test_order=pairs(test_index,3);

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
     %wa=ALTR_train_v4(feat,Om,[Sm;Sp],Rp,s(1),s(1),1,1);
     wb=ALTR_train_v4(feat,Om,Sm,Rp,s(1),s(1),1,0.3);
     %wc=ALTR_train_v2(feat,Om,[Sm;Sp],s(1),s(1));
     wd=ALTR_train_v2(feat,Om,Sm,s(1),s(1));
     
     real_inds=test_inds(img_test);
    O=orders(7,:);
    img_order=O(class_labels(real_inds));
    test_order=3*ones(2000,1);
    test_order(img_order(:,1)<img_order(:,2))=2;
    test_order(img_order(:,1)>img_order(:,2))=1;

    %wb=ALTR_train_v3(feat,Om,Sm,s(i),s(i));
 	%predictions=testconvnetfeature*wa;
    %acc(1)= test(predictions,img_test,test_order);
    predictions=flipconvnetfeature*wb;
     acc(i,1,j)= test(predictions,img_test,test_order);
    %predictions=testconvnetfeature*wc;
    %acc(3)= test(predictions,img_test,test_order);
    predictions=flipconvnetfeature*wd;
     acc(i,2,j)= test(predictions,img_test,test_order);
    
    %fprintf('Best AC =%f %f\n',acc(2),acc(4));
    end
    ac1=mean(acc(i,1,:));
	ac2=mean(acc(i,2,:));
    fprintf('Sample ratio is %f, best AC =%f %f\n',aug_ratio(i),ac1,ac2);
end