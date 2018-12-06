function noteHeadImg = separateNoteHead(noteImg, r)
% separateNoteHead(noteImg, r)
% Performs morphologiacal operation 'open', with a disk-shaped structuring-element. 
% Input:
%   note = small image of note
%   r = note head radius
% Output: 
%   Image of note head. (Binary and inverted)

binNoteImg = getBinImg(noteImg, 1);

% Create a structuring element
%se = strel('disk', r);

% Perform opening operation 
%noteHeadImg = imopen(noteImg, se);
figure('name', 'this')
imshow(binNoteImg)

figure('name', 'hiy')
lines = imclose(binNoteImg, ones(round(r*2), 5));
imshow(lines)
figure
lines = imopen(lines, ones(round(r*5), 5));
imshow(lines)
binNoteImg(lines) = 0;
figure('name', 'hsdfdsfiy')
imshow(binNoteImg)
noteHeadImg =  binNoteImg;

