% homography 2H1 from img2 to img1

function [H] = calcul_homographie(ptsNorm1, ptsNorm2, K1, K2)
    H = zeros (3,3);
    A = zeros (3*size(ptsNorm1,1),9);
    
    % A = [p2]^ x tp1
    for i=1:size(ptsNorm1,1)
        A(3*i-2,:) = [0 0 0 -ptsNorm2(i,1) -ptsNorm2(i,2) -1 ptsNorm1(i,2)*ptsNorm2(i,1) ptsNorm1(i,2)*ptsNorm2(i,2) ptsNorm1(i,2)];
        A(3*i-1,:) = [ptsNorm2(i,1) ptsNorm2(i,2) 1 0 0 0 -ptsNorm1(i,1)*ptsNorm2(i,1) -ptsNorm1(i,1)*ptsNorm2(i,2) -ptsNorm1(i,1)];
        A(3*i,:) = [0 0 0 0 0 0 ptsNorm2(i,1) ptsNorm2(i,2) 1]; % 3eme ligne de A
        

    end

    % applying svd
    [u, s, v] = svd(A);
    h = v(:,end);
	Hbis = reshape(h,3,3)';
    H = inv(K2) * Hbis * K1;
    H = H/H(3,3);% normalisation0
    

    
   
    
    
    
end