function findNoteHeadCenter(smallImg, r)

% Separate note head from rest of object
noteHeadImg = separateNoteHead(smallImg, r);

% Find centroid of note head
s = regionprops(noteHeadImg,'centroid');
centroids = cat(1, s.Centroid);

% Test
figure
imshow(noteHeadImg,[]);
viscircles([centroids(1,1), centroids(1,2)], 1, 'EdgeColor', 'b')
disp(centroids);