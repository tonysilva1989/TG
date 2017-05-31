% C7
%USANDO K-FOLD CROSS VALIDATION PRA FAZER O CONJUNTO DE TREINAMENTO E TESTE

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
    
            %caso não precise rodar novamente a redução (só quer mudar o K), basta
            %colocar um teste de k maior que 10
            if k==0
                %%%realizando a reduÃ§Ã£o de dimensionalidade:
                disp(['Reduzindo dimensionalidade do conjunto (treinamento) ' num2str(k)]);
                patterns = [matrizTR; matrizTE];
                patterns = patterns';
                targets = [rotulosTR',rotulosTE'];
                targets = targets+1;  %[0,1] -> [1,2] (label das classes)
                dim = size(patterns,1);

                %normalizando os dados:
                [MIN,I] = min(patterns,[],2); %pega o menor valor de todos dentro da base
                [MAX,I] = max(patterns,[],2); %pega o maior valor de todos dentro da base

                for n=1:dim
                    if (MAX(n)-MIN(n))==0
                        patterns(n,:)=0;
                    else
                        patterns(n,:) = (patterns(n,:)-MIN(n))/(MAX(n)-MIN(n));
                    end
                end

                disp('Aplicando a redução de dimensionalidade para ser usado em treinamento e teste');
                Weight = Logo(patterns, targets(:), Para);
                %%apenas pra salvar:
                %save(['pesos.mat'], 'Weight');
            end

            [val ind] = sort(Weight,'descend'); %dá um sort nos pesos, organizando por índices

            K = 173; %pega os K maiores índices do array de pesos (escolha empírica)
            first_k = ind(1:K);
            %neste ponto, os k maiores pesos estão desordenados, neste caso é bom
            %organizar os índices para serem extraídos da matriz original na devida
            %sequência:
            first_k = sort(first_k);

            %patterns = patterns'; %recupera a forma original da matriz de treinamento
            x = matrizTR(:,first_k); %devolve o conjunto de k atributos dos N totais
            matrizTR = x;
            %%%%%%%TESTE%%%%%%%%
            %disp(['Reduzindo dimensionalidade do conjunto (teste) ' num2str(k)]);
            %patterns = matrizTE'; 
            %targets = rotulosTE';
            %targets = targets+1;  %[0,1] -> [1,2]
            % disp ('Aplicando a redução de dimensionalidade');
            %Weight = Logo(patterns, targets(:), Para);

            %patterns = patterns'; %recupera a forma original da matriz de treinamento    
            x = matrizTE(:,first_k); %devolve o conjunto de elementos filtrados -- está usando os pesos calulados para o conjunto de treinamento
            matrizTE = x;
    
 
           
    
    save(['trainWLDLBPC7/conj' num2str(k) '/TR.mat'], 'rotulosTR', 'matrizTR');
    save(['trainWLDLBPC7/conj' num2str(k) '/TE.mat'], 'rotulosTE', 'matrizTE');
    
end