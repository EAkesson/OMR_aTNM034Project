function [stafflinesYpos, lineHeight] = getStafflineProperties(img)
%   getStafflineProperties(img)
%   This function takes an img and return the stafflineposistions and the
%   lineheight
%
%   img = the image to be evaluated
%   
%   stafflinesYpos = an array with stafflines y pos (stafflinesYpos(5) = lowest line)
%   lineHeight = an approximation of the lineheight

%The area to cut out and use for evaluation
sizeOfImgRange = 20; %pixels
im = rgb2gray(img);
binImg = getBinImg(im, 1);

vertProj = sum(binImg, 1); %vertical proj
%plot(1:size(binImg,2), vertProj);
[junk, peaks] = findpeaks(vertProj, 'MinPeakHeight', 0.5*max(vertProj)); %find were the rows start and end. 

imgRange = peaks(length(peaks))-sizeOfImgRange : peaks(length(peaks));
%imshow(binImg(:, imgRange));

horzProj = sum(binImg(:, imgRange), 2); %horisontal proj
%disp(max(horzProj));
[junk, peaks] = findpeaks(horzProj, 'MinPeakHeight', 0.8*max(horzProj)); %find where stafflines is


%figure
%plot(horzProj,1:size(binImg(:, peaks(length(peaks))-10:peaks(length(peaks))),1))

%firstLineYPos = peaks(length(peaks)); % lowest staffline
stafflinesYpos =  peaks( length(peaks)-4 : length(peaks) ); % all staffline positions (stafflinesYpos(5) = lowest)
lineHeight = (stafflinesYpos(5) - stafflinesYpos(1)) * 0.25; %average height for each space
