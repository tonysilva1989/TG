for k=0:9
    
    Para.plotfigure = 0;     % 1: plot of the result of each iteration; 0: do not plot
    Para.distance = 'block'; % 'euclidean';  
    Para.sigma= 2;           % kernel width; If the algorithm does not converge, use a larger kernel width.
    Para.lambda = 1;         % regularization parameter
    
    rotulosTE = [];
    rotulosTR = [];
    matrizTE = [];
    matrizTR = [];
    conj = (0:9);
    
    load(['folds/class_' num2str(k)]); %carrega o bool de classes (1- original 0- forjada)
    load(['folds/fold_' num2str(k)]); %carrega o conjunto de imagens do fold atual
    load(['featuresWLDLBPC7/X_' num2str(k)]); %carrega o conjunto de features combinados do fold X_n atual
    
    % teste
    rotulosTE = classFold'; %possui dimensÃ£o 171x1 ( rotulando o nÃºmero de exemplos do fold atual)
    matrizTE = C8; %variï¿½vel carregada da funï¿½ï¿½o load(['featuresWLDLBPC7/X_' num2str(k)])
    
    conj = conj(find(conj~=k)); %devolve um array na qual o indice atual ï¿½ desconsiderado
    %etapa de treinamento
    for i=conj % o treinamento ï¿½ feito com todos, exceto o atual (k-fold)
        % gerando conjunto de treinamento
        load(['folds/class_' num2str(i)]);
        load(['featuresWLDLBPC7/X_' num2str(i)]);

        rotulosTR = [rotulosTR; classFold']; 
        matrizTR = [matrizTR; C8];   
    end

           
            %[COEFF,SCORE] = princomp(matrizTR);
            %[residuals,reconstructed] = pcares(matrizTR,500);
            %princ1 = SCORE(:,1:100);
            %matrizTR = princ1;
            
            %[COEFF,SCORE] = princomp(matrizTE);
            %princ2 = SCORE(:,1:100);
            %matrizTE = princ2;
            
    feat = [matrizTR; matrizTE];
    numberOfDimensions = 300;
    coeff = pca(feat);
    reducedDimension = coeff(:,1:numberOfDimensions);
    
    reducedDataTR = matrizTR * reducedDimension;
    reducedDataTE = matrizTE * reducedDimension;

    matrizTR = reducedDataTR;
    matrizTE = reducedDataTE;
            
    
    save(['trainWLDLBPC7/conj' num2str(k) '/TR.mat'], 'rotulosTR', 'matrizTR');
    save(['trainWLDLBPC7/conj' num2str(k) '/TE.mat'], 'rotulosTE', 'matrizTE');
    
end