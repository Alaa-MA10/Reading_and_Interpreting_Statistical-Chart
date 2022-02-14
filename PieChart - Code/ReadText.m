function [text] = ReadText(img)

final_words = [];

ocrResults = ocr(img,'TextLayout', 'Block');
    
% Replace in Words in (\d" -> numeric) with '' using regular expression
words = regexprep(ocrResults.Words,'[\d"]','');

for i=1:length(words)
    if ~isempty(words(i)) & length(words{i})~=1
       word = words(i);
       final_words= strcat(final_words,{' '}, string(word));
    end
end
text = final_words;
end
