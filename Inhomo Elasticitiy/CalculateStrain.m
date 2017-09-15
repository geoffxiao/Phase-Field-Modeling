% kx_grid_3D=kx_grid;
% ky_grid_3D=ky_grid;
% kz_grid_3D=kz_grid;
HET_ELASTIC_RELAX = 1;
% C_hom = constant
C11_hom = C11;
C12_hom = C12;
C44_hom = C44;

C_hom(1,1,1,1) = C11_hom; C_hom(2,2,2,2) = C11_hom; C_hom(3,3,3,3) = C11_hom;
C_hom(1,1,2,2) = C12_hom; C_hom(1,1,3,3) = C12_hom; C_hom(2,2,1,1) = C12_hom;
C_hom(2,2,3,3) = C12_hom; C_hom(3,3,1,1) = C12_hom; C_hom(3,3,2,2) = C12_hom;
C_hom(1,2,1,2) = C44_hom; C_hom(2,1,2,1) = C44_hom; C_hom(1,3,1,3) = C44_hom;
C_hom(3,1,3,1) = C44_hom; C_hom(2,3,2,3) = C44_hom; C_hom(3,2,3,2) = C44_hom;
C_hom(1,2,2,1) = C44_hom; C_hom(2,1,1,2) = C44_hom; C_hom(1,3,3,1) = C44_hom;
C_hom(3,1,1,3) = C44_hom; C_hom(2,3,3,2) = C44_hom; C_hom(3,2,2,3) = C44_hom;

%%
% C_het = spatially dependent in real space
C11_het_realspace = 0;
C12_het_realspace = 0;
C44_het_realspace = 0;
  
%%
GreenHomoTensorSetup
HomoStrainSetup

TotalStrain_homo_11 = TotalStrain_homo_11_func(P1,P2,P3);
TotalStrain_homo_12 = TotalStrain_homo_12_func(P1,P2,P3);
TotalStrain_homo_13 = TotalStrain_homo_13_func(P1,P2,P3);
TotalStrain_homo_21 = TotalStrain_homo_12;
TotalStrain_homo_22 = TotalStrain_homo_22_func(P1,P2,P3);
TotalStrain_homo_23 = TotalStrain_homo_23_func(P1,P2,P3);
TotalStrain_homo_31 = TotalStrain_homo_13;
TotalStrain_homo_32 = TotalStrain_homo_23;
TotalStrain_homo_33 = TotalStrain_homo_33_func(P1,P2,P3);


