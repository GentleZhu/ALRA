load 'teeth.mat'
load 'contour.mat'
n=sum(train_order~=3);
idx=find(train_order~=3);
addpath '~/Desktop/DavisSummer/dataset/LFW10/images'
for i=1:10
    clear img_A;
    clear img_B;
    fprintf('%d\n',i);
    id_1=img_train(idx(i),1);
    id_2=img_train(idx(i),2);
    s=num2str(id_1);
    im1=strcat(s,'.jpg');
    
    n_im1=strcat('./exchange/',num2str(2*i-1),'.jpg');
    s=num2str(id_2);
    im2=strcat(s,'.jpg');
    n_im2=strcat('./exchange/',num2str(2*i),'.jpg');
    img_A = double(imread(im1));
    img_B = double(imread(im2));
    if sum(contour(id_1,:))==0 || sum(contour(id_2,:))==0
        imwrite(uint8(img_A),n_im1);
        imwrite(uint8(img_B),n_im2);
        continue
    end
    

    [Lh,Lv] = imgrad(img_A);
    [Gh,Gv] = imgrad(img_B);

    X = img_A;
    Y=img_B;
    Fh = Lh;
    Fv = Lv;
    fh=Gh;
    fv=Gv;

    w_1 = contour(id_1,3);
    h_1 = contour(id_1,4);
    w_2 = contour(id_2,3);
    h_2 = contour(id_2,4);
    LX = contour(id_1,1);
    LY = contour(id_1,2);
    GX = contour(id_2,1);
    GY = contour(id_2,2);
    %size(girl(GY:GY+h_2,GX:GX+w_2,:))
    %size(imresize(girl(GY:GY+h_2,GX:GX+w_2,:),[h_1,w_1]))
    X(LY:LY+h_1-1,LX:LX+w_1-1,:) = imresize(img_B(GY:GY+h_2-1,GX:GX+w_2-1,:),[h_1,w_1]);
    Fh(LY:LY+h_1-1,LX:LX+w_1-1,:) = imresize(Gh(GY:GY+h_2-1,GX:GX+w_2-1,:),[h_1,w_1]);
    Fv(LY:LY+h_1-1,LX:LX+w_1-1,:) = imresize(Gv(GY:GY+h_2-1,GX:GX+w_2-1,:),[h_1,w_1]);

    msk = zeros(size(X));
    msk(LY:LY+h_1-1,LX:LX+w_1-1,:) = 1;

    %imwrite(uint8(X),'X.png');

    %tic;
    X_Y = PoissonGaussSeidel( X, Fh, Fv, msk );
    %toc
    %imwrite(uint8(Y),'Yjc.png');
    %tic;
    %PoissonJacobi
    %Y = PoissonGaussSeidel( X, Fh, Fv, msk );
    %toc
    imwrite(uint8(X_Y),n_im1);

    Y(GY:GY+h_2-1,GX:GX+w_2-1,:) = imresize(img_A(LY:LY+h_1-1,GX:GX+w_1-1,:),[h_2,w_2]);
    fh(GY:GY+h_2-1,GX:GX+w_2-1,:) = imresize(Lh(LY:LY+h_1-1,GX:GX+w_1-1,:),[h_2,w_2]);
    fv(GY:GY+h_2-1,GX:GX+w_2-1,:) = imresize(Lv(LY:LY+h_1-1,GX:GX+w_1-1,:),[h_2,w_2]);

    msk = zeros(size(Y));
    msk(GY:GY+h_2-1,GX:GX+w_2-1,:) = 1;

    Y_X = PoissonGaussSeidel( Y, fh, fv, msk );
    imwrite(uint8(Y_X),n_im2);
    %break;
end
