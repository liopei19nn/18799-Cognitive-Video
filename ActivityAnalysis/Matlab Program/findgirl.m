%removing back ground to make people in blobs
inputObj = VideoReader('Shopping Mall Wing People.mp4');
nFrames = inputObj.NumberOfFrames; % Total number of frames

frame = read(inputObj,1); % read in 1st frame as background frame 

[height,width,d] = size(frame);%get the size of each frame
% ----------------------- set frame size variables -----------------------
load('backgroundAvg.mat');
% --------------------- process frames -----------------------------------


foreGround = zeros(height, width); 
threshold = 25; 
for i = 1:nFrames
    inputFrame = read(inputObj, i);
    inputGray = rgb2gray(inputFrame); 
    frameDiff = abs(double(inputGray) - backgroundAvg); 
    for j=1:width 
        for k=1:height
            if ((frameDiff(k,j) > threshold)) 
                
                foreGround(k,j) =255;
            else
                foreGround(k,j) =0;
            end

            if((inputFrame(k,j,1)<=140)&&(inputFrame(k,j,1)>= 96)&&(inputFrame(k,j,2)>=35)&&(inputFrame(k,j,2)<=60)&&(inputFrame(k,j,2)>=35)&&(inputFrame(k,j,3)<=60))
                foreGround(k,j)=255;
            elseif((foreGround(k,j,1)<=140)&&(foreGround(k,j,1)>=100)&&(foreGround(k,j,2)<=150)&&(foreGround(k,j,2)>=110)&&(foreGround(k,j,3)<=140)&&(foreGround(k,j,1) >=90))
                foreGround(k,j)=255;
            else
                foreGround(k,j)=foreGround(k,j);
            end
        end
    end
    figure(1),subplot(2,1,1),imshow(uint8(inputFrame)); subplot(2,1,2),imshow(foreGround)
end