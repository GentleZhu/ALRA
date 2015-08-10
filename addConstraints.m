function [ S_ ] = addConstraints( Or,Sr )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[n,d]=size(Or);
Sp=zeros(n,d);
for i=1:n
    Sp(i,find(Or(i,:)==1)+d/2)=1;
    Sp(i,find(Or(i,:)==-1)+d/2)=-1;
end
S_=[Sr;Sp];
end

