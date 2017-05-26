% C7
for c=7
    disp(['Escala C', num2str(c)]);
    TMS = [];
    TM = [];
    for k=0:9
        disp(['treinando conj', num2str(k)']);
        load(['trainWLDLBPC' num2str(c) '/conj' num2str(k) '/TR.mat']);
        load(['trainWLDLBPC' num2str(c) '/conj' num2str(k) '/TE.mat']);

        %treinando
        matrizTR = double (matrizTR); %para o double que vem do HOG
        TMS = sparse(matrizTR);
        TM = svmtrain(rotulosTR,TMS,'-t 1 -b 1');
        
        %testando
        matrizTE = double (matrizTE); %para o double que vem do HOG
        TEMS=sparse(matrizTE);
        [predict_label, accuracy, prob_estimates] = svmpredict(rotulosTE, TEMS, TM, '-b 1');
        
        %guardando
        save(['trainWLDLBPC' num2str(c) '/conj' num2str(k) '/test.mat'], 'predict_label', 'accuracy', 'prob_estimates');
        %salva para abrir no outro arquivo (o de teste)
        save(['trainWLDLBPC' num2str(c) '/conj' num2str(k) '/train.mat'], 'TM');
        
    end
end

%printing results