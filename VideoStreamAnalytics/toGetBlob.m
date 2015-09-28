clc;
clear all;
close all;

% Input frames with VideoReader 
inputObj = VideoReader('AID-495-N-53.4-2.mp4'); 
%lastFrame = read(inputObj, inf);                                 
nFrames = inputObj.NumberOfFrames;

% Set up output video with VideoWriter
workingDir = pwd;
outputVideo = VideoWriter(fullfile(workingDir,'N-53.4-2.avi')); 
outputVideo.FrameRate = inputObj.FrameRate; 
open(outputVideo);

% Approximate Median algorithm to subtract background
first_fr = read(inputObj, 1);
median_fr_bw = double(rgb2gray(first_fr));

fr_size = size(first_fr);
height = fr_size(1);
width = fr_size(2);
foreground = zeros(height,width);
threshold = 25;

th_bk = 25;                                                     

for i = 2 : nFrames
    current_fr = read(inputObj, i);
    current_fr_bw = rgb2gray(current_fr);
    
    delta = abs(double(current_fr_bw) - double(median_fr_bw));
    for j = 1 : width
        for k = 1 : height
            if (delta(k,j) > th_bk)                            
                median_fr_bw(k,j) = current_fr_bw(k,j);         
            elseif (current_fr_bw(k,j) > median_fr_bw(k,j))     
                median_fr_bw(k,j) = median_fr_bw(k,j) + 1;
            elseif (current_fr_bw(k,j) < median_fr_bw(k,j))
                median_fr_bw(k,j) = median_fr_bw(k,j) - 1;
            end
                
            if (delta(k,j) > threshold)
                foreground(k,j) = 255;
            else
                foreground(k,j) = 0;
            end
            
        end
    end
    
    I = uint8(foreground);                                     
    J = imadjust(I);   
    se = strel('square', 3);
    BW2 = imclose(J, se);
    BW = imfill(BW2, 'holes');
    %BW = bwmorph(uint8(J), 'dilate');
    %BW2 = bwmorph(uint8(BW), 'erode');

    %figure(1)
    %subplot(2,1,1),imshow(current_fr)
    %subplot(2,1,2),imshow(uint8(median_fr_bw))
    %figure(1)
    %imshow(BW)
    
    writeVideo(outputVideo, BW);

end
close(outputVideo);
