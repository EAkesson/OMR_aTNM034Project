%%%%%%%%%%%%%%%%%%%%%%%%%%
function strout = tnm034(Im)
%
% Im: Input image of captured sheet music. Im should be in
% double format, normalized to the interval [0,1]
%
% strout: The resulting character string of the detected notes.
% The string must follow the pre-defined format, explained below.
%
Im = im2double(Im);
strout = '';

% Sharpen the image a bit
Im = imsharpen(Im, 'Radius', 1.5, 'Amount', 1.1);
%Strighten up the image
Im = HoughRotate(Im);

%split the image to several images with one row in each
imageRowArray = splitImageIntoRows(Im);

%loop through all rowimages
for rowIndex=1:length(imageRowArray)    
    %findStafflineprop
    [staffLinesYPos, lineHeight] = getStafflineProperties(imageRowArray{rowIndex}); 
        
    %remove stafflines    
    imageRowArray{rowIndex} = removeStaffLines(imageRowArray{rowIndex}, lineHeight/2);
    
    %get note string from one row
    strout = strcat(strout, rowProcessing(imageRowArray{rowIndex}, staffLinesYPos, lineHeight));
    
    %add rowchange 'n' (not one last image change)
    if(rowIndex ~= length(imageRowArray))
        strout = strcat(strout, 'n');
    end
end
%disp(strout);
%celebrate

%%%%%%%%%%%%%%%%%%%%%%%%%%