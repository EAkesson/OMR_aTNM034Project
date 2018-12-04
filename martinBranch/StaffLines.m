function [notes, lines] = StaffLines(Im)
%% By using morphological operations the staff lines are deleted.
level = graythresh(rgb2gray(Im));
BW = im2bw(rgb2gray(Im),level);
BW = imcomplement(BW);

notes = imopen(BW, strel('disk',2));

lines = imopen(BW, ones(4,1));

end