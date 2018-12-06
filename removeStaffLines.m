function outImg = removeStaffLines(Im, noteHeadRadius)
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

linesBW = imopen(BW, ones(round(noteHeadRadius),1));
circular = imclose(linesBW, ones(1,4));


%figure('name', 'lines')
%imshow(linesBW)
%figure('name', 'heads')
%imshow(circular)

%finished = linesBW;
%disp('hi')
%temppish = graythresh(imgaussfilt(imsharpen(finished)));
%disp(temppish)
%finished(finished < 0.1) = 0;

Tfinished = [~linesBW, ~linesBW, ~linesBW];
iis = Im;
iis(Tfinished) = 1;
%figure('name', 'sup')
%imshow(iis);
%figure('name', 'supclose')
%imshow(imcomplement(imclose(imcomplement(iis), strel('disk', round(1)))));

Tfinished = [~circular, ~circular, ~circular];
iss = Im;
iss(Tfinished) = 1;
%figure('name', 'yyu')
imshow(iss);
%figure('name', 'yyuclose')
%imshow(imcomplement(imclose(imcomplement(iss), strel('disk', round(noteHeadRadius-1)))));

outImg = iss;

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