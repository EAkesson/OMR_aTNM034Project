function rowString = rowProcessing(img, staffLinesYPos, lineHeight)
% rowProcessing(img)
% This function process a row of notes and return them as a string of tones
% according to document https://liuonline.sharepoint.com/sites/TNM034/TNM034_2018HT_OH/CourseDocuments/Forms/AllItems.aspx?viewpath=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments%2FForms%2FAllItems%2Easpx&id=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments%2FTNM034_Course_Information_2018%2Epdf&parent=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments
% THIS FUNCTION ONLY WORKS IF THERE ONLY ARE ONE ROW OF NOTES
%
%   img = the inputimage with notes in a row. 
%   tones = the string with notes according to the img
%

img = rgb2gray(img);

spaceRadi = lineHeight/2;
radiiVariation = 1;
%firstLineYPos = 87;

rowString = '';

% remove G-clef
img = removeGClef(img);

% Find noteheads and get thier pos


[centers, radius] = findNoteheadsByHough(img, [max(spaceRadi-radiiVariation, 1), spaceRadi+radiiVariation], 0.5, 1);
%centers = findNoteHeadCenter(img, spaceRadi);
%radius = ones(size(centers, 1), 1)*3;
%disp(size(centers));
%viscircles(centers, radius,'EdgeColor','b');

jump = 0;
for i = 1:length(centers)    
  if(jump == 0)
      centers(i,1) = round(centers(i,1)); %To get rid of warning about intvalues
      
      smallImg = img( 1:size(img,1), centers(i,1) - round(spaceRadi*3) : centers(i,1) + round(spaceRadi*3));
      %figure
      %imshow(smallImg);  

      %newCenter = findNoteHeadCenter(smallImg, spaceRadi);
      %[newCenter, junk] = findNoteheadsByHough(smallImg, [spaceRadi-1, spaceRadi+1], 0.5, 0);
      
      %[newCenter, junk] = findNoteheadsByHough(smallImg, [max(spaceRadi-radiiVariation, 1), spaceRadi], 0.3, 0);
      newCenter = [round(spaceRadi*3), centers(i, 2)];
      %viscircles(newCenter, junk,'EdgeColor','b');
      
      if(length(newCenter) == 0)
        continue
      end
      % get note rythm (returns 0, 4 or 8)
      rythm = getNoteRythm(smallImg, newCenter, spaceRadi);
      
      disp(rythm)
      % get note name (returns note name)
      if(rythm > 0)          
          noteName = getNoteName(newCenter(:,2), rythm, staffLinesYPos, spaceRadi);
          rowString = strcat(rowString, noteName);
      end
          
      if(size(newCenter, 1) > 1)
          jump = size(newCenter, 1) - 1;
      end
  else
      jump = jump-1;
  end  
end

disp(rowString)

% smallimg = binImg( 1:size(binImg,1), sortCenters(num,1) - 10 : sortCenters(num,1) + 20);
% imshow(smallimg)