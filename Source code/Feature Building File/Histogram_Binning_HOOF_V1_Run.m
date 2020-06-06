%image size
image = imread(strcat('C:\Users\Decrypt\Desktop\Adavus_session_1\13_tirmana\1\Dancer1\','RESIZED_USB-VID_045E&PID_02BF-0000000000000000_10.png'));
imageSize = size(image);

% Cell size in pixels (the cells are square).
hog.cellSize = 8;
% The number of cells horizontally and vertically.
hog.numHorizCells = imageSize(2)/hog.cellSize;
hog.numVertCells = imageSize(1)/hog.cellSize;
hog.numBins = 9;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This is for histogram binning from 1 to 9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%Bins = 9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
for ATTAS = {'1_tatta', '2_natta', '4_kuditta_mettu', '5_kuditta_nattal',  '6_kuditta_tattal', '8_tei_tei_dhatta', '9_katti_kartari'}
% for ATTAS = {'6_kuditta_tattal'}
    ATTA = char(ATTAS);
    % mkdir (['C:\Users\Decrypt\Desktop\' ATTA 'Cell_4']);
    mkdir (['C:\Users\Decrypt\Desktop\Final Result V1\Resized_Histogram_Binning_HOOF\' ATTA  '_Histogram_Binning_HOOF']);
%     
%     ATTA = char(ATTAS);
    % SAVE_DIR = ['C:\Users\Decrypt\Desktop\' ATTA 'Cell_4' '\'];
    SAVE_DIR = ['C:\Users\Decrypt\Desktop\Final Result V1\Resized_Histogram_Binning_HOOF\' ATTA '_Histogram_Binning_HOOF' '\'];
    for NUMBER_ = 1:8
       for DANCERS_ = {'Dancer1','Dancer2','Dancer3'}
        % for DANCERS_ = {'Dancer1'}
            DANCERS = char(DANCERS_);
            DANCER_NUMBER = DANCERS(end);
            NUMBER = int2str(NUMBER_);
            root_path = fullfile('C:\Users\Decrypt\Desktop\Adavus_session_1\', ATTA,NUMBER,DANCERS, '\');

        %     For index 1 to 9
            FILE = strcat(upper(ATTA(3:end)),'_',NUMBER,'_', 'Dancer_',DANCER_NUMBER );

            SAVE_DATA_OUTPUT =  strcat(ATTA(1),'_', upper(ATTA(3)), ATTA(4:end),'_',NUMBER,'_', 'Dancer_',DANCER_NUMBER);
            READ_CSV = strcat(FILE,'.csv');
            Nomenclature = strcat(ATTA(1), '_', FILE);
            SAVE_FILE = strcat(ATTA(1), '_', FILE, '.mat');

            HOOF1 = []; % Variable that will hold histogram of otical flow
            HOOF2 = [];


            try
                annotations = readtable([root_path,READ_CSV]);
                annotations2= removevars(annotations,{'Var1'});
                annotations3=table2array(annotations2);
                annotations4 = int64(annotations3);
                dim_annotations = size(annotations2);

                allImg = dir(strcat(root_path, 'RESIZED_USB-VID_045E&PID_02BF-0000000000000000_*.png'));
                No_ofImages = length(allImg);
                opticFlow = opticalFlowLK;
                for i=1:No_ofImages - 1
                    prevImg = imread(strcat(root_path,'RESIZED_USB-VID_045E&PID_02BF-0000000000000000_',int2str(i),'.png'));
                    currImg = imread(strcat(root_path,'RESIZED_USB-VID_045E&PID_02BF-0000000000000000_',int2str(i+1),'.png'));
                    flow = estimateFlow(opticFlow,prevImg);
                    flow = estimateFlow(opticFlow,currImg);

                    H = getHOOFDescriptor(hog, prevImg, flow);
                    H = reshape(H, [1, (hog.numHorizCells - 1) * (hog.numVertCells - 1) * 4 * hog.numBins]);
                    HOOF2 = [HOOF2; H];
                    if mod(i, 100) == 0
                        fprintf('%d %s\n', i, strcat(root_path,'RESIZED_USB-VID_045E&PID_02BF-0000000000000000_',int2str(i),'.png'));
                    end
                end
    
                [HOOF2_row, HOOF2_col] = size(HOOF2);

                [row, col] = size(annotations2);

                start_image = annotations4(1,1);
                end_image = annotations4(row,col);

                X = HOOF2;
                y = ones(HOOF2_row, 1);

                for i = 1:row
                    y((annotations4(i,1) + 1):(annotations4(i,2) + 1)) = 0;
                end


                X_final = X(start_image:end_image,:);
                Y_final = y(start_image:end_image,:);
                save([SAVE_DIR, strcat(SAVE_DATA_OUTPUT, '.mat')],'X_final', 'Y_final');
                
            catch
                fprintf('%s \n',strcat(SAVE_DATA_OUTPUT, '.csv'));
            end

        end
    end
end
%%%%%%%%%%%%%








%image size
image = imread(strcat('C:\Users\Decrypt\Desktop\Adavus_session_1\13_tirmana\1\Dancer1\','RESIZED_USB-VID_045E&PID_02BF-0000000000000000_10.png'));
imageSize = size(image);

% Cell size in pixels (the cells are square).
hog.cellSize = 8;
% The number of cells horizontally and vertically.
hog.numHorizCells = imageSize(2)/hog.cellSize;
hog.numVertCells = imageSize(1)/hog.cellSize;
hog.numBins = 9;

% for ATTAS = {'10_utsanga', '11_mandi','13_tirmana','14_sarika', '15_joining'}
for ATTAS = {'11_mandi','13_tirmana','14_sarika', '15_joining'}
% for ATTAS = {'10_utsanga'}
    ATTA = char(ATTAS);
    % mkdir (['C:\Users\Decrypt\Desktop\' ATTA 'Cell_4']);
    mkdir (['C:\Users\Decrypt\Desktop\Final Result V1\Resized_Histogram_Binning_HOOF\' ATTA '_Histogram_Binning_HOOF']);

    SAVE_DIR = ['C:\Users\Decrypt\Desktop\Final Result V1\Resized_Histogram_Binning_HOOF\' ATTA '_Histogram_Binning_HOOF' '\'];
    for NUMBER_ = 1:8
        for DANCERS_ = {'Dancer1','Dancer2','Dancer3'}
%         for DANCERS_ = {'Dancer2'}
            DANCERS = char(DANCERS_);
            DANCER_NUMBER = DANCERS(end);
            NUMBER = int2str(NUMBER_);
            root_path = fullfile('C:\Users\Decrypt\Desktop\Adavus_session_1\', ATTA,NUMBER,DANCERS, '\');

        %     For after 10 index
            FILE = strcat(upper(ATTA(4:end)),'_',NUMBER,'_', 'Dancer_',DANCER_NUMBER );
            SAVE_DATA_OUTPUT = strcat(ATTA(1:2),'_', upper(ATTA(4)), ATTA(5:end),'_',NUMBER,'_', 'Dancer_',DANCER_NUMBER);
            READ_CSV = strcat(FILE,'.csv');
            Nomenclature = strcat(int2str(NUMBER_), '_', FILE);
            SAVE_FILE = strcat(int2str(NUMBER_), '_', FILE, '.mat');

            HOOF1 = []; % Variable that will hold histogram of otical flow
            HOOF2 = [];


            try
                annotations = readtable([root_path,READ_CSV]);
                annotations2= removevars(annotations,{'Var1'});
                annotations3=table2array(annotations2);
                annotations4 = int64(annotations3);
                dim_annotations = size(annotations2);

                allImg = dir(strcat(root_path, 'RESIZED_USB-VID_045E&PID_02BF-0000000000000000_*.png'));
                No_ofImages = length(allImg);
                opticFlow = opticalFlowLK;
                for i= 1:No_ofImages - 1
                    prevImg = imread(strcat(root_path,'RESIZED_USB-VID_045E&PID_02BF-0000000000000000_',int2str(i),'.png'));
                    currImg = imread(strcat(root_path,'RESIZED_USB-VID_045E&PID_02BF-0000000000000000_',int2str(i+1),'.png'));

                    flow = estimateFlow(opticFlow,prevImg);
                    flow = estimateFlow(opticFlow,currImg);

                    H = getHOOFDescriptor(hog, prevImg, flow);
                    H = reshape(H, [1, (hog.numHorizCells - 1) * (hog.numVertCells - 1) * 4 * hog.numBins]);
                    HOOF2 = [HOOF2; H];
                    if mod(i, 100) == 0
                        fprintf('%d %s\n', i, strcat(root_path,'RESIZED_USB-VID_045E&PID_02BF-0000000000000000_',int2str(i),'.png'));
                    end

                end
    % 
                [HOOF2_row, HOOF2_col] = size(HOOF2);

                [row, col] = size(annotations2);

                start_image = annotations4(1,1);
                end_image = annotations4(row,col);

                X = HOOF2;
                y = ones(HOOF2_row, 1);

                for i = 1:row
                    y((annotations4(i,1) + 1):(annotations4(i,2) + 1)) = 0;
                end


                X_final = X(start_image:end_image,:);
                Y_final = y(start_image:end_image,:);
                save([SAVE_DIR, strcat(SAVE_DATA_OUTPUT, '.mat')],'X_final', 'Y_final');
            catch
                fprintf('%s \n',strcat(SAVE_DATA_OUTPUT, '.csv'));
            end

        end
    end
end