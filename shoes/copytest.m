load '~/Desktop/DavisSummer/training_data/shoes/shoes_attributes.mat'
prefix='~/Desktop/shoes/'
for i=1:numel(test_inds)
str=char(im_names(test_inds(i)));
     sub=strfind(str,'_');
     path=str(sub(2)+1:sub(3)-1);
copyfile(strcat(prefix,path,'/',str),strcat('./test/',num2str(i),'.jpg'));
end