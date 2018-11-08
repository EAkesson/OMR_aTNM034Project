function template(img)
    
    % Read template image
    templateNote = rgb2gray(imread('Images_Training/oneNote.png'));
    
    % Convert original image to binary
    binImg = getBinImg(img, 1);

    % Search for correlations between template and original
    corr = normxcorr2(templateNote,binImg);
    
    % Find correlation peaks 
    [A, I] = sort(corr(:), 'descend');
    [w, l] = size(corr);
    ypeaks = I(1:60)/w;
    xpeaks = mod(I(1:60),w);
      
    % Show result as circles on original image
    yoffSet = ypeaks-size(templateNote,1)/2;
    xoffSet = xpeaks-size(templateNote,2)/2;
    figure
    imshow(binImg);
    % imrect(gca, [xoffSet, yoffSet, size(templateNote,2), size(templateNote,1)]);
    radius = ones(size(ypeaks))*2;
    viscircles([yoffSet xoffSet], radius, 'EdgeColor', 'b')

end