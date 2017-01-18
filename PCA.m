function [  ] = PCA( image_block )
%% POTENTIALLY USEFUL
%This function is the perform Principal Component Analysis on the image set
%of worms to determine an eigenspace for the data set

%The following eigenworms will be the return matrix block in which the
%third dimension index will be encoded for each image


no_im = size(image_block, 3);
m = size(image_block, 1);
n = size(image_block, 2);  %Such that m and n are dimensions of an mxn matrix

% reshape the images to a single column vector
for i = 1:no_im
    image_vec(:,i) = reshape(image_block(:,:,i), [m*n, 1]);
end

mean = 1/no_im * image_vec * ones(no_im, 1);
Xc = image_vec - mean*ones(1, no_im); %Centered data set about mean
C = 1/no_im * Xc*Xc'; %Covariance Matrix
[V, D] = eig(C); %Eigenworms
firstten = V(:, 1:10);
First = reshape(firstten, [m, n, 10]);
First = First*10;

figure;
subplot(2, 5, 1);
imshow(First(:,:,1));

subplot(2, 5, 2);
imshow(First(:,:,2));

subplot(2, 5, 3);
imshow(First(:,:,3));

subplot(2, 5, 4);
imshow(First(:,:,4));

subplot(2, 5, 5);
imshow(First(:,:,5));

subplot(2, 5, 6);
imshow(First(:,:,6));

subplot(2, 5, 7);
imshow(First(:,:,7));

subplot(2, 5, 8);
imshow(First(:,:,8));

subplot(2, 5, 9);
imshow(First(:,:,9));

subplot(2, 5, 10);
imshow(First(:,:,10));







end






