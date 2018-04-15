%% Set up real space axis
x_axis = linspace(0, Lx, Nx)'; y_axis = linspace(0, Ly, Ny)'; z_axis = linspace(0, Lz, Nz)';

%% VERY IMPORTANT STEP!! Let us redefine zero, otherwise the exp() term will make our matrix solving go to shit...
z_axis = z_axis - z_axis((round(Nz/2)));

dx = x_axis(2) - x_axis(1); dy = y_axis(2) - y_axis(1); dz = z_axis(2) - z_axis(1);
[y_grid, x_grid, z_grid] = meshgrid(x_axis, y_axis, z_axis);
% kx_grid(x,y,z)

%% Fourier space vectors -> Gradient energy terms and things that use air + film + sub
kx = 2*pi/Lx*[0:Nx/2 -Nx/2+1:-1]'; 
ky = 2*pi/Ly*[0:Ny/2 -Ny/2+1:-1]';
kz = 2*pi/Lz*[0:Nz/2 -Nz/2+1:-1]';
[ky_grid_3D,kx_grid_3D,kz_grid_3D] = meshgrid(kx,ky,kz);
[ky_grid_2D, kx_grid_2D] = meshgrid(kx, ky);

k_mag_3D = sqrt(kx_grid_3D.^2 + ky_grid_3D.^2 + kz_grid_3D.^2);
ex_3D = kx_grid_3D ./ k_mag_3D;
ey_3D = ky_grid_3D ./ k_mag_3D;
ez_3D = kz_grid_3D ./ k_mag_3D;

%%
if( sub_index > 0 )
    in_film = (z_grid > z_axis(sub_index)) & (z_grid <= z_axis(film_index));
    not_in_film = ~in_film;
    not_in_film = +not_in_film;
    in_film = +in_film;
else
    in_film = 1;
    not_in_film = 0;
end

%% z axis
h_film = z_axis(film_index); % end of film
h_sub = z_axis(1); % where substrate ends...limit of elastic deformation allowed in substrate
h_int = z_axis(interface_index);