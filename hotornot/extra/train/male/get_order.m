%hot_index=hot(:,1);
%not_index=nothot(:,1);
for i=1:1000
    r1=all(pairs(i,1),2);
    r2=all(pairs(i,2),2);
    result=r1-r2;
    if result>1
        pairs(i,3)=1;
    else if result<-1
            pairs(i,3)=2;
        else
            pairs(i,3)=3;
        end
    end
%     if ismember(pairs(i,1),hot_index)
%         a_1=2;
%     else
%         a_1=1
%     end
%     if ismember(pairs(i,2),hot_index)
%         a_2=2;
%     else
%         a_2=1
%     end
%     if a_1>a_2
%         pairs(i,3)=1;
%     else if a_1<a_2
%             pairs(i,3)=2;
%         else
%             pairs(i,3)=3;
%         end
%     end
end
