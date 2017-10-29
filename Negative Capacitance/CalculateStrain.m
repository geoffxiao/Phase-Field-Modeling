if(HET_ELASTIC_RELAX)
    EigenstrainInFilm;
    InfinitePlate;
else % Don't do heterogenous strain relaxation
    u_1_A = 0;
    u_2_A = 0;
    u_3_A = 0;
    
    u_1_B = 0;
    u_2_B = 0;
    u_3_B = 0;    
    
    e_11_A = 0;
    e_22_A = 0;
    e_33_A = 0;
    e_12_A = 0;    
    e_13_A = 0;
    e_23_A = 0;
    
    e_11_B = 0;
    e_22_B = 0;
    e_33_B = 0;
    e_12_B = 0;    
    e_13_B = 0;
    e_23_B = 0;
end

% e_11_A + e_11_B = TotalStrain_het_11
% TotalStrain_het_11 = e_11_A + e_11_B;
% TotalStrain_het_22 = e_22_A + e_22_B;
% TotalStrain_het_33 = e_33_A + e_33_B;
% TotalStrain_het_12 = e_12_A + e_12_B;
% TotalStrain_het_13 = e_13_A + e_13_B;
% TotalStrain_het_23 = e_23_A + e_23_B;
% TotalStrain_het_21 = TotalStrain_12_het;
% TotalStrain_het_31 = TotalStrain_13_het;
% TotalStrain_het_32 = TotalStrain_23_het;


u_1 = u_1_A + u_1_B; u_2 = u_2_A + u_2_B; u_3 = u_3_A + u_3_B;
TotalStrain_11 = e_11_A + e_11_B + TotalStrain_homo_11(P1,P2,P3); 
TotalStrain_22 = e_22_A + e_22_B + TotalStrain_homo_22(P1,P2,P3); 
TotalStrain_33 = e_33_A + e_33_B + TotalStrain_homo_33(P1,P2,P3);
TotalStrain_23 = e_23_A + e_23_B + TotalStrain_homo_23(P1,P2,P3); 
TotalStrain_13 = e_13_A + e_13_B + TotalStrain_homo_13(P1,P2,P3); 
TotalStrain_12 = e_12_A + e_12_B + TotalStrain_homo_12(P1,P2,P3);
TotalStrain_32 = TotalStrain_23; 
TotalStrain_21 = TotalStrain_12; 
TotalStrain_31 = TotalStrain_13;