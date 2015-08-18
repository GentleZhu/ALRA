load '../mouthopen.mat'
load 'contour.mat'
n=sum(train_order~=3);
idx=find(train_order~=3);
addpath '~/Desktop/DavisSummer/dataset/LFW10/images'
for i=1:n
    clear img_A;
    clear img_B;
    fprintf('%d\n',i);
    id_1=img_train(idx(i),1);
    id_2=img_train(idx(i),2);
    s=num2str(id_1);
    im1=strcat(s,'.jpg');
    
    n_im1=strcat('./mouthexchange/',num2str(2*i-1),'.jpg');
    s=num2str(id_2);
    im2=strcat(s,'.jpg');
    n_im2=strcat('./mouthexchange/',num2str(2*i),'.jpg');
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
    
    t=max([w_1,w_2;h_1,h_2],[],2);
    w=t(1);
    h=t(2);
    LX = double(contour(id_1,1));
    LY = double(contour(id_1,2));
    GX = double(contour(id_2,1));
    GY = double(contour(id_2,2));
    
    %size(girl(GY:GY+h_2,GX:GX+w_2,:))
    %size(imresize(girl(GY:GY+h_2,GX:GX+w_2,:),[h_1,w_1]))
%     X(LY:LY+h_1-1,LX:LX+w_1-1,:) = imresize(img_B(GY:GY+h_2-1,GX:GX+w_2-1,:),[h_1,w_1]);
%     Fh(LY:LY+h_1-1,LX:LX+w_1-1,:) = imresize(Gh(GY:GY+h_2-1,GX:GX+w_2-1,:),[h_1,w_1]);
%     Fv(LY:LY+h_1-1,LX:LX+w_1-1,:) = imresize(Gv(GY:GY+h_2-1,GX:GX+w_2-1,:),[h_1,w_1]);
    ly=floor(LY-h/2);
    uy=ceil(LY+h/2);
    lx=floor(LX-w/2);
    ux=ceil(LX+w/2);
    lY=floor(GY-h/2);
    uY=ceil(GY+h/2);
    lX=floor(GX-w/2);
    uX=ceil(GX+w/2);
    X(ly:uy,lx:ux,:) = img_B(lY:uY,lX:uX,:);
    Fh(ly:uy,lx:ux,:) = Gh(lY:uY,lX:uX,:);
    Fv(ly:uy,lx:ux,:) = Gv(lY:uY,lX:uX,:);
    
    msk = zeros(size(X));
    msk(ly:uy,lx:ux,:) = 1;

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

    Y(lY:uY,lX:uX,:) = img_A(ly:uy,lx:ux,:);
    fh(lY:uY,lX:uX,:) = Lh(ly:uy,lx:ux,:);
    fv(lY:uY,lX:uX,:) = Lv(ly:uy,lx:ux,:);

    msk = zeros(size(Y));
    msk(lY:uY,lX:uX,:) = 1;

    Y_X = PoissonGaussSeidel( Y, fh, fv, msk );
    imwrite(uint8(Y_X),n_im2);
    %break;
end
