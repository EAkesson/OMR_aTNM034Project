function outImage = HoughRotate(Im)
%   HoughRotate(Im)
%   This function rotates an image if it is not completely straight. It
%   only works for smal rotations 5 degrees
%
%   Im = the image that should be rotated
%
%   outImage = the rotated image


% Read RGB-image and convert to binary image
BW = edge(rgb2gray(Im),'canny');

% Define a narrow intervall of angles to check with the Hough transform
range = 85:0.01:89.99;
[H,theta,rho] = hough(BW, 'theta', range);
peaks = houghpeaks(H, 15,'threshold', ceil(0.1*max(H(:))));

%-----------Get rotation angle------------------------
% Since the Hough transform is done on the interval range (see above) we
% must interpret what one step in range resembles in degrees. For this we
% use the standard normalization formula to convert range to [0 1].
normRange = numel(range);               % The range we Hough transform with and want to apply to Theta's range
thetaRange = max(range) - min(range);   % The range theta varies between
normPeaks = peaks(:,2)./normRange;      % Nomralized peak values
normPeaks = (normPeaks .* thetaRange) + min(range); % Here we apply the range to the normalized peaks
rotationAngles_1 = max(range)-normPeaks;            % Since we're after the small rotations we simply subtract the angles we recieved from the largest value of range


%-----------check rotation direction-------------------
% Because of the range we use, our rotation might be in the wrong
% direction. This quick check ensures that we rotate the image in the
% correct direction by checking if the angle we should rotate the test
% image in, after a new Hough transform, is greater than the first angle we
% rotated with. If it is greater, then the rotation was performed in the
% wrong direction and we rotate the real image with the negative original
% rotation angle. If not, we rotate the real image with the original
% rotation angle.
testBW = imrotate(BW,mean(rotationAngles_1));           % Apply the rotation to a test image testBW
[H_2,theta_2,rho_2] = hough(testBW, 'theta', range);    % Perform a new Hough transform on the newly rotated image
peaks = houghpeaks(H_2, 15,'threshold', ceil(0.1*max(H_2(:))));
normPeaks = peaks(:,2)./normRange;
normPeaks = (normPeaks .* thetaRange) + min(range);
rotationAngles_2 = max(range)-normPeaks;

if(mean(rotationAngles_2) > mean(rotationAngles_1))
    Im1 = imrotate(Im,-mean(rotationAngles_1), 'bicubic'); %rotate the after what the hough transform give
    Mrot = ~imrotate(true(size(Im)),-mean(rotationAngles_1)); %to make the clipping background white instead of black
else
    Im1 = imrotate(Im,mean(rotationAngles_1), 'bicubic'); %rotate the after what the hough transform give
    Mrot = ~imrotate(true(size(Im)),mean(rotationAngles_1)); %to make the clipping background white instead of black
end

Im1(Mrot&~imclearborder(Mrot)) = 1; %to make the clipping background white instead of black

Im1(1:3,:,:) = 1; %make the edge white to remove black
Im1(size(Im1,1)-3:size(Im1,1),:,:) = 1; %make the edge white to remove black
Im1(:,1:3,:) = 1; %make the edge white to remove black
Im1(:,size(Im1,2)-3:size(Im1,2),:) = 1; %make the edge white to remove black

outImage = Im1; %Set image to the output

end

