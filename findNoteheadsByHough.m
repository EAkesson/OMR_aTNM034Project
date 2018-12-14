function [centers, radius] = findNoteheadsByHough(img, r, threshold, sortHorizontal)
% [centers, radius] = findNoteheadsByHough(img, r, threshold)
% This function finds the noteheads (and other circular objects and returns
% thier coords in img. And sort them so they goes from left to right
% 
%   img = the image we want to find noteheads in
%   r = the radious the noteheads can be. Can be one value or and array [min, max]
%   threshold = threshold of meticulous the edgedetection should be. Recomended 0.7
%   sortHorizontal = if the centers shpuld be sorted horisontaly or verticaly
%
%   centers = the centercoords of noteheads. If the function finds several all are returned as an array
%   radius = the corresponding radius to the centers
%


%Round r to nearest integer to aviod errors i following functions
r = round(r);


%Scale image to get "bigger" pixels"
scale = 10;
img = imresize(img, scale);
% Separate note head from rest of object
binImg = separateNoteHead(img, scale*r(1));


%figure ('name', 'before close')
%imshow(binImg)

%Scale back image
img = imresize(img, 1/scale);
binImg = imresize(binImg, 1/scale);

%find objects smaller than noteheads
cc = bwconncomp(binImg); 
stats = regionprops(cc, 'Area');
%find objects with smaller area than smallest notehead
notTooSmall = find([stats.Area] > pi*(r(1)-1)*(r(1)));
%all objects larger than TOO SMALL
BW2 = ismember(labelmatrix(cc), notTooSmall); 

%Close the image to get big broken objects to be repared so it can be removed in next part
binImg = (imclose(binImg, strel('disk', round(r(1)+2)))); 
%figure('name', 'closed')
%imshow(binImg)

%find objects smaller & larger than noteheads
cc = bwconncomp(binImg); 
stats = regionprops(cc, 'Area'); 
%find objects with smaller area than largest notehead
notTooLarge = find([stats.Area] < pi*(r(2)+0.5)*(r(2)+0.5)); 
%all objects smaller than TOO LARGE
BW3 = ismember(labelmatrix(cc), notTooLarge); 

%Make an image were the nottosmall and nottolarge objects are
intersectedImage=bitand(BW2,BW3);

%figure
%subplot(4,1,1), imshow(binImg), title('after separateNotehead')
%subplot(4,1,2), imshow(BW2), title('large objects')
%subplot(4,1,3), imshow(BW3), title('small objects')

%Another way of doing the things above. But the things above has been prooven to be better
binImg = bwareafilt(binImg, [pi*((r(1)+0.5))^2 pi*((r(2)+0.5))^2]);

%figure
%subplot(3,1,1), imshow(intersectedImage), title('after regionprop filter')
%subplot(3,1,2), imshow(binImg), title('after bwareafilt')
%subplot(3,1,3), imshow(img)

%Find centers of the noteheads
[centers, rad, metric] = imfindcircles(intersectedImage, r, 'ObjectPolarity','bright', 'Method', 'TwoStage', 'EdgeThreshold', threshold);
%show the centers
%viscircles(centers, rad,'EdgeColor','b');

%[centers, rad, metric] = imfindcircles(binImg, r, 'ObjectPolarity','bright', 'Method', 'TwoStage', 'EdgeThreshold', threshold);
%[centers, rad, metric] = imfindcircles(binImg, r, 'ObjectPolarity','bright', 'EdgeThreshold', threshold);

%If we dosent find ny notes dont crash
if(length(centers) == 0)
    radius = rad;
    return
end

%sort centers (useed for accords)
if(sortHorizontal == 1)
    [centers, i] = sortrows(centers, 1);    
else
    [centers, i] = sortrows(centers, 2);    
end
%Sord radius after how centers were sorted
radius(:) = rad(i);
