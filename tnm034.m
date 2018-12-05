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
    [firstLineYPos, lineHeight] = getStafflineProperties(imageRowArray{1}); %findStafflineprop
    
    %remove stafflines
    imageRowArray{1} = StaffLines(imageRowArray{1})
    
    rowProcessing(imageRowArray{1}, firstLineYPos, lineHeight);
    
%end
%celebrate
strout =  'Something that is returned from a function';
%%%%%%%%%%%%%%%%%%%%%%%%%%