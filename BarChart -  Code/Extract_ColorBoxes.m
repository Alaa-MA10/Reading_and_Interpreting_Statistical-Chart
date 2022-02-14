function [stat] = Extract_ColorBoxes(Image)

BW_img = ~im2bw(Image, 0.9);

SE = strel('rectangle',[5 5]);
Boxes_img = imopen(BW_img, SE);

stat  = regionprops(Boxes_img,'boundingbox', 'Centroid', 'Area');
end