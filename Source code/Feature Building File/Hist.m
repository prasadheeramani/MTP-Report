function H = Hist(hog, prevImg, flow)
%     pi = 180;
    H = [];

    magnitudes_2d = flow.Magnitude;
    magnitudes = (magnitudes_2d(:))';
% 
%     angles_2d = flow.Orientation;
%     angles = (angles_2d(:))';
% 
% 
%     angles = angles*pi/180;
    numBins = hog.numBins;
    
    H = hist(magnitudes,numBins);
end

