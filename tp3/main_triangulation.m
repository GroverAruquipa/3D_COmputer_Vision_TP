
clear all
close all
%% Images
    img1 = imread("img2l.jpg"); % Img left
img2 = imread("img2r.jpg"); % img rigtht
    
img1 = imrotate(img1,-90,"bilinear");
img2 = imrotate(img2,-90,"bilinear");
%%
    nbPix = 3;
    [pix1, pix2] = correspondance(img1, img2, nbPix);

    %
% Données géométriques
    angle = 55.6*pi/180 % (rad)
    R = 0.15 % (m)
    distanceX = 0.5
    distanceY = 0.15

% Paramètres caméra
    %[ptsNorm1, K] = normalise_pts(pix1, img1)
    [ptsNorm2, K] = normalise_pts(pix2, img2)
    %K1=K; K2=K;
    %K is the intrinsic matrix of the camera (focal length, principal point) of iphone 13  (focal length, principal point) of iphone 13
    %K = [  1.0000e+03   0.0000e+00   1.2800e+02
    %       0.0000e+00   1.0000e+03   2.3400e+02
    %       0.0000e+00   0.0000e+00   1.0000e+00];
    K = [  3151   0.0000e+00   1988
           0.0000e+00   3158   1444.6
           0.0000e+00   0.0000e+00   1.0000e+00];



    K1=K; K2=K;

    
    %K = [  1.0e+03 0 0; 0 1.0e+03 0; 0 0 1];
    %T2_1 =  calcul_homographie(ptsNorm1, ptsNorm2, K1, K2)
    %T1_1 =calcul_homographie(ptsNorm2, ptsNorm1, K2, K1)
    T1_1=homography2(pix1, pix2)
    T2_1=homography2(pix2, pix1)
    %% Verification
    
    
%% 3.3.2
 T1_w=T1_1;
    T2_w=T2_1;
    pts1=pix1;
    pts2=pix2;
clear pts3D
pts3D = triangulate(K1, K2, pts1, pts2, T1_w, T2_w,0)

%% 3.3.3 
% Create vecotor with the points 3D different gama
    % linspace between 0 and 180 degrees with 10 points
    gama = linspace(-180, 180, 1);
    % convert gama to radian
    gama = gama*pi/180;
    clear pts3D
    %figure()
    for i=1:length(gama)
        % create a rotation matrix
        % triangulate the points
        pts3D = triangulate(K1, K2, pts1, pts2, T1_w, T2_w,gama(i));
        figure()
        % plot pts3D points 
        axis('ij');
        for i=1:size(pts3D)
            plot3(pts3D(i,1), pts3D(i,2), pts3D(i,3),'m+');
            hold on
            %axis equal
            scatter3(pts3D(i,1), pts3D(i,2), pts3D(i,3),'m+');
            str = num2str(i); 
            text(pts3D(i,2), pts3D(i,1), pts3D(i,3),str); % affiche le numéro des points
        end
    end
    
