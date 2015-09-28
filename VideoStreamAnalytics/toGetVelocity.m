
input_video_gray = 'N-52.3-1.avi';

inputObj = VideoReader('AID-495-N-52.3-1.mp4');
nFrames = inputObj.NumberOfFrames; % Total number of frames

videoReader = vision.VideoFileReader(input_video_gray,'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
converter = vision.ImageDataTypeConverter; 
opticalFlow = vision.OpticalFlow('ReferenceFrameDelay', 1);
opticalFlow.OutputValue = 'Horizontal and vertical components in complex form';

%Convert the image to single precision, then compute optical flow for the video. Generate coordinate points and draw lines to indicate flow. Display results.
blobAnalysis = vision.BlobAnalysis(...
'CentroidOutputPort', false, 'AreaOutputPort', false, ...
'BoundingBoxOutputPort', true, ...
'MinimumBlobAreaSource', 'Property', 'MinimumBlobArea', 100);

speed_detection_limit = 10;

% t = 0;
while ~isDone(videoReader)
%     t = t+1;
    frame = step(videoReader);
    im = step(converter, frame);
    of = step(opticalFlow, im);
    lines = videooptflowlines(of, 20);
    
    %
    velocity = sqrt(of.*conj(of));
    [row,col] = size(velocity);

    for i = 1:row
        for j = 1:col
            if velocity(i,j) > 0.2
                v(i,j) = velocity(i,j) * 300;
            else
                v(i,j) = 0;

            end
        end
    end
    
    bbox = step(blobAnalysis, boolean(v));
     
     k = 1;
     for j = 1:size(bbox,1)
            x = bbox(j,1);
            y = bbox(j,2);
            width = bbox(j,3);
            height= bbox(j,4);
        
        if width*height > 0
            if (x+ width < col) && (y + height  < row)
                m =  mean(mean(v(y:y+height,x:x+width)));
                if m > speed_detection_limit    %%set threshold for detecting cars
                    display_box(k,:) = bbox(j,:);
                    velocity_mark(k,:) = [x,y,m];
                    k = k + 1;
                end
            end
        end
     end
     
     result = insertShape(frame, 'Rectangle', display_box, 'Color', 'green');
     for p = 1:size(velocity_mark,1)
         if velocity_mark(p,3) > speed_detection_limit
             
             result = insertText (result,[velocity_mark(p,1),velocity_mark(p,2)],velocity_mark(p,3),...
             'BoxOpacity', 1,'FontSize', 10);
         end
     end
     inputFrame =  read(inputObj, t);
         figure(1),subplot(2,1,1),imshow(inputFrame); 
        subplot(2,1,2),imshow(result)
     
     display_box = zeros(k,4);
     velocity_mark = zeros(k,3);
     
%      if t == 20
%         break;
%      end

end
%Close the video reader and player

release(videoReader);