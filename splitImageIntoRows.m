function imgArray = splitImageIntoRows(im)



img = rgb2gray(im);
binImgMin = getBinImg(img, 0); %Fix a image bw to find rows
binImgMax = getBinImg(img, 1); %Fix a image to find max thresholdvalues

horzProjMin = sum(binImgMin, 2); %horiontal proj
horzProjMax = sum(binImgMax, 2); %horiontal proj

maxValue = max(horzProjMax); %Find maxvalue of image for a whole row
smoothhorzProjMin = movmean(horzProjMin, 50); %Smooth the graph to easier find rows
[junk, posToCut] = findpeaks(smoothhorzProjMin, 'MinPeakWidth', 10); %find were the rows start and end. 



posToCut(length(posToCut)+1, 1) = length(smoothhorzProjMin); %insert end value at the end
disp(size(posToCut))
posToCut = [1; posToCut]; %insert start value at the start

imgArray{1} = 1;

z = 1; %cnt to store imagerows
%go through all cuttingpoints and save image
for i=1:length(posToCut)-1
    %disp(max(horzProjMax(posToCut(i):posToCut(i+1))));
    if(maxValue*0.6 < max(horzProjMax(posToCut(i):posToCut(i+1)))) %Only save image if it has a value of 60% of maximumvalue (for a row)       
        imgArray{z} = im(posToCut(i):posToCut(i+1),:, :); %Store imagerow i the imgarray
        z=z+1;        
    else        
        %figure
        %imshow(horzProjMax(posToCut(i):posToCut(i+1),:, :))
    end       
end 

%figure
%plot(horzProjMin,1:size(binImgMin,1))
