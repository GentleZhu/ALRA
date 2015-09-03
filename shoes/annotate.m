load 'shoes_attributes.mat'
prefix='~/Desktop/shoes/'
idx=find(mturk_labels(:,3)==1);
img_train=mturk_labels(idx,1:2);
train_order=mturk_labels(idx,4);
%gistrgb=gist_feat(idx,:);
uni_pic=unique(img_train);
contour=zeros(numel(uni_pic),4);
%set(gcf,'position',[50 50 200 200])
for i=1:numel(uni_pic)
    i
%     str=char(im_names(uni_pic(i)));
%     sub=strfind(str,'_');
%     path=str(sub(2)+1:sub(3)-1);
    %im=imread(strcat(prefix,path,'/',str));
    im=imread(strcat('./process/',num2str(i),'.jpg'));
    %copyfile(strcat(prefix,path,'/',str),strcat('./exchange/',num2str(i),'.jpg'))
    %imwrite(im,strcat('./process/',num2str(i),'.jpg'));
     imshow(im);
%     zoom on;   % use mouse button to zoom in or out
    % Press Enter to get out of the zoom mode.
    % CurrentCharacter contains the most recent key which was pressed after opening
    % the figure, wait for the most recent key to become the return/enter key
%     pause()
%     zoom reset
%     zoom off
     [x,y,but] = ginput(2);
     contour(i,1:2)=x';
     contour(i,3:4)=y';
end