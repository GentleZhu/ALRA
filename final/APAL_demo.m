function APAL_demo( train_data,init_sample,train_iter,nrepeat,batch,feature )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
addpath '~/Desktop/DavisSummer/training_data/faces'
%addpath '../../training_data'
load (train_data);
if nargin<5
    batch=1;
end
if nargin<6
    feature='CNN';
end
if feature=='CNN'
    feat=convnetfeature(1:1000,:);
    X=convnetfeature;
    augfeat=exconvnetfeature;
else
    feat=gistrgb(1:1000,:);
    augfeat=exgisrgb;
    X=gistrgb;
end
n_sample=size(img_train,1);
acc=zeros(nrepeat,train_iter,2);
for i=1:nrepeat
clear passive;
clear model;
iter=0;
train_index=randperm(n_sample,init_sample)';
model.train_index=train_index;
passive.train_index=train_index;
Rp=addConstraints(size(feat,2),img_train,train_order,2);
active_feat=[feat;augfeat];
model.Aug=[];
model.selected=[];
passive.Aug=[];
passive.selected=[];
passive.train_order=train_order;
img_partial=img_train(train_order~=3,:);
model.init=train_index;
model.feat=feat;
passive.init=train_index;
passive.feat=feat;
model.img_train=img_train;
passive.img_train=img_train;



while iter<train_iter
    if ~isempty(model.selected)
        ind=augment_select(model.selected,img_train,img_partial);
        if size(model.Aug,1)<length(ind)
			aug_flag=1;
		else
			aug_flag=0;
		end
			model.Aug=Rp(ind,:);
			[~,passive_index]=APAL_passive(passive,aug_flag,batch);
			if ismember(passive_index,passive.train_index)
				error 'Passive select training data'
			else
				passive.selected=[passive.selected;passive_index];
				passive.train_index=[passive.train_index;passive_index];
			end
			ind=augment_select(passive.selected,img_train,img_partial);
			passive.Aug=Rp(ind,:);
		%end
		%size(model.Aug)
		%size(passive.Aug)
		if size(passive.Aug,1)~=size(model.Aug,1)
			error 'Passive does not equal with active'
		end
        
    end
    [Om,Sm]=constructTraining(img_train(train_index,:),feat,train_order(train_index));
    model.w=rankSVM_train(active_feat,Om,Sm,model.Aug,1,1,1,0.7);
    passive.w=rankSVM_train(active_feat,Om,Sm,passive.Aug,1,1,1,0.7);
	[info_pair,info_index]=APAL_active(model,1,batch);
    if ismember(info_index,model.train_index)
        error 'Select training data'
    else
        model.selected=[model.selected;info_index];
        model.train_index=[model.train_index;info_index];
    end
    iter=iter+batch;
    predictions=X*model.w;
    acc(i,iter,1)= test(predictions,img_test,test_order);
    acc(i,iter,2)= test(X*passive.w,img_test,test_order);
	fprintf('Epoch %d, # %d of active training, choose %d pair, %d and %d active accuracy is %f, passive is %f\n',i,iter,info_index,info_pair(1),info_pair(2),acc(i,iter,1),acc(i,iter,2));
end
end
save('acc_active.mat','acc');
