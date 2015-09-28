%Removing background first first
%Accumulate the color in heat map
%Cover the color on original frame
%---------read in video and get the attributes-------------
inputObj = VideoReader('Shopping Mall Wing People.mp4');
nFrames = inputObj.NumberOfFrames;% Total number of frames

frame = read(inputObj,1); % read in 1st frame as background frame 

load('backgroundAvg.mat');

[height,width,d] = size(frame);%get the size of each frame

%-------------------------processing!---------------------------
threshold =25; 
foreGround = zeros (height, width);

for k = 1:nFrames
    inputFrame = read(inputObj, k);
    inputGray = rgb2gray(inputFrame);
    frameDiff = abs(double(inputGray) - backgroundAvg); 
    for i=1:width
        for j=1:height
            if ((frameDiff(j,i) > threshold))
                foreGround(j,i) = foreGround(j,i)+10;
            end
        end
    end
    figure(1)
    imshow(inputFrame)
    hold on 
    heat=imagesc(foreGround,[0,255]); %turn double value into color
    set(heat,'AlphaData', 0.5); 
    imagesc(heat);
    hold off 
end