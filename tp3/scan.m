function [img2_rect] = scan(img2) % points are 4x2 points selected 
    %im2 is the image to be rectified 
    % select corresponding pixels on image 1 and 2 alternatively
    for i = 1:4
        figure(1)
        imshow(img2)
        [x,y] = ginput(1);
        points(i,1) = x;
        points(i,2) = y;
        hold on
        %scatter vector  points
        scatter(points(:,1),points(:,2),'filled')
    end
    %close figure
    close(1)
    % Normalise the points
    points = normalise_pts(points);
    % homography 1H2 from img1 to img2
    H = homography(points(1:4,1:2),points(5:8,1:2));
    % rectify image 2
    img2_rect = homwarp(H,img2);
    figure(2)
    imshow(img2_rect)
    
    
    % Mosaic
    
end