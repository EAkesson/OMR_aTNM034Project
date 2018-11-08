function binIm = getBinImg(img, inverted) 
%img (the image you want to make bin)
%inverted (if you want the image to be inverted or not. 1 or 0)

threshold = graythresh(img) * 255;
disp(threshold);
if(inverted)
    disp('hi');
    binIm = img < threshold;
else
   disp('by');
   binIm = img > threshold;
end

%binIm = im2bw(img) == 0;
