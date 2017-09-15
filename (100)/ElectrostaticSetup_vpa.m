% Use vpa to get more accurate inverted matrices

electric_bc_mats_inv = zeros(Nx,Ny,2,2);

for k1_ind = 1 : Nx
for k2_ind = 1 : Ny
    if(k1_ind ~= 1 || k2_ind ~= 1)
        eta_1 = kx_grid_2D(k1_ind,k2_ind);
        eta_2 = ky_grid_2D(k1_ind,k2_ind);
        p = sqrt((k_electric_11*eta_1^2 + k_electric_22*eta_2^2)/k_electric_33);

        potential_sol_mat = [ exp(h_int*p), exp(-h_int*p); ...
                              exp(h_film*p), exp(-h_film*p)];

        vpa_mat = vpa(potential_sol_mat);
        electric_bc_mats_inv(k1_ind,k2_ind,:,:) = double(inv(vpa_mat));
    end            
end
end

electric_bc_mats_inv_korigin = double ( inv( vpa([h_int,  1;...
                                                  h_film, 1]) ) );