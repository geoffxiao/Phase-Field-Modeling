%% Green's Tensor
Green_homo_k = zeros(Nx,Ny,Nz,3,3);

% For each k vector find Green_homo_k's Tensor
for k1_ind = 1 : Nx
for k2_ind = 1 : Ny
for k3_ind = 1 : Nz

    K_vec = [kx_grid_3D(k1_ind,k2_ind,k3_ind) ky_grid_3D(k1_ind,k2_ind,k3_ind) kz_grid_3D(k1_ind,k2_ind,k3_ind)]; % Fourier space vector
    g_inv = zeros(3,3);
    for i_ind = 1 : 3
    for j_ind = 1 : 3
        for l_ind = 1 : 3
        for k_ind = 1 : 3
            g_inv(i_ind,j_ind) = g_inv(i_ind,j_ind) + C_hom(i_ind,k_ind,j_ind,l_ind) * K_vec(k_ind) * K_vec(l_ind);
        end
        end
    end
    end
    
    Green_homo_k(k1_ind,k2_ind,k3_ind,:,:) = inv(g_inv);
    
end
end
end

Green_homo_k((kx==0),(ky==0),(kz==0),:,:) = 0;

Green_homo_k_11 = squeeze(Green_homo_k(:,:,:,1,1));
Green_homo_k_12 = squeeze(Green_homo_k(:,:,:,1,2));
Green_homo_k_13 = squeeze(Green_homo_k(:,:,:,1,3));

Green_homo_k_21 = squeeze(Green_homo_k(:,:,:,2,1));
Green_homo_k_22 = squeeze(Green_homo_k(:,:,:,2,2));
Green_homo_k_23 = squeeze(Green_homo_k(:,:,:,2,3));

Green_homo_k_31 = squeeze(Green_homo_k(:,:,:,3,1));
Green_homo_k_32 = squeeze(Green_homo_k(:,:,:,3,2));
Green_homo_k_33 = squeeze(Green_homo_k(:,:,:,3,3));