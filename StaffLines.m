function outImg = StaffLines(Im)
%% By using morphological operations the staff lines are deleted.
%level = graythresh(rgb2gray(Im));
%BW = im2bw(rgb2gray(Im),level);
%BW = imcomplement(BW);

Img = rgb2gray(Im);
BW = getBinImg(Img, 1);
%BW = edge(getBinImg(Img, 1), 'canny');
%imshow(BW)


notes = imopen(imcomplement(Img), strel('disk',2));
lines = imopen(imcomplement(Img), ones(3,1));
linesBW = imopen(BW, ones(3,1));

%figure
%imshow(linesBW)
%figure
%imshow(lines)

finished = lines;
finished(finished < 0.3) = 0;

%figure
%imshow(finished);
%figure
%imshow(finished > 0.1);

Tfinished = [finished, finished, finished];
Im(Tfinished < 0.1) = 1;

%figure
%imshow(Im);

outImg = Im;

%outImg = 1;

%%
%[H, T, R] = hough(BW);
%P = houghpeaks(H, 100, 'threshold', ceil(0.3*max(H(:))));
%lines = houghlines(BW, T, R, P, 'FillGap', 5, 'Minlength', 7);
%max_len = 0;

%for k = 1:length(lines)
%   xy = [lines(k).point1; lines(k).point2];
%   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   %plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

%end


end