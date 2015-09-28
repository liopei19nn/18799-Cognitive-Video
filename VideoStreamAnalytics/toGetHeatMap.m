%Removing background first first
%Accumulate the color in heat map
%Cover the color on original frame
%---------read in video and get the attributes-------------
inputObj1 = VideoReader('AID-495-N-52.3-1.mp4');
nFrames = inputObj1.NumberOfFrames;% Total number of frames
inputObj2 = VideoReader('AID-495-N-52.3-2.mp4');
inputObj3 = VideoReader('AID-495-S-52.9-1.mp4');
inputObj4 = VideoReader('AID-495-N-52.3-1.mp4');
inputObj5 = VideoReader('AID-495-N-52.3-2.mp4');
inputObj6 = VideoReader('AID-495-S-52.9-2.mp4');



backGround1 = read(inputObj1,1); % read in 1st frame as background frame 
backGround_Gray1 = rgb2gray(backGround1);
backGround2 = read(inputObj2,1);  
backGround_Gray2 = rgb2gray(backGround2);
backGround3 = read(inputObj3,1);
backGround_Gray3 = rgb2gray(backGround3);
backGround4 = read(inputObj4,1);
backGround_Gray4 = rgb2gray(backGround4);
backGround5 = read(inputObj5,1); 
backGround_Gray5 = rgb2gray(backGround5);
backGround6 = read(inputObj6,1); 
backGround_Gray6 = rgb2gray(backGround6);


[height,width,d] = size(backGround1);%get the size of each frame

%-------------------------processing!---------------------------
threshold =25; 
foreGround1 = zeros (height, width);
foreGround2 = zeros (height, width);
foreGround3 = zeros (height, width);
foreGround4 = zeros (height, width);
foreGround5 = zeros (height, width);
foreGround6 = zeros (height, width);

for k = 1:nFrames
    inputFrame1 = read(inputObj1, k);
    inputFrame2 = read(inputObj2, k);
    inputFrame3 = read(inputObj3, k);
    inputFrame4 = read(inputObj4, k);
    inputFrame5 = read(inputObj5, k);
    inputFrame6 = read(inputObj6, k);
    
    inputGray1 = rgb2gray(inputFrame1);
    inputGray2 = rgb2gray(inputFrame2);
    inputGray3 = rgb2gray(inputFrame3);
    inputGray4 = rgb2gray(inputFrame4);
    inputGray5 = rgb2gray(inputFrame5);
    inputGray6 = rgb2gray(inputFrame6);
    
    frameDiff1 = abs(double(inputGray1) - double(backGround_Gray1)); 
    frameDiff2 = abs(double(inputGray2) - double(backGround_Gray2));
    frameDiff3 = abs(double(inputGray3) - double(backGround_Gray3));
    frameDiff4 = abs(double(inputGray4) - double(backGround_Gray4)); 
    frameDiff5 = abs(double(inputGray5) - double(backGround_Gray5));
    frameDiff6 = abs(double(inputGray6) - double(backGround_Gray6));
    
    for i=1:width
        for j=1:height
            if ((frameDiff1(j,i) > threshold))
                foreGround1(j,i) = foreGround1(j,i)+8;
            end
            if ((frameDiff2(j,i) > threshold))
                foreGround2(j,i) = foreGround2(j,i)+8;
            end
            if ((frameDiff3(j,i) > threshold))
                foreGround3(j,i) = foreGround3(j,i)+8;
            end
            if ((frameDiff4(j,i) > threshold))
                foreGround4(j,i) = foreGround4(j,i)+8;
            end
            if ((frameDiff5(j,i) > threshold))
                foreGround5(j,i) = foreGround5(j,i)+8;
            end
            if ((frameDiff6(j,i) > threshold))
                foreGround6(j,i) = foreGround6(j,i)+8;
            end
        end
    end
    backGround_Gray1 = inputGray1;
    backGround_Gray2 = inputGray2;
    backGround_Gray3 = inputGray3;
    backGround_Gray4 = inputGray4;
    backGround_Gray5 = inputGray5;
    backGround_Gray6 = inputGray6;
    
    figure(1), subplot(3,2,1),imshow(inputFrame1)
    hold on 
    heat1=imagesc(foreGround1,[0,255]); %turn double value into color
    set(heat1,'AlphaData', 0.5); 
    imagesc(heat1);
    hold off 
    
    subplot(3,2,2),imshow(inputFrame2)
    hold on 
    heat2=imagesc(foreGround2,[0,255]); %turn double value into color
    set(heat2,'AlphaData', 0.5); 
    imagesc(heat2);
    hold off 
    
    subplot(3,2,3),imshow(inputFrame3)
    hold on 
    heat3=imagesc(foreGround3,[0,255]); %turn double value into color
    set(heat3,'AlphaData', 0.5); 
    imagesc(heat3);
    hold off 
    
    subplot(3,2,4),imshow(inputFrame4)
    hold on 
    heat4=imagesc(foreGround4,[0,255]); %turn double value into color
    set(heat4,'AlphaData', 0.5); 
    imagesc(heat4);
    hold off 
    
    subplot(3,2,5),imshow(inputFrame5)
    hold on 
    heat5=imagesc(foreGround5,[0,255]); %turn double value into color
    set(heat5,'AlphaData', 0.5); 
    imagesc(heat5);
    hold off 
    
    subplot(3,2,6),imshow(inputFrame6)
    hold on 
    heat6=imagesc(foreGround6,[0,255]); %turn double value into color
    set(heat6,'AlphaData', 0.5); 
    imagesc(heat6);
    hold off 
%     if(k == 200)
%         break;
%     end
end