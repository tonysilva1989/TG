flag = 0;
for k=0:9


    load(['folds/fold_' num2str(k) '.mat' ] ); % carrega a variï¿½vel fold
    load(['folds/class_' num2str(k) '.mat' ]); % carrega as classes das imagens
    
    X = [];
    for i=1:length(fold);

        disp(['Extraindo caracterï¿½sticas HOG do fold ' num2str(k) ' img: ' num2str(i)]);

        if(classFold(i)==1)
            imagem = imread(['CASIA1/AU/' fold{i}]);		
            % converted image into the YCbCr color space
            %imageYCbCr = rgb2ycbcr(imagem);
            % get the chrominance component Cr (1: Y, 2: Cb, 3: Cr)
            %img2 = imageYCbCr(:,:,3);
            img2 = rgb2gray(imagem); %converte para escala de cinza            
            
            out = extractHOGFeatures(img2,'CellSize',[64 64]);

%             out = HOG(img2);
%             out = out';

            if (isempty(out)) %um caso está dando array vazio
                    flag = flag +1;
                     out = zeros(1,b);
            else
                
                [um, a] = size(out);
                %na primeira execução do código, X ainda está vazio e não
                %tem dimensão, neste caso ele pega antecipadamente a
                %dimensão do vetor out calculada primeiramente
                if(isempty(X))
                    b = a;
                else
                   [um, b] =  size(X); 
                end

                
                %se o tamanho das features atuais são maiores do que a que tem
                %na matriz e não está recebendo vetor vazio, limita o tamanho
                %da inserção das features ao tamanho da matriz de atributos                
                if a > b %se o array de features atual, por algum motivo é maior do que o tamanho padrão, corta valores
                   
                   out = out(1:b);
                elseif a < b && ~(isempty(X)) %caso seja menor, é preenchido com zeros
                    temp = zeros(1,b);
                    temp(1:a) = out;
                    out = temp;
                end
                
            end

            X = [X; out];
        elseif(classFold(i)==0)
			%realizar uma conversÃ£o pra tons de cinza e aplicar um filtro gaussiano (paper do LBP)?
            imagem = imread(['CASIA1/Sp/' fold{i}]);
            %imageYCbCr = rgb2ycbcr(imagem);
            % get the chrominance component Cr (1: Y, 2: Cb, 3: Cr)
            %img2 = imageYCbCr(:,:,3);
            img2 = rgb2gray(imagem); %converte para escala de cinza
            out = extractHOGFeatures(img2,'CellSize',[64 64]);

%             out = HOG(img2);
%             out = out';
            
            if (isempty(out)) %um caso está dando vazio
                flag = flag +1;
                  out = zeros(1,b);
            else
                
                [um, a] = size(out);
                %na primeira execução do código, X ainda está vazio e não
                %tem dimensão, neste caso ele pega antecipadamente a
                %dimensão do vetor out calculada primeiramente.
                if(isempty(X))
                    b = a;
                else
                   [um, b] =  size(X); 
                end
                
                %se o tamanho das features atuais são maiores do que a que tem
                %na matriz e não está recebendo vetor vazio, limita o tamanho
                %da inserção das features ao tamanho da matriz de atributos
                if a > b  
                   out = out(1:b);
                elseif a < b && ~(isempty(X))
                    temp = zeros(1,b);
                    temp(1:a) = out;
                    out = temp;
                end
            end

            X = [X; out];

        end

    end
    
    save(['featuresHOGC7/X_' num2str(k) '.mat'], 'X');
end