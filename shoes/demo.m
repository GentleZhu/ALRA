
%load '../dataset/LFW10/annotations/trainpairs.mat'
%load '../dataset/LFW10/code/testpairs.mat'
load 'pointy.mat'
prefix='~/Desktop/shoes/';
n=sum(train_order~=3);
idx=find(train_order~=3);
uni_pic=unique(img_train);
contour=uint16(contour);
for i=1:size(img_train,1)
    img_train(i,1)=find(uni_pic==img_train(i,1));
    img_train(i,2)=find(uni_pic==img_train(i,2));
end
for i=1:n
    %clear img_A;
    %clear img_B;
    fprintf('%d\n',i);
    id_1=img_train(idx(i),1);
    id_2=img_train(idx(i),2);
 %   str=char(im_names(id_1));
    img_A=double(imread(strcat('./process/',num2str(id_1),'.jpg')));
    img_B=double(imread(strcat('./process/',num2str(id_2),'.jpg')));
%     sub=strfind(str,'_');
%     path=str(sub(2)+1:sub(3)-1);
%     img_A = double(imread(strcat(prefix,path,'/',str)));
%     strcat(prefix,path,'/',str)
%     str=char(im_names(id_2));
%     sub=strfind(str,'_');
%     path=str(sub(2)+1:sub(3)-1);
%     img_B = double(imread(strcat(prefix,path,'/',str)));
    n_im1=strcat('./exchange/',num2str(2*i-1),'.jpg');
%    s=num2str(id_2);
%    im2=strcat(s,'.jpg');
    n_im2=strcat('./exchange/',num2str(2*i),'.jpg');
    uni_idxa=id_1;%find(uni_pic==id_1);
    uni_idxb=id_2;%find(uni_pic==id_2);
%     if sum(contour(uni_idxa,:))==0 || sum(contour(uni_idxb,:))==0
%         imwrite(uint8(img_A),n_im1);
%         imwrite(uint8(img_B),n_im2);
%         continue
%     end
%     

    [Lh,Lv] = imgrad(img_A);
    [Gh,Gv] = imgrad(img_B);

    X = img_A;
    Y=img_B;
    Fh = Lh;
    Fv = Lv;
    fh=Gh;
    fv=Gv;


    LX = contour(uni_idxa,1);
    LY = contour(uni_idxa,3);
    GX = contour(uni_idxb,1);
    GY = contour(uni_idxb,3);
    w_1 = contour(uni_idxa,2)-contour(uni_idxa,1);
    h_1 = contour(uni_idxa,4)-contour(uni_idxa,3);
    w_2 = contour(uni_idxb,2)-contour(uni_idxb,1);
    h_2 = contour(uni_idxb,4)-contour(uni_idxb,3);
%     w=min([w_1;w_2]);
%     h=min([h_1;h_2]);
%     h_1=h;
%     h_2=h;
%     w_1=w;
%     w_2=h;
%     %size(girl(GY:GY+h_2,GX:GX+w_2,:))
%     %size(imresize(girl(GY:GY+h_2,GX:GX+w_2,:),[h_1,w_1]))
%size(X(LY:LY+hh-1,LX:LX+ww,:))
%size(imresize(img_B(:,GX:GX+w_b-1,:),[w_a NaN]))
%size(imresize(img_B(:,GX:GX+w_2-1,:),[280,w_1]))
%size(imresize(img_B(:,GX:GX+w_2-1,:),[280,w_1]))
    X(LY:LY+h_1-1,LX:LX+w_1-1,:)=imresize(img_B(GY:GY+h_2-1,GX:GX+w_2-1,:),[h_1,w_1]);
     Fh(LY:LY+h_1-1,LX:LX+w_1-1,:) = imresize(Gh(GY:GY+h_2-1,GX:GX+w_2-1,:),[h_1,w_1]);
     Fv(LY:LY+h_1-1,LX:LX+w_1-1,:) = imresize(Gv(GY:GY+h_2-1,GX:GX+w_2-1,:),[h_1,w_1]);
% 
    msk = zeros(size(X));

    msk(LY:LY+h_1-1,LX:LX+w_1-1,:) = 1;
       X_Y = PoissonJacobi( X, Fh, Fv, msk );

    %imwrite(uint8(X),'X.png');
% 
%     %tic;

    %toc
    %imwrite(uint8(X_Y),'Yjc.png');
    %tic;
    %PoissonJacobi
    %Y = PoissonGaussSeidel( X, Fh, Fv, msk );
    %toc
    imwrite(uint8(X_Y),n_im1);

      Y(GY:GY+h_2-1,GX:GX+w_2-1,:) = imresize(img_A(LY:LY+h_1-1,LX:LX+w_1-1,:),[h_2,w_2]);
     fh(GY:GY+h_2-1,GX:GX+w_2-1,:) = imresize(Lh(LY:LY+h_1-1,LX:LX+w_1-1,:),[h_2,w_2]);
     fv(GY:GY+h_2-1,GX:GX+w_2-1,:) = imresize(Lv(LY:LY+h_1-1,LX:LX+w_1-1,:),[h_2,w_2]);
% 
    msk = zeros(size(Y));
    msk(GY:GY+h_2-1,GX:GX+w_2-1,:) = 1;
% 
     Y_X = PoissonJacobi( Y, fh, fv, msk );
    imwrite(uint8(Y_X),n_im2);
    %break;
end
