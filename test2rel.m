function [acc]=test2rel(w,ord,feat)
% calculates percentage accuracy
count=0;
total=size(ord,1);

for i=1:total
  f1=find(ord(i,:)==1);
  feat1=feat(f1,:);
  f2=find(ord(i,:)==-1);
  feat2=feat(f2,:);
  a=feat1*w;
  b=feat2*w;
  if a>b
      count=count+1;
  end

end

    acc=(count/total)*100;
end
