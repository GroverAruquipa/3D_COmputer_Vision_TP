% Best Method
function [temp] = mosaic_bis(img1, img2, pix1,pix2, H)
    IH=inv(H); % inverse of homography matrix
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
    % corners=[x1 y1;x2 y2;x3 y3;x4 y4;1 1;1 ,size(img1,1);size(img1,2), 1;size(img1,2),size(img1,1)];
    MAX_X=0;
    for i=1:8
        if MAX_X<= corners(i,1)      %calcluate the max x wothout using max function
        MAX_X=corners(i,1);
        end
    end

    MAX_Y=0;
    for i=1:8
        if MAX_Y<= corners(i,2)      % calculate the max y without using max function
        MAX_Y=corners(i,2);
        end
    end
    
    
    MIN_X=0;
    for i=1:8
        if MIN_X>= corners(i,1)      % calculate the min x without using min function
        MIN_X=corners(i,1);
        end
    end
    
    
    MIN_Y=0;
    for i=1:8
        if MIN_Y>= corners(i,2)      % calculate the min y without using min function
        MIN_Y=corners(i,2);
        end
    end
    
    
    max_height=round(MAX_Y-MIN_Y);     % maximum height of new image 
    max_width=round(MAX_X-MIN_X);      % maximum width of new image
    x_offset=round(abs(MIN_X));        % x offset for new image
    y_offset=round(abs(MIN_Y));        % y offset for new image
    
    
    % Create new image with the maxium size
    temp = zeros(max_height,max_width); % create a new image with zeros
    temp=im2double(temp); % convert to double for intensity values
    %%
    % Prepare the image for the transformation by copying the intensity values of the first image
    for i=1:size(img1,1)
        for j=1:size(img1,2)
             temp(i+y_offset,j+x_offset,1)=img1(i,j,1);  % copy intensity values of image 1
            temp(i+y_offset,j+x_offset,2)=img1(i,j,2); % copy intensity values of image 1
            temp(i+y_offset,j+x_offset,3)=img1(i,j,3); % copy intensity values of image 1
           
        end
     end
    figure, imshow(temp);
    
    %% Each pixel in the new image is transformed to the original image
    
    for i=1:size(temp,1)
        for j=1:size(temp,2)
            % projected points after applying homography
            projected_point= [j, i, 1]*H; % apply homography to each pixel in the new image
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
    
    
    


end