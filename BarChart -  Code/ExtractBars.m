function [Bars_image, Bars_stat] = ExtractBars(Original_img)

gray_img = rgb2gray(Original_img);

% Detect rectangles
BW_img = (gray_img < 240);
SE = strel('square',25);
Boxes_img = imopen(BW_img, SE);
%figure, imshow(Boxes_img);

% % Extract bounding box
Bars_image = Original_img.*uint8(Boxes_img);
Bars_stat = regionprops(Boxes_img,'BoundingBox', 'Area', 'Centroid');

end

% %---- use to draw rectangle ---
% for k=1 : numel(Bars_stat)
%     bb = Bars_stat(k).BoundingBox;
%     rectangle('position',bb,'edgecolor','r','linewidth',2); 
% end
