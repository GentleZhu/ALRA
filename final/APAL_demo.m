function APAL_demo( train_data,init_sample,train_iter,batch,feature )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
addpath '~/Desktop/DavisSummer/training_data/'
load (train_data);
if nargin<4
    batch=1;
end
if nargin<5
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
train_index=randperm(n_sample,init_sample)';
Rp=addConstraints(size(feat,2),img_train,train_order,2);
active_feat=[feat;augfeat];
Aug=[];
model.selected=[];
iter=0;
img_partial=img_train(train_order~=3,:);
model.init=train_index;
model.feat=feat;
while iter<100
    if length(model.selected)>0
        ind=augment_select(model.selected,img_train,img_partial);
        %ind
        Aug=Rp(ind,:);
        
    end
    [Om,Sm]=constructTraining(img_train(train_index,:),feat,train_order(train_index));
    model.w=rankSVM_train(active_feat,Om,Sm,Aug,1,1,1,0.5);
    model.img_train=img_train;
    [info_pair,info_index]=APAL_active(model,1,batch);
    if ismember(info_index,train_index)
        error 'Select training data'
    else
        model.selected=[model.selected;info_index];
        train_index=[train_index;info_index];
    end
    iter=iter+batch;
    predictions=X*model.w;
    acc= test(predictions,img_test,test_order);
    fprintf('# %d of active training, choose %d pair, %d and %d accuracy is %f\n',iter,info_index,info_pair(1),info_pair(2),acc);
end
end

