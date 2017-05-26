
disp('Criando os Folds');
createFolds;
disp('Extraindo LBP');
createFeaturesLBP;
disp('Extraindo WLD');
createFeaturesWLD;

createCConjs;
createConjsTrain;

train;
test;
