function H=homography2(pts1,pts2) % x1 is  pts1 is 4rows x 2 columns, pts2 is 4 rows x 2 columns
   % x1,y1,x2,y2,x3,y3,x4,y4 , xp1,yp1,xp2,yp2,xp3,yp3,xp4,yp4
   x1=pts1(1,1); y1=pts1(1,2);
    x2=pts1(2,1); y2=pts1(2,2);
    x3=pts1(3,1); y3=pts1(3,2);
    x4=pts1(4,1); y4=pts1(4,2);
    xp1=pts2(1,1); yp1=pts2(1,2);
    xp2=pts2(2,1); yp2=pts2(2,2);
    xp3=pts2(3,1); yp3=pts2(3,2);
    xp4=pts2(4,1); yp4=pts2(4,2);
    % HOMOGRAPHY  Apply homography to points    
A=[
    -x1  -y1  -1   0    0    0   x1*xp1   y1*xp1   xp1;
     0    0    0 -x1   -y1  -1   x1*yp1   y1*yp1   yp1;
    -x2  -y2  -1   0    0    0   x2*xp2   y2*xp2   xp2;
     0    0    0 -x2   -y2  -1   x2*yp2   y2*yp2   yp2;
    -x3  -y3  -1   0    0    0   x3*xp3   y3*xp3   xp3;
     0    0    0 -x3   -y3  -1   x3*yp3   y3*yp3   yp3;
    -x4  -y4   -1  0    0    0   x4*xp4   y4*xp4   xp4;
     0    0    0  -x4  -y4  -1   x4*yp4   y4*yp4   yp4]; % A IS 8x9  MATRIX, 8 EQUATIONS AND 9 UNKNOWN COEFFICIENTS OF HOMOGRAPHY MATRIX H  % SOLVE AX=0 USING SVD
     
    [~,~,V] = svd(A); % SVD OF A MATRIX 
     
     
    H=V(:,end);% HOMOGRAPHY MATRIX IS THE LAST COLUMN OF V MATRIX, WHICH IS 9X1 MATRIX 
    % normalizing homography matrix
    H = reshape(H,3,3); % RESHAPE HOMOGRAPHY MATRIX TO 3X3 MATRIX 
    for i=1:3
        for j=1:3
            H(i,j)=H(i,j)/H(3,3); % NORMALIZING HOMOGRAPHY MATRIX 
        end
    end
    
end