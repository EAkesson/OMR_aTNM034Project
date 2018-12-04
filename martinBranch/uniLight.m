function outImage = uniLight(doubleImage) 
% Uniform lightning
% Read image and convert to double
% Im = imread('im3c.jpg');
gray = rgb2gray(doubleImage);
gray = im2double(gray);

% M defines the dimensions of the matrix used in the nlfilter
M = [9, 9];

% fun simply returns a scalar value with the max value of a matrix
fun = @(x) max(max(x));

% nlfilter applies the function fun to each M sliding block of the grayscale imaage 
B = nlfilter(gray, M, fun);

% Normalization by division
norm = gray./B;

outImage = norm;
%imshow(norm);
end

