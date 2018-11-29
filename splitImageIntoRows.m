function imgArray = splitImageIntoRows(im)

img = rgb2gray(im);
binImgMin = getBinImg(img, 0);
binImgMax = getBinImg(img, 1);

horzProjMin = sum(binImgMin, 2);
horzProjMax = sum(binImgMax, 2);

maxValue = max(horzProjMax);
a = movmean(horzProjMin, 50);
[junk, posToCut] = findpeaks(a, 'MinPeakWidth', 10);
posToCut(length(posToCut)+1) = length(a);
posToCut = [1; posToCut];
%[value, place] = min(horzProj);
%place = islocalmin(horzProj)
disp(maxValue)
z = 1;
for i=1:length(posToCut)-1
    disp(max(horzProjMax(posToCut(i):posToCut(i+1))));
    if(maxValue*0.6 < max(horzProjMax(posToCut(i):posToCut(i+1))))
        figure
        imgArray{z} = im(posToCut(i):posToCut(i+1),:, :);
        z=z+1;
%imshow(im(posToCut(i):posToCut(i+1),:, :))
    else
        figure
        imshow(horzProjMax(posToCut(i):posToCut(i+1),:, :))
    end   
    %imgArr(i) = im( posToCut(i):posToCut(i+1),:, :); 
end
    imshow(imgArray{3})
    %nybild = bild(i i+i)
figure
%imshow(a)
plot(horzProjMax,1:size(binImgMax, 1));
%imgArray = binImg;