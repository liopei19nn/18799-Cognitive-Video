converter = vision.ImageDataTypeConverter; 
shapeInserter = vision.ShapeInserter('Shape','Lines','BorderColor','Custom', 'CustomBorderColor', 255);
opticalFlow = vision.OpticalFlow('ReferenceFrameDelay', 1);
opticalFlow.OutputValue = 'Horizontal and vertical components in complex form';

input_video_gray1 = 'N-52.3-1.avi';
videoReader1 = vision.VideoFileReader(input_video_gray1,'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
input_video_gray2 = 'N-52.3-2.avi';
videoReader2 = vision.VideoFileReader(input_video_gray2,'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
input_video_gray3 = 'S-52.9-1.avi';
videoReader3 = vision.VideoFileReader(input_video_gray3,'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
input_video_gray4 = 'S-52.9-2.avi';
videoReader4 = vision.VideoFileReader(input_video_gray4,'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
input_video_gray5 = 'N-53.4-1.avi';
videoReader5 = vision.VideoFileReader(input_video_gray5,'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
input_video_gray6 = 'N-53.4-2.avi';
videoReader6 = vision.VideoFileReader(input_video_gray6,'ImageColorSpace','Intensity','VideoOutputDataType','uint8');

videoPlayer = vision.VideoPlayer('Name','Motion Vector');

% t = 0; % set the stop time
while ~isDone(videoReader1)
%   t = t+1;   
    frame1 = step(videoReader1);
    frame2 = step(videoReader2);
    frame3 = step(videoReader3);
    frame4 = step(videoReader4);
    frame5 = step(videoReader5);
    frame6 = step(videoReader6);
    
    im1 = step(converter, frame1);
    im2 = step(converter, frame2);
    im3 = step(converter, frame3);
    im4 = step(converter, frame4);
    im5 = step(converter, frame5);
    im6 = step(converter, frame6);
    
    of1 = step(opticalFlow, im1);
    of2 = step(opticalFlow, im2);
    of3 = step(opticalFlow, im3);
    of4 = step(opticalFlow, im4);
    of5 = step(opticalFlow, im5);
    of6 = step(opticalFlow, im6);
    
    lines1 = videooptflowlines(of1, 20);
    lines2 = videooptflowlines(of2, 20);
    lines3 = videooptflowlines(of3, 20);
    lines4 = videooptflowlines(of4, 20);
    lines5 = videooptflowlines(of5, 20);
    lines6 = videooptflowlines(of6, 20);
    
    if ~isempty(lines1)
        out1 =  step(shapeInserter, im1, lines1);
        out2 =  step(shapeInserter, im2, lines2);
        out3 =  step(shapeInserter, im3, lines3);
        out4 =  step(shapeInserter, im4, lines4);
        out5 =  step(shapeInserter, im5, lines5);
        out6 =  step(shapeInserter, im6, lines6);

        figure(1),subplot(3,2,1),imshow(out1); title('N-52.3-1.avi');
        subplot(3,2,2),imshow(out2); title('N-52.3-2.avi');
        subplot(3,2,3),imshow(out3); title('S-52.9-1.avi');
        subplot(3,2,4),imshow(out4); title('S-52.9-2.avi');
        subplot(3,2,5),imshow(out5); title('N-53.4-1.avi');
        subplot(3,2,6),imshow(out6); title('N-53.4-2.avi');
    end
%     if t == 50
%          break;
%     end       
end
%Close the video reader and player

release(videoPlayer);
release(videoReader);


