function modImage = findClef(img)
%  removeGClef(img)
%  This function will try to remove the G-clef in the img. It will only remove one G-clef
%   
%   img: The img you want to remove the G-clef from
%
    
% Read template image and convert to binary image 
templateImg = imread('Gklave.jpg');
templateImg = rgb2gray(templateImg);
level = graythresh(templateImg);
templateImg = im2bw(templateImg, level);

% Read image we want to find clef in and convert to binary image
level = graythresh(img);
binImg = im2bw(img, level);

clefPos = template(binImg, templateImg);
modImage = img;
%modImage(clefPos(1):(clefPos(1)+size(templateImg,1)), clefPos(2):(clefPos(2)+size(templateImg,2))) = 1;

%    imshow(img)
%    figure
%    imshow(modImage);
end

    