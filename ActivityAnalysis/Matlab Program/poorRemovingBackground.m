%removing back ground to make people in blobs
%duplicate some program in sample code "runVideoReader.m"
%a poor application because the rightmost man stayed for a while

%-----------read in video and get the attributes----------------
inputObj = VideoReader('Shopping Mall Wing People.mp4');

nFrames = inputObj.NumberOfFrames;%get the number of frames

frame = read(inputObj,1);

[height,width,d] = size(frame);%get the size of each frame

backGround = rgb2gray(frame);%get the approximate median background

%-----------------------processing!------------------------------

foreGround = zeros(height,width);%initializing the output

threshold = 25;%set the threshold of comparison

for k = 1:nFrames
    inputFrame = read(inputObj, k);
    inputGray = rgb2gray(inputFrame);
    frameDiff = abs(double(inputGray) - double(backGround)); 
    for i = 1:width
        for j = 1:height
            if(frameDiff(j,i) > threshold)

                foreGround(j,i) = 255;
            else

                foreGround(j,i) = 0;
            end
            
        end
        
    end
    %show in figure(1)
    figure(1),subplot(2,1,1),imshow(inputFrame); 
    subplot(2,1,2),imshow(uint8(foreGround));
end











