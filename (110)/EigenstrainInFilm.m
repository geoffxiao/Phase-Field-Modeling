%% Eigenstrains
% Transformed eigenstrains, in film reference frame
CalcEigenstrains

%% Calculate the displacement field via Khachutaryan method
% For each k vector calculate displacement field
u_1_A_k = (- Eigenstrain_FilmRef_11_k.*Green_FilmRef_k_11.*kx_grid_3D.*1i - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_12.*ky_grid_3D.*1i)/2 - Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_13.*ky_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_12.*ky_grid_3D.*1i)/2 - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_13.*kz_grid_3D.*1i)/2 - Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_12.*kz_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_13.*kz_grid_3D.*1i)/2).*C11 + (- Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_11.*kx_grid_3D.*1i - Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_11.*kx_grid_3D.*1i - Eigenstrain_FilmRef_11_k.*Green_FilmRef_k_12.*ky_grid_3D.*1i - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_12.*ky_grid_3D.*1i)/2 + Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_13.*ky_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_12.*ky_grid_3D.*1i)/2 - Eigenstrain_FilmRef_11_k.*Green_FilmRef_k_13.*kz_grid_3D.*1i - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_13.*kz_grid_3D.*1i)/2 + Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_12.*kz_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_13.*kz_grid_3D.*1i)/2).*C12 + (- Eigenstrain_FilmRef_12_k.*Green_FilmRef_k_12.*kx_grid_3D.*2i - Eigenstrain_FilmRef_13_k.*Green_FilmRef_k_13.*kx_grid_3D.*2i - Eigenstrain_FilmRef_12_k.*Green_FilmRef_k_11.*ky_grid_3D.*2i - Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_12.*ky_grid_3D.*1i + Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_12.*ky_grid_3D.*1i - Eigenstrain_FilmRef_13_k.*Green_FilmRef_k_11.*kz_grid_3D.*2i + Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_13.*kz_grid_3D.*1i - Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_13.*kz_grid_3D.*1i).*C44;
u_2_A_k = (- Eigenstrain_FilmRef_11_k.*Green_FilmRef_k_21.*kx_grid_3D.*1i - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_22.*ky_grid_3D.*1i)/2 - Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_23.*ky_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_22.*ky_grid_3D.*1i)/2 - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_23.*kz_grid_3D.*1i)/2 - Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_22.*kz_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_23.*kz_grid_3D.*1i)/2).*C11 + (- Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_21.*kx_grid_3D.*1i - Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_21.*kx_grid_3D.*1i - Eigenstrain_FilmRef_11_k.*Green_FilmRef_k_22.*ky_grid_3D.*1i - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_22.*ky_grid_3D.*1i)/2 + Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_23.*ky_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_22.*ky_grid_3D.*1i)/2 - Eigenstrain_FilmRef_11_k.*Green_FilmRef_k_23.*kz_grid_3D.*1i - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_23.*kz_grid_3D.*1i)/2 + Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_22.*kz_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_23.*kz_grid_3D.*1i)/2).*C12 + (- Eigenstrain_FilmRef_12_k.*Green_FilmRef_k_22.*kx_grid_3D.*2i - Eigenstrain_FilmRef_13_k.*Green_FilmRef_k_23.*kx_grid_3D.*2i - Eigenstrain_FilmRef_12_k.*Green_FilmRef_k_21.*ky_grid_3D.*2i - Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_22.*ky_grid_3D.*1i + Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_22.*ky_grid_3D.*1i - Eigenstrain_FilmRef_13_k.*Green_FilmRef_k_21.*kz_grid_3D.*2i + Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_23.*kz_grid_3D.*1i - Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_23.*kz_grid_3D.*1i).*C44;
u_3_A_k = (- Eigenstrain_FilmRef_11_k.*Green_FilmRef_k_31.*kx_grid_3D.*1i - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_32.*ky_grid_3D.*1i)/2 - Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_33.*ky_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_32.*ky_grid_3D.*1i)/2 - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_33.*kz_grid_3D.*1i)/2 - Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_32.*kz_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_33.*kz_grid_3D.*1i)/2).*C11 + (- Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_31.*kx_grid_3D.*1i - Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_31.*kx_grid_3D.*1i - Eigenstrain_FilmRef_11_k.*Green_FilmRef_k_32.*ky_grid_3D.*1i - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_32.*ky_grid_3D.*1i)/2 + Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_33.*ky_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_32.*ky_grid_3D.*1i)/2 - Eigenstrain_FilmRef_11_k.*Green_FilmRef_k_33.*kz_grid_3D.*1i - (Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_33.*kz_grid_3D.*1i)/2 + Eigenstrain_FilmRef_23_k.*Green_FilmRef_k_32.*kz_grid_3D.*1i - (Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_33.*kz_grid_3D.*1i)/2).*C12 + (- Eigenstrain_FilmRef_12_k.*Green_FilmRef_k_32.*kx_grid_3D.*2i - Eigenstrain_FilmRef_13_k.*Green_FilmRef_k_33.*kx_grid_3D.*2i - Eigenstrain_FilmRef_12_k.*Green_FilmRef_k_31.*ky_grid_3D.*2i - Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_32.*ky_grid_3D.*1i + Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_32.*ky_grid_3D.*1i - Eigenstrain_FilmRef_13_k.*Green_FilmRef_k_31.*kz_grid_3D.*2i + Eigenstrain_FilmRef_22_k.*Green_FilmRef_k_33.*kz_grid_3D.*1i - Eigenstrain_FilmRef_33_k.*Green_FilmRef_k_33.*kz_grid_3D.*1i).*C44;

% DC component = zero by def.
u_1_A_k((kx==0),(ky==0),(kz==0)) = 0;
u_2_A_k((kx==0),(ky==0),(kz==0)) = 0;
u_3_A_k((kx==0),(ky==0),(kz==0)) = 0;

u_1_A = real( ifftn( u_1_A_k ) );
u_2_A = real( ifftn( u_2_A_k ) );
u_3_A = real( ifftn( u_3_A_k ) );

e_11_A_k = 1i .* kx_grid_3D .* u_1_A_k;
e_22_A_k = 1i .* ky_grid_3D .* u_2_A_k;
e_33_A_k = 1i .* kz_grid_3D .* u_3_A_k;
e_12_A_k = 0.5 * ( 1i .* kx_grid_3D .* u_2_A_k + 1i .* ky_grid_3D .* u_1_A_k );
e_13_A_k = 0.5 * ( 1i .* kx_grid_3D .* u_3_A_k + 1i .* kz_grid_3D .* u_1_A_k );
e_23_A_k = 0.5 * ( 1i .* kz_grid_3D .* u_2_A_k + 1i .* ky_grid_3D .* u_3_A_k );

e_11_A = real(ifftn(e_11_A_k));
e_22_A = real(ifftn(e_22_A_k));
e_33_A = real(ifftn(e_33_A_k));
e_12_A = real(ifftn(e_12_A_k));
e_13_A = real(ifftn(e_13_A_k));
e_23_A = real(ifftn(e_23_A_k));