flag = 0;
for k=0:9

    load(['folds/fold_' num2str(k) '.mat' ] ); % carrega a vari�vel fold
    load(['folds/class_' num2str(k) '.mat' ]); % carrega as classes das imagens
    
    X = [];
    for i=1:length(fold);
        disp (['Extraindo caracter�sticas HOG do fold ' num2str(k) ' img: ' num2str(i)]);
        if(classFold(i)==1)
            img = imread(['CASIA1/AU/' fold{i}]);		
            % converted image into the YCbCr color space
            %imageYCbCr = rgb2ycbcr(img);

            % get the chrominance component Cr (1: Y, 2: Cb, 3: Cr)
            %img2 = imageYCbCr(:,:,3);

            img2 = rgb2gray(img); %converte para escala de cinza            
            out = extractHOGFeatures(img2,'CellSize',[64 64]);
            [um, a] = size(out);
            [um, b] =  size(X);
            
            if a > b %se o array de features atual, por algum motivo � maior do que o tamanho padr�o, corta valores
               out = out(1:b);
            elseif a < b && ~(isempty(X)) %caso seja menor, � preenchido com zeros
                temp = zeros(1,b);
                temp(1:a) = out;
                out = temp;
                temp=[];
            end
            if (isempty(out)) %um caso est� dando array vazio
%                     flag = flag +1;
%                     cell = fold{i};
                      temp = zeros(1,b);
            end
            X = [X; out];
        elseif(classFold(i)==0)
			%realizar uma conversão pra tons de cinza e aplicar um filtro gaussiano (paper do LBP)?
            img = imread(['CASIA1/Sp/' fold{i}]);
            img2 = rgb2gray(img); %converte para escala de cinza
            out = extractHOGFeatures(img2,'CellSize',[64 64]);
            [um, a] = size(out);
            [um, b] =  size(X);
                
            %se o tamanho das features atuais s�o maiores do que a que tem
            %na matriz e n�o est� recebendo vetor vazio, limita o tamanho
            %da inser��o das features ao tamanho da matriz de atributos
            if a > b && ~(isempty(X))
               out = out(1:b);
            elseif a < b
                temp = zeros(1,b);
                temp(1:a) = out;
                out = temp;
                temp=[];
            end
            
            if (isempty(out)) %um caso est� dando vazio
%                 flag = flag +1;
%                 cell = fold{i};
                  out = zeros(1,b);
            end
            X = [X; out];

        end
    end
    save(['featuresHOGC7/X_' num2str(k) '.mat'], 'X');
end