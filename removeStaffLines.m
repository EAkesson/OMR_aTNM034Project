function outImg = removeStaffLines(Im, noteHeadRadius)
%   removeStaffLines(Im, noteHeadRadius)
%   This function removes the stafflines. This is done with morphology
%
%   Im = The image stafflines should be removed on
%   noteHeadRadius = The radious of the notehead
%
%   outImg = teh result image without stafflines
%

%level = graythresh(rgb2gray(Im));
%BW = im2bw(rgb2gray(Im),level);
%BW = imcomplement(BW);

Img = rgb2gray(Im);
BW = getBinImg(Img, 1);

%notes = imopen(imcomplement(Img), strel('disk',2));
%lines = imopen(imcomplement(Img), ones(3,1));

linesBW = imopen(BW, ones(round(noteHeadRadius),1)); %Remove the Stafflines and other lines that is horisontal
circular = imclose(linesBW, ones(1,4)); %Fill the gaps from the removed lines
%After these two operations, everything except stafflines should be left

%figure('name', 'lines')
%imshow(linesBW)
%figure('name', 'heads')
%imshow(circular)

%finished = linesBW;
%disp('hi')
%temppish = graythresh(imgaussfilt(imsharpen(finished)));
%disp(temppish)
%finished(finished < 0.1) = 0;

%ThingsToRemove = [~linesBW, ~linesBW, ~linesBW];
%iis = Im;
%iis(ThingsToRemove) = 1;
%figure('name', 'sup')
%imshow(iis);
%figure('name', 'supclose')
%imshow(imcomplement(imclose(imcomplement(iis), strel('disk', round(1)))));

%Make an image oposite of what we got image so we can remove the stafflines from orginal image
ThingsToRemove = [~circular, ~circular, ~circular]; 
imageWithoutStafflines = Im; 
imageWithoutStafflines(ThingsToRemove) = 1;

%figure('name', 'yyu')
%imshow(iss);
%figure('name', 'yyuclose')
%imshow(imcomplement(imclose(imcomplement(iss), strel('disk', round(noteHeadRadius-1)))));

outImg = imageWithoutStafflines;
end