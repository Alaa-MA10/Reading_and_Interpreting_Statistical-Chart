function [final_words, final_BarHeight]= BarChart_info(original_img, Bars_img, Bars_stat, legend_box, legend_stat)


%Crop numbers line
limit_width = floor(Bars_stat(1).BoundingBox(1));
numbers_line = original_img(:, 1:limit_width,:);

%Apply OCR
img_scaler = 5;
ocr_numbersInfo = Read_numbersLine(numbers_line, img_scaler);

bars_result = [];
for j=1:length(Bars_stat)
    %---------------// (1) get region number from numbers line\\-------
    %  BoundingBoxes -> [x y width height]
    bar_yTop = (Bars_stat(j).BoundingBox(2))*img_scaler;
    bar_yTop = round(bar_yTop);
    
    number = Match_suitableNumber(bar_yTop, ocr_numbersInfo, img_scaler);
    bars_result = [bars_result number];
end


final_BarHeight = [];
final_words = [];

for i=1 :length(Bars_stat)
    
    color_diff_arr = zeros(length(legend_stat), 1);
    for k=1 :length(legend_stat)
        if (legend_stat(k).Area >= 1000)   % skip legend background
            color_diff_arr(k) =  10000;
            continue;
        end
        
        pixel_center = round(Bars_stat(i).Centroid);
        pixel_color = Bars_img(pixel_center(2),pixel_center(1),:);
        
        color_box_center = round(legend_stat(k).Centroid);
        color_box_pixel = legend_box(color_box_center(2), color_box_center(1),:);
        
        % --- comparing pixel with specific range of brightness 
        % --- to cover the difference between it and the pixel in the legend
        if ( pixel_color >= (color_box_pixel-15)) & ( pixel_color <= (color_box_pixel+15) )
            cropped_legend = Crop_LegendPart2(k, legend_box, legend_stat, color_box_center);
            break;
        end
    end
    
    cropped_legend = imresize(cropped_legend, 2);
    %figure, imshow(cropped_legend);
    
    word = ReadText2(cropped_legend);
    final_words = [final_words word];
    final_BarHeight = [final_BarHeight bars_result(i)];
    
end


end