function [ret_number] = Match_suitableNumber(bar_yTop, ocr_numbersInfo, img_scaler)

 num_diff = zeros(length(ocr_numbersInfo),1);
 number = -1;
 
 for k=1:length(ocr_numbersInfo)
     %{} to acess cell, [ k -> row, 2nd field, 2->yTop of boundingBox]
     number_yTop = ocr_numbersInfo{k,2}(2);
     number_h = ocr_numbersInfo{k,2}(4);
     number_center = number_yTop + number_h;  % (+) <- go down
     
     diff = abs(bar_yTop - number_center);
     num_diff(k) = diff;
 end
 
 [sorted_diff, min_idx] = mink(num_diff,2);
 
 num1 = str2num(ocr_numbersInfo{min_idx(1),1});
 num1_yTop = ocr_numbersInfo{min_idx(1),2}(2) /img_scaler;
 num2 = str2num(ocr_numbersInfo{min_idx(2),1});
 
 if sorted_diff(1) <100
     number = num1;
     
 elseif sorted_diff(2) <100
     number = num2;
     
 else
     min_num = min(num1, num2);
     dec_num = (bar_yTop - num1_yTop) / img_scaler;
     
     string_digit = num2str(dec_num);
     first_digit = str2num(string_digit(1));
     
     number = min_num + first_digit;
 end

ret_number = number;

end
