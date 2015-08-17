load 'methodcompare'
h=bar((methodcompare'));
LabelsX = {'smile', 'teeth', 'mouthopen'};
set(gca, 'XTick', 1:3, 'XTickLabel', LabelsX);
l = cell(1,4);
l{1}='Original'; l{2}='Original+O'; l{3}='Original+R'; l{4}='Original+both';   
legend(h,l);
xlabel('dataset');
ylabel('accuracy');
title('Method comparison'); 