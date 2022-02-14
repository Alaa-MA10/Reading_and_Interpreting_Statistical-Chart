function [Cropped_legend] = Crop_LegendPart2(k, legend_box, legend_stat, color_box_center)

[legend_H, legend_W, ~] = size(legend_box);
bb = legend_stat(k).BoundingBox;
color_box_H = bb(4);
color_box_W = bb(3);
start_x = color_box_center(1) - (0.5*color_box_W);
start_y = bb(2) - (0.4*color_box_H);

if legend_H > legend_W   
    crop_height = floor(legend_H / numel(legend_stat));
    if k == 1
        start_y = 1;
    end

    cropped_legend = uint8(zeros(size([ crop_height, legend_W])));
    end_y = start_y + crop_height;
    if end_y > legend_H
        end_y = legend_H;
    end
    cropped_legend = legend_box( start_y:end_y, start_x:legend_W,:);
else
    if k == length(legend_stat)
        end_width = legend_W;
    else
        end_width = legend_stat(k+1).BoundingBox(1);
    end
    cropped_legend = uint8(zeros(size([legend_H, end_width])));
    start_y = 1;
    start_x = color_box_center(1) + (0.5*color_box_W);
    cropped_legend = legend_box( start_y:legend_H, start_x : end_width,:);
end
Cropped_legend = cropped_legend;

end