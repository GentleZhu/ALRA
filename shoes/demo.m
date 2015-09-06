
%load '../dataset/LFW10/annotations/trainpairs.mat'
%load '../dataset/LFW10/code/testpairs.mat'
%load '~/Desktop/DavisSummer/training_data/shoes/pointy.mat'
%load './open.mat';
load './pointy.mat';
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
    img_A=double(imread(strcat('./leg/',num2str(id_1),'.jpg')));
    img_B=double(imread(strcat('./leg/',num2str(id_2),'.jpg')));
%     sub=strfind(str,'_');
%     path=str(sub(2)+1:sub(3)-1);
%     img_A = double(imread(strcat(prefix,path,'/',str)));
%     strcat(prefix,path,'/',str)
%     str=char(im_names(id_2));
%     sub=strfind(str,'_');
%     path=str(sub(2)+1:sub(3)-1);
%     img_B = double(imread(strcat(prefix,path,'/',str)));
    n_im1=strcat('./pointyexchange/',num2str(2*i-1),'.jpg');
%    s=num2str(id_2);
%    im2=strcat(s,'.jpg');
    n_im2=strcat('./pointyexchange/',num2str(2*i),'.jpg');
    %n_im3=strcat('./legexchange/',num2str(4*i-1),'.jpg');
    %n_im4=strcat('./legexchange/',num2str(4*i),'.jpg');
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


    LX = contour(uni_idxa,2);
    LY = contour(uni_idxa,4);
    GX = contour(uni_idxb,2);
    GY = contour(uni_idxb,4);
    w_1 = contour(uni_idxa,2)-contour(uni_idxa,1);
    h_1 = contour(uni_idxa,4)-contour(uni_idxa,3);
    w_2 = contour(uni_idxb,2)-contour(uni_idxb,1);
    h_2 = contour(uni_idxb,4)-contour(uni_idxb,3);
    %ratio_1=h_1/w_1;
    %ratio_2=h_2/w_2;
    %if ratio_1
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
    %XX=255*ones(size(X));
    %XX(LY:LY+h_1-1,LX:LX+w_1-1,:)=X(LY:LY+h_1-1,LX:LX+w_1-1,:);
    X(LY-h_1+1:LY,LX-w_1+1:LX,:)=255;
    hh_1=double(h_2)/double(w_2)*double(w_1);
    %hh_1
    hh_1=uint16(hh_1);
    if LY<hh_1
        hh_1=LY;
    end
    X(LY-hh_1+1:LY,LX-w_1+1:LX,:)=imresize(img_B(GY-h_2+1:GY,GX-w_2+1:GX,:),[hh_1,w_1]);
    Fh(LY-hh_1+1:LY,LX-w_1+1:LX,:) = imresize(Gh(GY-h_2+1:GY,GX-w_2+1:GX,:),[hh_1,w_1]);
    Fv(LY-hh_1+1:LY,LX-w_1+1:LX,:) = imresize(Gv(GY-h_2+1:GY,GX-w_2+1:GX,:),[hh_1,w_1]);
% 
    msk = zeros(size(X));

    msk(LY-hh_1+1:LY,LX-w_1+1:LX,:) = 1;
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
    %continue;
    %imwrite(uint8(XX),n_im2);
    %YY=255*ones(size(Y));
    %YY(GY:GY+h_2-1,GX:GX+w_2-1,:)=Y(GY:GY+h_2-1,GX:GX+w_2-1,:);
    Y(GY-h_2+1:GY,GX-w_2+1:GX,:)=255;
    hh_2=double(h_1)/double(w_1)*double(w_2);
    hh_2=uint16(hh_2);
    if GY<hh_2
        hh_2=GY;
    end
      Y(GY-hh_2+1:GY,GX-w_2+1:GX,:) = imresize(img_A(LY-h_1+1:LY,LX-w_1+1:LX,:),[hh_2,w_2]);
     fh(GY-hh_2+1:GY,GX-w_2+1:GX,:) = imresize(Lh(LY-h_1+1:LY,LX-w_1+1:LX,:),[hh_2,w_2]);
     fv(GY-hh_2+1:GY,GX-w_2+1:GX,:) = imresize(Lv(LY-h_1+1:LY,LX-w_1+1:LX,:),[hh_2,w_2]);

    msk = zeros(size(Y));
    msk(GY-hh_2+1:GY,GX-w_2+1:GX,:) = 1;
% 
     Y_X = PoissonJacobi( Y, fh, fv, msk );
    imwrite(uint8(Y_X),n_im2);
    %imwrite(uint8(YY),n_im4);
    %break;
end
