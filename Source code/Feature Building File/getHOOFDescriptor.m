function H = getHOOFDescriptor(HOOF, img, flow)
% GETHOOFDESCRIPTOR computes a HOOF descriptor vector for the supplied image.
%   H = getHOOFDescriptor(img)
 
%   This function takes a rowxcol pixel gray scale image returning a   column vector.

%   Parameters:
%     img - A grayscale image matrix with  rows and  columns.
%   Returns:
%     A column vector containing the HOOF descriptor.


%    Specifically, I'm using the following parameter choices:
%      - 8x8 pixel cells
%      - Block size of 2x2 cells
%      - 50% overlap between blocks
%      - 9-bin histogram

%     The above parameters give a final descriptor size of 
%     7 blocks across x 15 blocks high x 4 cells per block x 9 bins per hist
%     = 3,780 values in the final vector.

%    A couple other important design decisions:
%    - Each vector splits its contribution proportionally between the
%      two nearest bins
%    - For the block normalization, I'm using L2 normalization.
%


    
% Empty vector to store computed descriptor.
H = [];

% Verify the input image size matches the HOOF parameters.
% assert(isequal(size(prevImg), HOOF.winSize))
% assert(isequal(size(img), size(flow.Orientation)))
% ===============================
%    Compute Gradient Vectors
% ===============================
% Compute the flow vector at every pixel in the x and y direction in the image.

dx = flow.Vx;
dy = flow.Vy;

% Convert the gradient vectors to polar coordinates (angle and magnitude).
angles = atan2(dy, dx);
magnit = ((dy.^2) + (dx.^2)).^.5;


% =================================
%     Compute Cell Histograms 
% =================================
% Compute the histogram for every cell in the image. We'll combine the cells
% into blocks and normalize them later.

% Create a three dimensional matrix to hold the histogram for each cell.
histograms = zeros(HOOF.numVertCells, HOOF.numHorizCells, HOOF.numBins);

% For each cell in the y-direction...
for row = 0:(HOOF.numVertCells - 1)
    
    % Compute the row number in the 'img' matrix corresponding to the top
    % of the cells in this row. Add 1 since the matrices are indexed from 1.
    rowOffset = (row * HOOF.cellSize) + 1;
    
    % For each cell in the x-direction...
    for col = 0:(HOOF.numHorizCells - 1)
    
        % Select the pixels for this cell.
        
        % Compute column number in the 'img' matrix corresponding to the left
        % of the current cell. Add 1 since the matrices are indexed from 1.
        colOffset = (col * HOOF.cellSize) + 1;
        
%         disp(rowOffset, colOffset);
%         fprintf('%d %d\n', rowOffset, colOffset);
        % Compute the indices of the pixels within this cell.
        rowIndeces = rowOffset : (rowOffset + HOOF.cellSize - 1);
        colIndeces = colOffset : (colOffset + HOOF.cellSize - 1);
        
        % Select the angles and magnitudes for the pixels in this cell.
        cellAngles = angles(rowIndeces, colIndeces); 
        cellMagnitudes = magnit(rowIndeces, colIndeces);

        % Compute the histogram for this cell.
        % Convert the cells to column vectors before passing them in.
        histograms(row + 1, col + 1, :) = getHistogram(cellMagnitudes(:), cellAngles(:), HOOF.numBins);
    end
    
end


% ===================================
%       Block Normalization
% ===================================    

% Take 2 x 2 blocks of cells and normalize the histograms within the block.
% Normalization provides some invariance to changes in contrast, which can
% be thought of as multiplying every pixel in the block by some coefficient.

% For each cell in the y-direction...
for row = 1:(HOOF.numVertCells - 1)    
    % For each cell in the x-direction...
    for col = 1:(HOOF.numHorizCells - 1)
    
        % Get the histograms for the cells in this block.
        blockHists = histograms(row : row + 1, col : col + 1, :);
        
        % Put all the histogram values into a single vector (nevermind the 
        % order), and compute the magnitude.
        % Add a small amount to the magnitude to ensure that it's never 0.
        magnitude = norm(blockHists(:)) + 0.01;
    
        % Divide all of the histogram values by the magnitude to normalize 
        % them.
        normalized = blockHists / magnitude;
        
        % Append the normalized histograms to our descriptor vector.
        H = [H; normalized(:)];
    end
end
    
end
