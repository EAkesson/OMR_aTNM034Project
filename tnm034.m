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
Im = HoughRotate(Im);

imageRowArray = splitImageIntoRows(Im);

%loop through all rowimages
    
    %findStafflineprop
    [firstLineYPos, lineHeight] = getStafflineProperties(imageRowArray{1}); 
    
    %remove stafflines
    imageRowArray{1} = StaffLines(imageRowArray{1})
    
    %get note string from row
    rowProcessing(imageRowArray{1}, firstLineYPos, lineHeight);
    
%end
%celebrate
strout =  'Something that is returned from a function';
%%%%%%%%%%%%%%%%%%%%%%%%%%