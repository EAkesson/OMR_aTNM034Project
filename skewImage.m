function skewOperation = skewImage(doubleImage)
%
level = graythresh(doubleImage);
BW = im2bw(doubleImage, level);
%imshow(BW);

%close all

% Generate the coordinates of the grid points
[sr, sc] = size(BW);
[C, R] = meshgrid((1:sc), (1:sr));

% Pick four points that define the movingPoints for the distorted image
imshow(BW);
movingPoints = ginput(4);

% From the movingPoints, decide fixed points and put into an array
fp1 = [min(movingPoints(1,1), movingPoints(2,1)), min(movingPoints(1,2),movingPoints(3,2))];
fp2 = [min(movingPoints(1,1), movingPoints(2,1)), max(movingPoints(2,2),movingPoints(4,2))];
fp3 = [max(movingPoints(3,1), movingPoints(4,1)), min(movingPoints(1,2),movingPoints(3,2))];
fp4 = [max(movingPoints(3,1), movingPoints(4,1)), max(movingPoints(2,2),movingPoints(4,2))];
fixedPoints = [fp1 ; fp2 ; fp3 ; fp4];

skewOperation = fitgeotrans(movingPoints, fixedPoints, 'projective');

%fixedIm = imwarp(Im, tform);
%imshowpair(BW, fixedIm, 'montage');


end