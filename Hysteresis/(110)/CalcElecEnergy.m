if( ELECTRIC )

     %% Solve particular solution within the entire sample...
    P1_FilmRef_3Dk = fftn(P1_FilmRef); 
    P2_FilmRef_3Dk = fftn(P2_FilmRef); 
    P3_FilmRef_3Dk = fftn(P3_FilmRef);

    %%%%%%%%
    %%%%%%%%
    %%
    %% Isotropic relative background permittivity constant --> Nothing changes!!
    %%
    %%%%%%%%
    %%%%%%%%
    potential_A_k = -1i .* (kx_grid_3D .* P1_FilmRef_3Dk + ky_grid_3D .* P2_FilmRef_3Dk + kz_grid_3D .* P3_FilmRef_3Dk) ./ ...
        ( permittivity_0 .* (k_electric_11 .* kx_grid_3D.^2 + k_electric_22 .* ky_grid_3D.^2 + k_electric_33 .* kz_grid_3D.^2) );
    potential_A_k(k_mag_3D == 0) = 0;
    potential_A = real(ifftn(potential_A_k));

    E_A_1_k = -1i .* kx_grid_3D .* potential_A_k;
    E_A_2_k = -1i .* ky_grid_3D .* potential_A_k;
    E_A_3_k = -1i .* kz_grid_3D .* potential_A_k;

    E_A_1 = real(ifftn(E_A_1_k));
    E_A_2 = real(ifftn(E_A_2_k));
    E_A_3 = real(ifftn(E_A_3_k));

    %% Homogenous solution boundary condition application, 2D FT solution
    C_mat = zeros(Nx,Ny,2);
    potential_bc_interface = squeeze(potential_A(:,:,interface_index));
    potential_bc_film = squeeze(potential_A(:,:,film_index));
    potential_bc_interface_2Dk = -fft2(potential_bc_interface);
    potential_bc_film_2Dk = -fft2(potential_bc_film);
    potential_bc_given_mat = cat(3,potential_bc_interface_2Dk,potential_bc_film_2Dk);

    potential_B_2Dk = zeros(Nx,Ny,Nz);
    potential_B_2Dk_d3 = zeros(Nx,Ny,Nz);

    for k1_ind = 1 : Nx
    for k2_ind = 1 : Ny

        C_mat(k1_ind,k2_ind,:) = squeeze(electric_bc_mats_inv(k1_ind,k2_ind,:,:)) * squeeze(potential_bc_given_mat(k1_ind,k2_ind,:));

    end
    end

    C1 = squeeze(C_mat(:,:,1)); C2 = squeeze(C_mat(:,:,2));
    p = sqrt((k_electric_11*kx_grid_2D.^2 + k_electric_22*ky_grid_2D.^2)/k_electric_33);
    for z_loop = 1 : numel(z_axis)
        potential_B_2Dk(:,:,z_loop) = C1 .* exp(z_axis(z_loop) .* p) + C2 .* exp(-z_axis(z_loop) .* p);
        potential_B_2Dk_d3(:,:,z_loop) =  p .* C1 .* exp(z_axis(z_loop) .* p) - p .* C2 .* exp(-z_axis(z_loop) .* p);
    end

    % Fourier space origin
    C_origin = electric_bc_mats_inv_korigin * squeeze(potential_bc_given_mat(1,1,:));
    C1 = C_origin(1); C2 = C_origin(2);
    potential_B_2Dk(1,1,:) = C1 * z_axis + C2;
    potential_B_2Dk_d3(1,1,:) = C1;

    %% Total Potential
    potential_B = ifft_2d_slices(potential_B_2Dk);
    potential_FilmRef = potential_A + potential_B;

    % E field
    E_B_2Dk_1 = -1i .* kx_grid_3D .* potential_B_2Dk;
    E_B_2Dk_2 = -1i .* ky_grid_3D .* potential_B_2Dk;
    E_B_2Dk_3 = -potential_B_2Dk_d3;

    E_B_1 = ifft_2d_slices(E_B_2Dk_1);
    E_B_2 = ifft_2d_slices(E_B_2Dk_2);
    E_B_3 = ifft_2d_slices(E_B_2Dk_3);
    
    % Depolarization field, not including surface charge effect
    E_FilmRef_1_depol = E_A_1 + E_B_1;
    E_FilmRef_2_depol = E_A_2 + E_B_2;
    E_FilmRef_3_depol = E_A_3 + E_B_3;

    %% Electrical energy define
    f1_elec = -0.5 * E_FilmRef_1_depol .* in_film .* Nucleation_Sites; 
    f2_elec = -0.5 * E_FilmRef_2_depol .* in_film .* Nucleation_Sites; 
    f3_elec = -0.5 * E_FilmRef_3_depol .* in_film .* Nucleation_Sites; 

    f1_elec_2Dk = fft_2d_slices(f1_elec);
    f2_elec_2Dk = fft_2d_slices(f2_elec);
    f3_elec_2Dk = fft_2d_slices(f3_elec);

else

    f1_elec_2Dk = 0; f2_elec_2Dk = 0; f3_elec_2Dk = 0;
    E_FilmRef_1_depol = 0; E_FilmRef_2_depol = 0; E_FilmRef_3_depol = 0;     
    potential_FilmRef = 0;

end