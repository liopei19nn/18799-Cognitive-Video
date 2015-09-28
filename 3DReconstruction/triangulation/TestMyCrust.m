clc 
clear
close all

%Instructions :

%just uncomment one of the following line and run


%% Points cloud :
clear all
load p.mat
% load Skull.mat 
% load Standford_Bunny.mat
% load Horse.mat
% load hippo.mat 
% load Elephant.mat
% load chair.mat
% load Dino.mat
% load Block.mat
% load gargo50k.mat

%% plot of the current point cloud
figure(1);
hold on
axis equal
title('Points Cloud','fontsize',14)
plot3(p(:,1),p(:,2),p(:,3),'g.')
view(0,800)
% 
%% Run  program
[t]=MyCrust(p);

%% plot of the oyput triangulation
figure(2)
        hold on
        colormap('default');
        
        %title('Output Triangulation','fontsize',14)
        axis equal
        trisurf(t,p(:,1),p(:,2),p(:,3),1:size(p,1),'edgecolor','none')%plot della superficie trattata
        view(200,66)
        shading interp
