mapping = getmapping(24,'u2');
for k=0:9

    load(['folds/fold_' num2str(k) '.mat' ] ); % carrega a vari�vel fold
    load(['folds/class_' num2str(k) '.mat' ]); % carrega as classes das imagens
    
    G = fspecial('gaussian',[5 5],2); %criando filtro gaussiano 5x5, rho=2
    X = [];
    for i=1:length(fold);
        disp (['Extraindo caracter�sticas fold ' num2str(k) ' img: ' num2str(i)]);
        if(classFold(i)==1)
            img = imread(['CASIA1/AU/' fold{i}]);	
            
            imageYCbCr = rgb2ycbcr(img);
            % get the chrominance component Cr (1: Y, 2: Cb, 3: Cr)
            img2 = imageYCbCr(:,:,3);
            
            %img2 = rgb2gray(img); %converte para escala de cinza
            img3 = imfilter(img2,G,'same'); %aplicando filtro gaussiano para borramento
            X = [X; lbp(img3,3,24,mapping,'h')];
        elseif(classFold(i)==0)
			%realizar uma conversão pra tons de cinza e aplicar um filtro gaussiano (paper do LBP)?
            img = imread(['CASIA1/Sp/' fold{i}]);
            
            imageYCbCr = rgb2ycbcr(img);
            % get the chrominance component Cr (1: Y, 2: Cb, 3: Cr)
            img2 = imageYCbCr(:,:,3);
            
            %img2 = rgb2gray(img); %converte para escala de cinza
            img3 = imfilter(img2,G,'same'); %aplicando filtro gaussiano para borramento
            X = [X; lbp(img3,3,24,mapping,'h')];
        end
    end
    save(['featuresLBPC7/X_' num2str(k) '.mat'], 'X');
end