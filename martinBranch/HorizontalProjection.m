clear
close all

Im = imread('im1s.jpg');
I = rgb2gray(Im);
I = imrotate(I, 0.47);
BW = imbinarize(I);
S = sum(BW,2);


[pks, locs] = findpeaks(S);
I(locs,:) = 255;

figure
plot(pks, locs);

figure
imshow(I);