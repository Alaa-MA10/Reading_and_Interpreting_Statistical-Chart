Img = imread('1.png');
%Img = imread('2.JPG');
circle_img = ExtractCircle(Img);
figure, imshow(circle_img);

legend_box = Extract_LegendBox(Img);
figure, imshow(legend_box);

legend_stat = Extract_ColorBoxes(legend_box);

edged_img = EdgeImage(circle_img);

[final_words, final_percentage] = CalculatePie2(Img, legend_box, legend_stat, edged_img);

% removing percentages that we don't need (belongs to extra background not to legends)
final_percentage = final_percentage(final_percentage ~= 0);

for j = 1: length(final_words)
    disp( string(final_words(j)) + " = " + num2str(final_percentage(j)) + "%" )
 end
