function imageHist = featureWLD24(imageRGB)

    % converted image into the YCbCr color space
    %imageYCbCr = rgb2ycbcr(imageRGB);

    % get the chrominance component Cr
    %inputImageCr = imageYCbCr(:,:,3);
    inputImageCr = rgb2gray(imageRGB);

    % following the happy path

    % Determine the dimensions of the input image.
    [ySize, xSize] = size(inputImageCr);

    % Get double image
    crImageDouble = double(inputImageCr);

    % Block size, each WLD code is computed within a block of size yBlockSize*xBlockSize
    yBlockSize = 7;
    xBlockSize = 7;

    % some constantes
    BELTA=5; % to avoid that center pixture is equal to zero
    ALPHA=3; % like a lens to magnify or shrink the difference between neighbors
    EPSILON=0.0000001;
    PI=3.141592653589;

    % Minimum allowed size for the input image depends
    % on the radius of the used LBP operator.
    if(xSize < xBlockSize || ySize < yBlockSize)
        error('Too small input image. Should be at least (2*radius+1) x (2*radius+1)');
    end

    % filter f00 to 24 neighbors
    %    1  2  3  4   5  6  7  8  9
    f00=[1, 1, 1, 1, 1, 1, 1; 1, 0, 0, 0, 0, 0, 1; 1, 0, 0, 0, 0, 0, 1; 1, 0, 0, -24, 0, 0, 1; 1, 0, 0, 0, 0, 0, 1; 1, 0, 0, 0, 0, 0, 1; 1, 1, 1, 1, 1, 1, 1];

    % Calculate dx and dy;
    dX = xSize - xBlockSize;
    dY = ySize - yBlockSize;

    % Initialize the result matrix with zeros.
    differentialExcitation = zeros(dY+1,dX+1);
    gradientOrientation    = zeros(dY+1,dX+1);
    gradientOrientationL = zeros(dY+4, dX+4);

    %Compute the WLD code per pixel (8 neighbors)
    for y = 4:ySize-3
        for x = 4:xSize-3
            % Get 3*3 block
            imageBlock = crImageDouble(y-3:y+3,x-3:x+3);

            % Get center pixel
            centerPixel = crImageDouble(y,x);

            % Compute differential excitation

            % Step 01: Compute the difference between the center pixel
            % and its neighbours via the filter f00
            ks00 = sum(sum(f00 .* imageBlock));

            % Step 02: Calculate the proportion of the differences to the
            % current pixel intensity by the outputs of the filter f00 and f01
            % f01 = centerPixel

            centerPixel = centerPixel + BELTA;
            if ( centerPixel ~= 0 )
                differentialExcitation(y,x) = atan(ALPHA*ks00/centerPixel);
            else
                differentialExcitation(y,x) = 0.1;
            end

            % Compute gradient orientation

            pixel4 = crImageDouble(y-3,x);
            pixel16 = crImageDouble(y+3,x);
            pixel10 = crImageDouble(y,x+3);
            pixel22 = crImageDouble(y,x-3);

            if ( abs(pixel22-pixel10) < EPSILON)
                gradientOrientation(y,x) = 0;
            else
                ks10 = pixel16-pixel4;
                ks11 = pixel22-pixel10;
                gradientOrientation(y,x) = atan(ks11/ks10);

                % Perform the mapping from gradientOrientation to
                % grandientOrientationL

                if (ks11 > 0 && ks10 > 0)
                    gradientOrientation(y,x)= gradientOrientation(y,x) + 0;
                elseif (ks11 > 0 && ks10 < 0)
                    gradientOrientation(y,x)= gradientOrientation(y,x) + PI;
                elseif (ks11 < 0 && ks10 < 0)
                    gradientOrientation(y,x)= gradientOrientation(y,x) - PI;
                elseif (ks11 < 0 && ks10 > 0)
                    gradientOrientation(y,x)= gradientOrientation(y,x) + 0;
                end

                gradientOrientationL(y,x)= gradientOrientation(y,x) + PI;

            end
        end
    end

    % Define the number of differential excitation segments M
    M = 4;

    % Divides the differentialExcitation image into M parts
    DE = zeros(size(differentialExcitation));
    for m=0:M-1
        nml = (m/M - 0.5)*PI;
        nmu = ((m+1)/M - 0.5)*PI;
        idx = find((differentialExcitation>= nml) & (differentialExcitation<= nmu));
        DE(idx) = m+1;
    end

    %  gradientOrientationL is further quantized into T dominant
    %   orientations.
    T = 4;

    % Divides the gradientOrientationL image into T parts
    OG = zeros(size(gradientOrientationL));
    for t=0:T-1
        orientationQ = (2*t/T)*PI;
        idx = find((gradientOrientationL>= (orientationQ - PI/T)) & (gradientOrientationL<= (orientationQ + PI/T)));
        OG(idx) = t+1;
    end

    % Define the number of subhistograms bins S
    S = 20;

    % Define histogram
    imageHist = [];

    % Get histogram. Each columm has differentialExcitation M into T interval
    for t=1:T
        for m=1:M
            idx = find(OG==t & DE==m);
            imageHist = [imageHist hist(differentialExcitation(idx),20)]; %#ok<AGROW>
        end
    end
end
