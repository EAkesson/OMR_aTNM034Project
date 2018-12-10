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
Im = HoughRotate(Im);

imageRowArray = splitImageIntoRows(Im);
%loop through all rowimages
%rowIndex = 1; 
for rowIndex=1:length(imageRowArray)    
    %findStafflineprop

    [firstLineYPos, lineHeight] = getStafflineProperties(imageRowArray{rowIndex}); 
    %disp(lineHeight)
    %remove stafflines    
    imageRowArray{rowIndex} = removeStaffLines(imageRowArray{rowIndex}, lineHeight/2);
    
    %get note string from row
    rowProcessing(imageRowArray{rowIndex}, firstLineYPos, lineHeight);
    
    
    %add rowchnge n
end
%celebrate
strout =  'Something that is returned from a function';
%%%%%%%%%%%%%%%%%%%%%%%%%%