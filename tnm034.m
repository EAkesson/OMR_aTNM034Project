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

% Your program code…
Im = imsharpen(Im, 'Radius', 1.5, 'Amount', 1.1);
figure
imshow(Im)
Im = HoughRotate(Im);
imageRowArray = splitImageIntoRows(Im);

%loop through all rowimages
    rowIndex = 1; 
    %findStafflineprop
    [firstLineYPos, lineHeight] = getStafflineProperties(imageRowArray{rowIndex}); 
    
    %remove stafflines
    imageRowArray{rowIndex} = removeStaffLines(imageRowArray{rowIndex}, lineHeight/2);
    
    %get note string from row
    rowProcessing(imageRowArray{rowIndex}, firstLineYPos, lineHeight);
    
%end
%celebrate
strout =  'Something that is returned from a function';
%%%%%%%%%%%%%%%%%%%%%%%%%%