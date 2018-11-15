function rythm = getNoteRythm(smallImg, noteHeadPos, spaceRadi)
% getNoteRythm(spaceRadi, smallImg, noteHeadPos)
%   This function evaluate the rythm of a image on a note. It returns an
%   int. If the note is a quarternote or slower 0 is returned. Else it
%   returns x for note with 1/x tempo. 
%  
%  smallImg = The image this function should operate on
%  noteHeadPos = Posistion of noteheads (center)
%  spaceRadi = the height of spaces/radius of the noteheads
%

beamImg = flagsAndBeamsDetection(smallImg, noteHeadPos, spaceRadi);

if(max(max(beamImg))==0)
   rythm = 0;
   return;
end

%Go throug all the rows on a few places an evaluate the tone
if(max(max(beamImg))==1)
   rythm = 11;
   return;
end


rythm = 0;