if(HET_ELASTIC_RELAX)
    %% Eigenstrains
    CalcEigenstrains
    
    %% Calculate the displacement field via Khachutaryan method
    % For each k vector calculate displacement field
    
    % homogenous approx.
    u_1_k_0 = - C11_hom.*Eigenstrain_11_k.*kx_grid_3D.*Green_homo_k_11.*1i - C12_hom.*Eigenstrain_22_k.*kx_grid_3D.*Green_homo_k_11.*1i - C12_hom.*Eigenstrain_33_k.*kx_grid_3D.*Green_homo_k_11.*1i - C44_hom.*Eigenstrain_12_k.*kx_grid_3D.*Green_homo_k_12.*2i - C44_hom.*Eigenstrain_13_k.*kx_grid_3D.*Green_homo_k_13.*2i - C12_hom.*Eigenstrain_11_k.*ky_grid_3D.*Green_homo_k_12.*1i - C11_hom.*Eigenstrain_22_k.*ky_grid_3D.*Green_homo_k_12.*1i - C12_hom.*Eigenstrain_33_k.*ky_grid_3D.*Green_homo_k_12.*1i - C44_hom.*Eigenstrain_12_k.*ky_grid_3D.*Green_homo_k_11.*2i - C44_hom.*Eigenstrain_23_k.*ky_grid_3D.*Green_homo_k_13.*2i - C12_hom.*Eigenstrain_11_k.*kz_grid_3D.*Green_homo_k_13.*1i - C12_hom.*Eigenstrain_22_k.*kz_grid_3D.*Green_homo_k_13.*1i - C11_hom.*Eigenstrain_33_k.*kz_grid_3D.*Green_homo_k_13.*1i - C44_hom.*Eigenstrain_13_k.*kz_grid_3D.*Green_homo_k_11.*2i - C44_hom.*Eigenstrain_23_k.*kz_grid_3D.*Green_homo_k_12.*2i;
    u_2_k_0 = - C11_hom.*Eigenstrain_11_k.*kx_grid_3D.*Green_homo_k_21.*1i - C12_hom.*Eigenstrain_22_k.*kx_grid_3D.*Green_homo_k_21.*1i - C12_hom.*Eigenstrain_33_k.*kx_grid_3D.*Green_homo_k_21.*1i - C44_hom.*Eigenstrain_12_k.*kx_grid_3D.*Green_homo_k_22.*2i - C44_hom.*Eigenstrain_13_k.*kx_grid_3D.*Green_homo_k_23.*2i - C12_hom.*Eigenstrain_11_k.*ky_grid_3D.*Green_homo_k_22.*1i - C11_hom.*Eigenstrain_22_k.*ky_grid_3D.*Green_homo_k_22.*1i - C12_hom.*Eigenstrain_33_k.*ky_grid_3D.*Green_homo_k_22.*1i - C44_hom.*Eigenstrain_12_k.*ky_grid_3D.*Green_homo_k_21.*2i - C44_hom.*Eigenstrain_23_k.*ky_grid_3D.*Green_homo_k_23.*2i - C12_hom.*Eigenstrain_11_k.*kz_grid_3D.*Green_homo_k_23.*1i - C12_hom.*Eigenstrain_22_k.*kz_grid_3D.*Green_homo_k_23.*1i - C11_hom.*Eigenstrain_33_k.*kz_grid_3D.*Green_homo_k_23.*1i - C44_hom.*Eigenstrain_13_k.*kz_grid_3D.*Green_homo_k_21.*2i - C44_hom.*Eigenstrain_23_k.*kz_grid_3D.*Green_homo_k_22.*2i;
    u_3_k_0 = - C11_hom.*Eigenstrain_11_k.*kx_grid_3D.*Green_homo_k_31.*1i - C12_hom.*Eigenstrain_22_k.*kx_grid_3D.*Green_homo_k_31.*1i - C12_hom.*Eigenstrain_33_k.*kx_grid_3D.*Green_homo_k_31.*1i - C44_hom.*Eigenstrain_12_k.*kx_grid_3D.*Green_homo_k_32.*2i - C44_hom.*Eigenstrain_13_k.*kx_grid_3D.*Green_homo_k_33.*2i - C12_hom.*Eigenstrain_11_k.*ky_grid_3D.*Green_homo_k_32.*1i - C11_hom.*Eigenstrain_22_k.*ky_grid_3D.*Green_homo_k_32.*1i - C12_hom.*Eigenstrain_33_k.*ky_grid_3D.*Green_homo_k_32.*1i - C44_hom.*Eigenstrain_12_k.*ky_grid_3D.*Green_homo_k_31.*2i - C44_hom.*Eigenstrain_23_k.*ky_grid_3D.*Green_homo_k_33.*2i - C12_hom.*Eigenstrain_11_k.*kz_grid_3D.*Green_homo_k_33.*1i - C12_hom.*Eigenstrain_22_k.*kz_grid_3D.*Green_homo_k_33.*1i - C11_hom.*Eigenstrain_33_k.*kz_grid_3D.*Green_homo_k_33.*1i - C44_hom.*Eigenstrain_13_k.*kz_grid_3D.*Green_homo_k_31.*2i - C44_hom.*Eigenstrain_23_k.*kz_grid_3D.*Green_homo_k_32.*2i;
    
    u_1_k_prev = u_1_k_0;
    u_2_k_prev = u_2_k_0;
    u_3_k_prev = u_3_k_0;
    
    % iterative procedure to calculate displacement field
    for n = 1 : 5
        
        % derivative of previous displacement fields...
        u_1_d1_prev_realspace = real(ifftn(kx_grid_3D.*u_1_k_prev.*1i));
        u_1_d2_prev_realspace = real(ifftn(ky_grid_3D.*u_1_k_prev.*1i));
        u_1_d3_prev_realspace = real(ifftn(kz_grid_3D.*u_1_k_prev.*1i));       
        
        u_2_d1_prev_realspace = real(ifftn(kx_grid_3D.*u_2_k_prev.*1i));
        u_2_d2_prev_realspace = real(ifftn(ky_grid_3D.*u_2_k_prev.*1i));
        u_2_d3_prev_realspace = real(ifftn(kz_grid_3D.*u_2_k_prev.*1i));
        
        u_3_d1_prev_realspace = real(ifftn(kx_grid_3D.*u_3_k_prev.*1i));
        u_3_d2_prev_realspace = real(ifftn(ky_grid_3D.*u_3_k_prev.*1i));
        u_3_d3_prev_realspace = real(ifftn(kz_grid_3D.*u_3_k_prev.*1i));
                        
        u_1_k_n = - Green_homo_k_11.*kx_grid_3D.*fftn((Eigenstrain_11 - TotalStrain_homo_11).*(C11_hom + C11_het_realspace) - C11_het_realspace.*u_1_d1_prev_realspace).*1i - Green_homo_k_21.*kx_grid_3D.*fftn((Eigenstrain_12 - TotalStrain_homo_12).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_1_d2_prev_realspace).*1i - Green_homo_k_31.*kx_grid_3D.*fftn((Eigenstrain_13 - TotalStrain_homo_13).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_1_d3_prev_realspace).*1i - Green_homo_k_21.*ky_grid_3D.*fftn((Eigenstrain_11 - TotalStrain_homo_11).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_1_d1_prev_realspace).*1i - Green_homo_k_11.*ky_grid_3D.*fftn((Eigenstrain_12 - TotalStrain_homo_12).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_1_d2_prev_realspace).*1i - Green_homo_k_31.*kz_grid_3D.*fftn((Eigenstrain_11 - TotalStrain_homo_11).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_1_d1_prev_realspace).*1i - Green_homo_k_11.*kz_grid_3D.*fftn((Eigenstrain_13 - TotalStrain_homo_13).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_1_d3_prev_realspace).*1i;
        u_2_k_n = - Green_homo_k_12.*kx_grid_3D.*fftn((Eigenstrain_22 - TotalStrain_homo_22).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_2_d2_prev_realspace).*1i - Green_homo_k_22.*kx_grid_3D.*fftn((Eigenstrain_12 - TotalStrain_homo_21).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_2_d1_prev_realspace).*1i - Green_homo_k_22.*ky_grid_3D.*fftn((Eigenstrain_22 - TotalStrain_homo_22).*(C11_hom + C11_het_realspace) - C11_het_realspace.*u_2_d2_prev_realspace).*1i - Green_homo_k_12.*ky_grid_3D.*fftn((Eigenstrain_12 - TotalStrain_homo_21).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_2_d1_prev_realspace).*1i - Green_homo_k_32.*ky_grid_3D.*fftn((Eigenstrain_23 - TotalStrain_homo_23).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_2_d3_prev_realspace).*1i - Green_homo_k_32.*kz_grid_3D.*fftn((Eigenstrain_22 - TotalStrain_homo_22).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_2_d2_prev_realspace).*1i - Green_homo_k_22.*kz_grid_3D.*fftn((Eigenstrain_23 - TotalStrain_homo_23).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_2_d3_prev_realspace).*1i;
        u_3_k_n = - Green_homo_k_13.*kx_grid_3D.*fftn((Eigenstrain_33 - TotalStrain_homo_33).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_3_d3_prev_realspace).*1i - Green_homo_k_33.*kx_grid_3D.*fftn((Eigenstrain_13 - TotalStrain_homo_31).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_3_d1_prev_realspace).*1i - Green_homo_k_23.*ky_grid_3D.*fftn((Eigenstrain_33 - TotalStrain_homo_33).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_3_d3_prev_realspace).*1i - Green_homo_k_33.*ky_grid_3D.*fftn((Eigenstrain_23 - TotalStrain_homo_32).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_3_d2_prev_realspace).*1i - Green_homo_k_33.*kz_grid_3D.*fftn((Eigenstrain_33 - TotalStrain_homo_33).*(C11_hom + C11_het_realspace) - C11_het_realspace.*u_3_d3_prev_realspace).*1i - Green_homo_k_13.*kz_grid_3D.*fftn((Eigenstrain_13 - TotalStrain_homo_31).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_3_d1_prev_realspace).*1i - Green_homo_k_23.*kz_grid_3D.*fftn((Eigenstrain_23 - TotalStrain_homo_32).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_3_d2_prev_realspace).*1i;

        u_1_k_prev = u_1_k_n;
        u_2_k_prev = u_2_k_n;
        u_3_k_prev = u_3_k_n;
    
    end
    
    u_1_k = u_1_k_n;
    u_2_k = u_2_k_n;
    u_3_k = u_3_k_n;    
    
    % calculate strain now
    e_11_k = 1i .* kx_grid_3D .* u_1_k;
    e_22_k = 1i .* ky_grid_3D .* u_2_k;
    e_33_k = 1i .* kz_grid_3D .* u_3_k;
    e_12_k = 0.5 * ( 1i .* kx_grid_3D .* u_2_k + 1i .* ky_grid_3D .* u_1_k );
    e_13_k = 0.5 * ( 1i .* kx_grid_3D .* u_3_k + 1i .* kz_grid_3D .* u_1_k );
    e_23_k = 0.5 * ( 1i .* kz_grid_3D .* u_2_k + 1i .* ky_grid_3D .* u_3_k );

    % real space
    u_1 = real( ifftn( u_1_k ) );
    u_2 = real( ifftn( u_2_k ) );
    u_3 = real( ifftn( u_3_k ) );
    
    e_11 = real(ifftn(e_11_k));
    e_22 = real(ifftn(e_22_k));
    e_33 = real(ifftn(e_33_k));
    e_12 = real(ifftn(e_12_k));
    e_13 = real(ifftn(e_13_k));
    e_23 = real(ifftn(e_23_k));
    
