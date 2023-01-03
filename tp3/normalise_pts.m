% normalization of this points to have points in [-1,1]*[-1,1] as 
% pix1 = K1*ptsNorm1 and pix2 = K1*ptsNorm2

function [ptsNorm, K] = normalise_pts(pts, img) %% pts and img
 
    %...

    alpha=490/2;
    beta=700/2;
    u=490/2;
    v=700/2;
    K=[alpha 0 u; 0 beta v; 0 0 1];
    %P = K*Pnorm



    for i=1:size(pts,1)
        ptsNorm(i,:)=(K\[pts(i,:),1]')';
    end
   
end 