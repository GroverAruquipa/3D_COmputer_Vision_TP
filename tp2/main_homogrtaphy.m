%%
                        
%img1=imread('0.jpg');
%img2=imread('5.jpg');
%img1=imread('figa.jpg');
%img2=imread('figb.jpg')


img1b = imread("campus1.jpg"); % Img left
img2b = imread("campus2.jpg"); % img rigtht
    
img1b = imrotate(img1b,-90,"bilinear");
img2b = imrotate(img2b,-90,"bilinear");
img1 = imresize(img1b,0.15);
img2 = imresize(img2b,0.15);

img2a = imread("QuaisGrenoble1.jpg");% read QuaisGrenoble1.jpg
img1a =imread("QuaisGrenoble2.jpg"); % read QuaisGrenoble2.jpg;
%%%%%%%%%%%%%%%%%begin  esceine %%%%%%%%%%%%%%

img1=gray2rgb(img1a);
img2=gray2rgb(img2a);

%%%%%%%%%%%%%%%%%For esceine %%%%%%%%%%%%%%
[pix1, pix2] = correspondance(img1, img2, nbPix); 
    save('pts quais de grenoble.mat', 'pix1', 'pix2');
% Save the points in a  
%b=[1130,236,948,712,1881,1045,2065,617]; %x1,y1,x2,y2,x3,y3,x4,y4 %% Points in the image1
%a=[1003,916,963,1505,1722,1536,1735,1115]; % x1 y1 x2 y2 x3 y3 x4 y4 % points in the image2
a=[pix2(1,1) pix2(1,2) pix2(2,1) pix2(2,2) pix2(3,1) pix2(3,2) pix2(4,1) pix2(4,2)];
b=[pix1(1,1) pix1(1,2) pix1(2,1) pix1(2,2) pix1(3,1) pix1(3,2) pix1(4,1) pix1(4,2)];

%%
%% Calulate the homography matrix
H=homography(a(1),a(2),a(3),a(4),a(5),a(6),a(7),a(8),b(1),b(2),b(3),b(4),b(5),b(6),b(7),b(8));
% Calculate the inverse of the homography matrix
IH=inv(H);
trans_points=[1 1 1] * IH;
x1=trans_points(1,1)/trans_points(1,3); %Normalize the points
y1=trans_points(1,2)/trans_points(1,3); %Normalize the points

trans_points=[1,size(img2,1), 1] * IH; %Normalize the points
x2=trans_points(1,1)/trans_points(1,3);
y2=trans_points(1,2)/trans_points(1,3);

trans_points=[size(img2,2),1, 1] * IH;
x3=trans_points(1,1)/trans_points(1,3);
y3=trans_points(1,2)/trans_points(1,3);

trans_points=[size(img2,2), size(img2,1), 1] * IH;
x4=trans_points(1,1)/trans_points(1,3);
y4=trans_points(1,2)/trans_points(1,3);

corners=[x1 y1;x2 y2;x3 y3;x4 y4;1 1;1 ,size(img1,1);size(img1,2), 1;size(img1,2),size(img1,1)];
%min and max offset values
MAX_X=0;
for i=1:8
    if MAX_X<= corners(i,1)      % max x calculation
    MAX_X=corners(i,1);
    end
end

MAX_Y=0;
for i=1:8
    if MAX_Y<= corners(i,2)      % max y calculation
    MAX_Y=corners(i,2);
    end
end


MIN_X=0;
for i=1:8
    if MIN_X>= corners(i,1)      % min x calculation
    MIN_X=corners(i,1);
    end
end


MIN_Y=0;
for i=1:8
    if MIN_Y>= corners(i,2)      % min y calculation
    MIN_Y=corners(i,2);
    end
end


max_height=round(MAX_Y-MIN_Y);     % maximum height of new image 
max_width=round(MAX_X-MIN_X);      % maximum width of new image
x_offset=round(abs(MIN_X));        % x offset
y_offset=round(abs(MIN_Y));        % y offset


% Create new image with the maxium size
temp = zeros(max_height,max_width);
temp=im2double(temp);
%%
% Prepare the image for the transformation
for i=1:size(img1,1)
    for j=1:size(img1,2)
         temp(i+y_offset,j+x_offset,1)=img1(i,j,1);  % copy intensity values
        temp(i+y_offset,j+x_offset,2)=img1(i,j,2);
        temp(i+y_offset,j+x_offset,3)=img1(i,j,3);
       
    end
 end
figure, imshow(temp);

%% Each pixel in the new image is transformed to the original image

for i=1:size(temp,1)
    for j=1:size(temp,2)
        % projected points after applying homography
        projected_point= [j, i, 1]*H;
a1=projected_point(1,1)/projected_point(1,3);  % points in image 2
b1=projected_point(1,2)/projected_point(1,3);
a1=round(a1); % rounding values
b1=round(b1);
if(a1>=1 && b1>=1 && a1<=size(img2,2) && b1<=size(img2,1))
    temp(i+y_offset,j+x_offset,1)=img2(b1,a1,1);    %red channel
     temp(i+y_offset,j+x_offset,2)=img2(b1,a1,2);   % green channel
      temp(i+y_offset,j+x_offset,3)=img2(b1,a1,3);  % blue channel
end
    
    end
end


figure(); imshow(temp); % display the final image



%%






%%


