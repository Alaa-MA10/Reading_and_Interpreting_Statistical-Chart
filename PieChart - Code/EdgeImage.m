function [edge_Img] = EdgeImage(Image)

R_edge = edge(Image(:,:,1), 'sobel'); % edges only in the red channel.
G_edge = edge(Image(:,:,2), 'sobel');
B_edge = edge(Image(:,:,3), 'sobel');

combined_edge = R_edge | G_edge | B_edge;

SE = strel('disk', 1);
edge_Img = imdilate(combined_edge, SE);
end