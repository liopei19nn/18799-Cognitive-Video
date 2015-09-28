%removing back ground to make people in blobs
%adding all frames before to make motion enery image
%small substraction for frames before to make it fade
inputObj = VideoReader('Shopping Mall Wing People.mp4');
nFrames = inputObj.NumberOfFrames; % Total number of frames

frame = read(inputObj,1); % read in 1st frame as background frame 

%-----get the average value of every pixel in the frame-------
load('backgroundAvg.mat');

[height,width,d] = size(frame);%get the size of each frame
% --------------------- process frames -----------------------------------
threshold = 25; 
foreGround = zeros(height, width); 
for k = 2:nFrames 
    inputFrame = read(inputObj, k);
    inputGray = rgb2gray(inputFrame); 
    framDiff = abs(double(inputGray) - double(backgroundAvg)); 
    for i=1:width 
        for j=1:height
            if ((framDiff(j,i) > threshold)) 
      
                foreGround(j,i) =255;
            else
              
                if (foreGround(j,i)>0)
                    foreGround(j,i)=foreGround(j,i)-10;
                else
                    foreGround(j,i)=0;
                end
            end           
        end
    end
    figure(1),subplot(2,1,1),imshow(inputFrame); 
    subplot(2,1,2),imshow(uint8(foreGround))
end