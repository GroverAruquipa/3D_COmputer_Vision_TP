function [pt4prime,x,y,lengthx,lengthy, caractPlan] = calculePlan(coins) %coins = [x1,y1,z1;x2,y2,z2;x3,y3,z3;x4,y4,z4]
 % caractPlan is a vector [a,b,c,d] where a*x+b*y+c*z+d=0 is the equation of the plane
 % z=-(a*x+b*y+d)/c is the equation of the plane in the x-y plane
 %z=-(caractPlan(1)*x+caractPlan(2)*y+caractPlan(4))/caractPlan(3) is the equation of the plane in the x-y plane
    % vecteurs du plan
    x = (coins(3,1:3)-coins(2,1:3))'; %VECTOR 1
    lengthx = sqrt(x(1)^2 + x(2)^2 + x(3)^2); %longueur du vecteur 1
    x = x/lengthx; %vecteur unitaire
    y = (coins(1,1:3)-coins(2,1:3))'; %VECTOR 2
    lengthy = sqrt(y(1)^2 + y(2)^2 + y(3)^2); %longueur du vecteur 2
    y = y/lengthy; %vecteur unitaire
    z = cross(x(1:3,:)',y(1:3,:)')'; %VECTOR 3
    lengthz = sqrt(z(1)^2 + z(2)^2 + z(3)^2); %longueur du vecteur 3
    z = z/lengthz; %vecteur unitaire
    
    %trace les vecteurs du plan
    quiver3(coins(2,2),coins(2,1),coins(2,3),0.05*x(2,1),.05*x(1,1),.05*x(3,1)) %x 
    quiver3(coins(2,2),coins(2,1),coins(2,3),0.05*y(2,1),0.05*y(1,1),0.05*y(3,1)) %y
    quiver3(coins(2,2),coins(2,1),coins(2,3),0.05*z(2,1),0.05*z(1,1),0.05*z(3,1)) %z
    
    % plan P ax+by+cz+d = 0
    a = z(1,1);
    b = z(2,1);
    c = z(3,1);
    d = -(a*coins(2,1) + b*coins(2,2) + c*coins(2,3));
    
    % %Calculate the four points of the plan
    
    
    pt4prime = [coins(3,1)+lengthy*y(1,1), coins(3,2)+lengthy*y(2,1), -(a*(coins(3,1)+lengthy*y(1,1)) + b*(coins(3,2)+lengthy*y(2,1)) + d)/c];
    caractPlan = [a,b,c,d];

    
end