else % Don't do het_realspaceerogenous strain relaxation
    u_1 = 0;
    u_2 = 0;
    u_3 = 0;
    
    e_11 = 0;
    e_22 = 0;
    e_33 = 0;
    e_12 = 0;    
    e_13 = 0;
    e_23 = 0;
end


TotalStrain_11 = e_11 + TotalStrain_homo_11_func(P1,P2,P3); 
TotalStrain_22 = e_22 + TotalStrain_homo_22_func(P1,P2,P3); 
TotalStrain_33 = e_33 + TotalStrain_homo_33_func(P1,P2,P3);
TotalStrain_23 = e_23 + TotalStrain_homo_23_func(P1,P2,P3); 
TotalStrain_13 = e_13 + TotalStrain_homo_13_func(P1,P2,P3); 
TotalStrain_12 = e_12 + TotalStrain_homo_12_func(P1,P2,P3);
TotalStrain_32 = TotalStrain_23; 
TotalStrain_21 = TotalStrain_12; 
TotalStrain_31 = TotalStrain_13;

%% Verify
u_1_d1_realspace = real(ifftn(kx_grid_3D.*u_1_k.*1i));
u_1_d2_realspace = real(ifftn(ky_grid_3D.*u_1_k.*1i));
u_1_d3_realspace = real(ifftn(kz_grid_3D.*u_1_k.*1i));       

