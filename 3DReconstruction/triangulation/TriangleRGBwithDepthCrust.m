%get triangulation plot with RGB
clc
clear all
% triangulation for the back of body, de-comment it
% load colorpoint_b.txt;
% myfile = colorpoint_b;
% triangulation for the front of body, de-comment it
% load colorpoint_f.txt;
% myfile = colorpoint_f;
% triangulation for front and back of body
load colorpoint.txt
myfile = colorpoint;


%GET RGB Color and then ColorMap
RGB_X = myfile(:,4);
RGB_Y = myfile(:,5);
RGB_Z = myfile(:,6);
RGB_X=RGB_X(:);
RGB_Y=RGB_Y(:);
RGB_Z=RGB_Z(:);
M=uint8([RGB_X RGB_Y RGB_Z]);
C=double(M)/255;
colormap(C);

%Delaunay
p = myfile(:,1:3);
%t=delaunay(p(:,1),p(:,2));
t = MyRobustCrust(p);

% plot the triangulation
trisurf(t,p(:,1),p(:,2),p(:,3),1:size(p,1),'edgecolor','none')
%trisurf(t,p(:,1),p(:,2),p(:,3),1:size(p,1),'facecolor','none')
axis equal;
shading interp;



