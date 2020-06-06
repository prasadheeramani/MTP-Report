DANCERS = 'Dancer3';
DANCER_NUMBER = DANCERS(end);
NUMBER = '4';

ATTA = '5_kuditta_nattal';

root_path = fullfile('L:\Adavus_session_1\', ATTA,NUMBER,DANCERS, '\');
output_path = fullfile('F:\Adavus_session_1\', ATTA,NUMBER,DANCERS, '\');
allClasses = dir(root_path);

for ii = 1:length(allClasses)
    allMat = dir(strcat(root_path, allClasses(ii).name, '\', '*.mat'));
    for jj = 1:length(allMat)
        strcat(root_path, allClasses(ii).name, '\')
        load(strcat(root_path, allClasses(ii).name, '\', allMat(jj).name));
        
        % Color Image
        color_image = ColorFrame.ColorData;
        
        % Depth data
        Depth_image = DepthFrame.DepthData;
        Valiid_pixel = DepthFrame.Valid;
        PlayerIndex = DepthFrame.PlayerIndex;
        
        % Background subtraction of the Color image using PlayerIndex
        musk = zeros(480, 640); %480 , 640
        for i = 1:480 %480
            for j=1:640 % 640
                musk(DepthFrameToColorFrameMapping.Y(i, j), DepthFrameToColorFrameMapping.X(i, j)) = PlayerIndex(i, j);
            end
        end
        gray_image = rgb2gray(color_image);
        musk = uint8(mat2gray(musk));
        maskedGrayImage = gray_image.* musk;
        %maskedRgbImage = bsxfun(@times, color_image, cast(new_img, 'like', color_image));
        imwrite(maskedGrayImage, strcat(output_path, allClasses(ii).name, '\', allMat(jj).name(1:end-4), '.png'));
    end
end