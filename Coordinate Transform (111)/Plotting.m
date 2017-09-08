figure; hold on;

x1_film = [ [0 0 0]; [1 0 0] ];
x2_film = [ [0 0 0]; [0 1 0] ];
x3_film = [ [0 0 0]; [0 0 1] ];

quiver3(x1_film(1,1),x1_film(1,2),x1_film(1,3),x1_film(2,1),x1_film(2,2),x1_film(2,3),'b','LineWidth',2);
quiver3(x2_film(1,1),x2_film(1,2),x2_film(1,3),x2_film(2,1),x2_film(2,2),x2_film(2,3),'b','LineWidth',2);
quiver3(x3_film(1,1),x3_film(1,2),x3_film(1,3),x3_film(2,1),x3_film(2,2),x3_film(2,3),'b','LineWidth',2);
plotcube([1 1 1],[0 0 0],0.5,[1 1 1]); 

transform_mat = [ 0             1       0; ...
                  -1/sqrt(2)    0       1/sqrt(2);...
                  1/sqrt(2)     0       1/sqrt(2)];
              
x1_crystal = transform_mat * x1_film(2,:)' / 2;      
x2_crystal = transform_mat * x2_film(2,:)' / 2;              
x3_crystal = transform_mat * x3_film(2,:)' / 2;

x1_crystal = [ [0 0 0]; x1_crystal' ];
x2_crystal = [ [0 0 0]; x2_crystal' ];
x3_crystal = [ [0 0 0]; x3_crystal' ];


quiver3(x1_crystal(1,1),x1_crystal(1,2),x1_crystal(1,3),x1_crystal(2,1),x1_crystal(2,2),x1_crystal(2,3),'r','LineWidth',2);
quiver3(x2_crystal(1,1),x2_crystal(1,2),x2_crystal(1,3),x2_crystal(2,1),x2_crystal(2,2),x2_crystal(2,3),'r','LineWidth',2);
quiver3(x3_crystal(1,1),x3_crystal(1,2),x3_crystal(1,3),x3_crystal(2,1),x3_crystal(2,2),x3_crystal(2,3),'r','LineWidth',2);

axis([-1 1 -1 1 -1 1]);
set(gca,'xtick',[]);set(gca,'ytick',[]);set(gca,'ztick',[]);set(gca,'Visible','off')
