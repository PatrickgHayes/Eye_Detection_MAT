function [after] = PreProcess(before)
%%% POTENTIALLY USEFUL
%Insert one image called Before
%Returns a processed image called After
%This image is filtered using non-maximum suppression technique to remove
%extraneous details in the image

%Problem: picking the right threshold value varies from test subject to
%test subject

%Current acceptable values include 10-20

%Also doesn't completely remove the extraneous details


%% Type Casting to Double Precision
x = im2double(before);

%% Smoothing Using a Gausian Filter

Gauss = 1/159*[2 4 5 4 2; 4 9 12 9 4; 5 12 15 12 5; 4 9 12 9 4; 2 4 5 4 2];
smooth = conv2(x, Gauss);

%%
%The following uses edge detection to preprocess the image using a SOBEL
%Operator

kx = [-1 0 1; -2 0 2; -1 0 1];
ky = [-1 -2 -1; 0 0 0; 1 2 1];

Gx = conv2(x, kx);
Gy = conv2(x, ky);

G_mag = sqrt(Gx.*Gx + Gy.*Gy);
G_ang = atan2(Gy,Gx);

Gx = conv2(smooth, kx);
Gy = conv2(smooth, ky);

G_magS = sqrt(Gx.*Gx + Gy.*Gy);


% figure;
% subplot(2, 2, 1);
% imshow(x);
% subplot(2, 2, 2);
% imshow(G_mag);
% subplot(2, 2, 3);
% imshow(smooth);
% subplot(2, 2, 4);
% imshow(G_magS);

%% Now Implement Non Maximum Suppression 

G_angRound = pi/4*(round(G_ang/(pi/4))); %Round to Nearest 45 Deg

Gneg = G_angRound < 0;
GPhaseShift2pi = Gneg*(2*pi);

G_angRoundPos = G_angRound + GPhaseShift2pi;
%Make all Positive
POS = G_angRoundPos/pi/0.25;

POS = mod(POS,4);

NMS = G_magS;


for i = 2:size(before,1) - 1
    for j = 2:size(before,2) - 1
        idx = POS(i, j);
        
        if idx == 0
            vec = [G_magS(i, j) G_magS(i, j + 1) G_magS(i, j - 1)];
        end
        
        if idx == 1
            vec = [G_magS(i, j), G_magS(i - 1, j - 1), G_magS(i + 1, j + 1)];
        end
        
        if idx == 2
            vec = [G_magS(i, j), G_magS(i, j + 1), G_magS(i, j - 1)];
        end
        
        if idx == 3
            vec = [G_magS(i, j), G_magS(i - 1, j + 1), G_magS(i + 1, j - 1)];
        end
        
        if vec(1) ~= max(vec)
            NMS(i, j) = 0;
        end
    end
end


%imshow(NMS);
        
%%
%Now Thresholding
% n = 13;
% largest = max(max(NMS));
% thresh = largest/n;
% Thresholding = 255*(NMS>thresh);
% imshow(Thresholding, [0, 255]);


%%Let's use thresholds on G_magS directly
%n = 20;
largest = max(max(G_magS));
G_magS = G_magS / largest;
level = graythresh(G_magS);
thresh = im2bw(G_magS, level);
after = thresh;

end