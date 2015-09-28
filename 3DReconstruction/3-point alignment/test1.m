clc;
clear all;
load point1.txt;
load point2.txt;
plot3(point1(:,1),point1(:,2),point1(:,3),'g.')
hold on;

point2(:,3) = 4000 - point2(:,3);

plot3(point2(:,1),point2(:,2),point2(:,3),'g.')

mid_z = (max(point1(:,3)) + min(point2(:,3)))/2;
z_move_p2 = mid_z - max(point2(:,3));
 