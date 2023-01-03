% research matching points in the two images

function [pix1, pix2] = correspondance(im1, im2, nbPix) %% im1 mxn, im2=mxn, nbPix=(4,2)
    % create tables
    nbPix=nbPix+1;
    pix1 = zeros(nbPix,2);
    pix2 = pix1;
    figure(1)=imshow(im1)
    
    %figure(2)=imshow(img2)
    % select corresponding pixels on image 1 and 2 alternatively. 
    % These points are pix1 and pix2 as pix = [y1,x1;y2,x2;...]
    for i = 1:(nbPix)
        % select point i on image 1 with ginput. Put it in pix1
       % buff1=ginput(1); % Point1 
        hold on
       pix1(i,:)=ginput(1);
        scatter(pix1(i,1),pix1(i,2), 'filled');
        hold on
        % select point i on image 2 with ginput. Put it in pix2
        %buff2=ginput(1); % pOint 2

        
        %pix2(i,:)=ginput(2);%%
        %scatter(pix2(i,1),pix2(i,2));

    end
    im1a=getframe
    hold off
    
    figure(2)=imshow(im2)
    for i=1:(nbPix)
        hold on
        pix2(i,:)=ginput(1);
         scatter(pix2(i,1),pix2(i,2), 'filled');
         hold on

    end
    im2a=getframe
    hold off
    combImg = imfuse(im1a.cdata,im2a.cdata, 'montage');
    %figure()
    imshow(combImg);

    % create figure with the two images and points pix1 and pix2 on them
    % be careful: pix = [y1,x1;y2,x2;...]
    %figure("Récapitulatif des points en correspondance")
    %figure("Name","Récapitulatif des points en correspondance")
    %...
end