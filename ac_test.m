predictions=convnetfeature*wa;
acc(1)= test(predictions,img_test,test_order);
predictions=convnetfeature*wb;
acc(2)= test(predictions,img_test,test_order);
predictions=convnetfeature*wc;
acc(3)= test(predictions,img_test,test_order);
predictions=convnetfeature*wd;
acc(4)= test(predictions,img_test,test_order);

fprintf('Best AC =%f %f %f %f\n',acc(1),acc(2),acc(3),acc(4));