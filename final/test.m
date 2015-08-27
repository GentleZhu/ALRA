function [accuracy]=test(predictions,img_test,test_order)
    [N,~]=size(img_test);
    result=zeros(N,1);
    tot=N;
    cor=0;
    for i=1:N
        if (test_order(i)==1)
            if (predictions(img_test(i,1))>predictions(img_test(i,2)))
                cor=cor+1;
            end
        end
        if (test_order(i)==2)
           if (predictions(img_test(i,1))<predictions(img_test(i,2)))
                cor=cor+1;
           end
        end
        if (test_order(i)==3)
            tot=tot-1;
        end
    %     if (train_order(i)==1)
    %         if (predictions(img_train(i,1))>predictions(img_train(i,2)))
    %             cor=cor+1;
    %         end
    %     end
    %     if (train_order(i)==2)
    %        if (predictions(img_train(i,1))<predictions(img_train(i,2)))
    %             cor=cor+1;
    %        end 
    %     end
    %     if (train_order(i)==3)
    %         tot=tot-1;
    %     end
    %     t=predictions(img_compare(i,1))-predictions(img_compare(i,2));
    %     if t>0.05
    %         result(i)=1;
    %     else if t<-0.05
    %         result(i)=2;
    %         else 
    %             result(i)=3;
    %         end
    %     end
    end
    accuracy=cor/tot;
end