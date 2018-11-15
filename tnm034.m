%%%%%%%%%%%%%%%%%%%%%%%%%%
function strout = tnm034(Im)
%
% Im: Input image of captured sheet music. Im should be in
% double format, normalized to the interval [0,1]
%
% strout: The resulting character string of the detected notes.
% The string must follow the pre-defined format, explained below.
%
strout = '';
% Your program code…
Im = rgb2gray(Im);
rowProcessing(Im);

strout =  'Something that is returned from a function';
%%%%%%%%%%%%%%%%%%%%%%%%%%