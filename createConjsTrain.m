% C7

for k=0:9
    rotulosTE = [];
    rotulosTR = [];
    matrizTE = [];
    matrizTR = [];
    conj = (0:9);
    
    load(['folds/class_' num2str(k)]);
    load(['featuresWLDLBPC7/X_' num2str(k)]);
   
    % teste
    rotulosTE = classFold';
    matrizTE = C8;

    conj = conj(find(conj~=k));
    
    for i=conj
        % treinamento
        %disp(['estou no fold ' num2str(k) ]);
        load(['folds/class_' num2str(i)]);
        load(['featuresWLDLBPC7/X_' num2str(i)]);
        %load(['featuresLBPC7/X_' num2str(k)]);
        rotulosTR = [rotulosTR; classFold'];
        matrizTR = [matrizTR; C8];
    end
    
    save(['trainWLDLBPC7/conj' num2str(k) '/TR'], 'rotulosTR', 'matrizTR');
    save(['trainWLDLBPC7/conj' num2str(k) '/TE'], 'rotulosTE', 'matrizTE');
    
end