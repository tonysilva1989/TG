%caso seja para o conjunto C7 (8,1) (16,2) (24,3), verificar como adicionar
%as 3 features simultaneamente
for k=0:9
    load(['folds/fold_' num2str(k)]); % carrega o nome das fotos de cada um dos folds
    load(['folds/class_' num2str(k)]); % carrega o bool de cada uma das imagens do fold
    
    X = [];
    
    for i=1:length(fold);%(quantidade de imagens no fold)
        disp (['Extraindo caracter�sticas fold ' num2str(k) ' img: ' num2str(i)]);
        if(classFold(i)==1) % se � igual a 1, � aut�ntica
            img = imread(['CASIA1/AU/' fold{i}]);
            X = [X; featureWLD(img), featureWLD16(img), featureWLD24(img)];
        elseif(classFold(i)==0) % se for 0, � spliced
            img = imread(['CASIA1/Sp/' fold{i}]);
            X = [X; featureWLD(img), featureWLD16(img), featureWLD24(img)];
        end
    end
    %guarda todas as features das imagens em um vetor coluna de vetores X_n
    save(['featuresWLDC7/X_' num2str(k)], 'X');
end
