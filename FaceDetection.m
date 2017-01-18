function [zoom  ] = FaceDetection( before, after )
%%% PROBABLY USEFUL
% This function assumes a face is visible.
% Finds patterns from continuous data of images as the worm is moving
% around the plate.  The head will "lead" and the tail will "lag" and will
% appear as the most dynamic changes between frames.  

% After = after;
% before = PreProcess(before);
% after = PreProcess(after);

xdim = size(before, 2);
ydim = size(before, 1);

difference = after - before;
smallest = min(min(difference));
[x, y] = find(difference <= smallest * .90);
medx = mean(x);
medy = mean(y);
xrange = [medx - 50, medx + 49];
yrange = [medy - 50, medy + 49];

if xrange(1) < 2
    xrange = [1, 100];
end
if yrange(1) < 2
    yrange = [1, 100];
end
if xrange(2) > xdim
    yrange = [xdim - 99, xdim];
end
if yrange(2) > ydim
    yrange = [ydim - 99, ydim];
end

zoom = after(xrange(1):xrange(2), yrange(1):yrange(2));

imshow(zoom, []);


end

