%%
 img1 = imread("figb.jpg");% read QuaisGrenoble1.jpg
    img2 =imread("figa.jpg"); % read QuaisGrenoble2.jpg
[h1, w1, ~] = size(img1);
    % get size of image 2
    [h2, w2, ~] = size(img2);
    % loop over the pixels of image 1
    for i = 1:nbPix:w1
        for j = 1:nbPix:h1
            % get the pixel value of image 1
            pixel = img1(j, i, :);
            % get the corresponding pixel in image 2 using the homography matrix
            % H
            % use the function 'homography' to get the corresponding pixel
            % in image 2
            [x, y] = homography(H, i, j);
            
            % check if the pixel is inside the image 2
            if x > 0 && x < w2 && y > 0 && y < h2
                % copy the pixel value from image 1 to image 2
                img2(y, x, :) = pixel;
                % disp the pixel value
                disp(pixel);
            end
        end
    end
    % show the mosaic
    figure;
    imshow(img2);
    


%%