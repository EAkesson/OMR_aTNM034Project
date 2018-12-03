function [firstLineYPos, lineHeight] = getStafflineProperties(img)


im = rgb2gray(img);
binImg = getBinImg(im, 1);
vertProj = sum(binImg, 1); %vertical proj

plot(1:size(binImg,2), vertProj);

[junk, peaks] = findpeaks(vertProj, 'MinPeakHeight', 0.5*max(vertProj)); %find were the rows start and end. 

%linelength = peaks(length(peaks)) - peaks(1);
%remove barline
%se = strel('line', linelength/1.5, 0);
% Perform opening operation 
%lineimg = imopen(getBinImg(im, 1),se);
%
imshow(img(:, peaks(length(peaks))-10:peaks(length(peaks))));

vertProj = sum(binImg(:, peaks(length(peaks))-10:peaks(length(peaks))), 2); %vertical proj
figure
plot(vertProj,1:size(binImg(:, peaks(length(peaks))-10:peaks(length(peaks))),1))

  %figure
  %imshow(lineimg);

