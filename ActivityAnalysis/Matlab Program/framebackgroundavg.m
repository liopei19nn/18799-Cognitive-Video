%calculate the average frame background of the whole video

%read in video and get the attributes
inputObj = VideoReader('Shopping Mall Wing People.mp4');

nFrames = inputObj.NumberOfFrames;%get the number of frame

frame = read(inputObj,1);

[height,width,d] = size(frame);%get the size of each frame

%get the average value of every pixel in the frame

backgroundAvg = zeros(height,width);

for i = 1:nFrames
    background = double(rgb2gray(read(inputObj,i)));
    backgroundAvg = backgroundAvg + background;

    
end
backgroundAvg = backgroundAvg/nFrames;