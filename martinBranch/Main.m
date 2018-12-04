% ----- MAIN SCRIPT ----- %
clear
close all
clc

% Read image from computer
Im = imread('im8c.jpg');

% ----- PRE PROCESSING ----- %

% Apply uniform lighting to image
light = uniLight(Im);


% Skew the image to fix perspective
skew = skewImage(light); 

clef = findClef(light);

fixedIm = imwarp(Im, skew);

% Rotate the image to get straight staff lines
fixedIm = HoughRotate(fixedIm);




% Detect and delete staff lines
[notes,lines] = StaffLines(fixedIm);


new = notes + lines;
figure
imshow(new);



figure
imshow(fixedIm);

