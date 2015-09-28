foregroundDetector = vision.ForegroundDetector('NumGaussians', 10, ...
    'NumTrainingFrames', 50);

inputObj = VideoReader('N-52.3-1.avi');                
nFrames = inputObj.NumberOfFrames;

videoReader = vision.VideoFileReader('AID-495-N-52.3-1.mp4');
blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, ...
    'MinimumBlobArea', 100);
for i = 1:nFrames
    frame = step(videoReader); % read the next video frame
    foreground = step(foregroundDetector, frame);
    se = strel('square', 5);
    filteredForeground = imopen(foreground, se);
    
    bbox = step(blobAnalysis, filteredForeground);
    n = 0;
      for j = 1 : size(bbox,1)        
         if(bbox(j,2) < 120)   
             result = insertShape(frame, 'Rectangle', bbox, 'Color', 'red');
             n = n + 1;
         end
      end    
    result = insertText(result, [10 10], n, 'BoxOpacity', 1, ...
            'FontSize', 14);

    figure(1); imshow(result); title('Clean Foreground'); 
end

release(videoReader); % close the video file

