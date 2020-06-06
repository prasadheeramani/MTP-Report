for ATTAS = {'1_tatta', '2_natta', '3_pakka', '4_kuditta_mettu', '5_kuditta_nattal',...
        '6_kuditta_tattal', '8_tei_tei_dhatta','9_katti_kartari','10_utsanga'...
        '11_mandi','12_sarrikkal','13_tirmana','14_sarika','15_joining'}
    ATTA = char(ATTAS);
    for NUMBER = 1:8   
        for DANCERS = {'Dancer1','Dancer2','Dancer3'}
            DANCER = char(DANCERS);
            Input_path = fullfile('L:\Adavus_session_1\', ATTA,int2str(NUMBER),DANCER, '\');
            output_path = fullfile('F:\Adavus_session_1\', ATTA,int2str(NUMBER),DANCER, '\');
            
            allImg = dir(strcat(Input_path, 'color_USB-VID_*.png'));
            No_ofImages = length(allImg);
            
            for i=0 : No_ofImages - 1
                try
                    prevImg = imread(strcat(Input_path,'color_USB-VID_045E&PID_02BF-0000000000000000_',int2str(i),'.png'));
                    convertedImg = rgb2gray(prevImg);
                    imwrite(convertedImg, strcat(output_path,'GRAY_', 'USB-VID_045E&PID_02BF-0000000000000000_',int2str(i), '.png'));
%                     disp(strcat(output_path,'GRAY_', 'USB-VID_045E&PID_02BF-0000000000000000_',int2str(i), '.png'));
                catch
                    disp(strcat(Input_path,'color_USB-VID_045E&PID_02BF-0000000000000000_',int2str(i),'.png', 'Not found'));
                end
            end
            disp(Input_path);
        end
    end
end