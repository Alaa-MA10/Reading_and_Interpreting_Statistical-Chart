%img = imread('2.png');
img = imread('1.JPG');

[Bars_img, Bars_stat]  = ExtractBars(img);
figure,imshow(Bars_img), title('Bars Img');

legend_box = Extract_LegendBox(img);
figure, imshow(legend_box);

legend_stat = Extract_ColorBoxes(legend_box);

[final_words, final_BarHeight] = BarChart_info(img, Bars_img, Bars_stat, legend_box, legend_stat);


for j = 1: length(final_words)
    disp( string(final_words(j)) + " = " + num2str(final_BarHeight(j)) )
end

 