% question 5
      figure()
    axis('ij');
    for i=1:size(pts3D)
        plot3(pts3D(i,1), pts3D(i,2), pts3D(i,3),'m+');
        hold on
        scatter3(pts3D(i,1), pts3D(i,2), pts3D(i,3),'m+');
        str = num2str(i); 
        text(pts3D(i,2), pts3D(i,1), pts3D(i,3),str); % affiche le numéro des points
    end
    
    %% Cycle to connect the points with lines 
    for i=1:size(pts3D)
        for j=1:size(pts3D)
            if i~=j
                plot3([pts3D(i,1) pts3D(j,1)], [pts3D(i,2) pts3D(j,2)], [pts3D(i,3) pts3D(j,3)],'b-');
            end
        end
    end
    hold on
    
    
    % affiche la caméra
    %plotCamera('Location', [0 0 0], 'Orientation', eye(3), 'Opacity', 0, 'Size', 0.1);
    %hold on
    %plotCamera('Location', T1_w(1:3,4)', 'Orientation', T1_w(1:3,1:3), 'Opacity', 0, 'Size', 0.1);   
    % affiche la caméra 1
    figure()
    %scatter3 (0,0,0)
    plot3(0, 0, 0,'m*');
    hold on
    trcam=[25 17 8];
    rot1=roty(0+90)*rotz(0);
    rot2=roty(0+90)*rotz(11);
    tform1 = rigid3d(rot1,trcam);
    tform2 = rigid3d(rot2,trcam);
    cam = plotCamera(AbsolutePose=tform1,Opacity=0)

    %plotCamera('Location', trcam, 'Orientation', rotx(0), 'Opacity', 0, 'Size', 1);
    hold on
    cam = plotCamera(AbsolutePose=tform2,Opacity=0)
% affiche la caméra 2
    % plotCamera('Location', trcam, 'Orientation', rotx(11), 'Opacity', 0, 'Size', 1);
    hold on
    axis equal
    xlabel('x')
    ylabel('y')
    zlabel('z')
    title('3D reconstruction')
    grid on
    hold off

    
    
    
    
   %% 
   % choix des plans
% question 6
% Calulaate plane with pts3D 
vec1=pts3D(1,:)-pts3D(2,:);
vec2=pts3D(1,:)-pts3D(3,:);
%extract 3 e;ements of vec1 and vec2
vec1=vec1(1:3);
vec2=vec2(1:3);
%normal vector
normal=cross(vec1,vec2);
% plot vector normal 

quiver3(pts3D(1,1),pts3D(1,2),pts3D(1,3),normal(1),normal(2),normal(3),'r')


pts3D1=[0.2345 0.3432 -0.1255; 0.1143 0.0932 -0.1247; -0.0084 -0.0052 -0.1290];
pts3D2=[-0.3595 -0.2554 -0.1287;-0.22 -0.1978 -0.1322; -0.0287 -0.0713 -.1317];
pts3D3=[0.153695 0.1951 -0.1277; -0.0239 -0.067 -0.1327; -0.08531 -0.10963 -0.125];

pts3D1=[0+0.1 1.1 1.2; 0+0.1 1 0; 1 1 0+0.1];
pts3D2=[1 1 0+0.1; 1.01 0+0.1 0+0.1; 0.97 0+0.1 1];
pts3D3=[0+0.1 1 1; 0+0.1 0 1; 1 0+0.1 1];

%scatter3(pts3D1(:,1),pts3D1(:,2),pts3D1(:,3))
% cycle for to plot the points pts3D1, pts3D2 and pts3D3
figure()
for i=1:size(pts3D1)
    % catter3 color red 
    scatter3(pts3D1(i,1),pts3D1(i,2),pts3D1(i,3),'r','filled')
    hold on
end
for i=1:size(pts3D2)
    scatter3(pts3D2(i,1),pts3D2(i,2),pts3D2(i,3),'g','filled')
    hold on
end
for i=1:size(pts3D3)
    scatter3(pts3D3(i,1),pts3D3(i,2),pts3D3(i,3),'b','filled')
    hold on
end

%%%%%%%%%%%%%%%%%%%%%%planA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pt4planA,xA,yA,lenxA,lenyA, caractPlanA] = calculePlan(pts3D1);

% planaprime is the three first points concatenate with caracPlanA
planaprime=[pts3D1; pt4planA(:,1:3)];

planaprime=planaprime/norm(planaprime);
%create meshgrid with planaprime
%%%%%%%%%%%%%%%%%%%planB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pt4planB,xB,yB,lenxB,lenyB, caractPlanB] = calculePlan(pts3D2);
planbprime=[pts3D2; pt4planB(:,1:3)];
planbprime=planbprime/norm(planbprime);
%%%%%%%%%%%%%%%%%%%planC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pt4planC,xC,yC,lenxC,lenyC, caractPlanC] = calculePlan(pts3D3);
plancprime=[pts3D3; pt4planC(:,1:3)];
plancprime=plancprime/norm(plancprime);

%% remplissage coloré
   figure()
fill3(planaprime(1:4,2), planaprime(1:4,1), planaprime(1:4,3),'r', 'FaceAlpha', 0.5)
hold on
fill3(planbprime(1:4,2), planbprime(1:4,1), planbprime(1:4,3),'g', 'FaceAlpha', 0.5)
hold on
fill3(plancprime(1:4,2), plancprime(1:4,1), plancprime(1:4,3),'b', 'FaceAlpha', 0.5)

%% 3.3.4 remplissage avec la texture
%%%%%%%%%%%%%%%For plan A%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure()
widthA=450;
heightA=600;
scanA=imageRect(img2, widthA,heightA);
% pixA is the 4 points of the rectangle of scanA
pixA = [1, 1; widthA, 1; 1, heightA; widthA, heightA]; 
pixA = [pixA(:,1), pixA(:,2)];
%
close all
lenHA = round(sqrt((pixA(1,1)-pixA(2,1))^2 + (pixA(1,2)-pixA(2,2))^2));
lenVA = round(sqrt((pixA(1,1)-pixA(3,1))^2 + (pixA(1,2)-pixA(3,2))^2));
%scanA = scan(img1, pixA, lenVA, lenHA);
[h,w,~]=size(img1);

lenVA=450;
lenHA=600;



%%
%%%%%%%%%%%%%%%For plan B%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

