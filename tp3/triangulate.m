function [pts3D] = triangulate(K1, K2, pts1, pts2, T1_w, T2_w, gama)
    skew1 = [0 -T1_w(3) T1_w(2); T1_w(3) 0 -T1_w(1); -T1_w(2) T1_w(1) 0];
    %Pt2 in skew form
    skew2 = [0 -T2_w(3) T2_w(2); T2_w(3) 0 -T2_w(1); -T2_w(2) T2_w(1) 0];
    imgK = K1;
    %imgKc  
    imgKc = [imgK zeros(3,1)];
    %%% For the image 2 %%%
    imgK2 = K2;
    % transformation matrix 
    theta=0; % rotation angle
    alfa=0;
    gama=12*pi/180;
    %gama=55*pi/180;
    %pt=[0 0 0.25]; % translation
    pt=[0.08 0.17 0.25]; % translation
    
    %transformation matrix 
    %T2 is matriz with rotation around z axis and translation in x,y,z
    %T2=[cos(gama) -sin(gama) 0 pt(1); sin(gama) cos(gama) 0 pt(2); 0 0 1 pt(3); 0 0 0 1]
    T2 = [cos(theta)*cos(gama) -cos(theta)*sin(gama) sin(theta) pt(1); sin(alfa)*sin(theta)*cos(gama)+cos(alfa)*sin(gama) -sin(alfa)*sin(theta)*sin(gama)+cos(alfa)*cos(gama) -sin(alfa)*cos(theta) pt(2); -cos(alfa)*sin(theta)*cos(gama)+sin(alfa)*sin(gama) cos(alfa)*sin(theta)*sin(gama)+sin(alfa)*cos(gama) cos(alfa)*cos(theta) pt(3); 0 0 0 1];
    
    Ap1=skew1*imgKc;% A matrix is 3x4  for image 1
    clear Ap
    Ap2=skew2*imgKc*T2; % Ap matrix is 3x4 for image 2
    for i=1:size(pts1,1)% for each point
        %skew matrix of pts1 
        %skew1 = [1 0 -pts1(i,1); 0 1 -pts1(i,2); 0 0 1]
        skew1=[0 0 pts1(i,2); 0 0 -pts1(i,1); -pts1(i,2) pts1(i,1) 0];
        %skew matrix of pts2
        %skew2 = [1 0 -pts2(i,1); 0 1 -pts2(i,2); 0 0 1]
        skew2=[0 0 pts2(i,2); 0 0 -pts2(i,1); -pts2(i,2) pts2(i,1) 0];
        % A matrix is 3x4  for image 1
        Ap1=skew1*imgKc;
        % Ap matrix is 3x4 for image 2
        Ap2=skew2*imgKc*T2;
        % A matrix is 6x4
        A = [Ap1; Ap2];
        [U,S,V] = svd(A);
        % the last column of V is the solution
        pts3D(i,:) = V(:,end);
        pts3D(i,:) = pts3D(i,:)/pts3D(i,4);% normalize the 3D point
    end
%Normalize the 3D points
    %pts3D = pts3D./repmat(pts3D(:,4),1,4);
    %pts3D = pts3D(:,1:3);
end
