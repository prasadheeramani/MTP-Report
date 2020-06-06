% magnitudes = [40, 8, 12, 120];
% angles = [10,40,20,25];

function H = Histogram_Binning(hog, img, flow)
    pi = 180;
    
    dx = flow.Vx;
    dy = flow.Vy;

    % Convert the gradient vectors to polar coordinates (angle and magnitude).
    angles_2d = atan2(dy, dx);

    magnitudes_2d = flow.Magnitude;
    magnitudes = (magnitudes_2d(:))';

%     angles_2d = flow.Orientation;
    angles = (angles_2d(:))';

     angles(isnan(angles)) = 0;


    angles = angles*pi/180;

    numBins = hog.numBins;


    binSize = pi / numBins;


    % % The angle values will range from 0 to pi.
    % minAngle = 0;
    % 
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
        H(1, i) = H(1, i) + ( leftFraction(pixels) * magnitudes(pixels)');
        pixels = (rightBinIndex == i);

        %     For each of the selected pixels, add the gradient magnitude to bin 'i',
    %     weighted by the 'rightPortion' for that pixel.
        H(1, i) = H(1, i) + ( rightFraction(pixels) * magnitudes(pixels)' );
    end    
end