function [img] = mosaic_2in1(img1, img2,pix1,pix2, H)
% Calculate the transformation of the 4 corners of the image img1 in the image img2
% and find the min and max values of the coordinates
% to define the size of the mosaic image
% img1: image 1
% img2: image 2
% nbPix: number of pixels to add to the size of the mosaic image
% H: homography matrix
% img: mosaic image
%pix1 is the pixel matched in img1
%pix2 is the pixel matched in img2
% Calculate the transformation of the 4 corners of the image img1 in the image img2
nbPix=3;
corners = [1 1; size(img1,2) 1; size(img1,2) size(img1,1); 1 size(img1,1)];
corners = [corners ones(4,1)]';
corners = H*corners;
corners = corners./repmat(corners(3,:),3,1);
corners = corners(1:2,:)'
%find the size of the mosaic image
minX = min(corners(:,1));
maxX = max(corners(:,1));
minY = min(corners(:,2));
maxY = max(corners(:,2));
%round 
minX = floor(minX);
maxX = floor(maxX);
minY = floor(minY);
maxY = floor(maxY);

% for each pixel of the mosaic image find the corresponding pixel in the image img1 
% and the corresponding pixel in the image img2
% and make the average of the 2 pixels
img = zeros(maxY-minY+nbPix,maxX-minX+nbPix,3);
for i=1:size(img,1)
    for j=1:size(img,2)
        % find the corresponding pixel in the image img1
        p = [j+minX-1 i+minY-1 1]';
        p = inv(H)*p;
        p = p./p(3);
        p = round(p(1:2));
        % if the pixel is inside the image img1
        if p(1)>0 && p(1)<=size(img1,2) && p(2)>0 && p(2)<=size(img1,1)
            % find the corresponding pixel in the image img2
            p2 = [j+minX-1 i+minY-1 1]';
            p2 = p2';
            % if the pixel is inside the image img2
            if p2(1)>0 && p2(1)<=size(img2,2) && p2(2)>0 && p2(2)<=size(img2,1)
                % make the average of the 2 pixels
                img(i,j,:) = (img1(p(2),p(1),:)+img2(p2(2),p2(1),:))/2;
            else
                img(i,j,:) = img1(p(2),p(1),:);
            end
        else
            % find the corresponding pixel in the image img2
            p2 = [j+minX-1 i+minY-1 1]';
            p2 = p2';
            % if the pixel is inside the image img2
            if p2(1)>0 && p2(1)<=size(img2,2) && p2(2)>0 && p2(2)<=size(img2,1)
                img(i,j,:) = img2(p2(2),p2(1),:);
            end
       
    end
end
end
% show the mosaic image
figure;
imshow(uint8(img));




end