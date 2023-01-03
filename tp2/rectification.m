% read the image
im = imread('rect1.png');
% select 4 points on the image
figure(1), imshow(im);
[x,y] = ginput(4);
% create a matrix with the selected points
pts = [x y];


tic
% set the moving points := the original image control points
%x = [1380;2183;1282;422];
%y = [727;1166;2351;1678];
movingPoints = [x,y];
% set the fixed points := the desired image control points
xfix = [1;1000;1000;1];
yfix = [1;1;1000;1000];
fixedPoints = [xfix,yfix];
% generate geometric transform
tform = fitgeotrans(movingPoints,fixedPoints,'projective');
% generate reference object (full desired image size)
R = imref2d([1000 1000]);
% warp image

outputImage = imwarp(im,tform,'OutputView',R);



toc
% show image
imshow(outputImage);


