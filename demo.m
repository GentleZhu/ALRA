clear;
%load 'smile.mat'
load 'teeth.mat'
%load 'gistrgb.mat'
%load 'blurgistrgb.mat'
%load './localsift/siftfeature.mat'
%load './localsift/masksiftfeature.mat'
%load 'maskconvnetfeature.mat'
%load 'convnetfeature.mat'
%load 'mouthopen.mat'
%load ('./O_S.mat');
%gistrgb=double(hh);
feat=[gistrgb(1:1000,:);maskgistrgb(1:1000,:)];
n_sample=[20 40 60 80 100 120 140 160 180 200];
%Accuracy=zeros(10,10);
Co=[0.1 0.2 0.5 1 2 4 8];% 64 128 256 512 1000];
Cs=[0.1 0.2 0.5 1 2 4 8];% 64 128 256 512 1000];
acc=zeros(length(Co),length(Cs),5);
A=zeros(length(Co),length(Cs));
%feat=[siftfeature(1:1000,:);masksiftfeature(1:1000,:)];
%feat=[convnetfeature(1:1000,:);maskconvnetfeature(1:1000,:)];
%feat=siftfeature(1:1000,:);
%feat=double(gistrgb(1:1000,:));
%feat=double(blurgistrgb);
%  img_train=img_train(train_order~=3,:);
%  train_order=train_order(train_order~=3);
% for k=1:10
%     for nrepeat=1:10
%        fprintf('k = %d, nrepeat=%d\n',k,nrepeat);
        clear index;
        clear O;
        clear S;
        clear sb;
        clear sd;
        clear sbs;
        clear sds;
        clear t_all;
        clear t_all2;
        %index=randperm(length(train_order));
        %index=index(1:n_sample(k));
        %size(index)
        [O,S]=constructTraining(img_train,feat,train_order);
        %fprintf('Size O and size S,%d,%d',size(O,1),size(S,1));
        O=full(O);
        S=full(S);
        t_all=size(O,1)-rem(size(O,1),5);
        t_all2=size(S,1)-rem(size(S,1),5);

        t1=1:t_all/5; t2=(t_all/5)+1:(t_all*2)/5; t3=((t_all*2)/5)+1:(t_all*3)/5; t4=((t_all*3)/5)+1:(t_all*4)/5; t5=((t_all*4)/5)+1:t_all;
         sb(1,:)=[t1,t2,t3,t4]; sd(1,:)=[t5];
         sb(2,:)=[t1,t2,t4,t5]; sd(2,:)=[t3];
         sb(3,:)=[t1,t5,t3,t4]; sd(3,:)=[t2];
         sb(4,:)=[t1,t2,t3,t5]; sd(4,:)=[t4];
         sb(5,:)=[t2,t3,t4,t5]; sd(5,:)=[t1];


         t1=1:t_all2/5; t2=(t_all2/5)+1:(t_all2*2)/5; t3=((t_all2*2)/5)+1:(t_all2*3)/5; t4=((t_all2*3)/5)+1:(t_all2*4)/5; t5=((t_all2*4)/5)+1:t_all2;
         sbs(1,:)=[t1,t2,t3,t4]; sds(1,:)=[t5];
         sbs(2,:)=[t1,t2,t4,t5]; sds(2,:)=[t3];
         sbs(3,:)=[t1,t5,t3,t4]; sds(3,:)=[t2];
         sbs(4,:)=[t1,t2,t3,t5]; sds(4,:)=[t4];
         sbs(5,:)=[t2,t3,t4,t5]; sds(5,:)=[t1];


        for k=1:length(Co)
        for j=1:length(Cs)
            clear OR;
            clear SM;
            clear to;
            clear ts;
            
        for i=1:5

            clear TR_S;
            clear TR_O;
            clear T_S;
            clear T_O;
            clear tr_s;
            clear tr_o;
            clear t_s;
            clear t_o;
            clear c_s;
            clear c_o;
        OR=O(sb(i,:),:); SM=S(sbs(i,:),:);

        to=O(sd(i,:),:); ts=S(sds(i,:),:);


       %SM=addConstraints(OR,SM);
        tr_s(1:size(SM,1))=Cs(j); TR_S=tr_s';

        %tr_o(1:size(OR,1))=s2(k); TR_O=tr_o';
        tr_o(1:size(OR,1))=Co(k); TR_O=tr_o';

        t_s(1:size(ts,1))=Cs(j); T_S=tr_s';

        %t_o(1:size(to,1))=s2(k); T_O=tr_o';
        t_o(1:size(to,1))=Co(k); T_O=tr_o';
        
        
        w=ranksvm_with_sim(feat,sparse(OR),sparse(SM),TR_O,TR_S);
        %[~,w]=demo_train(feat,O,S,1);
        %predictions=gistrgb*w;
        %[r]= test(predictions,img_test,test_order);
        [r]= test2rel(w,to,feat);
        %acc((k-1)*12+j,i)=r;
        acc(k,j,i)=r;

        end 

        end
        end

        for i=1:length(Co)
            for j=1:length(Cs)
            A(i,j)=sum(acc(i,j,:));
            end
        end  


        % get the best c value.
        [Cr,Br]=max(A);
        [~,Bl]=max(Cr);
        %pp=mod(b,12);
        %qq=(b-pp)/12+1;
        %S=addConstraints(O,S);
        Om=sparse(O);
        Sm=sparse(S);

        c_s(1:size(Sm,1))=Cs(Bl);
        C_S=c_s';
        c_o(1:size(Om,1))=Co(Br(Bl));
        C_O=c_o';

        w=ranksvm_with_sim(feat,Om,Sm,C_O,C_S);
        predictions=gistrgb*w;
        [AC]= test(predictions,img_test,test_order);
        % predict=predictions(img_test(:,1),:)<predictions(img_test(:,2),:);
        % predict=predict+1;
        % 
        % fprintf('Accuracy is %f\n',length(find(predict==idx))/length(idx));
        %Accuracy(j,nrepeat)=AC;

%        end
%fprintf('Best C is %f Accuracy is %f\n',s(b),AC);
fprintf('Best Co is %f Cs is % fAccuracy is %f\n',Co(Br(Bl)),Cs(Bl),AC);
% end


