function [final_words, final_percentage] = CalculatePie2(circle_img, legend_box, legend_stat, edged_img)

[region_label, region_num] = bwlabel(~edged_img);
label_stat = regionprops(region_label, 'Area', 'Centroid');

[H, W, ~] = size(circle_img);
small_ratio = H*W*0.006;
large_area = max([label_stat.Area]);

total_area = 0;

for i=1:region_num             % calculate total Pie area
    x = uint8(region_label==i);
    local_area = sum(sum(x==1));
    if(local_area < small_ratio)
        continue;
    elseif(local_area == large_area)
        continue;
    end
    total_area = total_area + local_area;
end


color_diff_arr = zeros(region_num, 1);
used_regions = zeros(region_num, 1);
percentages_arr = zeros(region_num, 1);

legend_st_len = length(legend_stat);
final_percentage = zeros(legend_st_len, 1);
final_words = [];

for k=1 : length(legend_stat)       % looping on legend color boxes
    
    if (legend_stat(k).Area >= 1000)
        continue;
    end
     
    color_diff_arr = zeros(region_num, 1);

    for i=1:region_num         % looping on regions in chart
        x = uint8(region_label==i);
        local_area = sum(sum(x==1));
    
        if(local_area < small_ratio)
            color_diff_arr(i) = 10000;
            continue;
        elseif(local_area == large_area)
            color_diff_arr(i) = 10000;
            continue;
        end
        
        if used_regions(i) == 1     % if region already used, skip it.
            color_diff_arr(i) = 10000;
            continue;
        end
        
        portion_pct = ( label_stat(i).Area / total_area ) *100;

        pixel_center = round(label_stat(i).Centroid);
        pixel_color = circle_img(pixel_center(2),pixel_center(1),:);
        
        color_box_center = round(legend_stat(k).Centroid);
        color_box_pixel = legend_box(color_box_center(2), color_box_center(1),:);
        
        % Calculate difference between two pixel colors
        region_color_mean = mean(pixel_color);
        colorBox_color_mean = mean(color_box_pixel);
        diff_color = abs(region_color_mean - colorBox_color_mean);
           
        color_diff_arr(i) =  diff_color;
        percentages_arr(i) = portion_pct;
    end
    
    [min_diff, min_idx] = min(color_diff_arr);   % get min difference as correct region
    used_regions(min_idx) = 1;
    
      % Display regions taken in order %
%     x = uint8(region_label==min_idx);
%     d = zeros(size(circle_img));
%     d = uint8(x).*circle_img;
%     figure,imshow(uint8(d)), title('region');
    
    cropped_legend = Crop_LegendPart(k, legend_box, legend_stat, color_box_center);
    cropped_legend = imresize(cropped_legend, 2);
    %figure, imshow(cropped_legend);
    
    word = ReadText(cropped_legend);
    final_words = [final_words word];
    
    final_percentage(k) = percentages_arr(min_idx);
end

end