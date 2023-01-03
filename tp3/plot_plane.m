function [pts3D] = plot_plane(pt1, pt2, pt3)

p1=pt1;
p2=pt2;
p3=pt3;
% Plot trianle using 'patch'
figure('color','w')
h=patch('Faces',1:3,'Vertices',[p1;p2;p3]);
set(h,'FaceColor','r','EdgeColor','k','LineWidth',2,'FaceAlpha',0.5)
axis equal vis3d
view([30 30])
xlabel('x','FontSize',20)
ylabel('y','FontSize',20)
zlabel('z','FontSize',20)

end