function binIm = getBinImg(img, inverted) 
% getBinImg(img, inverted) 
% This function take an rgbimage and convert it to grayscale binaryimage
%
%   img (the image you want to make bin)
%   inverted (if you want the image to be inverted or not. 1 or 0)

%Even the contrast of image
I = imgaussfilt(img,3); 

%Find threshold value
threshold = graythresh(I) * 1;

%Use thresholdvalue as a comparesent in image
if(inverted)
    binIm = img < threshold;
else
    binIm = img > threshold;
end


