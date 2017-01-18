function [ x ] = LoadImages(n)
%Let's Load Images!
%They must always be named with numbers followed by the extensions .jpeg
%This load the images and returns a matrix x that has the images across the
%third dimension of the matrix

x = [];
for number = 1:n
    index = int2str(number);
    format = '.jpeg';
    strng = strcat(index, format);
    img = imread(strng);
    x(:, :, number) = img;
end

end

