function [centers, radius] = findNoteheadsByHough(img, r, threshold, sortHorizontal)
% [centers, radii] = findNoteheadsByHough(img, r, threshold)
% This function finds the noteheads (and other circular objects and returns
% thier coords in img. And sort them so they goes from left to right
% 
%   img = the image we want to find noteheads in
%   r = the radious the noteheads can be. Can be one value or and array [min, max]
%   threshold = threshold of meticulous the edgedetection should be. Recomended 0.7
%   sortHorizontal = if the centers shpuld be sorted horisontaly or
%   verticaly
%
%   centers = the centercoords of noteheads. If the function finds several all are returned as an array
%   radius = the corresponding radius to the centers
%

% Separate note head from rest of object
figure
imshow(img)
r = round(r);
disp(r)
binImg = separateNoteHead(img, r(1));


%binImg = binImg - imopen(binImg, ones(r(2)*2,1));
%binImg = getBinImg(binImg, 0);

figure
imshow(binImg)
binImg = bwareafilt(binImg, [pi*(r(1))^2 pi*(r(2)+1)^2]);
figure
imshow(binImg)

%Find centers
[centers, rad, metric] = imfindcircles(binImg, r, 'ObjectPolarity','bright', 'Method', 'TwoStage', 'EdgeThreshold', threshold);
%[centers, rad, metric] = imfindcircles(binImg, r, 'ObjectPolarity','bright', 'EdgeThreshold', threshold);

if(length(centers) == 0)
    radius = rad;
    return
end
%sort centers
if(sortHorizontal == 1)
    [centers, i] = sortrows(centers, 1);    
else
    [centers, i] = sortrows(centers, 2);    
end
radius(:) = rad(i);
