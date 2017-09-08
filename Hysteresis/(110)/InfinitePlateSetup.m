U = zeros(3,3);
m = [0, 0, 1];
for i_ind = 1 : 3
for k_ind = 1 : 3
    for j_ind = 1 : 3
    for l_ind = 1 : 3
        U(i_ind,k_ind) = U(i_ind,k_ind) + C_FilmRef(i_ind,j_ind,k_ind,l_ind) * m(j_ind) * m(l_ind);
    end
    end
end
end

R = zeros(Nx,Ny,3,3); W = zeros(numel(kx),numel(ky),3,3);
eigenvec_mat = zeros(Nx,Ny,6,6); % the eigenvalues and eigenvectors found at each k vector pt
eigenval_mat = zeros(Nx,Ny,6); % the eigenvalues and eigenvectors found at each k vector pt
mat_mat = zeros(numel(kx),numel(ky),6,6);

for k1_ind = 1 : numel(kx)
for k2_ind = 1 : numel(ky)

    if( k1_ind ~= 1 || k2_ind ~= 1 ) % Origin, different solution, be mindful of dividing by k vector as well!

        n = [ kx_grid_2D(k1_ind,k2_ind), ky_grid_2D(k1_ind,k2_ind), 0 ] ./ sqrt( kx_grid_2D(k1_ind,k2_ind)^2 + ky_grid_2D(k1_ind,k2_ind)^2 ) ;

        for i_ind = 1 : 3
        for k_ind = 1 : 3
            for j_ind = 1 : 3
            for l_ind = 1 : 3
                R(k1_ind,k2_ind,i_ind,k_ind) = R(k1_ind,k2_ind,i_ind,k_ind) + C_FilmRef(i_ind,j_ind,k_ind,l_ind) * n(j_ind) * m(l_ind);
                W(k1_ind,k2_ind,i_ind,k_ind) = W(k1_ind,k2_ind,i_ind,k_ind) + C_FilmRef(i_ind,j_ind,k_ind,l_ind) * n(j_ind) * n(l_ind);
            end
            end
        end
        end

        R_mat = squeeze(R(k1_ind,k2_ind,:,:));
        W_mat = squeeze(W(k1_ind,k2_ind,:,:));


        N1 = -inv(U)*R_mat'; N2 = inv(U); N3 = R_mat*inv(U)*R_mat'-W_mat;
        mat = [N1, N2; N3, N1'];

        [eigenvec, eigenval] = eig(mat,'vector');

        mat_mat(k1_ind,k2_ind,:,:) = mat;
        eigenvec_mat(k1_ind,k2_ind,:,:) = eigenvec;
        eigenval_mat(k1_ind,k2_ind,:) = eigenval;

    end
end
end

%% BC matrix solutions
bc_mats = zeros(Nx,Ny,6,6);
strain_bc_mats_inv = zeros(Nx,Ny,6,6);

for k1_ind = 1 : Nx
for k2_ind = 1 : Ny
    if( k1_ind ~= 1 || k2_ind ~= 1 ) % Because we divide by K^2 to make matrices better
        K = sqrt( kx_grid_2D(k1_ind,k2_ind)^2 + ky_grid_2D(k1_ind,k2_ind)^2 );
        bc_mat = zeros(6,6);
        % [ d1 * eigenvec(1,1) + d2 * eigenvec(1,2) + 
        %   d1 * eigenvec(2,1) + d2 * eigenvec(2,2) + 
        %   d1 * eigenvec(3,1) + d2 * eigenvec(3,2) + 
        %   d1 * eigenvec(4,1) + d2 * eigenvec(4,2) + 
        for m = 1 : 6 % the eigenvalue -> column of eigenvec_mat ~ eigenvector
            for k_ind = 1 : 3 % eigenvector a, scale by K 
                bc_mat(k_ind,m) = eigenvec_mat(k1_ind,k2_ind,k_ind,m) * exp(eigenval_mat(k1_ind,k2_ind,m)*h_sub*1i*K);
            end
            % rescale by K^-1 to avoid conditioning errors... need to rescale
            % the given value as well!
            for k_ind = 4 : 6 % eigenvector b
                bc_mat(k_ind,m) = eigenvec_mat(k1_ind,k2_ind,k_ind,m) * exp(eigenval_mat(k1_ind,k2_ind,m)*h_film*1i*K) * 1i * K / K^2;        
            end
        end
        bc_mats(k1_ind,k2_ind,:,:) = bc_mat;
        strain_bc_mats_inv(k1_ind,k2_ind,:,:) = inv(bc_mat);
    end
end
end

strain_bc_mat_inv_korigin = inv([ h_sub                1   0                   0   0                   0 ; ...
                                  0                    0   h_sub               1   0                   0 ; ...
                                  0                    0   0                   0   h_sub               1 ; ...
                                  C_FilmRef(1,3,1,3)   0   C_FilmRef(1,3,2,3)  0   C_FilmRef(1,3,3,3)  0 ; ...
                                  C_FilmRef(2,3,1,3)   0   C_FilmRef(2,3,2,3)  0   C_FilmRef(2,3,3,3)  0 ; ...
                                  C_FilmRef(3,3,1,3)   0   C_FilmRef(3,3,2,3)  0   C_FilmRef(3,3,3,3)  0 ]);
strain_bc_mat_inv_korigin = double(strain_bc_mat_inv_korigin);