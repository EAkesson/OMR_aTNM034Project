function noteName = getNoteName(centerYPos, rythm, stafflineYpos, spaceRadi)
    

    noteName = '';
    %init var
    if(rythm == 4)
        noteNameArray = {'G1', 'A1', 'B1', 'C2', 'D2', 'E2', 'F2', 'G2', 'A2', 'B2', 'C3', 'D3', 'E3', 'F3', 'G3', 'A3', 'B3', 'C4', 'D4', 'E4'};
    elseif(rythm == 8)
        noteNameArray = {'g1', 'a1', 'b1', 'c2', 'd2', 'e2', 'f2', 'g2', 'a2', 'b2', 'c3', 'd3', 'e3', 'f3', 'g3', 'a3', 'b3', 'c4', 'd4', 'e4'};
    else         
        return        
    end
    
    firstLineArrayIndex = 6;  
   
    for j=1:length(centerYPos)
       
        %if note is below stafflines
        if(centerYPos(j) > stafflineYpos(5) + spaceRadi/2)
           
            % Calculate distance between lowest staff line and note center.
            distanceFromLowestLine = centerYPos(j) - stafflineYpos(5);
             
            % Use note head radius to calculate index. 
            noteIndex = firstLineArrayIndex - round(distanceFromLowestLine/spaceRadi); 
                
        
        %if note is above stafflines
        elseif(centerYPos(j) < stafflineYpos(1)- spaceRadi/2)
           
            % Calculate distance between lowest staff line and note center.
            distanceFromHighestLine = stafflineYpos(1) - centerYPos(j);
            
            % Use note head radius to calculate index. 
            noteIndex = firstLineArrayIndex + 8 + round(distanceFromHighestLine/spaceRadi); 
             
        %if note is in stafflines range
        else
            %disp('in range')   
            % calculate distance to staff lines
            d = abs(stafflineYpos-centerYPos(j));
            disp(d)
            [nearest, nearestIdx] = min(d);

            %if note is on staffline
            if(nearest < spaceRadi/2)
                %disp('on line')
                 noteIndex = firstLineArrayIndex + (10 - 2*nearestIdx); 
            %if note is between 2 stafflines
            else
                disp('in space')
                %if nearest is upper line
                if( nearestIdx == 1)
                    disp('upper space')
                    noteIndex = 13;
                %if nearest is lower line
                elseif( nearestIdx == 5)
                    disp('lower space')
                    noteIndex = 7;
                %if note is in space below nearest
                elseif( d(nearestIdx-1) > d(nearestIdx+1) )
                   fprintf( 'd to upper line: d% d to line below: %d \n', d(nearestIdx-1), d(nearestIdx+1))
                   disp('below nearest')
                   noteIndex = firstLineArrayIndex + 2*(5 - (nearestIdx+0.5));
                   disp(nearestIdx)
                   fprintf('noteidx %d ', noteIndex)
                %if note is in space above nearest
                else
                   fprintf( 'd to upper line: d% d to line below: %d \n', d(nearestIdx-1), d(nearestIdx+1))
                   disp('above nearest')
                   noteIndex = firstLineArrayIndex + 2*(5 - (nearestIdx-0.5));
                   fprintf('noteidx %d', noteIndex)
                end
            end
        end
        
        % Return name from calculated index position.        
        noteName = strcat(noteName,noteNameArray(noteIndex));
    end
    
    