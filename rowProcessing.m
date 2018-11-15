function tones = rowProcessing(img)
% rowProcessing(img)
% This function process a row of notes and return them as a string of tones
% according to document https://liuonline.sharepoint.com/sites/TNM034/TNM034_2018HT_OH/CourseDocuments/Forms/AllItems.aspx?viewpath=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments%2FForms%2FAllItems%2Easpx&id=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments%2FTNM034_Course_Information_2018%2Epdf&parent=%2Fsites%2FTNM034%2FTNM034_2018HT_OH%2FCourseDocuments
% THIS FUNCTION ONLY WORKS IF THERE ONLY ARE ONE ROW OF NOTES
%
% img = the inputimage with notes in a row. 
% tones = the string with notes according to the img
%

tones = '';
% remove G-clef
img = removeGClef(img);

% Find noteheads and get thier pos
[centers, radius] = findNoteheadsByHough(img, [3, 5], 0.7);
viscircles(centers, radius,'EdgeColor','b');
disp(length(centers));

for i = 1:length(centers)
  smallimg = img( 1:size(img,1), centers(i,1) - 10 : centers(i,1) + 15);
  figure
  imshow(smallimg)  
  fiftyCent = findNoteHeadCenter(smallimg, 4);
%   disp(centers(i, :));
%   disp(fiftyCent);
%   if(length(fiftyCent) > 1)
%       i =+ 1;
%       disp('heeeyyo');
%   end
end

% smallimg = binImg( 1:size(binImg,1), sortCenters(num,1) - 10 : sortCenters(num,1) + 20);
% imshow(smallimg)