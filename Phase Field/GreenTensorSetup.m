%% Green's Tensor
Green = zeros(Nx,Ny,Nz,3,3);

% For each k vector find Green's Tensor
for k1_ind = 1 : Nx
for k2_ind = 1 : Ny
for k3_ind = 1 : Nz

    K_vec = [kx_grid_3D(k1_ind,k2_ind,k3_ind) ky_grid_3D(k1_ind,k2_ind,k3_ind) kz_grid_3D(k1_ind,k2_ind,k3_ind)]; % Fourier space vector
    g_inv = zeros(3,3);
    for i_ind = 1 : 3
    for j_ind = 1 : 3
        for l_ind = 1 : 3
        for k_ind = 1 : 3
            g_inv(i_ind,j_ind) = g_inv(i_ind,j_ind) + C(i_ind,k_ind,j_ind,l_ind) * K_vec(k_ind) * K_vec(l_ind);
        end
        end
    end
    end
    
    Green(k1_ind,k2_ind,k3_ind,:,:) = inv(g_inv);
    
end
end
end

Green((kx==0),(ky==0),(kz==0),:,:) = 0;

Green_11 = squeeze(Green(:,:,:,1,1));
Green_12 = squeeze(Green(:,:,:,1,2));
Green_13 = squeeze(Green(:,:,:,1,3));

Green_21 = squeeze(Green(:,:,:,2,1));
Green_22 = squeeze(Green(:,:,:,2,2));
Green_23 = squeeze(Green(:,:,:,2,3));

Green_31 = squeeze(Green(:,:,:,3,1));
Green_32 = squeeze(Green(:,:,:,3,2));
Green_33 = squeeze(Green(:,:,:,3,3));