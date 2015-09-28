clear all;
clc;
% load point
load p.mat
%triangulation
t=delaunay(p(:,1),p(:,2));

figure(1);

trisurf(t,p(:,1),p(:,2),p(:,3),1:size(p,1),'facecolor','none');
axis equal;  
view(200,66);
shading interp;