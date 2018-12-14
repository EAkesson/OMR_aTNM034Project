function rowString = rowProcessing(img, staffLinesYPos, lineHeight)
%   rowProcessing(img)
%   This function process a row of notes and return them as a string of tones
%   according to document https://liuonline.sharepoint.com/sites/TNM034/TNM034_2018HT_OH/CourseDocuments/Forms/AllItems.aspx?viewpath=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments%2FForms%2FAllItems%2Easpx&id=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments%2FTNM034_Course_Information_2018%2Epdf&parent=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments
%   THIS FUNCTION ONLY WORKS IF THERE ONLY ARE ONE ROW OF NOTES
%
%   img = the inputimage with notes in a row. 
%   staffLinesYPos = the Y postition of all the stafflines
%   lineHeight = the distanse between two stafflines
%
%   rowString = the string with notes according to the img

img = rgb2gray(img);

spaceRadi = lineHeight/2;
radiiVariation = 1;

rowString = '';

% remove G-clef
img = removeGClef(img);

% Find noteheads and get thier pos
[centers, radius] = findNoteheadsByHough(img, [max(spaceRadi-radiiVariation, 1), spaceRadi+radiiVariation], 0.5, 1);

%Go through all the found notheadposition and evaluate the note, rythm and tone
jump = 0; %If we should skip next image (is used for accords)
for i = 1:length(centers)    
  if(jump == 0)
      centers(i,1) = round(centers(i,1)); %To get rid of warning about intvalues
      
      %Take out a small img with just the note from the rowimage
      smallImg = img( 1:size(img,1), centers(i,1) - round(spaceRadi*3) : centers(i,1) + round(spaceRadi*3)); 
      %figure
      %imshow(smallImg);  

      %Thy to find a better center of the notehead (Not used anymore)
      %newCenter = findNoteHeadCenter(smallImg, spaceRadi);
      %[newCenter, junk] = findNoteheadsByHough(smallImg, [max(spaceRadi-radiiVariation, 1), spaceRadi], 0.3, 0);
      %viscircles(newCenter, junk,'EdgeColor','b');
      newCenter = [round(spaceRadi*3), centers(i, 2)]; %Transform the noteheadcenter to the new picture ratio                      
      
      %If we dont have a nte head center continue to next nothead
      if(length(newCenter) == 0)
        continue
      end
      
      % get note rythm (returns 0, 4 or 8)
      rythm = getNoteRythm(smallImg, newCenter, spaceRadi);
      
      % get note name (returns note name (string))
      if(rythm > 0)          
          noteName = getNoteName(newCenter(:,2), rythm, staffLinesYPos, spaceRadi);
          rowString = strcat(rowString, noteName); %concat the notename with the ones before
      end
          
      %If we found more than one notehead in one note (accord)
      if(size(newCenter, 1) > 1)
          jump = size(newCenter, 1) - 1;
      end
  else
      jump = jump-1;
  end  
end

%disp(rowString)