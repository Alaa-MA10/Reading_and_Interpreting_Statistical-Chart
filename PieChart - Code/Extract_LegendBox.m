function [res_image] = Extract_LegendBox(Original_img)

gray_img = rgb2gray(Original_img);

% Detect black line
BW_img = gray_img < 10;
filled_img = imfill(BW_img,'holes');  % fill small holes
area_img = bwareaopen(filled_img,120);  % Remove objects containing fewer than 120 pixels, small objects

SE = strel('square',17);
Boxes_img = imopen(area_img,SE);

% Calculate bounding box
stat = regionprops(Boxes_img,'BoundingBox');
bb = stat.BoundingBox;

% Crop the image
rec_box = imcrop(Original_img,bb);
res_image = rec_box;
end