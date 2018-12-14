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
%  rythm = a value with 4 or 8 or 0 for the rythm


%If the notehead has a hole inside of it (whole or halfnote)
if(smallImg(round(noteHeadPos(1,2)), round(noteHeadPos(1,1))) == 1) 
   rythm = 0;
   return;
end
    
%Remove everything except beams and flags
beamImg = flagsAndBeamsDetection(smallImg, noteHeadPos, spaceRadi);

%figure
%subplot(3,1,1), imshow(beamImg), title('beamimg')
%subplot(3,1,2), imshow(smallImg), title('smallimg')

%If no flag or beam
if(max(max(beamImg))==0)
   rythm = 4;
   return;
end

%Try to heal broken beams
beamImg = imclose(beamImg, ones(2, 1));
beamImg = imopen(beamImg, ones(4, 1));
%subplot(3,1,3), imshow(beamImg), title('beamimgafter')

%Go throug all the rows on a few places an evaluate the tone
leftColumn = beamImg(:, round(noteHeadPos(1) - spaceRadi*1.5));
rightColumn = beamImg(:, round(noteHeadPos(1) + spaceRadi*1.5));
left = numel(findpeaks(double(1 * leftColumn)));
right = numel(findpeaks(double(1 * rightColumn)));

%fprintf('%d ', [left, ' ', right]);
%disp('_')
numOfBeams = max([left,right]);
if(numOfBeams==1)
   rythm = 8;
   return;
elseif(numOfBeams==0)
   rythm = 4;
   return;
end

rythm = 0; %Higher speed than 8