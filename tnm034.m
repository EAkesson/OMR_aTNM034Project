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
imageRowArray = splitImageIntoRows(Im);

%loop through all rowimages
getStafflineProperties(imageRowArray{1});
    %findStafflineprop
    %remove stafflines
    %rowProcessing(Im);
%end
%celebrate
strout =  'Something that is returned from a function';
%%%%%%%%%%%%%%%%%%%%%%%%%%