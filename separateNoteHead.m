function noteHeadImg = separateNoteHead(noteImg, r)
% separateNoteHead(noteImg, r)
% Performs morphologiacal operation 'open', with a disk-shaped structuring-element. 
% Input:
%   note = small image of note
%   r = note head radius
% Output: 
%   Image of note head.

noteImg = getBinImg(noteImg, 1);
% Create a structuring element
se = strel('disk', r);

% Perform opening operation 
noteHeadImg = imopen(noteImg, se);

