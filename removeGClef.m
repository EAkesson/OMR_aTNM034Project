function modImage = removeGClef(img)
%  removeGClef(img)
%  This function will try to remove the G-clef in the img. It will only
%  remove one G-clef. The one that is closest to out template
%   
%   img: The img you want to remove the G-clef from
%

    % Load and fix template image
    templateImg = imread('Images_Training/Gklave.jpg');
    templateImg = im2double(templateImg);
    templateImg = rgb2gray(templateImg);
    templateImg = getBinImg(templateImg, 1);

    binImg = getBinImg(img, 1);
    
    %Find the Gclef position with our template function
    clefPos = template(binImg, templateImg);

    %Remove GClef
    modImage = img;
    modImage(clefPos(1):(clefPos(1)+size(templateImg,1)), clefPos(2):(clefPos(2)+size(templateImg,2))) = 1;
    
%    imshow(img)
%    figure
%    imshow(modImage);
    
    