%% Gradient Free Energy
% Treat the z term not in FFT...
P1_d3_d3 = finite_diff_x3_second_der(P1_prev_2Dk,dz);
P2_d3_d3 = finite_diff_x3_second_der(P2_prev_2Dk,dz);
P3_d3_d3 = finite_diff_x3_second_der(P3_prev_2Dk,dz);

G1_no_d3 = G11 * kx_grid_3D.^2 + H44 * ky_grid_3D.^2;
G2_no_d3 = G11 * ky_grid_3D.^2 + H44 * kx_grid_3D.^2;
G3_no_d3 = H44 * (kx_grid_3D.^2 + ky_grid_3D.^2);

G1_d3_part = H44 * P1_d3_d3 .* in_film .* Nucleation_Sites;
G2_d3_part = H44 * P2_d3_d3 .* in_film .* Nucleation_Sites;
G3_d3_part = G11 * P3_d3_d3 .* in_film .* Nucleation_Sites; 