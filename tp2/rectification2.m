%%
% read the image
im = imread('rect1.png');
% select 4 points on the image
figure(1), imshow(im);
[x,y] = ginput(4);

pts = [x y];

%%
%rectification parameters
X=pts(:,1);
Y=pts(:,2);
%rectification parameters
x1 = X(1);
x2 = X(2);
x3 = X(3);
x4 = X(4);
y1 = Y(1);
y2 = Y(2);
y3 = Y(3);
y4 = Y(4);
%rectification parameters
a = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);
b = (x1*y2-y1*x2)*(x3-x4)-(x1-x2)*(x3*y4-y3*x4);
c = (x1*y2-y1*x2)*(y3-y4)-(y1-y2)*(x3*y4-y3*x4);
%rectification parameters
d = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);
e = (x1*y2-y1*x2)*(x3-x4)-(x1-x2)*(x3*y4-y3*x4);
f = (x1*y2-y1*x2)*(y3-y4)-(y1-y2)*(x3*y4-y3*x4);
%rectification parameters
g = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);
h = (x1*y2-y1*x2)*(x3-x4)-(x1-x2)*(x3*y4-y3*x4);
i = (x1*y2-y1*x2)*(y3-y4)-(y1-y2)*(x3*y4-y3*x4);
%rectification parameters
clear A
A = [a b c; d e f; g h i];
%SVD of A  
[U,S,V] = svd(A);
%%

A=[x1 y1 1 0 0 0 -x1*x1 -x1*y1; 0 0 0 x1 y1 1 -y1*x1 -y1*y1; x2 y2 1 0 0 0 -x2*x2 -x2*y2; 0 0 0 x2 y2 1 -y2*x2 -y2*y2; x3 y3 1 0 0 0 -x3*x3 -x3*y3; 0 0 0 x3 y3 1 -y3*x3 -y3*y3; x4 y4 1 0 0 0 -x4*x4 -x4*y4; 0 0 0 x4 y4 1 -y4*x4 -y4*y4];
[U,S,V] = svd(A);
h = V(:,end);
H = [h(1) h(2) h(3); h(4) h(5) h(6); h(7) h(8) 1];
H = H/H(3,3);
%rectified image
for i=1:size(im,1)
    for j=1:size(im,2)
        p = [j i 1]';
        p = H*p;
        p = p/p(3);
        im2(i,j,:) = im(round(p(2)),round(p(1)),:);
    end
end


figure(2), imshow(im2);