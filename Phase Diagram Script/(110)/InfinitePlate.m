%% Application of Boundary Conditions
% bc in real space

% 3D fft diff..
bc_film_1_3Dk = C44.*(Eigenstrain_FilmRef_13_k - kx_grid_3D.*u_3_A_k.*1i) + C44.*(Eigenstrain_FilmRef_13_k - kz_grid_3D.*u_1_A_k.*1i);
bc_film_2_3Dk = (C11/2 - C12/2).*(Eigenstrain_FilmRef_23_k - ky_grid_3D.*u_3_A_k.*1i) + (C11/2 - C12/2).*(Eigenstrain_FilmRef_23_k - kz_grid_3D.*u_2_A_k.*1i);
bc_film_3_3Dk = (Eigenstrain_FilmRef_33_k - kz_grid_3D.*u_3_A_k.*1i).*(C11/2 + C12/2 + C44) + C12.*(Eigenstrain_FilmRef_11_k - kx_grid_3D.*u_1_A_k.*1i) + (Eigenstrain_FilmRef_22_k - ky_grid_3D.*u_2_A_k.*1i).*(C11/2 + C12/2 - C44);

% real space bc
% bc applied on the top surface in real space
bc_film_1 = real(ifftn(squeeze(bc_film_1_3Dk)));
bc_film_2 = real(ifftn(squeeze(bc_film_2_3Dk)));
bc_film_3 = real(ifftn(squeeze(bc_film_3_3Dk)));

bc_film_1 = squeeze(bc_film_1(:,:,end));
bc_film_2 = squeeze(bc_film_2(:,:,end));
bc_film_3 = squeeze(bc_film_3(:,:,end));

% Strain free substrate
bc_sub_1 = -squeeze(u_1_A(:,:,1));
bc_sub_2 = -squeeze(u_2_A(:,:,1));
bc_sub_3 = -squeeze(u_3_A(:,:,1));

%% fft2 the bc 
bc_film_1_2Dk = fft2(bc_film_1);
bc_film_2_2Dk = fft2(bc_film_2);
bc_film_3_2Dk = fft2(bc_film_3);

% Orders of magnitude larger... so let's make the matrix better to work with
rescaling_mat = sqrt( kx_grid_2D.^2 + ky_grid_2D.^2 ).^2;
rescaling_mat(1,1) = 1;
bc_film_1_2Dk = bc_film_1_2Dk ./ rescaling_mat;
bc_film_2_2Dk = bc_film_2_2Dk ./ rescaling_mat;
bc_film_3_2Dk = bc_film_3_2Dk ./ rescaling_mat;

bc_sub_1_2Dk = fft2(bc_sub_1);
bc_sub_2_2Dk = fft2(bc_sub_2);
bc_sub_3_2Dk = fft2(bc_sub_3);

bc_given_k_space = cat(4,bc_sub_1_2Dk,bc_sub_2_2Dk,bc_sub_3_2Dk,bc_film_1_2Dk,bc_film_2_2Dk,bc_film_3_2Dk);
d_sols = zeros(numel(kx),numel(ky),6);

%% Apply the boundary conditions to get the solution to the diff. eq.
for k1_ind = 1 : Nx
for k2_ind = 1 : Ny
    % Solve the matrix problem
    d_sols(k1_ind,k2_ind,:) = squeeze(strain_bc_mats_inv(k1_ind,k2_ind,:,:)) * squeeze(bc_given_k_space(k1_ind,k2_ind,:));
end
end

%% Construct the solution in the 2D k-space, kx,ky,z
u_B_2Dk_mat = zeros(Nx,Ny,Nz,3);
u_B_2Dk_d3_mat = zeros(Nx,Ny,Nz,3);

q_1 = squeeze(d_sols(:,:,1));
q_2 = squeeze(d_sols(:,:,2));
q_3 = squeeze(d_sols(:,:,3));
q_4 = squeeze(d_sols(:,:,4));
q_5 = squeeze(d_sols(:,:,5));
q_6 = squeeze(d_sols(:,:,6));

p_1 = squeeze(eigenval_mat(:,:,1));
p_2 = squeeze(eigenval_mat(:,:,2));
p_3 = squeeze(eigenval_mat(:,:,3));
p_4 = squeeze(eigenval_mat(:,:,4));
p_5 = squeeze(eigenval_mat(:,:,5));
p_6 = squeeze(eigenval_mat(:,:,6));

