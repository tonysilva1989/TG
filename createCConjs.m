% % C7 = 7, 16 e 24
% for k=0:9
%     C7 = [];
%     load(['featuresLBP/X_' num2str(k)]);
%     C7 = [C7 X];
%     load(['featuresLBP16/X_' num2str(k)]);
%     C7 = [C7 X];
%     load(['featuresLBP24/X_' num2str(k)]);
%     C7 = [C7 X];
%     save(['featuresLBPC7/X_' num2str(k)], 'C7');
% end

% C7 lbp e wld

for k=0:9
    C8 = [];
    load(['featuresWLDC7/X_' num2str(k)]); %retira o X do fold atual apenas com o WLD e joga em C8
    C8 = [C8 X];
    load(['featuresLBPC7/X_' num2str(k)]); %retira o X_LBP do fold atual e joga em C8
    C8 = [C8 X];
    save(['featuresWLDLBPC7/X_' num2str(k) '.mat'], 'C8'); %guarda a combina��o de features do fold atual em X_n
end