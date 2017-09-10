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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
% A + B = het strains
% A + B + homo = total strain
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e_FilmRef_het_11 = e_11_A + e_11_B;
% e_FilmRef_het_22 = e_22_A + e_22_B;
% e_FilmRef_het_33 = e_33_A + e_33_B;
% e_FilmRef_het_12 = e_12_A + e_12_B;
% e_FilmRef_het_13 = e_13_A + e_13_B;
% e_FilmRef_het_23 = e_23_A + e_23_B;
% e_FilmRef_het_21 = e_12_FilmRef_het;
% e_FilmRef_het_31 = e_13_FilmRef_het;
% e_FilmRef_het_32 = e_23_FilmRef_het;

u_FilmRef_1 = u_1_A + u_1_B; 
u_FilmRef_2 = u_2_A + u_2_B; 
u_FilmRef_3 = u_3_A + u_3_B;

TotalStrain_FilmRef_11 = e_11_A + e_11_B + TotalStrain_FilmRef_homo_11(P1_FilmRef,P2_FilmRef,P3_FilmRef); 
TotalStrain_FilmRef_12 = e_12_A + e_12_B + TotalStrain_FilmRef_homo_12(P1_FilmRef,P2_FilmRef,P3_FilmRef);
TotalStrain_FilmRef_13 = e_13_A + e_13_B + TotalStrain_FilmRef_homo_13(P1_FilmRef,P2_FilmRef,P3_FilmRef); 
TotalStrain_FilmRef_22 = e_22_A + e_22_B + TotalStrain_FilmRef_homo_22(P1_FilmRef,P2_FilmRef,P3_FilmRef); 
TotalStrain_FilmRef_23 = e_23_A + e_23_B + TotalStrain_FilmRef_homo_23(P1_FilmRef,P2_FilmRef,P3_FilmRef); 
TotalStrain_FilmRef_33 = e_33_A + e_33_B + TotalStrain_FilmRef_homo_33(P1_FilmRef,P2_FilmRef,P3_FilmRef);
TotalStrain_FilmRef_32 = TotalStrain_FilmRef_23; 
TotalStrain_FilmRef_21 = TotalStrain_FilmRef_12; 
TotalStrain_FilmRef_31 = TotalStrain_FilmRef_13;