for l_ind = 1 : 3
    for z_loop = 1 : numel(z_axis);
        K = sqrt( kx_grid_2D.^2 + ky_grid_2D.^2 );

        a_vec_1 = squeeze(eigenvec_mat(:,:,l_ind,1));
        a_vec_2 = squeeze(eigenvec_mat(:,:,l_ind,2));
        a_vec_3 = squeeze(eigenvec_mat(:,:,l_ind,3));
        a_vec_4 = squeeze(eigenvec_mat(:,:,l_ind,4));
        a_vec_5 = squeeze(eigenvec_mat(:,:,l_ind,5));
        a_vec_6 = squeeze(eigenvec_mat(:,:,l_ind,6));

        u_B_2Dk_mat(:,:,z_loop,l_ind) =   q_1 .* a_vec_1 .* exp(p_1.*z_axis(z_loop).*1i.*K) + ...
                                 q_2 .* a_vec_2 .* exp(p_2.*z_axis(z_loop).*1i.*K) + ...
                                 q_3 .* a_vec_3 .* exp(p_3.*z_axis(z_loop).*1i.*K) + ...
                                 q_4 .* a_vec_4 .* exp(p_4.*z_axis(z_loop).*1i.*K) + ...
                                 q_5 .* a_vec_5 .* exp(p_5.*z_axis(z_loop).*1i.*K) + ...
                                 q_6 .* a_vec_6 .* exp(p_6.*z_axis(z_loop).*1i.*K);
        u_B_2Dk_d3_mat(:,:,z_loop,l_ind) = ( q_1 .* a_vec_1 .* exp(p_1.*z_axis(z_loop).*1i.*K) .* p_1 + ...
                                    q_2 .* a_vec_2 .* exp(p_2.*z_axis(z_loop).*1i.*K) .* p_2 + ...
                                    q_3 .* a_vec_3 .* exp(p_3.*z_axis(z_loop).*1i.*K) .* p_3 + ...
                                    q_4 .* a_vec_4 .* exp(p_4.*z_axis(z_loop).*1i.*K) .* p_4 + ...
                                    q_5 .* a_vec_5 .* exp(p_5.*z_axis(z_loop).*1i.*K) .* p_5 + ...
                                    q_6 .* a_vec_6 .* exp(p_6.*z_axis(z_loop).*1i.*K) .* p_6 ) .* 1i .* K; 
    end
end

% 2D origin point...
d_sols(1,1,:) = strain_bc_mat_inv_korigin * squeeze(bc_given_k_space(1,1,:));

q = squeeze(d_sols(1,1,:));
u_B_2Dk_mat(1,1,:,1) = q(1) * z_axis + q(2);
u_B_2Dk_mat(1,1,:,2) = q(3) * z_axis + q(4);
u_B_2Dk_mat(1,1,:,3) = q(5) * z_axis + q(6);
u_B_2Dk_d3_mat(1,1,:,1) = q(1);
u_B_2Dk_d3_mat(1,1,:,2) = q(3);
u_B_2Dk_d3_mat(1,1,:,3) = q(5);

u_1_B_2Dk = squeeze(u_B_2Dk_mat(:,:,:,1));
u_2_B_2Dk = squeeze(u_B_2Dk_mat(:,:,:,2));
u_3_B_2Dk = squeeze(u_B_2Dk_mat(:,:,:,3));
u_1_B_2Dk_d3 = squeeze(u_B_2Dk_d3_mat(:,:,:,1));
u_2_B_2Dk_d3 = squeeze(u_B_2Dk_d3_mat(:,:,:,2));
u_3_B_2Dk_d3 = squeeze(u_B_2Dk_d3_mat(:,:,:,3));

%% Calculate the strains, e_ij = 0.5 * (u_i,j + u_j,i)
e_11_B_2Dk = u_1_B_2Dk .* 1i .* kx_grid_3D;
e_22_B_2Dk = u_2_B_2Dk .* 1i .* ky_grid_3D;
e_33_B_2Dk = u_3_B_2Dk_d3;
e_23_B_2Dk = 0.5 * (u_2_B_2Dk_d3 + 1i .* ky_grid_3D .* u_3_B_2Dk);
e_13_B_2Dk = 0.5 * (u_1_B_2Dk_d3 + 1i .* kx_grid_3D .* u_3_B_2Dk);
e_12_B_2Dk = 0.5 * (1i .* ky_grid_3D .* u_1_B_2Dk + 1i .* kx_grid_3D .* u_2_B_2Dk);

%% Final outputs
u_1_B = ifft_2d_slices(squeeze(u_B_2Dk_mat(:,:,:,1)));
u_2_B = ifft_2d_slices(squeeze(u_B_2Dk_mat(:,:,:,2)));
u_3_B = ifft_2d_slices(squeeze(u_B_2Dk_mat(:,:,:,3)));

e_11_B = ifft_2d_slices(e_11_B_2Dk);
e_22_B = ifft_2d_slices(e_22_B_2Dk);
e_33_B = ifft_2d_slices(e_33_B_2Dk);
e_23_B = ifft_2d_slices(e_23_B_2Dk);
e_13_B = ifft_2d_slices(e_13_B_2Dk);
e_12_B = ifft_2d_slices(e_12_B_2Dk);