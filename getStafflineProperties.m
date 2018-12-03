function [firstLineYPos, lineHeight] = getStafflineProperties(img)


im = rgb2gray(img);
binImg = getBinImg(im, 1);
vertProj = sum(binImg, 1); %vertical proj

[junk, peaks] = findpeaks(vertProj, 'MinPeakHeight', 0.5*max(vertProj)); %find were the rows start and end. 

linelength = peaks(length(peaks)) - peaks(1);

  %remove barline
  se = strel('line', linelength/1.5, 0);
  % Perform opening operation 
  lineimg = imopen(getBinImg(im, 1),se);
  imshow(img);
  figure
  imshow(lineimg);
%plot(1:size(binImg,2), vertProj);
