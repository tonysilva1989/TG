K = 10;
files_Sp = dir('CASIA1/Sp/*.jpg');
files_Au = dir('CASIA1/Au/*.jpg');

nfiles_Sp = length(files_Sp);
nfiles_Au = length(files_Au);

randon_Sp = randperm(nfiles_Sp); %arranjo aleat�rio das imagens pelo �ndice
randon_Au = randperm(nfiles_Au); %arranjo aleat�rio das imagens pelo �ndice

nFilesByFold_Sp = round(nfiles_Sp/K);  %n� de fotos por fold
nFilesByFold_Au = round(nfiles_Au/K);

filesName_Sp = {files_Sp.name}; %lista todos os nomes das imagens manipuladas
filesName_Au = {files_Au.name}; %lista todos os nomes das imagens originais


for i=0:9
    
    down_au = (i*nFilesByFold_Au)+1;
    upper_au = (nFilesByFold_Au*(i+1));

    down_sp = (i*nFilesByFold_Sp)+1;
    upper_sp = (nFilesByFold_Sp*(i+1));

    
    subFiles_Au = filesName_Au(randon_Au(down_au:upper_au)); %separando imagens aleatoriamente pelo fold atual
    subFiles_Sp = filesName_Sp(randon_Sp(down_sp:upper_sp)); %separando imagens aleatoriamente pelo fold atual
    fold = [subFiles_Au subFiles_Sp]; % vetor com a quantidade total de imagens no fold atual (guarda os indices)
    classFold = [ones(1, nFilesByFold_Au) zeros(1,nFilesByFold_Sp)];
    
    randon_fold = randperm(length(fold));
    fold = fold(randon_fold);
    classFold = classFold(randon_fold);
    %armazena as fotos escolhidas aleatoriamente para cada um dos folds
    
   
    save(['folds/fold_' num2str(i) '.mat'], 'fold'); %vetor booleano
    save(['folds/class_' num2str(i) '.mat'], 'classFold'); %vetor com nome dos arquivos de fotos
end
