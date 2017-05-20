% C7
sum = 0;
for c=7
    disp(['Escala C', num2str(c)]);
    for k=0:9
        disp(['testand conj', num2str(k)']);
        load(['trainWLDLBPC' num2str(c) '/conj' num2str(k) '/TE.mat']);
        load(['trainWLDLBPC' num2str(c) '/conj' num2str(k) '/train.mat']);
        
        TEMS=sparse(matrizTE);
        [predict_label, accuracy, prob_estimates] = svmpredict(rotulosTE, TEMS, TM, '-b 1');
        sum = sum + accuracy;
        save(['trainWLDLBPC' num2str(c) '/conj' num2str(k) '/test.mat'], 'predict_label', 'accuracy', 'prob_estimates');
        
    end
    avg = sum /10.0;
end
