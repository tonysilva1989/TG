fl=0;

for k=0:9

    load(['folds/fold_' num2str(k) '.mat' ] ); % carrega a vari�vel fold
    load(['folds/class_' num2str(k) '.mat' ]); % carrega as classes das imagens
    
    X = [];
    for i=1:length(fold);
     %for i=2;
        disp(['Extraindo caracter�sticas HOG do fold ' num2str(k) ' img: ' num2str(i)]);

        if(classFold(i)==1)
            imagem = imread(['CASIA1/AU/' fold{i}]);		
            % converted image into the YCbCr color space
            imageYCbCr = rgb2ycbcr(imagem);
            % get the chrominance component Cr (1: Y, 2: Cb, 3: Cr)
            img2 = imageYCbCr(:,:,3);
            
            out = extractHOGFeatures(img2,'CellSize',[64 64]);
            [um tam_atual] = size(out);
            
            if fl == 0
               [um tam_padr] = size(out);
               fl = 1;
            end

            if (isempty(out)) %um caso est� dando array vazio
                out = zeros(1,tam_padr);
            else
                %na primeira execu��o do c�digo, X ainda est� vazio e n�o
                %tem dimens�o, neste caso ele pega antecipadamente a
                %dimens�o do vetor out calculada primeiramente
                if(isempty(X))
                    tam_atual = tam_padr;
                end

                
                %se o tamanho das features atuais s�o maiores do que a que tem
                %na matriz e n�o est� recebendo vetor vazio, limita o tamanho
                %da inser��o das features ao tamanho da matriz de atributos                
                if tam_atual < tam_padr %caso seja menor, � preenchido com zeros
                    temp = zeros(1,tam_padr);
                    temp(1:tam_atual) = out;
                    out = temp;
                end
                
            end
            %o range abaixo garante que ele ir� passar o tamanho do array
            %de features atual sempre no m�ximo com o tamanho da base j�
            %existente
            X = [X; out(1:tam_padr)];
            
        elseif(classFold(i)==0)
			%realizar uma conversão pra tons de cinza e aplicar um filtro gaussiano (paper do LBP)?
            imagem = imread(['CASIA1/Sp/' fold{i}]);
            imageYCbCr = rgb2ycbcr(imagem);
            % get the chrominance component Cr (1: Y, 2: Cb, 3: Cr)
            img2 = imageYCbCr(:,:,3);
            out = extractHOGFeatures(img2,'CellSize',[64 64]);
            [um tam_atual] = size(out);

            %garante que a primeira vez que o c�digo for executado, ir�
            %guardar a dimens�o para todos os folds
            if fl == 0
               [um tam_padr] = size(out);
               fl = 1;
            end

            if (isempty(out)) %um caso est� dando array vazio

                out = zeros(1,tam_padr);
            else
                
                %[um, tam_atual] = size(out);
                %na primeira execu��o do c�digo, X ainda est� vazio e n�o
                %tem dimens�o, neste caso ele pega antecipadamente a
                %dimens�o do vetor out calculada primeiramente
                if(isempty(X))
                    tam_atual = tam_padr;
                end
                
                %se o tamanho das features atuais s�o maiores do que a que tem
                %na matriz e n�o est� recebendo vetor vazio, limita o tamanho
                %da inser��o das features ao tamanho da matriz de atributos                
                if tam_atual < tam_padr %caso seja menor, � preenchido com zeros
                    temp = zeros(1,tam_padr);
                    temp(1:tam_atual) = out;
                    out = temp;
                end
            end
            %o range abaixo garante que ele ir� passar o tamanho do array
            %de features atual sempre no m�ximo com o tamanho da base j�
            %existente
            X = [X; out(1:tam_padr)];

        end
    end
    
    save(['featuresHOGC7/X_' num2str(k) '.mat'], 'X');
end