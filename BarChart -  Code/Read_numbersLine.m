function [ocr_numbersInfo] = Read_numbersLine(numbers_line, img_scaler)

BW_img = im2bw(numbers_line);
BW_img = imresize(BW_img, img_scaler);

%Apply OCR, looking for a block of text:
ocrResults = ocr(BW_img,'TextLayout','Block'); 

%---------------// Draw Confidences \\----------------------%
% numbers_line = imresize(numbers_line, 5);
% Iocr = insertObjectAnnotation(numbers_line, 'rectangle', ...
%        ocrResults.WordBoundingBoxes, ocrResults.WordConfidences);
% figure, imshow(Iocr), title('Iocr');
%---------------// Draw Confidences end \\----------------------%

numbers = [];
% display number only
for i=1:length(ocrResults.Words)
    if ~isempty(ocrResults.Words(i)) & ~isnan(str2double(ocrResults.Words(i)))
       ocr_WordsInfo = [ocrResults.Words(i), ocrResults.WordBoundingBoxes(i,:)];
       numbers = [numbers; ocr_WordsInfo];
    end
end

ocr_numbersInfo = numbers;
end