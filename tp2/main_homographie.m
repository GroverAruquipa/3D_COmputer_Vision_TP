%% 2.3.1 Images 'Quais de Grenoble'

    % load images
    img1 = imread("QuaisGrenoble1.jpg");% read QuaisGrenoble1.jpg
    img2 =imread("QuaisGrenoble2.jpg"); % read QuaisGrenoble2.jpg
    
    img1b = imread("campus1.jpg"); % Img left
    img2b = imread("campus2.jpg"); % img rigtht

    img1b = imrotate(img1b,-90,"bilinear");
    img2b = imrotate(img2b,-90,"bilinear");
    img1 = imresize(img1b,0.15);
    img2 = imresize(img2b,0.15);
     %img1 = imread("figb.jpg");% read QuaisGrenoble1.jpg
    %img2 =imread("figa.jpg"); % read QuaisGrenoble2.jpg
    imshow(img1)
    % corresponding pixels variable (Question 1) 
    nbPix = 3
    
    % research matching points in the two images
    [pix1, pix2] = correspondance(img1, img2, nbPix); 
    save('pts quais de grenoble.mat', 'pix1', 'pix2');
%     load('pts quais de grenoble.mat');


combImg = imfuse(img1,img2, 'montage');
imshow(combImg);
%% 2.3.2

    % normalization of this points to have points in [-1,1]*[-1,1] as 
    % pix1 = K1*ptsNorm1 and pix2 = K1*ptsNorm2
    [ptsNorm1, K1] = normalise_pts(pix1, img1);
    [ptsNorm2, K2] = normalise_pts(pix2, img2);

%% 2.3.3  
    a=[pix2(1,1) pix2(1,2) pix2(2,1) pix2(2,2) pix2(3,1) pix2(3,2) pix2(4,1) pix2(4,2)];
    b=[pix1(1,1) pix1(1,2) pix1(2,1) pix1(2,2) pix1(3,1) pix1(3,2) pix1(4,1) pix1(4,2)];
    % homography 2H1 from img2 to img1
    H2_1 = calcul_homographie(ptsNorm1, ptsNorm2, K1, K2);
    H1_2=homography(a(1),a(2),a(3),a(4),a(5),a(6),a(7),a(8),b(1),b(2),b(3),b(4),b(5),b(6),b(7),b(8));
    % homography 1H2 from img1 to img2
    %H2_1 = calcul_homographie(ptsNorm2, ptsNorm1, K2, K1);
    a=[pix1(1,1) pix1(1,2) pix1(2,1) pix1(2,2) pix1(3,1) pix1(3,2) pix1(4,1) pix1(4,2)];
    b=[pix2(1,1) pix2(1,2) pix2(2,1) pix2(2,2) pix2(3,1) pix2(3,2) pix2(4,1) pix2(4,2)];
    
    H2_1=homography(a(1),a(2),a(3),a(4),a(5),a(6),a(7),a(8),b(1),b(2),b(3),b(4),b(5),b(6),b(7),b(8));
    
    %% Verification
    I1=H1_2*H2_1 % Identity matriz
    
    
    %%
    
%% 2.3.4 
clc
% question 7
    % mosaic of image 2 in image 1: show image 1 and change the color of
    % pixels with the part of image 2 which is in image 1
    
    % show img2 in img1
   img2= mosaic_2in1(img1, img2,pix1,pix2,H1_2);
    % show img1 in img2
    img2=mosaic_2in1(img2, img1,pix1,pix2,H2_1);
%%        
% question 9  

    %first method
    mosaic(img1, img2, H2_1);
    mosaic(img2, img1, H1_2);
 %%
 temp1=mosaic_bis(img1, img2, pix1,pix2, H1_2);
    temp2=mosaic_bis(img2, img1, pix1,pix2, H2_1);
%% 2.3.5
    % mosaic with the two entire images
    img2a = imread("QuaisGrenoble1.jpg");% read QuaisGrenoble1.jpg
    img1a =imread("QuaisGrenoble2.jpg"); % read QuaisGrenoble2.jpg;
    img1=gray2rgb(img1a);
    img2=gray2rgb(img2a);
    temp1=mosaic_bis(img1, img2, pix1,pix2, H1_2);
    temp2=mosaic_bis(img2, img1, pix1,pix2, H2_1);

%% 2.4.2  Rectification of the images
    %scanA4 = ... % read your image
    scanA4=im2double(imread('sample3.png'));
    widthA=853;
    heightA=640;
    clear scanim
    scanim=scan(scanA4,widthA,heightA); 
    %scanA=imageRect(img2, widthA,heightA);
 
 
%% 2.4.3
    
incruste=imread('rect1.jpg');
scene=imread('scene1.jpg');
% chante the size incruste to the size of scene
incruste=imresize(incruste,[size(scene,1) size(scene,2)]);
Image_incruste = im2double(incruste);
Image_scene = im2double(scene);
im3=incrust(Image_incruste,Image_scene);

    
    