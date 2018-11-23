function rowString = rowProcessing(img)
% rowProcessing(img)
% This function process a row of notes and return them as a string of tones
% according to document https://liuonline.sharepoint.com/sites/TNM034/TNM034_2018HT_OH/CourseDocuments/Forms/AllItems.aspx?viewpath=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments%2FForms%2FAllItems%2Easpx&id=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments%2FTNM034_Course_Information_2018%2Epdf&parent=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments
% THIS FUNCTION ONLY WORKS IF THERE ONLY ARE ONE ROW OF NOTES
%
%   img = the inputimage with notes in a row. 
%   tones = the string with notes according to the img
%
imshow(img)
spaceRadi = 5;
firstLineYPos = 87;
rowString = '';

% remove G-clef
img = removeGClef(img);

% Find noteheads and get thier pos
[centers, radius] = findNoteheadsByHough(img, [spaceRadi-1, spaceRadi+1], 0.6);
%centers = findNoteHeadCenter(img, spaceRadi);
%radius = ones(size(centers, 1), 1)*3;
%disp(size(centers));
viscircles(centers, radius,'EdgeColor','b');

jump = 0;
for i = 1:length(centers)
  if(jump == 0)
      centers(i,1) = round(centers(i,1));%To get rid of warning about intvalues
      smallImg = img( 1:size(img,1), centers(i,1) - (spaceRadi*3) : centers(i,1) + (spaceRadi*3));
      figure
      imshow(smallImg);  

      %newCenter = findNoteHeadCenter(smallImg, spaceRadi);
      [newCenter, junk] = findNoteheadsByHough(smallImg, [spaceRadi-1, spaceRadi+1], 0.6);

      % get note rythm (returns 0, 4 or 8)
      rythm = getNoteRythm(smallImg, newCenter(1,:), spaceRadi);

      % get note name (returns note name)
      if(1)%rythm ~= 0)
          noteName = getNoteName(newCenter(:,2), rythm, firstLineYPos, spaceRadi);
          rowString = strcat(rowString, noteName);
      end
      
      disp(newCenter)
      if(length(newCenter) > 1)
      end

    %   disp(centers(i, :));
    %   disp(fiftyCent);
    %   if(length(fiftyCent) > 1)
    %       i =+ 1;
    %       disp('heeeyyo');
    %   end
  else
      jump = 0;
  end
  
end

disp(rowString)

% smallimg = binImg( 1:size(binImg,1), sortCenters(num,1) - 10 : sortCenters(num,1) + 20);
% imshow(smallimg)