% subplot(2,3,1);
% surf(z_axis,y_axis,squeeze(P3(:,16,:))); shading interp; view(0,90); axis([min(z_axis) max(z_axis) min(y_axis) max(y_axis)]); colormap parula; 
% xlabel('Y (m)'); ylabel('Z (m)'); colorbar
% freezeColors

subplot(2,2,1);
surf(x_axis*1e9,y_axis*1e9,P3(:,:,film_index)); shading interp; view(0,90); 
axis([min(x_axis)*1e9 max(x_axis)*1e9 min(y_axis)*1e9 max(y_axis)*1e9]); colormap parula; 
% xlabel('X (m)'); ylabel('Y (m)');
freezeColors

subplot(2,2,2);
angle = atan2(P2,P1); surf(x_axis*1e9,y_axis*1e9,angle(:,:,film_index)); view(0,90); colormap hsv; shading interp;
axis([min(x_axis)*1e9 max(x_axis)*1e9 min(y_axis)*1e9 max(y_axis)*1e9]); 
caxis([-pi pi]); 
% xlabel('X (m)'); ylabel('Y (m)'); 
freezeColors

subplot(2,2,3);
semilogy(errors(1:c));

subplot(2,2,4);
% Visualize_3D(P1,P2,P3,x_grid*1e9,y_grid*1e9,z_grid*1e9,interface_index,film_index,Nx,Ny,Nz)
surf(z_axis*1e9,y_axis*1e9,squeeze(P3(:,1,:))); colormap parula; shading interp; view(0,90);
axis([min(z_axis)*1e9 max(z_axis)*1e9 min(y_axis)*1e9 max(y_axis)*1e9]); 