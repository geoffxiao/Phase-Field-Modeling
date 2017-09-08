% Landau Energy
f_landau = a1 .* ( P1.^2 + P2.^2 + P3.^2 ) + a11 .* ( P1.^4 + P2.^4 + P3.^4 ) + ...
    a12 .* ( P1.^2 .* P2.^2 + P1.^2 .* P3.^2 + P2.^2 .* P3.^2 ) + ...
    a111 .* ( P1.^6 + P2.^6 + P3.^6 ) + a112 .* ( P1.^4 .* (P2.^2 + P3.^2) + P2.^4 .* (P3.^2 + P1.^2) + P3.^4 .* (P1.^2 + P2.^2) ) + ...
    a123 .* ( P1.^2 .* P2.^2 .* P3.^2 ) + ...
    a1111 .* ( P1.^8 + P2.^8 + P3.^8 ) + ...
    a1112 .* ( P1.^4 .* P2.^4 + P2.^4 .* P3.^4 + P1.^4 .* P3.^4 ) + ...
    a1123 .* ( P1.^4 .* P2.^2 .* P3.^2 + P2.^4 .* P3.^2 .* P1.^2 + P3.^4 .* P1.^2 .* P2.^2 );

Eigenstrain_11 = Q11 * P1.^2 + Q12 .* (P2.^2 + P3.^2);
Eigenstrain_22 = Q11 * P2.^2 + Q12 .* (P1.^2 + P3.^2);
Eigenstrain_33 = Q11 * P3.^2 + Q12 .* (P1.^2 + P2.^2);
Eigenstrain_23 = Q44 * P2 .* P3;
Eigenstrain_13 = Q44 * P1 .* P3;
Eigenstrain_12 = Q44 * P1 .* P2; 

ElasticStrain_11 = e_11 + e_11_homo( P1, P2, P3 ) - Eigenstrain_11;
ElasticStrain_22 = e_22 + e_22_homo( P1, P2, P3 ) - Eigenstrain_22;
ElasticStrain_33 = e_33 + e_33_homo( P1, P2, P3 ) - Eigenstrain_33;
ElasticStrain_12 = e_12 + e_12_homo( P1, P2, P3 ) - Eigenstrain_12;
ElasticStrain_23 = e_23 + e_23_homo( P1, P2, P3 ) - Eigenstrain_23;
ElasticStrain_13 = e_13 + e_13_homo( P1, P2, P3 ) - Eigenstrain_13;

f_elastic = (C11/2) .* ( ElasticStrain_11.^2 + ElasticStrain_22.^2 + ElasticStrain_33.^2 ) + ...
    (C12) .* ( ElasticStrain_11 .* ElasticStrain_22 + ElasticStrain_22 .* ElasticStrain_33 + ElasticStrain_11 .* ElasticStrain_33 ) + ...
    (2*C44) .* ( ElasticStrain_12.^2 + ElasticStrain_23.^2 + ElasticStrain_13.^2 );

% e11_tot = e_11 + e_11_homo( P1, P2, P3 );
% e22_tot = e_22 + e_22_homo( P1, P2, P3 );
% e33_tot = e_33 + e_33_homo( P1, P2, P3 );
% e12_tot = e_12 + e_12_homo( P1, P2, P3 );
% e23_tot = e_23 + e_23_homo( P1, P2, P3 );
% e13_tot = e_13 + e_13_homo( P1, P2, P3 );
% 
% f_elastic_2 = b11 .* ( P1.^4 + P2.^4 + P3.^4 ) + b12 .* ( P1.^2 .* P2.^2 + P1.^2 .* P3.^2 + P2.^2 .* P3.^2 ) + ...
%     (C11/2) .* ( e11_tot.^2 + e22_tot.^2 + e33_tot.^2 ) + ...
%     (C12) .* ( e11_tot .* e22_tot + e22_tot .* e33_tot + e11_tot .* e33_tot ) + ...
%     (2*C44) .* ( e12_tot.^2 + e23_tot.^2 + e13_tot.^2 ) + ...
%     -( q11 .* e11_tot + q12 .* e22_tot + q12 .* e33_tot ) .* P1.^2 + ...
%     -( q11 .* e22_tot + q12 .* e11_tot + q12 .* e33_tot ) .* P2.^2 + ...
%     -( q11 .* e33_tot + q12 .* e11_tot + q12 .* e22_tot ) .* P3.^2 + ...
%     -(2*q44) .* ( e12_tot .* P1 .* P2 + e23_tot .* P2 .* P3 + e13_tot .* P1 .* P3 );

P1_2Dk = fft_2d_slices(P1); P2_2Dk = fft_2d_slices(P2); P3_2Dk = fft_2d_slices(P3);

P1_1 = ifft_2d_slices(P1_2Dk .* kx_grid_3D);
P1_2 = ifft_2d_slices(P1_2Dk .* ky_grid_3D);
P1_3 = finite_diff_x3_first_der(P1,dz);

P2_1 = ifft_2d_slices(P2_2Dk .* kx_grid_3D);
P2_2 = ifft_2d_slices(P2_2Dk .* ky_grid_3D);
P2_3 = finite_diff_x3_first_der(P2,dz);

P3_1 = ifft_2d_slices(P3_2Dk .* kx_grid_3D);
P3_2 = ifft_2d_slices(P3_2Dk .* ky_grid_3D);
P3_3 = finite_diff_x3_first_der(P3,dz);

G12 = 0; H44 = 0.6 * G110; H14 = 0;
E_1_applied = 0; E_2_applied = 0; E_3_applied = 0;

f_grad = (G11/2) * ( P1_1.^2 + P2_2.^2 + P3_3.^2 ) + ...
    G12 .* ( P1_1 .* P2_2 + P2_2 .* P3_3 + P3_3 .* P1_1 ) + ...
    (H44/2) .* ( P1_2.^2 + P2_1.^2 + P2_3.^2 + P3_2.^2 + P1_3.^2 + P3_1.^2 ) + ...
    (H14 - G12) .* ( P1_2 .* P2_1 + P1_3 .* P3_1 + P2_3 .* P3_2 );

f_elec = (-1/2) .* ( E_1_depol .* P1 + E_2_depol .* P2 + E_3_depol .* P3 );

f_elec_ext = -( E_1_applied .* P1 + E_2_applied .* P2 + E_3_applied .* P3 );

F_landau = sum(sum(sum(f_landau)));
F_elastic = sum(sum(sum(f_elastic)));
F_grad = sum(sum(sum(f_grad)));
F_elec = sum(sum(sum(f_elec)));
F_elec_ext = sum(sum(sum(f_elec_ext)));

[F_landau, F_elastic,F_grad,F_elec]