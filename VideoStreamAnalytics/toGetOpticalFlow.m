input_video = 'AID-495-S-52.9-2.mp4';
input_video_gray = 'S-52.9-2.avi';
videoReader = vision.VideoFileReader(input_video_gray,'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
converter = vision.ImageDataTypeConverter; 
opticalFlow = vision.OpticalFlow('ReferenceFrameDelay', 1);
opticalFlow.OutputValue = 'Horizontal and vertical components in complex form';
shapeInserter = vision.ShapeInserter('Shape','Lines','BorderColor','Custom', 'CustomBorderColor', 255);
videoPlayer = vision.VideoPlayer('Name','Motion Vector');


% Input frames with VideoReader 
inputObj = VideoReader(input_video); 
%lastFrame = read(inputObj, inf);                                 
nFrames = inputObj.NumberOfFrames;


%Convert the image to single precision, then compute optical flow for the video. Generate coordinate points and draw lines to indicate flow. Display results.
blob = vision.BlobAnalysis(...
'CentroidOutputPort', false, 'AreaOutputPort', false, ...
'BoundingBoxOutputPort', true, ...
'MinimumBlobAreaSource', 'Property', 'MinimumBlobArea', 160);
k = 1;
t = 0; % set the stop time
while ~isDone(videoReader)
    t = t+1; 
    inputFrame = read(inputObj, k);
    k = k+1;

    frame = step(videoReader);
    im = step(converter, frame);
    of = step(opticalFlow, im);
    lines = videooptflowlines(of, 20);
    if ~isempty(lines)
      out =  step(shapeInserter, im, lines);
  
      
      %step(videoPlayer, out);
      %figure(1),imshow(out); 
      figure(1),
      subplot(2,1,1),imshow(inputFrame); 
        subplot(2,1,2),
        imshow(out); 
    end
    if t == 30
         break;
    end
       
end
%Close the video reader and player

release(videoPlayer);
release(videoReader);

