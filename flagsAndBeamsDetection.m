function flagAndBeamImg = flagsAndBeamsDetection(smallImg, noteHeadPos, spaceRadi)
% flagsAndBeamsDetection(spaceRadi, smallImg, noteHeadPos)
%   This function tries to remove everything except flags and beams. It
%   returns an Logical/binary image with only beams and flags. The
%   beams/flag has value 1 and rest is value 0.
%  
%  smallImg = The image this function should operate on
%  noteHeadPos = Posistion of noteheads (center)
%  spaceRadi = the height of spaces/radius of the noteheads
%

% Using edge deteciton gave a poor result on our perfect test image 
  %Psmallimg = edge(smallimg,'Prewitt', 'horizontal');
  %imshow(Psmallimg)
  %Ssmallimg = edge(smallimg,'Sobel', 'horizontal');
  %figure
  %imshow(Ssmallimg)
  
  noteHeadPos(2) = round(noteHeadPos(2)); %To get rid of warning about intvalues
  %Remove head
  smallImg(noteHeadPos(2)-spaceRadi*2:noteHeadPos(2)+spaceRadi*2, 1:size(smallImg,2)) = 255;
  
  %remove barline
  se = strel('line', spaceRadi, 0);
  % Perform opening operation 
  flagAndBeamImg = imopen(getBinImg(smallImg, 1),se);
  
  figure
  imshow(flagAndBeamImg);