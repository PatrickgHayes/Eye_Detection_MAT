function [  ] = ExportImages(image , number)

    index = int2str(number);
    format = 'NEW.jpeg';
    filename = strcat(index,format);
    
    imwrite(image, filename);
    
end


