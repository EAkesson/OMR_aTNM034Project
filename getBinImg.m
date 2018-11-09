function binIm = getBinImg(img, inverted) 
%img (the image you want to make bin)
%inverted (if you want the image to be inverted or not. 1 or 0)

threshold = graythresh(img) * 255;
if(inverted)
    binIm = img < threshold;
else
   binIm = img > threshold;
end
