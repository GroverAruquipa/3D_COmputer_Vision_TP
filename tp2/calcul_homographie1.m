% homography 2H1 from img2 to img1

function [H] = calcul_homographie(ptsNorm1, ptsNorm2, K1, K2)
    H = zeros (3,3);
    A = zeros (3*size(ptsNorm1,1),9);
    
    % A = [p2]^ x tp1
    for i=1:size(ptsNorm1,1)
        %convert p2 to skew symmetric matrix
        p2 = ptsNorm2(i,:);
        p2 = p2';
        p2 = [0 -p2(3) p2(2); p2(3) 0 -p2(1); -p2(2) p2(1) 0];
        %convert p1 to vector
        p1 = ptsNorm1(i,:);
        p1 = p1';
        %fill A
        
        At=kron(p1,p2)'; % A = [p2]^ x tp1
        A(3*i-2:3*i,:)=At;

        %A(i,:)=kron(ptsNorm2(i,:),ptsNorm1(i,:));
        
        
    end
    
    % applying svd
    [u, s, v] = svd(A);
    h = v(:,end);
	Hbis = reshape(h,3,3)';
    H = inv(K2).*Hbis.*K1;
    %verify that H is a homography
 

    pvect1=K1*ptsNorm1(1,:)';
    pvect2=K2*ptsNorm2(1,:)';
    
    %paux=ptsNorm2(1,:)'
    %PtsNorm1ver=H*ptsNorm2(1,:)'
    PtsNorm1ver=inv(H)*ptsNorm2(1,:)'
    %Ptspix=K2*PtsNorm1ver
    Ptspix=inv(K2)*PtsNorm1ver

    disp('Verification of the homography')

    disp('Original')
    disp(pvect1)
    %disp(ptsNorm1(1,:)')
    disp('Reprojected')
    disp(Ptspix)


        
    
end