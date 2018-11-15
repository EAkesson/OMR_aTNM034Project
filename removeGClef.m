function modImage = removeGClef(img)
%  removeGClef(img)
%  This function will try to remove the G-clef in the img. It will only remove one G-clef
%   
%   img: The img you want to remove the G-clef from
%

    templateImg = imread('Images_Training/Gklave.jpg');
    templateImg = rgb2gray(templateImg);
    templateImg = getBinImg(templateImg, 1);
    
    binImg = getBinImg(img, 1);
    
    clefPos = template(binImg, templateImg);

    modImage = img;
    modImage(clefPos(1):(clefPos(1)+size(templateImg,1)), clefPos(2):(clefPos(2)+size(templateImg,2))) = 255;
    
%    imshow(img)
%    figure
%    imshow(modImage);
    
    