function [circle] = ExtractCircle(Image)

[H, W, ~] = size(Image);
half_W = int16(W/2);

[circle_center, circle_rad] = imfindcircles(Image,[20 half_W],'ObjectPolarity',...
    'dark', 'Sensitivity',0.95);

%  --------Create the circle mask -----------------
% center and radius of circle ([x_center, y_center, r])  %x_center = circle_center(1);  %y_center = circle_center(2);
% use max() if have more than one circle, find the largest
[circle_rad, max_idx] = max(circle_rad);

circle_height = (1:H) - circle_center(max_idx,2);
circle_width = (1:W) - circle_center(max_idx,1);

[xx,yy] = ndgrid(circle_height, circle_width);
mask = uint8( (xx.^2 + yy.^2) < circle_rad^2);
circle = Image.*mask;
end