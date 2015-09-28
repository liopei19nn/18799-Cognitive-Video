%removing back ground to make people in blobs
%adding all frames before to make motion enery image

%---------read in video and get the attributes-------------
inputObj = VideoReader('Shopping Mall Wing People.mp4');

nFrames = inputObj.NumberOfFrames;%get the number of frame

frame = read(inputObj,1);

[height,width,d] = size(frame);%get the size of each frame

%----get the average value of every pixel in the frame-----

load('backgroundAvg.mat');
 
%-----------------------processing!------------------------

foreGround = zeros(height,width);%initializing the output

threshold = 25;%set the threshold of comparison

for k = 1:nFrames
    inputFrame = read(inputObj, k);
    inputGray = rgb2gray(inputFrame);
    frameDiff = abs(double(inputGray) - backgroundAvg);%get diffrence
    
    for i = 1:width
        for j = 1:height
            if(frameDiff(j,i) > threshold)
                foreGround(j,i) = 255;
            end
            
        end
        
    end

    %show in figure(1)
    figure(1),subplot(2,1,1),imshow(inputFrame); subplot(2,1,2),imshow(uint8(foreGround));
end


