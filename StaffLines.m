function outImg = StaffLines(Im)
%% By using morphological operations the staff lines are deleted.
%level = graythresh(rgb2gray(Im));
%BW = im2bw(rgb2gray(Im),level);
%BW = imcomplement(BW);

Img = rgb2gray(Im)
BW = edge(getBinImg(Img, 1), 'canny');
imshow(BW)
figure

[H, T, R] = hough(BW);
P = houghpeaks(H, 100, 'threshold', ceil(0.3*max(H(:))));
lines = houghlines(BW, T, R, P, 'FillGap', 5, 'Minlength', 7);
max_len = 0;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

end

notes = imopen(BW, strel('disk',2));
lines = imopen(BW, ones(3,1));

%imshow(notes)
figure
%imshow(lines)

outImg = 1
end