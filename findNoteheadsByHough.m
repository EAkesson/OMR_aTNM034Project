function [centers, radius] = findNoteheadsByHough(img, r, threshold)
% [centers, radii] = findNoteheadsByHough(img, r, threshold)
% This function finds the noteheads (and other circular objects and returns
% thier coords in img. And sort them so they goes from left to right
% 
%   img = the image we want to find noteheads in
%   r = the radious the noteheads can be. Can be one value or and array [min, max]
%   threshold = threshold of meticulous the edgedetection should be. Recomended 0.7
%   centers = the centercoords of noteheads. If the function finds several all are returned as an array
%   radius = the corresponding radius to the centers
%

% Separate note head from rest of object
binImg = separateNoteHead(img, r(1)+1);

%binImg = getBinImg(img, 1);
%imshow(binImg)
[centers,rad, metric] = imfindcircles(binImg, r, 'ObjectPolarity','bright', 'Method','TwoStage', 'EdgeThreshold', threshold);
[centers, i] = sortrows(centers, 1);
%disp(rad)
%disp(i)
radius(:) = rad(i);