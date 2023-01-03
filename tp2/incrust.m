function [resultImg] = incrust(Image_incruste, Image_scene)

    
mockup=Image_incruste;
originalImg=Image_scene;
[h, w, c] = size(originalImg);
%[h, w, c] = size(mockup);

resultImg = originalImg;


%% Mouse input

imshow(mockup);
[ x, y ] = ginput(4);
imshow(originalImg);
[x1,y1]=ginput(4);
%concatenate x and x1 
x=[x;x1]; % first 4 points are the points of the mockup image and the last 4 points are the points of the original image
%concatenate y and y1
y=[y;y1]; % first 4 points are the points of the mockup image and the last 4 points are the points of the original image
%%
m = [x(1) y(1) 1 0 0 0 -x(1)*x(5) -y(1)*x(5);
     x(2) y(2) 1 0 0 0 -x(2)*x(6) -y(2)*x(6);
     x(3) y(3) 1 0 0 0 -x(3)*x(7) -y(3)*x(7);
     x(4) y(4) 1 0 0 0 -x(4)*x(8) -y(4)*x(8);
     0 0 0 x(1) y(1) 1 -x(1)*y(5) -y(1)*y(5);
     0 0 0 x(2) y(2) 1 -x(2)*y(6) -y(2)*y(6);
     0 0 0 x(3) y(3) 1 -x(3)*y(7) -y(3)*y(7);
     0 0 0 x(4) y(4) 1 -x(4)*y(8) -y(4)*y(8);
    ]; % 8x8 matrix of equations for H matrix 



z = [x(5); x(6); x(7); x(8); y(5); y(6); y(7); y(8)]; % 8x1 matrix of coordinates of the 4 points in the mockup image
H = m\z;
H = H'; % 1x8 matrix of H values

%  debug
%  for i = 1:4
%      a = (H(1)*x(i) + H(2)*y(i) + H(3))/(H(7)*x(i) + H(8)*y(i) + 1);
%      b = (H(4)*x(i) + H(5)*y(i) + H(6))/(H(7)*x(i) + H(8)*y(i) + 1);
%      fprintf('x y : %f %f\n',a,b );
%  end

m = (y(5) - y(6)) / (x(5) - x(6));
c = y(5) - m*x(5);
top = [m c];

if(x(6) == x(7))
    m = 10000;
else
    m = (y(6) - y(7)) / (x(6) - x(7));
end
c = y(6) - m*x(6);
right = [m c];

m = (y(7) - y(8)) / (x(7) - x(8));
c = y(7) - m*x(7);
down = [m c];

if(x(8) == x(5))
    m = 10000;
else
    m = (y(8) - y(5)) / (x(8) - x(5));
end
c = y(5) - m*x(5);
left = [m c];

max_x = round(max(x(5:8)));
min_x = round(min(x(5:8)));
max_y = round(max(y(5:8)));
min_y = round(min(y(5:8)));

for i = min_y:max_y
    for j = min_x:max_x
        if i-j*top(1) >= top(2) && i-j*down(1) < down(2)
            if (left(1) > 0 && i-j*left(1) < left(2)) || (left(1) < 0 && i-j*left(1) >= left(2))
                if (right(1) > 0 && i-j*right(1) >= right(2)) || (right(1) < 0 && i-j*right(1) < right(2))
                    %fprintf('doooo\n');
                    A = H(1) - H(7)*j;
                    B = H(2) - H(8)*j;
                    C = j - H(3);
                    D = H(4) - H(7)*i;
                    E = H(5) - H(8)*i;
                    F = i - H(6);
                    a = ((C*E)-(B*F))/((A*E)-(B*D)); 
                    b = ((C*D)-(A*F))/((B*D)-(A*E));
                    resultImg(i,j,:) = mockup(round(b), round(a), :);
                end
            end
        end
    end
end
figure()
imshow(resultImg);






end