%% 2.3.1 Images 'Quais de Grenoble'

    % load images
    img1 = imread("QuaisGrenoble1.jpg");% read QuaisGrenoble1.jpg
    img2 =imread("QuaisGrenoble2.jpg"); % read QuaisGrenoble2.jpg
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

%%

 [ptsNorm1, K1] = normalise_pts(pix1, img1)
 [ptsNorm2, K2] = normalise_pts(pix2, img2)

    
%%


%% 2.3.3  
    % homography 2H1 from img2 to img1
    H2_1 = calcul_homographie(ptsNorm1, ptsNorm2, K1, K2)
    % homography 1H2 from img1 to img2
   % Verification of the homography
    H1_2 = calcul_homographie(ptsNorm2, ptsNorm1, K2, K1)
    % Verification of the homography
    H1_2*H2_1 % should be identity matrix
    %%
    
    H1_2 = calcul_homographie(ptsNorm2, ptsNorm1, K2, K1);
    paux=ptsNorm2(1,:)'
    PtsNorm1ver=H2_1*paux

    H21=homography_solve(pix2', pix1');
    H12=homography_solve(pix1', pix2');
    H11*H21
     %%
     mosaic_2in1(img1, img2,nbPix,H12);
   % mosaic_2in1(img2, img1,nbPix,H2_1);
    
 %%
    % question 9  
    %first method
    mosaic(img1, img2, H2_1);
    
%%
 mosaic(img1, img2, H2_1);

    
