function resultImg = hb_cropOval(inputImg, spareFactor, bgrcolor)
if nargin < 3
    bgrcolor = 0;
end
hwidth = size(inputImg, 2) / 2.0;
hheight = size(inputImg, 1) / 2.0;

spareWidth = hwidth * spareFactor;
spareHeight = hheight * spareFactor;

[ww, hh] = meshgrid(1:hwidth, 1:hheight);

% simple ellipse equation gets us part three of your mask
mask_rightBottom = (((ww.^2)/spareWidth^2+(hh.^2)/spareHeight^2)<=1); 
mask_rightTop = flipud(mask_rightBottom);
mask_leftBottom = fliplr(mask_rightBottom);
mask_leftTop = flipud(mask_leftBottom);

mask_integrated = [mask_leftTop, mask_rightTop; ...
    mask_leftBottom, mask_rightBottom];

resultImg = inputImg;
[~,~,nDim] = size(resultImg);
if nDim == 1
    resultImg(mask_integrated(:,:)==0) = bgrcolor;
else
    multichannel_mask = repmat(mask_integrated,[1 1 nDim]);
    resultImg(multichannel_mask==0) = bgrcolor;
end

return

