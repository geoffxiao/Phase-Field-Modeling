function out = Visualize_3D(P1,P2,P3,x_grid,y_grid,z_grid,interface_index,film_index,Nx,Ny,Nz_film)
    P1_film = P1(:,:,interface_index:film_index);
    P2_film = P2(:,:,interface_index:film_index);
    P3_film = P3(:,:,interface_index:film_index);

    x_grid_film = x_grid(:,:,interface_index:film_index);
    y_grid_film = y_grid(:,:,interface_index:film_index);
    z_grid_film = z_grid(:,:,interface_index:film_index);

    P1_max = max(max(max(P1_film)));
    P1_min = min(min(min(P1_film)));

    P2_max = max(max(max(P2_film)));
    P2_min = min(min(min(P2_film)));

    P3_max = max(max(max(P3_film)));
    P3_min = min(min(min(P3_film)));

    Nz_film = film_index - interface_index + 1;

    %% Get the sides of the cube...
    yz_1_x = x_grid_film(1,:,:); yz_1_x = reshape(yz_1_x,Ny,Nz_film);
    yz_1_y = y_grid_film(1,:,:); yz_1_y = reshape(yz_1_y,Ny,Nz_film);
    yz_1_z = z_grid_film(1,:,:); yz_1_z = reshape(yz_1_z,Ny,Nz_film);

    yz_1_P1 = P1_film(1,:,:); yz_1_P1 = reshape(yz_1_P1,Ny*Nz_film,1);
    yz_1_P2 = P2_film(1,:,:); yz_1_P2 = reshape(yz_1_P2,Ny*Nz_film,1);
    yz_1_P3 = P3_film(1,:,:); yz_1_P3 = reshape(yz_1_P3,Ny*Nz_film,1);

    % Switch P1,P2,P3 into a color now...

    C = convert(yz_1_P1,yz_1_P2,yz_1_P3,P1_min,P1_max,P2_min,P2_max,P3_min,P3_max);
    Area = squeeze(C(:,:,1)); Area = reshape(Area,Ny,Nz_film,3);
    Height = squeeze(C(:,:,1)); Height = reshape(Height,Ny,Nz_film,3);
    yz_1_color = (Area+Height)/2;

    surf(yz_1_x,yz_1_y,yz_1_z,yz_1_color);
    hold on;

    %% Get the sides of the cube...
    yz_2_x = x_grid_film(end,:,:); yz_2_x = reshape(yz_2_x,Ny,Nz_film);
    yz_2_y = y_grid_film(end,:,:); yz_2_y = reshape(yz_2_y,Ny,Nz_film);
    yz_2_z = z_grid_film(end,:,:); yz_2_z = reshape(yz_2_z,Ny,Nz_film);

    yz_2_P1 = P1_film(end,:,:); yz_2_P1 = reshape(yz_2_P1,Ny*Nz_film,1);
    yz_2_P2 = P2_film(end,:,:); yz_2_P2 = reshape(yz_2_P2,Ny*Nz_film,1);
    yz_2_P3 = P3_film(end,:,:); yz_2_P3 = reshape(yz_2_P3,Ny*Nz_film,1);

    % Switch P1,P2,P3 into a color now...

    C = convert(yz_2_P1,yz_2_P2,yz_2_P3,P1_min,P1_max,P2_min,P2_max,P3_min,P3_max);
    Area = squeeze(C(:,:,1)); Area = reshape(Area,Ny,Nz_film,3);
    Height = squeeze(C(:,:,1)); Height = reshape(Height,Ny,Nz_film,3);
    yz_2_color = (Area+Height)/2;

    surf(yz_2_x,yz_2_y,yz_2_z,yz_2_color);


    %% Get the sides of the cube...
    xz_1_x = x_grid_film(:,1,:); xz_1_x = reshape(xz_1_x,Nx,Nz_film);
    xz_1_y = y_grid_film(:,1,:); xz_1_y = reshape(xz_1_y,Nx,Nz_film);
    xz_1_z = z_grid_film(:,1,:); xz_1_z = reshape(xz_1_z,Nx,Nz_film);

    xz_1_P1 = P1_film(:,1,:); xz_1_P1 = reshape(xz_1_P1,Nx*Nz_film,1);
    xz_1_P2 = P2_film(:,1,:); xz_1_P2 = reshape(xz_1_P2,Nx*Nz_film,1);
    xz_1_P3 = P3_film(:,1,:); xz_1_P3 = reshape(xz_1_P3,Nx*Nz_film,1);

    % Switch P1,P2,P3 into a color now...

    C = convert(xz_1_P1,xz_1_P2,xz_1_P3,P1_min,P1_max,P2_min,P2_max,P3_min,P3_max);
    Area = squeeze(C(:,:,1)); Area = reshape(Area,Nx,Nz_film,3);
    Height = squeeze(C(:,:,1)); Height = reshape(Height,Nx,Nz_film,3);
    xz_1_color = (Area+Height)/2;

    surf(xz_1_x,xz_1_y,xz_1_z,xz_1_color);

    %% Get the sides of the cube...
    xz_2_x = x_grid_film(:,end,:); xz_2_x = reshape(xz_2_x,Nx,Nz_film);
    xz_2_y = y_grid_film(:,end,:); xz_2_y = reshape(xz_2_y,Nx,Nz_film);
    xz_2_z = z_grid_film(:,end,:); xz_2_z = reshape(xz_2_z,Nx,Nz_film);

    xz_2_P1 = P1_film(:,end,:); xz_2_P1 = reshape(xz_2_P1,Nx*Nz_film,1);
    xz_2_P2 = P2_film(:,end,:); xz_2_P2 = reshape(xz_2_P2,Nx*Nz_film,1);
    xz_2_P3 = P3_film(:,end,:); xz_2_P3 = reshape(xz_2_P3,Nx*Nz_film,1);

    % Switch P1,P2,P3 into a color now...

    C = convert(xz_2_P1,xz_2_P2,xz_2_P3,P1_min,P1_max,P2_min,P2_max,P3_min,P3_max);
    Area = squeeze(C(:,:,1)); Area = reshape(Area,Nx,Nz_film,3);
    Height = squeeze(C(:,:,1)); Height = reshape(Height,Nx,Nz_film,3);
    xz_2_color = (Area+Height)/2;

    surf(xz_2_x,xz_2_y,xz_2_z,xz_2_color);

    %% Get the sides of the cube...
    xy_1_x = x_grid_film(:,:,1); xy_1_x = reshape(xy_1_x,Nx,Ny);
    xy_1_y = y_grid_film(:,:,1); xy_1_y = reshape(xy_1_y,Nx,Ny);
    xy_1_z = z_grid_film(:,:,1); xy_1_z = reshape(xy_1_z,Nx,Ny);

    xy_1_P1 = P1_film(:,:,1); xy_1_P1 = reshape(xy_1_P1,Nx*Ny,1);
    xy_1_P2 = P2_film(:,:,1); xy_1_P2 = reshape(xy_1_P2,Nx*Ny,1);
    xy_1_P3 = P3_film(:,:,1); xy_1_P3 = reshape(xy_1_P3,Nx*Ny,1);

    % Switch P1,P2,P3 into a color now...

    C = convert(xy_1_P1,xy_1_P2,xy_1_P3,P1_min,P1_max,P2_min,P2_max,P3_min,P3_max);
    Area = squeeze(C(:,:,1)); Area = reshape(Area,Nx,Ny,3);
    Height = squeeze(C(:,:,1)); Height = reshape(Height,Nx,Ny,3);
    xy_1_color = (Area+Height)/2;

    surf(xy_1_x,xy_1_y,xy_1_z,xy_1_color);

    %% Get the sides of the cube...
    xy_2_x = x_grid_film(:,:,end); xy_2_x = reshape(xy_2_x,Nx,Ny);
    xy_2_y = y_grid_film(:,:,end); xy_2_y = reshape(xy_2_y,Nx,Ny);
    xy_2_z = z_grid_film(:,:,end); xy_2_z = reshape(xy_2_z,Nx,Ny);

    xy_2_P1 = P1_film(:,:,end); xy_2_P1 = reshape(xy_2_P1,Nx*Ny,1);
    xy_2_P2 = P2_film(:,:,end); xy_2_P2 = reshape(xy_2_P2,Nx*Ny,1);
    xy_2_P3 = P3_film(:,:,end); xy_2_P3 = reshape(xy_2_P3,Nx*Ny,1);

    % Switch P1,P2,P3 into a color now...

    C = convert(xy_2_P1,xy_2_P2,xy_2_P3,P1_min,P1_max,P2_min,P2_max,P3_min,P3_max);
    Area = squeeze(C(:,:,1)); Area = reshape(Area,Nx,Ny,3);
    Height = squeeze(C(:,:,1)); Height = reshape(Height,Nx,Ny,3);
    xy_2_color = (Area+Height)/2;

    surf(xy_2_x,xy_2_y,xy_2_z,xy_2_color);

    %%
    axis([min(min(min(x_grid_film))) max(max(max(x_grid_film))) ... 
          min(min(min(y_grid_film))) max(max(max(y_grid_film))) ... 
          min(min(min(z_grid_film))) max(max(max(z_grid_film)))] )
    shading flat
end