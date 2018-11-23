function rythm = getNoteRythm(smallImg, noteHeadPos, spaceRadi)
% getNoteRythm(spaceRadi, smallImg, noteHeadPos)
%   This function evaluate the rythm of a image on a note. It returns an
%   int. If the note is a halfnote or slower 0 is returned. Else it
%   returns x for note with 1/x tempo. 
%  
%  smallImg = The image this function should operate on
%  noteHeadPos = Posistion of noteheads (center)
%  spaceRadi = the height of spaces/radius of the noteheads
%

%If the notehead has a hole inside of it (whole or halfnote)
if(smallImg(round(noteHeadPos(2)), round(noteHeadPos(1))) == 255) 
   rythm = '0';
   return;
end
    
beamImg = flagsAndBeamsDetection(smallImg, noteHeadPos, spaceRadi);

if(max(max(beamImg))==0)
   rythm = '4';
   return;
end

%Go throug all the rows on a few places an evaluate the tone
leftColumn = beamImg(:, round(noteHeadPos(1) - spaceRadi*1.5));
rightColumn = beamImg(:, round(noteHeadPos(1) + spaceRadi*1.5));
left = numel(findpeaks(double(255 * leftColumn)));
right = numel(findpeaks(double(255 * rightColumn)));

numOfBeams = max([left,right]);
if(numOfBeams==1)
   rythm = '8';
   return;
end

rythm = '0'; %Higher speed than 8