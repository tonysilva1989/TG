%parameters
Para.plotfigure = 0;     % 1: plot of the result of each iteration; 0: do not plot
Para.distance = 'block'; % 'euclidean';  
Para.sigma= 2;           % kernel width; If the algorithm does not converge, use a larger kernel width.
Para.lambda = 1;         % regularization parameter

load(['trainWLDLBPC' num2str(7) '/conj' num2str(0) '/TR.mat']); %pegando
%as features do WLD + LBP
%load(['featuresWLDC7/X_' num2str(0)], 'X'); %Pegando as features só do WLD
patterns = matrizTR'; 
targets = rotulosTR';

targets = targets+1;  

dim = size(patterns,1);
%normalizando os dados
[MIN,I] = min(patterns,[],2); %pega o menor valor de todos dentro da base
[MAX,I] = max(patterns,[],2); %pega o maior valor de todos dentro da base
for n=1:dim
    if (MAX(n)-MIN(n))==0
        patterns(n,:)=0;
    else
        patterns(n,:) = (patterns(n,:)-MIN(n))/(MAX(n)-MIN(n));
    end
end

 disp ('Aplicando a redução de dimensionalidade');
Weight = Logo(patterns, targets(:), Para);



