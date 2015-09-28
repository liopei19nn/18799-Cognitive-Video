clear all
clc


load('point1.txt');    
load('point2.txt');
b1=point1;
b2=point2;



save('b1.mat')
save('b2.mat')

figure(3);
hold on
axis equal
title('Points Cloud','fontsize',14)
plot3(b1(:,1),b1(:,2),b1(:,3),'g.')      

figure(4);
hold on
axis equal
title('Points Cloud','fontsize',14)
plot3(b2(:,1),b2(:,2),b2(:,3),'g.')


% adjust this matrix for setup the right position
% of kinect
Q1=[2670    1736 - 50   2910];
Q2=[2654    2305 - 50   2889];
Q3=[1786    1954 - 50   2944];
P1=[2706 - 50    2375    2829 - 70 ];
P2=[2700 - 50   1790    2792 - 70 ];
P3=[1781 - 50   2052    2875 - 70];				       

V1=P2-P1;
V11=P3-P1;

W1=Q2-Q1;
W11=Q3-Q1;

V3=cross(V1,V11);
W3=cross(W1,W11);

V2=cross(V3,V1);
W2=cross(W3,W1);

v1=V1/norm(V1);
v2=V2/norm(V2);
v3=V3/norm(V3);

w1=W1/norm(W1);
w2=W2/norm(W2);
w3=W3/norm(W3);

v=[v1 
   v2 
   v3];

w=[w1
    w2
    w3];

R=inv(v)*w;          
S=Q1-P1*R;           

load('point1.txt');
[m,n]=size(point1);

T=repmat(S,m,1);          

P=point1*R+T;         

save('P.mat')

p=[P;point2];         

save('p.mat')        

figure(5);
hold on
axis equal
title('Points Cloud','fontsize',14);
plot3(p(:,1),p(:,2),p(:,3),'g.')      

