function [ index ] = augment_select( selected,img_train,img_partial )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
img_selected=img_train(selected,:);
[~,idx]=ismember(img_selected,img_partial,'rows');
idx = idx(idx ~= 0);
first_pair=2*idx-1;
second_pair=2*idx;
index=sort([first_pair;second_pair]);

end