widthB=450;
heightB=600;
scanB=imageRect(img2, widthB,heightB);
% pixB is the 4 points of the rectangle of scanB 
pixB = [1, 1; widthB, 1; 1, heightB; widthB, heightB];
pixB = [pixB(:,1), pixB(:,2)];
%
lenHB = round(sqrt((pixB(1,1)-pixB(2,1))^2 + (pixB(1,2)-pixB(2,2))^2));
lenVB = round(sqrt((pixB(1,1)-pixB(3,1))^2 + (pixB(1,2)-pixB(3,2))^2));
%scanA = scan(img1, pixA, lenVA, lenHA);
[h,w,~]=size(img1);
close all
lenVB=450;
lenHB=600;
%%
%%%%%%%%%%%%%%For plan C%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
widthC=450;
heightC=600;
scanC=imageRect(img2, widthC,heightC);
% pixC is the 4 points of the rectangle of scanC
pixC = [1, 1; widthC, 1; 1, heightC; widthC, heightC];
pixC = [pixC(:,1), pixC(:,2)];
%
lenHC = round(sqrt((pixC(1,1)-pixC(2,1))^2 + (pixC(1,2)-pixC(2,2))^2));
lenVC = round(sqrt((pixC(1,1)-pixC(3,1))^2 + (pixC(1,2)-pixC(3,2))^2));
[h,w,~]=size(img1);
lenVC=450;
lenHC=600;
%get texture of scanA to fill the face 3d p3DX 
%%
%%%%%%%%%%%%%%For the planA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
pt3DA=zeros(3, lenVA*lenHA);
colorA=zeros(3, lenVA*lenHA);
k=1;
for i = 1:lenHA
    for j = 1:lenVA
        % dx is the x coordinate of the point in the 3D space
        dx = i;
        % dy is the y coordinate of the point in the 3D space
        dy = j;
        % dz is the z coordinate of the point in the 3D space usung caractPlanA
        dz=-(caractPlanA(1)*dx+caractPlanA(2)*dy+caractPlanA(4))/caractPlanA(3) ;%is the equation of the plane in the x-y plane
        
        pt3DA(:,k)=[dx;dy;dz];
        color(1:3)=scanA(i,j,:);
        color=double(color(1:3));
        colorA(:,k)=[color(1);color(2);color(3)];
        k=k+1;
    end
end
%scatter3 pt3DA and colorA
scatter3(pt3DA(1,:),pt3DA(2,:),pt3DA(3,:),[],colorA(1:3,:).'/255,'filled')
%%%%%%%%%%%%%%%%%%For the planB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
pt3DB=zeros(3, lenVB*lenHB);
colorB=zeros(3, lenVB*lenHB);
k=1;
for i = 1:lenHB
    for j = 1:lenVB
        % dx is the x coordinate of the point in the 3D space
        dx = i;
        % dy is the y coordinate of the point in the 3D space
        dy = j;
        % dz is the z coordinate of the point in the 3D space usung caractPlanB
        dz=-(caractPlanB(1)*dx+caractPlanB(2)*dy+caractPlanB(4))/caractPlanB(3) ;%is the equation of the plane in the x-y plane
        
        pt3DB(:,k)=[dx;dy;dz];
        color(1:3)=scanB(i,j,:);
        color=double(color(1:3));
        colorB(:,k)=[color(1);color(2);color(3)];
        k=k+1;
    end
end
%scatter3 pt3DB and colorB
scatter3(pt3DB(1,:),pt3DB(2,:),pt3DB(3,:),[],colorB(1:3,:).'/255,'filled')

%%%%%%%%%%%%%%%%%%For the planC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
pt3DC=zeros(3, lenVC*lenHC);
colorC=zeros(3, lenVC*lenHC);
k=1;
for i = 1:lenHC
    for j = 1:lenVC
        % dx is the x coordinate of the point in the 3D space
        dx = i;
        % dy is the y coordinate of the point in the 3D space
        dy = j;
        % dz is the z coordinate of the point in the 3D space usung caractPlanC
        dz=-(caractPlanC(1)*dx+caractPlanC(2)*dy+caractPlanC(4))/caractPlanC(3) ;%is the equation of the plane in the x-y plane
        
        pt3DC(:,k)=[dx;dy;dz];
        color(1:3)=scanC(i,j,:);
        color=double(color(1:3));
        colorC(:,k)=[color(1);color(2);color(3)];
        k=k+1;
    end
end
%scatter3 pt3DC and colorC
scatter3(pt3DC(1,:),pt3DC(2,:),pt3DC(3,:),[],colorC(1:3,:).'/255,'filled')

figure()
scatter3(pt3DA(1,:),pt3DA(2,:),pt3DA(3,:),[],colorA(1:3,:).'/255,'filled')
hold on
scatter3(pt3DB(1,:),pt3DB(2,:),pt3DB(3,:),[],colorB(1:3,:).'/255,'filled')

hold on
scatter3(pt3DC(1,:),pt3DC(2,:),pt3DC(3,:),[],colorC(1:3,:).'/255,'filled')