u_2_d1_realspace = real(ifftn(kx_grid_3D.*u_2_k.*1i));
u_2_d2_realspace = real(ifftn(ky_grid_3D.*u_2_k.*1i));
u_2_d3_realspace = real(ifftn(kz_grid_3D.*u_2_k.*1i));

u_3_d1_realspace = real(ifftn(kx_grid_3D.*u_3_k.*1i));
u_3_d2_realspace = real(ifftn(ky_grid_3D.*u_3_k.*1i));
u_3_d3_realspace = real(ifftn(kz_grid_3D.*u_3_k.*1i));
        
RHS_k = kx_grid_3D.*fftn((Eigenstrain_11 - TotalStrain_homo_11).*(C11_hom + C11_het_realspace) - C11_het_realspace.*u_1_d1_realspace).*1i + kx_grid_3D.*fftn((Eigenstrain_22 - TotalStrain_homo_22).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_2_d2_realspace).*1i + kx_grid_3D.*fftn((Eigenstrain_33 - TotalStrain_homo_33).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_3_d3_realspace).*1i + ky_grid_3D.*fftn((Eigenstrain_12 - TotalStrain_homo_12).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_1_d2_realspace).*1i + ky_grid_3D.*fftn((Eigenstrain_12 - TotalStrain_homo_21).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_2_d1_realspace).*1i + kz_grid_3D.*fftn((Eigenstrain_13 - TotalStrain_homo_13).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_1_d3_realspace).*1i + kz_grid_3D.*fftn((Eigenstrain_13 - TotalStrain_homo_31).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_3_d1_realspace).*1i;
LHS_k = - C11_hom.*kx_grid_3D.^2.*u_1_k - C44_hom.*ky_grid_3D.^2.*u_1_k - C44_hom.*kz_grid_3D.^2.*u_1_k - C12_hom.*kx_grid_3D.*ky_grid_3D.*u_2_k - C44_hom.*kx_grid_3D.*ky_grid_3D.*u_2_k - C12_hom.*kx_grid_3D.*kz_grid_3D.*u_3_k - C44_hom.*kx_grid_3D.*kz_grid_3D.*u_3_k;

RHS = real(ifftn(RHS_k));
LHS = real(ifftn(LHS_k));