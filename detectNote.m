function detectNote(img)
%% Fix image
%imshow(img);
%figure;
img = removeGClef(img);
binImg = getBinImg(img, 1);
imshow(binImg)

%% Find notes by circular hough (Good)

% [centers,radii, metric] = imfindcircles(binImg, [4, 7], 'ObjectPolarity','bright', 'Method','TwoStage', 'EdgeThreshold',0.7); %shloud vary on staff widht
[centers,radii, metric] = imfindcircles(binImg, [3, 5], 'ObjectPolarity','bright', 'Method','TwoStage', 'EdgeThreshold',0.7); %shloud vary on staff widht

% center5 = centers(1:50, :)
% radii5 = radii(1:50)
viscircles(centers, radii,'EdgeColor','b');

[sortCenters, i] = sortrows(centers, 1);
disp(size(sortCenters))
figure
num = 1;
smallimg = binImg( 1:size(binImg,1), sortCenters(num,1) - 10 : sortCenters(num,1) + 20);
imshow(smallimg)


%% Find notes by linear hough (noot good)
%{
    % BW = edge(binImg,'sobel', 'vertical');
    %BW = edge(img, 'roberts');
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
%}

%% Test labeling
% figure
% labeldimg = bwlabel(binImg);
% labeldimg = uint8(labeldimg * 10);
% rgblabelimg = ind2rgb(labeldimg, colormap('hsv'));
% % disp(labeldimg == 0);
% % fmask =  etempl <= th; %Mask    % this is the mask use C and R to generate it
% % tempImage(~fmask) = 0; %Set everything outside the mask to zero (black)
% mask = labeldimg == 0;
% rgbmask = cat(3, mask, mask, mask);
% %disp(max(max(labeldimg)));
% %disp(min(min(labeldimg)));
% rgblabelimg(rgbmask) = 0;
% imshow(rgblabelimg);