function H = getHistogram(magnitudes, angles, numBins)

    pi = 180;
    angles = angles*pi/180;

    binSize = pi / numBins;
    % % The angle values will range from 0 to pi.

    % Make the angles unsigned by adding pi (180 degrees) to all negative angles.
    angles(angles < 0) = angles(angles < 0) + pi;

    leftBinIndex = angles/binSize;
    leftBinIndex = floor(leftBinIndex) + 1;
    rightBinIndex = leftBinIndex + 1;

    bins = 0:binSize:pi;



    leftBinCenter = bins(leftBinIndex);
    leftDistance = abs(angles - leftBinCenter);
    rightDistance = binSize - leftDistance;

    leftFraction = (rightDistance/binSize);
    rightFraction = 1 - leftFraction;

    % Create an empty row vector for the histogram.
    H = zeros(1, numBins);

    for i = 1:numBins
    %     Find the pixels with left bin == i
        pixels = (leftBinIndex == i);

    %     For each of the selected pixels, add the gradient magnitude to bin 'i',
    %     weighted by the 'leftPortion' for that pixel.
        H(1, i) = H(1, i) + (magnitudes(pixels)' * leftFraction(pixels) );
        pixels = (rightBinIndex == i);

        %     For each of the selected pixels, add the gradient magnitude to bin 'i',
    %     weighted by the 'rightPortion' for that pixel.
        H(1, i) = H(1, i) + (magnitudes(pixels)' * rightFraction(pixels) );
    end    
end