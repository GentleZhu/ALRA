%load '~/Desktop/DavisSummer/training_data/shoes/leg.mat'
load 'leg.mat'
exfeature=zeros(232,9216);
for i=1:116
    exfeature(2*i-1,:)=exconvnetfeature(4*i-3,:)+exconvnetfeature(4*i,:);
    exfeature(2*i,:)=exconvnetfeature(4*i-1,:)+exconvnetfeature(4*i-2,:);
end
exfeature=normr(exfeature);