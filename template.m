function objPos =  template(binImg, templateImg)
%   template(binImg, templateImg)
%   binImg: the image we want to search in. Should be logical and bw
%   templateImg: the img we want to search for. Should be logical and bw
%
%   return: objPos the topleft corner of the find object. Only returns the
%   most alike object at the moment.        

    % Search for correlations between template and original
    corr = normxcorr2(templateImg,binImg);
    
%     % Find correlation peaks  (For several circles)
%     [A, I] = sort(corr(:), 'descend');
%     [w, l] = size(corr);
%     ypeaks = I(1:60)/w;
%     xpeaks = mod(I(1:60),w);
%     yoffSet = ypeaks-size(templateNote,1)/2;
%     xoffSet = xpeaks-size(templateNote,2)/2;
      
    %For gclafe
    [ypeaks, xpeaks] = find(corr == max(corr(:)));
    yoffSet = ypeaks-size(templateImg,1);
    xoffSet = xpeaks-size(templateImg,2);
    objPos = [yoffSet, xoffSet];
    
    % Show result as circles on original image
%     figure
%      imshow(binImg);
%      imrect(gca, [xoffSet(1), yoffSet(1), size(templateImg,2), size(templateImg,1)]);
    
%     radius = ones(size(ypeaks))*2;
%     viscircles([yoffSet xoffSet], radius, 'EdgeColor', 'b')

end