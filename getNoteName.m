function noteName = getNoteName(centerYPos, rythm, stafflineYpos, spaceRadi)
    
    %init var
    if(rythm == 4)
        noteNameArray = ['G1', 'A1', 'B1', 'C2', 'D2', 'E2', 'F2', 'G2', 'A2', 'B2', 'C3', 'D3', 'E3', 'F3', 'G3', 'A3', 'B3', 'C4', 'D4', 'E4'];
    elseif(rythm == 8)
        noteNameArray = ['g1', 'a1', 'b1', 'c2', 'd2', 'e2', 'f2', 'g2', 'a2', 'b2', 'c3', 'd3', 'e3', 'f3', 'g3', 'a3', 'b3', 'c4', 'd4', 'e4'];
    else 
        %noteName = '';
        %return
        noteNameArray = {'G1', 'A1', 'B1', 'C2', 'D2', 'E2', 'F2', 'G2', 'A2', 'B2', 'C3', 'D3', 'E3', 'F3', 'G3', 'A3', 'B3', 'C4', 'D4', 'E4'};
    end
    firstLineArrayIndex = 6;
    noteName = '';
   
    for j=1:length(centerYPos)
        % Calculate distance between lowest staff line and note center.
        distanceFromFirstLine = firstLineYPos - centerYPos(j);
    
        % Use note head radius to calculate index. 
        noteIndex = firstLineArrayIndex + round(distanceFromFirstLine/5.5);
        if(noteIndex < 1 || noteIndex > length(noteNameArray))
            noteName = strcat(noteName,'E9');
            return
        end
        % Return name from calculated index position.
        noteName = strcat(noteName,noteNameArray(noteIndex));
    end
    
    