function detectNote(img)

%imshow(img);
%figure;
%BW = edge(img, 'sobel', 'horizontal');
%BW = edge(img, 'roberts');
%imshow(BW)
%[H, teta, rho] = hough(BW);

%imshow(imadjust(rescale(H)),'XData',T,'YData',R,...'InitialMagnification','fit');

%BW = edge(img,'sobel', 'horizontal');
binImg = getBinImg(img, 1);
BW = edge(binImg,'sobel', 'vertical');
%BW = edge(img, 'roberts');
imshow(BW)
figure

%-----------------------------------
% Create the Hough transform using the binary image.
[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

%------------------------------
P  = houghpeaks(H,80,'threshold',(0.2*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
%----------------------

lines = houghlines(BW,T,R,P,'FillGap',2,'MinLength',5);

figure, imshow(img), hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end

