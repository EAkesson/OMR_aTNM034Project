function [firstLineYPos, lineHeight] = getStafflineProperties(img)

sizeOfImgRange = 20; %pixels
im = rgb2gray(img);
binImg = getBinImg(im, 1);
vertProj = sum(binImg, 1); %vertical proj
%plot(1:size(binImg,2), vertProj);

[junk, peaks] = findpeaks(vertProj, 'MinPeakHeight', 0.5*max(vertProj)); %find were the rows start and end. 

%linelength = peaks(length(peaks)) - peaks(1);
%remove barline
%se = strel('line', linelength/1.5, 0);
% Perform opening operation 
%lineimg = imopen(getBinImg(im, 1),se);
%
%morpholoogy do this
imgRange = peaks(length(peaks))-sizeOfImgRange : peaks(length(peaks));
imshow(binImg(:, imgRange));

horzProj = sum(binImg(:, imgRange), 2); %horisontal proj
%disp(max(horzProj));
[junk, peaks] = findpeaks(horzProj, 'MinPeakHeight', 0.8*max(horzProj)); %

%figure
%plot(horzProj,1:size(binImg(:, peaks(length(peaks))-10:peaks(length(peaks))),1))
figure

firstLineYPos = peaks(length(peaks)-4);
lineHeight = (peaks(length(peaks)) - firstLineYPos) * 0.25;





%%
%img(peaks(1)-1:peaks(1)+1, :) = 1;
%img(peaks(2)-1:peaks(2)+1, :) = 1;
%img(peaks(3)-1:peaks(3)+1, :) = 1;
%img(peaks(4)-1:peaks(4)+1, :) = 1;
%img(peaks(5)-1:peaks(5)+1, :) = 1;

%imshow(img)
%figure
%imshow(imdilate(getBinImg(rgb2gray(img), 1), strel('sphere',1)))
%imshow(imclose(getBinImg(rgb2gray(img), 1), strel('sphere',3)))

%figure
%imshow(lineimg);

