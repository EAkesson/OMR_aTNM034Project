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

%remove thin bars etc
scale = 10;
img = imresize(img, scale);
binImg = separateNoteHead(img, scale*r(1));


figure ('name', 'before close')
imshow(binImg)

img = imresize(img, 1/scale);
binImg = imresize(binImg, 1/scale);

%find objects smaller than noteheads
cc = bwconncomp(binImg); 
stats = regionprops(cc, 'Area');
%find objects with smaller area than smallest notehead
notTooSmall = find([stats.Area] > pi*(r(1))*(r(1)));
%all objects larger than TOO SMALL
BW2 = ismember(labelmatrix(cc), notTooSmall); 


binImg = (imclose(binImg, strel('disk', round(r(1))))); 
figure('name', 'closed')
imshow(binImg)

%find objects smaller & larger than noteheads
cc = bwconncomp(binImg); 
stats = regionprops(cc, 'Area'); 

%find objects with smaller area than largest notehead
notTooLarge = find([stats.Area] < pi*(r(2)+0.5)*(r(2)+0.5)); 


%all objects smaller than TOO LARGE
BW3 = ismember(labelmatrix(cc), notTooLarge); 

intersectedImage=bitand(BW2,BW3);

figure
subplot(4,1,1), imshow(binImg), title('after separateNotehead')
subplot(4,1,2), imshow(BW2), title('large objects')
subplot(4,1,3), imshow(BW3), title('small objects')

binImg = bwareafilt(binImg, [pi*((r(1)+0.5))^2 pi*((r(2)+0.5))^2]);

figure
subplot(3,1,1), imshow(intersectedImage), title('after regionprop filter')
subplot(3,1,2), imshow(binImg), title('after bwareafilt')
subplot(3,1,3), imshow(img)




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
