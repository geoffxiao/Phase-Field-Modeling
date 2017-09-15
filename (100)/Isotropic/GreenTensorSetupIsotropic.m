Shear_Mod = 0.69 * 1e11;
Poisson_Ratio = 0.35;

Green_11 = (( 1 / Shear_Mod ) - ( (kx_grid_3D .* kx_grid_3D) ./ (2 .* Shear_Mod .* (1 - Poisson_Ratio) .* k_mag_3D.^2) )) ./ k_mag_3D.^2;
Green_12 = (( 0 / Shear_Mod ) - ( (kx_grid_3D .* ky_grid_3D) ./ (2 .* Shear_Mod .* (1 - Poisson_Ratio) .* k_mag_3D.^2) )) ./ k_mag_3D.^2;
Green_13 = (( 0 / Shear_Mod ) - ( (kx_grid_3D .* kz_grid_3D) ./ (2 .* Shear_Mod .* (1 - Poisson_Ratio) .* k_mag_3D.^2) )) ./ k_mag_3D.^2;

Green_21 = (( 0 / Shear_Mod ) - ( (ky_grid_3D .* kx_grid_3D) ./ (2 .* Shear_Mod .* (1 - Poisson_Ratio) .* k_mag_3D.^2) )) ./ k_mag_3D.^2;
Green_22 = (( 1 / Shear_Mod ) - ( (ky_grid_3D .* ky_grid_3D) ./ (2 .* Shear_Mod .* (1 - Poisson_Ratio) .* k_mag_3D.^2) )) ./ k_mag_3D.^2;
Green_23 = (( 0 / Shear_Mod ) - ( (ky_grid_3D .* kz_grid_3D) ./ (2 .* Shear_Mod .* (1 - Poisson_Ratio) .* k_mag_3D.^2) )) ./ k_mag_3D.^2;

Green_31 = (( 0 / Shear_Mod ) - ( (kx_grid_3D .* kz_grid_3D) ./ (2 .* Shear_Mod .* (1 - Poisson_Ratio) .* k_mag_3D.^2) )) ./ k_mag_3D.^2;
Green_32 = (( 0 / Shear_Mod ) - ( (ky_grid_3D .* kz_grid_3D) ./ (2 .* Shear_Mod .* (1 - Poisson_Ratio) .* k_mag_3D.^2) )) ./ k_mag_3D.^2;
Green_33 = (( 1 / Shear_Mod ) - ( (kz_grid_3D .* kz_grid_3D) ./ (2 .* Shear_Mod .* (1 - Poisson_Ratio) .* k_mag_3D.^2) )) ./ k_mag_3D.^2;

Green_11((kx==0),(ky==0),(kz==0)) = 0;
Green_12((kx==0),(ky==0),(kz==0)) = 0;
Green_13((kx==0),(ky==0),(kz==0)) = 0;

Green_21((kx==0),(ky==0),(kz==0)) = 0;
Green_22((kx==0),(ky==0),(kz==0)) = 0;
Green_23((kx==0),(ky==0),(kz==0)) = 0;

Green_31((kx==0),(ky==0),(kz==0)) = 0;
Green_32((kx==0),(ky==0),(kz==0)) = 0;
Green_33((kx==0),(ky==0),(kz==0)) = 0;