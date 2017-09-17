GreenTensorSetup

%% Eigenstrains
CalcEigenstrains

%% Calculate the displacement field via Khachutaryan method
% For each k vector calculate displacement field
u_1_A_k = - C11.*Eigenstrain_11_k.*kx_grid_3D.*Green_11.*1i - C12.*Eigenstrain_22_k.*kx_grid_3D.*Green_11.*1i - C12.*Eigenstrain_33_k.*kx_grid_3D.*Green_11.*1i - C44.*Eigenstrain_12_k.*kx_grid_3D.*Green_12.*2i - C44.*Eigenstrain_13_k.*kx_grid_3D.*Green_13.*2i - C12.*Eigenstrain_11_k.*ky_grid_3D.*Green_12.*1i - C11.*Eigenstrain_22_k.*ky_grid_3D.*Green_12.*1i - C12.*Eigenstrain_33_k.*ky_grid_3D.*Green_12.*1i - C44.*Eigenstrain_12_k.*ky_grid_3D.*Green_11.*2i - C44.*Eigenstrain_23_k.*ky_grid_3D.*Green_13.*2i - C12.*Eigenstrain_11_k.*kz_grid_3D.*Green_13.*1i - C12.*Eigenstrain_22_k.*kz_grid_3D.*Green_13.*1i - C11.*Eigenstrain_33_k.*kz_grid_3D.*Green_13.*1i - C44.*Eigenstrain_13_k.*kz_grid_3D.*Green_11.*2i - C44.*Eigenstrain_23_k.*kz_grid_3D.*Green_12.*2i;
u_2_A_k = - C11.*Eigenstrain_11_k.*kx_grid_3D.*Green_21.*1i - C12.*Eigenstrain_22_k.*kx_grid_3D.*Green_21.*1i - C12.*Eigenstrain_33_k.*kx_grid_3D.*Green_21.*1i - C44.*Eigenstrain_12_k.*kx_grid_3D.*Green_22.*2i - C44.*Eigenstrain_13_k.*kx_grid_3D.*Green_23.*2i - C12.*Eigenstrain_11_k.*ky_grid_3D.*Green_22.*1i - C11.*Eigenstrain_22_k.*ky_grid_3D.*Green_22.*1i - C12.*Eigenstrain_33_k.*ky_grid_3D.*Green_22.*1i - C44.*Eigenstrain_12_k.*ky_grid_3D.*Green_21.*2i - C44.*Eigenstrain_23_k.*ky_grid_3D.*Green_23.*2i - C12.*Eigenstrain_11_k.*kz_grid_3D.*Green_23.*1i - C12.*Eigenstrain_22_k.*kz_grid_3D.*Green_23.*1i - C11.*Eigenstrain_33_k.*kz_grid_3D.*Green_23.*1i - C44.*Eigenstrain_13_k.*kz_grid_3D.*Green_21.*2i - C44.*Eigenstrain_23_k.*kz_grid_3D.*Green_22.*2i;
u_3_A_k = - C11.*Eigenstrain_11_k.*kx_grid_3D.*Green_31.*1i - C12.*Eigenstrain_22_k.*kx_grid_3D.*Green_31.*1i - C12.*Eigenstrain_33_k.*kx_grid_3D.*Green_31.*1i - C44.*Eigenstrain_12_k.*kx_grid_3D.*Green_32.*2i - C44.*Eigenstrain_13_k.*kx_grid_3D.*Green_33.*2i - C12.*Eigenstrain_11_k.*ky_grid_3D.*Green_32.*1i - C11.*Eigenstrain_22_k.*ky_grid_3D.*Green_32.*1i - C12.*Eigenstrain_33_k.*ky_grid_3D.*Green_32.*1i - C44.*Eigenstrain_12_k.*ky_grid_3D.*Green_31.*2i - C44.*Eigenstrain_23_k.*ky_grid_3D.*Green_33.*2i - C12.*Eigenstrain_11_k.*kz_grid_3D.*Green_33.*1i - C12.*Eigenstrain_22_k.*kz_grid_3D.*Green_33.*1i - C11.*Eigenstrain_33_k.*kz_grid_3D.*Green_33.*1i - C44.*Eigenstrain_13_k.*kz_grid_3D.*Green_31.*2i - C44.*Eigenstrain_23_k.*kz_grid_3D.*Green_32.*2i;

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
