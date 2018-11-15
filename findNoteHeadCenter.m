function centroids = findNoteHeadCenter(smallImg, r)
% findNoteHeadCenter(smallImg, r)
% This function finds center of circular objects in provided img. If there
% is several circular objects it will return an array circular objects
% 
%   smallImg = The image this function should search in
%   r = radius of circular object that we want to find
%   centroids = The center of the find circle. If several circular objects
%   are finded this will be an array. 

% Separate note head from rest of object
noteHeadImg = separateNoteHead(smallImg, r);

% Find centroid of note head
s = regionprops(noteHeadImg,'centroid');
centroids = cat(1, s.Centroid);

% Test
%figure
%imshow(noteHeadImg,[]);
%viscircles([centroids(1,1), centroids(1,2)], 1, 'EdgeColor', 'b')
%disp(centroids);
