

% %HOG
% for k=0:9
%     C8 = [];
%     load(['featuresHOGC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
%     C8 = X;
%     save(['featuresWLDLBPC7/X_' num2str(k) '.mat'], 'C8'); %guarda a combinaï¿½ï¿½o de features do fold atual em X_n
% end

% %LBP
% for k=0:9
%     C8 = [];
%     load(['featuresLBPC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
%     C8 = X;
%     save(['featuresWLDLBPC7/X_' num2str(k) '.mat'], 'C8'); %guarda a combinaï¿½ï¿½o de features do fold atual em X_n
% end

% WLD
for k=0:9
    C8 = [];
    load(['featuresWLDC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
    C8 = X;
    save(['featuresWLDLBPC7/X_' num2str(k) '.mat'], 'C8'); %guarda a combinaï¿½ï¿½o de features do fold atual em X_n
end

% %LBP+HOG
% for k=0:9
%     C8 = [];
%     load(['featuresLBPC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
%     C8 = [C8 X];
%     load(['featuresHOGC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
%     C8 = [C8 (X*1000)]; %as features possuem valores muito baixos, causando baixa representatividade de pesos dos atributos, fazendo com que 
%                         %a acurácia da combinação sendo igual a apenas LBP
%                         %(features com mais representatividade)
%     save(['featuresWLDLBPC7/X_' num2str(k) '.mat'], 'C8'); %guarda a combinaï¿½ï¿½o de features do fold atual em X_n
% end

% %WLD+HOG
% for k=0:9
%     C8 = [];
%     load(['featuresWLDC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
%     C8 = [C8 X];
%     load(['featuresHOGC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
%     C8 = [C8 (X*1000)];
%     save(['featuresWLDLBPC7/X_' num2str(k) '.mat'], 'C8'); %guarda a combinaï¿½ï¿½o de features do fold atual em X_n
% end


% % LBP + WLD
% for k=0:9
%     C8 = [];
%     load(['featuresWLDC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
%     C8 = [C8 X];
%     load(['featuresLBPC7/X_' num2str(k)]); %retira o X_LBP do fold atual e joga em C8
%     C8 = [C8 X];
%     save(['featuresWLDLBPC7/X_' num2str(k) '.mat'], 'C8'); %guarda a combinaï¿½ï¿½o de features do fold atual em X_n
% end

% %WLD+LBP+HOG
% for k=0:9
%     C8 = [];
%     load(['featuresWLDC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
%     C8 = [C8 X];
%     load(['featuresLBPC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
%     C8 = [C8 X];
%     load(['featuresHOGC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
%     C8 = [C8 (X*1000)];
%     save(['featuresWLDLBPC7/X_' num2str(k) '.mat'], 'C8'); %guarda a combinaï¿½ï¿½o de features do fold atual em X_n
% end








