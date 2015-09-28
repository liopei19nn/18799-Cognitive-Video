clear all;
clc;
load f_colorpoint.txt %back point cloud with background
load b_colorpoint.txt %front point cloud with background

% buffer for the front points
extracted_f = zeros(1,6);

% buffer for the back points
extracted_b = zeros(1,6);

% extract all the front body points
j = 1;
for i = 1:640*480
    if f_colorpoint(i,3)>12000 && f_colorpoint(i,3)<20000 ...
        && f_colorpoint(i,1) > 50 && f_colorpoint(i,1) < 400 ...
            && f_colorpoint(i,2) > 200 && f_colorpoint(i,2) < 500
        
        extracted_f(j,:) =f_colorpoint(i,:);
        j = j + 1;
    end
end

% extract all the back body points
j = 1;
for i = 1:640*480
    if b_colorpoint(i,3)>12000 && b_colorpoint(i,3)<18000 ...
         && b_colorpoint(i,1) > 0 && b_colorpoint(i,1) < 400
        extracted_b(j,:) =b_colorpoint(i,:);
        j = j + 1;
    end
end

% compress the Z axis
extracted_f(:,3) = extracted_f(:,3)/30;
extracted_b(:,3) = extracted_b(:,3)/30;
% slight move for triangulation
extracted_f(:,2) = extracted_f(:,2) + 0.001;

% get front point cloud
delete colorpoint_f.txt;
save('colorpoint_f.txt','extracted_f','-ASCII','-append');

% get back point cloud
delete colorpoint_b.txt;
save('colorpoint_b.txt','extracted_b','-ASCII','-append');

% 3-point alignment
extracted_b(:,3) = 1000 - extracted_b(:,3) + 35;
extracted_b(:,1) = extracted_b(:,1);
extracted_b(:,2) = extracted_b(:,2);
% get extracted point cloud
extracted = [extracted_f;extracted_b];
delete colorpoint.txt;
save('colorpoint.txt','extracted','-ASCII','-append');

