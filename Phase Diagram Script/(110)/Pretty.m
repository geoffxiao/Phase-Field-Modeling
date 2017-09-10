Render3D_CrystalRef
dx = x_axis(2) - x_axis(1);
dy = y_axis(2) - y_axis(1);
dz = z_axis(2) - z_axis(1);

axis([min(x_axis)*1e9, max(x_axis)*1e9, min(y_axis)*1e9, max(y_axis)*1e9,...
    min(z_axis)*1e9, (min(z_axis)+(max(x_axis)-min(x_axis)))*1e9]);
set(gca,'xtick',[]);set(gca,'ytick',[]);set(gca,'ztick',[]);set(gca,'Visible','off')